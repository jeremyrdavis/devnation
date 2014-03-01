require 'spec_helper'

describe "Static Pages" do

  	describe "Home page" do

  		it "should have the title 'DevNation Bank'" do
  			visit '/static_pages/home'
  			expect(page).to have_title("DevNation Bank")
  		end

      it "should not have a custom page title" do
        visit '/static_pages/home'
        expect(page).not_to have_title('| Home')
      end

  		it "should have the content 'DevNation'" do
  			visit '/static_pages/home'
  			expect(page).to have_content('DevNation')
  		end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
  end

  describe "About page" do

    it "should have the content 'About DevNation Bank'" do
      visit '/static_pages/about'
      expect(page).to have_content('About DevNation Bank')
    end
  end

end
