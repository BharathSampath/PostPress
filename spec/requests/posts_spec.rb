require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "works! (now write some real specs)" do

     visit new_post_path
     fill_in "Title",  :with => "Java Program"
     fill_in "Content", :with => "Content of Java Program"
     click_button "Create Post"
     page.should have_content('Post was successfully created.')
    end
  end
end
