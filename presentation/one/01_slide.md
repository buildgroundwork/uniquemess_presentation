!SLIDE
# What to Do When ActiveRecord Uniqueness Validations Fails
## Jonathan Mukai-Heidt & Masha Rikhter
## Groundwork Software
## http://buildgroundwork.com

!SLIDE
# A familiar story...

!SLIDE small
# Band model

    @@@ Ruby
    class Band < ActiveRecord::Base
      has_many :memberships
      accepts_nested_attributes_for :memberships,
        allow_destroy: true
    end

!SLIDE
# Person model

    @@@ Ruby
    class Person < ActiveRecord::Base
    end

!SLIDE small
# Membership model

    @@@ Ruby
    class Membership < ActiveRecord::Base
      belongs_to :band
      belongs_to :person
      validates :person_id, uniqueness: { scope: :band_id }
    end

!SLIDE
# Everything good?

!SLIDE small

    @@@ Ruby
    band = Band.create(name: "Sonny Rollins Plus 4")
    # => #<Band id: 1, name: "Sonny Rollins Plus 4"...>

    max_roach = Person.create(name: "Max Roach")
    # => #<Person id: 1, name: "Max Roach"...>

!SLIDE small

    @@@ Ruby
    band.memberships.create!(person: max_roach)
    # => Success!

    band.memberships.create!(person: max_roach)
    # => ActiveRecord::RecordInvalid: Validation failed: Person has already been taken

    band.memberships.last.errors.full_messages
    # => ["Person has already been taken"]

!SLIDE
# Great!

!SLIDE
# Oops

!SLIDE small

    @@@ Ruby
    band.memberships_attributes =
      [ { person: max_roach }, { person: max_roach } ]
    band.save!
    # => Success..?!

!SLIDE small

    @@@ Ruby
    band.memberships.collect(&:valid?)
    # => [false, false]

    band.memberships.collect { |m| m.errors.full_messages }
    # => [["Person has already been taken"], ["Person has...

!SLIDE small

# Furthermore...

    @@@ Ruby
    band.memberships_attributes =
    [{ id: 1, _destroy: 1}, { person: max_roach }]

    band.save # => false

    band.memberships.collect { |m| m.errors.full_messages }
    # => [ ... ["Person has already been taken"]]

!SLIDE
# ???

