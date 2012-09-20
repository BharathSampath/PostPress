require 'spec_helper'

require 'rspec/rails'
require 'capybara/rails'

describe "Postvotes" do
  before(:each) do
    @user = Factory(:user)
    visit "/register"
    fill_in :Email,    :with => @user.email
    fill_in :Pwd, :with => @user.password
    click_button "Login"
    page.should have_content('Listing posts')
  end
end
