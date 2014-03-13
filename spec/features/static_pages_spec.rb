require 'spec_helper'

describe "Static Pages" do

  	describe "Home page" do

  		it "should have the title 'DevNation Bank'" do
  			visit root_path
  			expect(page).to have_title("DevNation Bank")
  		end

      it "should not have a custom page title" do
        visit root_path
        expect(page).not_to have_title('| Home')
      end

  		it "should have the content 'DevNation'" do
  			visit root_path
  			expect(page).to have_content('DevNation')
  		end
  end

  describe "Help page" do

    it "should have the content 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end

      it "should have the title 'DevNation Bank | Help'" do
        visit help_path
        expect(page).to have_title("DevNation Bank | Help")
      end

  end

  describe "About page" do

    it "should have the content 'About DevNation Bank'" do
      visit about_path
      expect(page).to have_content('About DevNation Bank')
    end

    it "should have the title 'DevNation Bank | About Us'" do
      visit about_path
      expect(page).to have_title("DevNation Bank | About Us")
    end

  end

  describe "Contact page" do
    
    it "should have the content, 'Contatct Us'" do
      visit contact_path
      expect(page).to have_content('Contact DevNation Bank')
    end

    it "should have the title 'DevNation Bank'" do
      visit contact_path
      expect(page).to have_title("DevNation Bank | Contact Us")
    end

  end

end
