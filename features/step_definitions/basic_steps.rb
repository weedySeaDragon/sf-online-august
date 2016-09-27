Given(/^I am on the "([^"]*)" page$/) do |page|
  set_goto(page)
  visit @goto
  expect(current_path).to eq @goto
end

Then(/^I should see:$/) do |table|
  table.hashes.each do |hash|
    expect(page).to have_content hash[:content]
  end
end

def set_goto(page)
  @goto = '/restaurant' if page == "restaurant"
  @goto = '/menu'if page == "menu"
end