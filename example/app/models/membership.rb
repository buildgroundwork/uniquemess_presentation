class Membership < ActiveRecord::Base
  belongs_to :band
  belongs_to :person
  validates :person_id, uniqueness: { scope: :band_id, unless: :skip_uniqueness_validation? }

  private

  def skip_uniqueness_validation!
    @skip_uniqueness_validation = true
  end

  def skip_uniqueness_validation?
    @skip_uniqueness_validation
  end
end

