
require 'spec_helper'

require 'rspec/rails'
require 'capybara/rails'
describe "home page" do
  it "check if a user is able to successfully Login as a Normal user" do
    visit "/register"
    fill_in "Email", :with => "bill.mike@postpress.com"
    fill_in "Pwd", :with => "billmike"
    click_button "Login"

    page.should have_content('Listing posts')
  end
end
