!SLIDE
## How does Rails validate record uniqueness?


!SLIDE small
## Query the database to see if a record with this value already exists

    @@@ sql
    SELECT 1 AS one 
    FROM   memberships
    WHERE  person_id = ?
           AND memberships.band_id = ? LIMIT 1

!SLIDE small

    @@@ Ruby
    band.memberships_attributes =
      [ { person: max_roach }, { person: max_roach } ]
    band.save!
    
