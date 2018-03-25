class NonprofitAccount < ActiveRecord::Base

	attr_accessible \
		:stripe_account_id, #str
		:nonprofit, :nonprofit_id #int

	belongs_to :nonprofit

	validates :nonprofit, presence: true
	validates :stripe_account_id, presence: true

end
