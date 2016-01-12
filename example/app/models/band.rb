class Band < ActiveRecord::Base
  has_many :memberships
  accepts_nested_attributes_for :memberships,
    allow_destroy: true

  before_validation :suppress_nested_uniqueness_validation_for_memberships
  validate :unique_memberships

  private

  def suppress_nested_uniqueness_validation_for_memberships
    memberships.each(&:skip_uniqueness_validation!)
  end

  def unique_memberships
    person_ids = memberships.reject(&:marked_for_destruction?).collect(&:person_id)
    if person_ids.size != person_ids.uniq.size
      errors.add(:"memberships.person_id", I18n.translate('errors.messages.taken'))
    end
  end
end

