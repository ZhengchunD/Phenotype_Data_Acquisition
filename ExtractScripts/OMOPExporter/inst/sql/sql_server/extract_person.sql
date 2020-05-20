--PERSON
--OUTPUT_FILE: PERSON.csv
SELECT
   p.PERSON_ID,
   GENDER_CONCEPT_ID,
   YEAR_OF_BIRTH,
   MONTH_OF_BIRTH,
   RACE_CONCEPT_ID,
   ETHNICITY_CONCEPT_ID,
   LOCATION_ID,
   PROVIDER_ID,
   CARE_SITE_ID,
   PERSON_SOURCE_VALUE,
   GENDER_SOURCE_VALUE,
   RACE_SOURCE_VALUE,
   RACE_SOURCE_CONCEPT_ID,
   ETHNICITY_SOURCE_VALUE,
   ETHNICITY_SOURCE_CONCEPT_ID
  FROM @cdmDatabaseSchema.PERSON p
  JOIN @cohortDatabaseSchema.N3C_COHORT n
    ON p.PERSON_ID = n.PERSON_ID;