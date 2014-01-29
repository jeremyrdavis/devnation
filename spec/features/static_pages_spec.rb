require 'spec_helper'

describe "Static Pages" do

  	describe "Home page" do

  		it "should have the content 'DevNation'" do
  			visit '/static_pages/home'
  			expect(page).to have_content('DevNation')
  		end
  end

end
