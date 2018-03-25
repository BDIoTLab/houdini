class OffsitePayment < ActiveRecord::Base

	attr_accessible :gross_amount, :kind, :date, :check_number
	belongs_to :payment, dependent: :destroy
	belongs_to :donation
	belongs_to :nonprofit
	belongs_to :supporter

end
