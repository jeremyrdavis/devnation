require 'spec_helper'

describe "CustomerPages" do

  subject { page }

  describe "Signup Page" do

	before { visit signup_path }

    it { should have_title(full_title('Signup')) } 

  end

end
