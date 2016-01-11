class Band < ActiveRecord::Base
  has_many :members
  accepts_nested_attributes_for :members
end

