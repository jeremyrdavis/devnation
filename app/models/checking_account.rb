class CheckingAccount < ActiveRecord::Base
	belongs_to :customer, :class_name => "Customer", :foreign_key => "customer_id"
	validates :customer_id, presence: true

end
