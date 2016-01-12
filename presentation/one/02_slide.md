!SLIDE bullets incremental
# How does rails validate record uniqueness? #

* Query the database to see if a record with this value already exists
* @@@ sql
  SELECT 1 AS one 
  FROM   members 
  WHERE  person_id = person_id 
         AND members.band_id = band_id LIMIT 1

!SLIDE bullets incremental
# When does this become an issue? #
* 1) When creating duplicate records through the parent (false negative)
* 2) When destroy and creating duplicate records through the parent (false positive)

