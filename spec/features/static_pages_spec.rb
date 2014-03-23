require 'spec_helper'

describe "Static Pages" do

    subject { page }

  	describe "Home page" do

      before { visit root_path }

  		it { should  have_title(full_title('')) }
      it { should_not have_title(' | Home') }
  		it { should have_content('DevNation') }
  end

  describe "Help page" do

    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title('DevNation Bank | Help') }
    it { should have_link('Home') }

  end

  describe "About page" do

    before { visit about_path }

    it { should have_content('About DevNation Bank') }
    it { should have_title('DevNation Bank | About Us') }
    it { should have_link('Home') }

  end

  describe "Contact page" do
    
    before { visit contact_path }

    it { should have_content('Contact DevNation Bank') }
    it { should have_title('DevNation Bank | Contact Us') }
    it { should have_link('Home') }

  end

end
