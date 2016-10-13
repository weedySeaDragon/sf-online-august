class AddDeviseAuthToUsers < ActiveRecord::Migration[5.0]
  def change
    change_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Tokens
      t.text :tokens
    end
  end
end
