require 'spec_helper'

describe "ATM" do

	subject { page }

	describe "page should display form correctly" do

		before do
			visit atm_path
		end

		it { should have_title("DevNation Bank ATM") }

	end

end
