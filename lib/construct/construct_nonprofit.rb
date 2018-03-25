require 'create/stripe/create_stripe_account'

module ConstructNonprofit

	def self.construct(user, h)
		h[:verification_status] = 'unverified'
		h[:published] = true
		h[:statement] = h[:name][0..16]
		h.except!(:website) if h[:website].blank?
		stripe_acct = CreateStripeAccount.for_nonprofit(user, h)
		h[:stripe_account_id] = stripe_acct.id
		return h
	end

end

