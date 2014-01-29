require 'spec_helper'

describe "Static Pages" do

  	describe "Home page" do

  		it "should have the correct title" do
  			visit '/static_pages/home'
  			expect(page).to have_title("DevNation Bank | Home")
  		end

  		it "should have the content 'DevNation'" do
  			visit '/static_pages/home'
  			expect(page).to have_content('DevNation')
  		end
  end

end
