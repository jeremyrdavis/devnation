class Customer < ActiveRecord::Base

	#always downcase email address to ensure uniqueness
	before_save { self.email = email.downcase }

	validates :first_name, presence: true
	validates :last_name, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  	has_secure_password
	has_many :accounts
	has_many :checking_accounts
	validates :password, length: { minimum: 6 }

	def name
		return "#{first_name} #{last_name}"
	end
end
