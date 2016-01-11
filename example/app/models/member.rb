class Member < ActiveRecord::Base
  belongs_to :band
  belongs_to :person
  validates :person_id, uniqueness: { scope: :band_id }
end

