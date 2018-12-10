# License: AGPL-3.0-or-later WITH Web-Template-Output-Additional-Permission-3.0-or-later
class Address < ActiveRecord::Base
  attr_accessible :address, :city, :country,
                  :state_code,
                  :supporter,
                  :zip_code,
                  :fingerprint

  belongs_to :supporter
  has_many :address_tags


  before_save :update_fingerprint

  validates_presence_of :supporter

  # really only makes sense for CustomAddress
  scope :not_deleted, -> {where('COALESCE( deleted,FALSE) = FALSE')}

  private

  def update_fingerprint
    self.fingerprint = AddressComparisons.calculate_hash(self.supporter.id, self.address, self.city, self.state_code, self.zip_code, self.country)
  end
end
