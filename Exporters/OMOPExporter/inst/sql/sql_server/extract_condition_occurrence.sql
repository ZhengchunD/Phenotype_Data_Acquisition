
--CONDITION_OCCURRENCE
--OUTPUT_FILE: CONDITION_OCCURRENCE.csv
SELECT
   CONDITION_OCCURRENCE_ID,
   n.PERSON_ID,
   CONDITION_CONCEPT_ID,
   CONVERT(VARCHAR(20),CONDITION_START_DATE, 120) as CONDITION_START_DATE,
   CONVERT(VARCHAR(20),CONDITION_START_DATETIME, 120) as CONDITION_START_DATETIME,
   CONVERT(VARCHAR(20),CONDITION_END_DATE, 120) as CONDITION_END_DATE,
   CONVERT(VARCHAR(20),CONDITION_END_DATETIME, 120) as CONDITION_END_DATETIME,
   CONDITION_TYPE_CONCEPT_ID,
   CONDITION_STATUS_CONCEPT_ID,
   STOP_REASON,
   VISIT_OCCURRENCE_ID,
   NULL as VISIT_DETAIL_ID,
   CONDITION_SOURCE_VALUE,
   CONDITION_SOURCE_CONCEPT_ID,
   CONDITION_STATUS_SOURCE_VALUE
FROM @cdmDatabaseSchema.CONDITION_OCCURRENCE co
JOIN @cohortDatabaseSchema.N3C_COHORT n
  ON CO.person_id = n.person_id
WHERE co.CONDITION_START_DATE >= '1/1/2018';