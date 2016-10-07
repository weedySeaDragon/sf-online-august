class CartsController < ApplicationController
  before_action :find_or_create_cart, only: [:index, :add_item]

  def index
    if current_user
      @headline = "Cart for #{current_user.name}"
    else
      @headline = "Your cart"
    end
  end

  def add_item
    @dish = Dish.find(params[:dish_id])
    @cart.add(@dish, @dish.dish_price)
    flash[:notice] = "#{@dish.dish_name} added to cart"
    redirect_back(fallback_location: restaurants_path)
  end

  def checkout
    @order = ShoppingCart.find(params[:format])
    @headline = "Hey #{current_user.name}, you're checking out"
    session.delete(:cart_id)
    flash[:notice] = 'Your food is on its way!'
    # In a later feature this needs to create some action item to actually make the order happen.
    # Restrict this function to a Customer
  end
  def create
    link_user_and_cart(params)
    charge = StripePayment.perform_payment(params, @cart)
    @order = ShoppingCart.find_by(user_id: current_user.id)
    if charge.class == Stripe::Charge
      mark_cart_as_paid(charge)
      session.delete(:cart_id)
      flash[:notice] = 'Your food is on its way!'
      render :checkout
    else
      redirect_to carts_path, alert: charge
    end
  end

  private
  def find_or_create_cart
    @cart = ShoppingCart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id
  end

  def link_user_and_cart(params)
    @cart = ShoppingCart.find(params[:cart_id])
    @cart.user_id = current_user.id
    @cart.save
  end

  def mark_cart_as_paid(charge)
    @cart.paid = true
    @cart.stripe_customer = charge.id
    @cart.save
  end
end
