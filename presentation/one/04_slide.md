!SLIDE
# Child validations
!SLIDE small

    @@@ Ruby
    class Memberships < ActiveRecord::Base
      validates :person_id,
        uniqueness:
          { scope: :band_id,
          unless: skip_uniqueness_validation? }
      
      def skip_uniqueness_validation!
        @skip_uniqueness_validation = true
      end

      private

      def skip_uniqueness_validation?
        @skip_uniqueness_validation
      end
    end

!SLIDE
# Parent validations

!SLIDE small

    @@@ Ruby
    class Band < ActiveRecord::Base
      before_validation :suppress_nested_uniqueness_validation_for_memberships
      validate :unique_memberships

      private

      def suppress_nested_uniqueness_validation_for_memberships
        memberships.each(&:skip_uniqueness_validation!)
      end

      def unique_memberships
        person_ids = memberships.reject(&:marked_for_destruction?)
          .collect(&:person_id)
        if person_ids.size != person_ids.uniq.size
          errors.add(:"memberships.person_id"
            , I18n.translate('errors.messages.taken'))
        end
      end
    end

!SLIDE

# voilà!

!SLIDE

# THANKS!
## http://buildgroundwork.com
