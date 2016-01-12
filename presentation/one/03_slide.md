!SLIDE bullets
# Possible solutions
* Database constraints
* Parent validations
* Something special

!SLIDE
# Database constraints

!SLIDE
# 500 Error Explosion!

!SLIDE
# Parent validations

!SLIDE small

    @@@ Ruby
    class Band < ActiveRecord::Base
      # ...

      validate :unique_memberships

      private

      def unique_memberships
        person_ids = memberships.reject(&:marked_for_destruction?).collect(&:person_id)
        if person_ids.size != person_ids.uniq.size
          errors.add(:"memberships.person_id",
          I18n.translate('errors.messages.taken'))
        end
      end
    end

!SLIDE small

    @@@ Ruby
    band = Band.create(name: 'Mingus 5') # => #<Band id: 3, name: "Mingus 5" ...>
    max = Person.first # => #<Person id: 1, name: "Max Roach" ...>
    band.memberships_attributes = [{ person: max }, { person: max }]
    band.save # => false
    band.errors.full_messages
    # => ["Memberships person has already been taken"]

!SLIDE small

## However...

    @@@ Ruby
    band.memberships.create!(person: max) # => Success

    band.memberships_attributes = [{ person: max }]
    band.save # => false

    band.errors.full_messages
    # => ["Memberships person has already been taken", "Memberships person has already been taken"]

!SLIDE small
# Special Sauce

