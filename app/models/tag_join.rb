class TagJoin < ActiveRecord::Base

	attr_accessible \
		:supporter, :supporter_id,
		:tag_master, :tag_master_id

	validates :tag_master, presence: true

	belongs_to :tag_master

	def name; self.tag_master.name; end

	def self.create_with_name(nonprofit, h)
		tm = nonprofit.tag_masters.find_by_name(h['name'])
		if tm.nil?
			tm = nonprofit.tag_masters.create(name: h['name'])
		end
		self.create tag_master: tm, supporter_id: h['supporter_id']
	end

end

