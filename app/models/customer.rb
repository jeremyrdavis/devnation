class Customer < ActiveRecord::Base
	validates :email, presence: true
	validates :first_name, presence: true
	validates :last_name, presence: true

	has_many :accounts
end
