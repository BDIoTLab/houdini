namespace :seed do

	task :np => :environment do
		ActiveRecord::Base.transaction do
			supers = Role.super_admins.includes(:user).map{|r| r.user}
			n = Nonprofit.register(supers.last, name: "Testify #{rand(0..100)}", city: 'Albuquerque', state_code: 'NM')
			n.verification_status = 'verified'
			n.vetted = true
			n.create_billing_subscription({billing_plan: BillingPlan.where(tier: 2).last})
			n.save!
			supers.each{|user| user.roles.create(name: :nonprofit_admin, host: n)}
			puts "New test nonprofit id: #{n.id}"
		end
	end
end
