
require 'spec_helper'

require 'rspec/rails'
require 'capybara/rails'
describe "home page" do
  it "displays the user's username after successful login" do

    visit "/register"
    fill_in "First name", :with => "Prakash"
    fill_in "Last name", :with => "Vasudevan"
    fill_in "Email", :with => "abc@gmail.com"
    fill_in "Pwd", :with => "abc"
    fill_in "Phone", :with => "91919191"

    click_button "Register"

    page.should have_content('Listing posts')
  end
end
