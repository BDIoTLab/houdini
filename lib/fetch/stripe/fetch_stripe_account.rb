# Retrive a stripe account object, catching any errors

module FetchStripeAccount

	def self.with_account_id(stripe_account_id)
		begin
			stripe_acct = Stripe::Account.retrieve(stripe_account_id)
		rescue
			stripe_acct = nil
		end
		return stripe_acct
	end

end
