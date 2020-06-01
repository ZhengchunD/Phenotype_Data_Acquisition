--PCORNet 5.1 extraction code for N3C
--Written by Emily Pfaff, UNC Chapel Hill; Harold Lehmann, JHU
--Code written for MS SQL Server
--This extract purposefully excludes the following PCORnet tables: ENROLLMENT, HARVEST, HASH_TOKEN, PCORNET_TRIAL
--Assumptions: 
--	1. You have already built the N3C_COHORT table (with that name) prior to running this extract
--	2. You are extracting data with a lookback period to 1-1-2018

--DEMOGRAPHIC
--OUTPUT_FILE: DEMOGRAPHIC.csv
SELECT
   DEMOGRAPHIC.PATID,
   LEFT(CONVERT(VARCHAR(20), BIRTH_DATE, 120),7) as BIRTH_DATE, --purposely removing day from birth date
   '00:00' as BIRTH_TIME, --purposely removing time from birth date
   SEX,
   SEXUAL_ORIENTATION,
   GENDER_IDENTITY,
   HISPANIC,
   RACE,
   BIOBANK_FLAG,
   PAT_PREF_LANGUAGE_SPOKEN,
   null as RAW_SEX,
   null as RAW_SEXUAL_ORIENTATION,
   null as RAW_GENDER_IDENTITY,
   null as RAW_HISPANIC,
   null as RAW_RACE,
   null as RAW_PAT_PREF_LANGUAGE_SPOKEN 
FROM DEMOGRAPHIC JOIN N3C_COHORT ON DEMOGRAPHIC.PATID = N3C_COHORT.PATID;

--ENCOUNTER
--OUTPUT_FILE: ENCOUNTER.csv
SELECT
   ENCOUNTERID,
   ENCOUNTER.PATID,
   CONVERT(VARCHAR(20), ADMIT_DATE, 120) as ADMIT_DATE,
   ADMIT_TIME,
   CONVERT(VARCHAR(20), DISCHARGE_DATE, 120) as DISCHARGE_DATE,
   DISCHARGE_TIME,
   PROVIDERID,
   FACILITY_LOCATION,
   ENC_TYPE,
   FACILITYID,
   DISCHARGE_DISPOSITION,
   DISCHARGE_STATUS,
   DRG,
   DRG_TYPE,
   ADMITTING_SOURCE,
   PAYER_TYPE_PRIMARY,
   PAYER_TYPE_SECONDARY,
   FACILITY_TYPE,
   null as RAW_SITEID,
   null as RAW_ENC_TYPE,
   null as RAW_DISCHARGE_DISPOSITION,
   null as RAW_DISCHARGE_STATUS,
   null as RAW_DRG_TYPE,
   null as RAW_ADMITTING_SOURCE,
   null as RAW_FACILITY_TYPE,
   null as RAW_PAYER_TYPE_PRIMARY,
   null as RAW_PAYER_NAME_PRIMARY,
   null as RAW_PAYER_ID_PRIMARY,
   null as RAW_PAYER_TYPE_SECONDARY,
   null as RAW_PAYER_NAME_SECONDARY,
   null as RAW_PAYER_ID_SECONDARY 
FROM ENCOUNTER JOIN N3C_COHORT ON ENCOUNTER.PATID = N3C_COHORT.PATID
WHERE ADMIT_DATE >= '1/1/2018';

--CONDITION
--OUTPUT_FILE: CONDITION.csv
SELECT
   CONDITIONID,
   CONDITION.PATID,
   ENCOUNTERID,
   CONVERT(VARCHAR(20), REPORT_DATE, 120) as REPORT_DATE,
   CONVERT(VARCHAR(20), RESOLVE_DATE, 120) as RESOLVE_DATE,
   CONVERT(VARCHAR(20), ONSET_DATE, 120) as ONSET_DATE,
   CONDITION_STATUS,
   CONDITION,
   CONDITION_TYPE,
   CONDITION_SOURCE,
   null as RAW_CONDITION_STATUS,
   null as RAW_CONDITION,
   null as RAW_CONDITION_TYPE,
   null as RAW_CONDITION_SOURCE 
FROM CONDITION JOIN N3C_COHORT ON CONDITION.PATID = N3C_COHORT.PATID
WHERE REPORT_DATE >= '1/1/2018';

--DEATH
--OUTPUT_FILE: DEATH.csv
--No lookback period for death
SELECT
   DEATH.PATID,
   CONVERT(VARCHAR(20), DEATH_DATE, 120) as DEATH_DATE,
   DEATH_DATE_IMPUTE,
   DEATH_SOURCE,
   DEATH_MATCH_CONFIDENCE 
FROM DEATH JOIN N3C_COHORT ON DEATH.PATID = N3C_COHORT.PATID;

--DEATH CAUSE
--OUTPUT_FILE: DEATH_CAUSE.csv
--No lookback period for death cause
SELECT
   DEATH_CAUSE.PATID,
   DEATH_CAUSE,
   DEATH_CAUSE_CODE,
   DEATH_CAUSE_TYPE,
   DEATH_CAUSE_SOURCE,
   DEATH_CAUSE_CONFIDENCE 
FROM DEATH_CAUSE JOIN N3C_COHORT ON DEATH_CAUSE.PATID = N3C_COHORT.PATID;

--DIAGNOSIS
--OUTPUT_FILE: DIAGNOSIS.csv
SELECT
   DIAGNOSISID,
   DIAGNOSIS.PATID,
   ENCOUNTERID,
   ENC_TYPE,
   CONVERT(VARCHAR(20), ADMIT_DATE, 120) as ADMIT_DATE,
   PROVIDERID,
   DX,
   DX_TYPE,
   CONVERT(VARCHAR(20), DX_DATE, 120) as DX_DATE,
   DX_SOURCE,
   DX_ORIGIN,
   PDX,
   DX_POA,
   null as RAW_DX,
   null as RAW_DX_TYPE,
   null as RAW_DX_SOURCE,
   null as RAW_PDX,
   null as RAW_DX_POA 
FROM DIAGNOSIS JOIN N3C_COHORT ON DIAGNOSIS.PATID = N3C_COHORT.PATID
WHERE DX_DATE >= '1/1/2018';

--DISPENSING
--OUTPUT_FILE: DISPENSING.csv
SELECT
   DISPENSINGID,
   DISPENSING.PATID,
   PRESCRIBINGID,
   CONVERT(VARCHAR(20), DISPENSE_DATE, 120) as DISPENSE_DATE,
   NDC,
   DISPENSE_SOURCE,
   DISPENSE_SUP,
   DISPENSE_AMT,
   DISPENSE_DOSE_DISP,
   DISPENSE_DOSE_DISP_UNIT,
   DISPENSE_ROUTE,
   null as RAW_NDC,
   null as RAW_DISPENSE_DOSE_DISP,
   null as RAW_DISPENSE_DOSE_DISP_UNIT,
   null as RAW_DISPENSE_ROUTE 
FROM DISPENSING JOIN N3C_COHORT ON DISPENSING.PATID = N3C_COHORT.PATID
WHERE DISPENSE_DATE >= '1/1/2018';

--IMMUNIZATION
--OUTPUT_FILE: IMMUNIZATION.csv
--No lookback period for immunizations
SELECT
   IMMUNIZATIONID,
   IMMUNIZATION.PATID,
   ENCOUNTERID,
   PROCEDURESID,
   VX_PROVIDERID,
   CONVERT(VARCHAR(20), VX_RECORD_DATE, 120) as VX_RECORD_DATE,
   CONVERT(VARCHAR(20), VX_ADMIN_DATE, 120) as VX_ADMIN_DATE,
   VX_CODE_TYPE,
   VX_CODE,
   VX_STATUS,
   VX_STATUS_REASON,
   VX_SOURCE,
   VX_DOSE,
   VX_DOSE_UNIT,
   VX_ROUTE,
   VX_BODY_SITE,
   VX_MANUFACTURER,
   VX_LOT_NUM,
   CONVERT(VARCHAR(20), VX_EXP_DATE, 120) as VX_EXP_DATE,
   null as RAW_VX_NAME,
   null as RAW_VX_CODE,
   null as RAW_VX_CODE_TYPE,
   null as RAW_VX_DOSE,
   null as RAW_VX_DOSE_UNIT,
   null as RAW_VX_ROUTE,
   null as RAW_VX_BODY_SITE,
   null as RAW_VX_STATUS,
   null as RAW_VX_STATUS_REASON,
   null as RAW_VX_MANUFACTURER 
FROM IMMUNIZATION JOIN N3C_COHORT ON IMMUNIZATION.PATID = N3C_COHORT.PATID;

--LAB_RESULT_CM
--OUTPUT_FILE: LAB_RESULT_CM.csv
SELECT
   LAB_RESULT_CM_ID,
   LAB_RESULT_CM.PATID,
   ENCOUNTERID,
   SPECIMEN_SOURCE,
   LAB_LOINC,
   LAB_RESULT_SOURCE,
   LAB_LOINC_SOURCE,
   PRIORITY,
   RESULT_LOC,
   LAB_PX,
   LAB_PX_TYPE,
   CONVERT(VARCHAR(20), LAB_ORDER_DATE, 120) as LAB_ORDER_DATE,
   CONVERT(VARCHAR(20), SPECIMEN_DATE, 120) as SPECIMEN_DATE,
   SPECIMEN_TIME,
   CONVERT(VARCHAR(20), RESULT_DATE, 120) as RESULT_DATE,
   RESULT_TIME,
   RESULT_QUAL,
   RESULT_SNOMED,
   RESULT_NUM,
   RESULT_MODIFIER,
   RESULT_UNIT,
   NORM_RANGE_LOW,
   NORM_MODIFIER_LOW,
   NORM_RANGE_HIGH,
   NORM_MODIFIER_HIGH,
   ABN_IND,
   RAW_LAB_NAME,
   null as RAW_LAB_CODE,
   null as RAW_PANEL,
   RAW_RESULT,
   RAW_UNIT,
   null as RAW_ORDER_DEPT,
   null as RAW_FACILITY_CODE 
FROM LAB_RESULT_CM JOIN N3C_COHORT ON LAB_RESULT_CM.PATID = N3C_COHORT.PATID
WHERE LAB_ORDER_DATE >= '1/1/2018';

--LDS_ADDRESS_HISTORY
--OUTPUT_FILE: LDS_ADDRESS_HISTORY.csv
SELECT
   ADDRESSID,
   LDS_ADDRESS_HISTORY.PATID,
   ADDRESS_USE,
   ADDRESS_TYPE,
   ADDRESS_PREFERRED,
   ADDRESS_CITY,
   ADDRESS_STATE,
   ADDRESS_ZIP5,
   ADDRESS_ZIP9,
   ADDRESS_PERIOD_START,
   ADDRESS_PERIOD_END 
FROM LDS_ADDRESS_HISTORY JOIN N3C_COHORT ON LDS_ADDRESS_HISTORY.PATID = N3C_COHORT.PATID
WHERE ADDRESS_PERIOD_END is null OR ADDRESS_PERIOD_END >= '1/1/2018';

--MED_ADMIN
--OUTPUT_FILE: MED_ADMIN.csv
SELECT
   MEDADMINID,
   MED_ADMIN.PATID,
   ENCOUNTERID,
   PRESCRIBINGID,
   MEDADMIN_PROVIDERID,
   CONVERT(VARCHAR(20), MEDADMIN_START_DATE, 120) as MEDADMIN_START_DATE,
   MEDADMIN_START_TIME,
   CONVERT(VARCHAR(20), MEDADMIN_STOP_DATE, 120) as MEDADMIN_STOP_DATE,
   MEDADMIN_STOP_TIME,
   MEDADMIN_TYPE,
   MEDADMIN_CODE,
   MEDADMIN_DOSE_ADMIN,
   MEDADMIN_DOSE_ADMIN_UNIT,
   MEDADMIN_ROUTE,
   MEDADMIN_SOURCE,
   RAW_MEDADMIN_MED_NAME,
   null as RAW_MEDADMIN_CODE,
   null as RAW_MEDADMIN_DOSE_ADMIN,
   null as RAW_MEDADMIN_DOSE_ADMIN_UNIT,
   null as RAW_MEDADMIN_ROUTE 
FROM MED_ADMIN JOIN N3C_COHORT ON MED_ADMIN.PATID = N3C_COHORT.PATID
WHERE MEDADMIN_START_DATE >= '1/1/2018';

--OBS_CLIN
--OUTPUT_FILE: OBS_CLIN.csv
SELECT
   OBSCLINID,
   OBS_CLIN.PATID,
   ENCOUNTERID,
   OBSCLIN_PROVIDERID,
   CONVERT(VARCHAR(20), OBSCLIN_DATE, 120) as OBSCLIN_DATE,
   OBSCLIN_TIME,
   OBSCLIN_TYPE,
   OBSCLIN_CODE,
   OBSCLIN_RESULT_QUAL,
   OBSCLIN_RESULT_TEXT,
   OBSCLIN_RESULT_SNOMED,
   OBSCLIN_RESULT_NUM,
   OBSCLIN_RESULT_MODIFIER,
   OBSCLIN_RESULT_UNIT,
   OBSCLIN_SOURCE,
   null as RAW_OBSCLIN_NAME,
   null as RAW_OBSCLIN_CODE,
   null as RAW_OBSCLIN_TYPE,
   null as RAW_OBSCLIN_RESULT,
   null as RAW_OBSCLIN_MODIFIER,
   null as RAW_OBSCLIN_UNIT 
FROM OBS_CLIN JOIN N3C_COHORT ON OBS_CLIN.PATID = N3C_COHORT.PATID
WHERE OBSCLIN_DATE >= '1/1/2018';

--OBS_GEN
--OUTPUT_FILE: OBS_GEN.csv
SELECT
   OBSGENID,
   OBS_GEN.PATID,
   ENCOUNTERID,
   OBSGEN_PROVIDERID,
   CONVERT(VARCHAR(20), OBSGEN_DATE, 120) as OBSGEN_DATE,
   OBSGEN_TIME,
   OBSGEN_TYPE,
   OBSGEN_CODE,
   OBSGEN_RESULT_QUAL,
   OBSGEN_RESULT_TEXT,
   OBSGEN_RESULT_NUM,
   OBSGEN_RESULT_MODIFIER,
   OBSGEN_RESULT_UNIT,
   OBSGEN_TABLE_MODIFIED,
   OBSGEN_ID_MODIFIED,
   OBSGEN_SOURCE,
   null as RAW_OBSGEN_NAME,
   null as RAW_OBSGEN_CODE,
   null as RAW_OBSGEN_TYPE,
   null as RAW_OBSGEN_RESULT,
   null as RAW_OBSGEN_UNIT 
FROM OBS_GEN JOIN N3C_COHORT ON OBS_GEN.PATID = N3C_COHORT.PATID
WHERE OBSGEN_DATE >= '1/1/2018';

--PRESCRIBING
--OUTPUT_FILE: PRESCRIBING.csv
SELECT
   PRESCRIBINGID,
   PRESCRIBING.PATID,
   ENCOUNTERID,
   RX_PROVIDERID,
   CONVERT(VARCHAR(20), RX_ORDER_DATE, 120) as RX_ORDER_DATE,
   RX_ORDER_TIME,
   CONVERT(VARCHAR(20), RX_START_DATE, 120) as RX_START_DATE,
   CONVERT(VARCHAR(20), RX_END_DATE, 120) as RX_END_DATE,
   RX_DOSE_ORDERED,
   RX_DOSE_ORDERED_UNIT,
   RX_QUANTITY,
   RX_DOSE_FORM,
   RX_REFILLS,
   RX_DAYS_SUPPLY,
   RX_FREQUENCY,
   RX_PRN_FLAG,
   RX_ROUTE,
   RX_BASIS,
   RXNORM_CUI,
   RX_SOURCE,
   RX_DISPENSE_AS_WRITTEN,
   RAW_RX_MED_NAME,
   null as RAW_RX_FREQUENCY,
   null as RAW_RXNORM_CUI,
   null as RAW_RX_QUANTITY,
   null as RAW_RX_NDC,
   null as RAW_RX_DOSE_ORDERED,
   null as RAW_RX_DOSE_ORDERED_UNIT,
   null as RAW_RX_ROUTE,
   null as RAW_RX_REFILLS 
FROM PRESCRIBING JOIN N3C_COHORT ON PRESCRIBING.PATID = N3C_COHORT.PATID
WHERE RX_START_DATE >= '1/1/2018';

--PRO_CM
--OUTPUT_FILE: PRO_CM.csv
SELECT
   PRO_CM_ID,
   PRO_CM.PATID,
   ENCOUNTERID,
   CONVERT(VARCHAR(20), PRO_DATE, 120) as PRO_DATE,
   PRO_TIME,
   PRO_TYPE,
   PRO_ITEM_NAME,
   PRO_ITEM_LOINC,
   PRO_RESPONSE_TEXT,
   PRO_RESPONSE_NUM,
   PRO_METHOD,
   PRO_MODE,
   PRO_CAT,
   PRO_SOURCE,
   PRO_ITEM_VERSION,
   PRO_MEASURE_NAME,
   PRO_MEASURE_SEQ,
   PRO_MEASURE_SCORE,
   PRO_MEASURE_THETA,
   PRO_MEASURE_SCALED_TSCORE,
   PRO_MEASURE_STANDARD_ERROR,
   PRO_MEASURE_COUNT_SCORED,
   PRO_MEASURE_LOINC,
   PRO_MEASURE_VERSION,
   PRO_ITEM_FULLNAME,
   PRO_ITEM_TEXT,
   PRO_MEASURE_FULLNAME 
FROM PRO_CM JOIN N3C_COHORT ON PRO_CM.PATID = N3C_COHORT.PATID
WHERE PRO_DATE >= '1/1/2018';

--PROCEDURES
--OUTPUT_FILE: PROCEDURES.csv
SELECT
   PROCEDURESID,
   PROCEDURES.PATID,
   ENCOUNTERID,
   ENC_TYPE,
   CONVERT(VARCHAR(20), ADMIT_DATE, 120) as ADMIT_DATE,
   PROVIDERID,
   CONVERT(VARCHAR(20), PX_DATE, 120) as PX_DATE,
   PX,
   PX_TYPE,
   PX_SOURCE,
   PPX,
   null as RAW_PX,
   null as RAW_PX_TYPE,
   null as RAW_PPX 
FROM PROCEDURES JOIN N3C_COHORT ON PROCEDURES.PATID = N3C_COHORT.PATID
WHERE PX_DATE >= '1/1/2018';

--PROVIDER
--OUTPUT_FILE: PROVIDER.csv
SELECT
   PROVIDERID,
   PROVIDER_SEX,
   PROVIDER_SPECIALTY_PRIMARY,
   null as PROVIDER_NPI,	--to avoid accidentally identifying sites
   null as PROVIDER_NPI_FLAG,
   null as RAW_PROVIDER_SPECIALTY_PRIMARY 
FROM PROVIDER
;
--VITAL
--OUTPUT_FILE: VITAL.csv
SELECT
   VITALID,
   VITAL.PATID,
   ENCOUNTERID,
   CONVERT(VARCHAR(20), MEASURE_DATE, 120) as MEASURE_DATE,
   MEASURE_TIME,
   VITAL_SOURCE,
   HT,
   WT,
   DIASTOLIC,
   SYSTOLIC,
   ORIGINAL_BMI,
   BP_POSITION,
   SMOKING,
   TOBACCO,
   TOBACCO_TYPE,
   null as RAW_DIASTOLIC,
   null as RAW_SYSTOLIC,
   null as RAW_BP_POSITION,
   null as RAW_SMOKING,
   null as RAW_TOBACCO,
   null as RAW_TOBACCO_TYPE 
FROM VITAL JOIN N3C_COHORT ON VITAL.PATID = N3C_COHORT.PATID
WHERE MEASURE_DATE >= '1/1/2018';

--DATA_COUNTS TABLE
--OUTPUT_FILE: DATA_COUNTS.csv
(select 
   'DEMOGRAPHIC' as TABLE_NAME, 
   (select count(*) FROM DEMOGRAPHIC JOIN N3C_COHORT ON DEMOGRAPHIC.PATID = N3C_COHORT.PATID) as ROW_COUNT

UNION

select 
   'ENCOUNTER' as TABLE_NAME,
   (select count(*) from ENCOUNTER JOIN N3C_COHORT ON ENCOUNTER.PATID = N3C_COHORT.PATID AND ADMIT_DATE >= '1/1/2018') as ROW_COUNT

UNION

select 
   'CONDITION' as TABLE_NAME,
   (select count(*) from CONDITION JOIN N3C_COHORT ON CONDITION.PATID = N3C_COHORT.PATID AND REPORT_DATE >= '1/1/2018') as ROW_COUNT

UNION

select 
   'DEATH' as TABLE_NAME,
   (select count(*) from DEATH JOIN N3C_COHORT ON DEATH.PATID = N3C_COHORT.PATID) as ROW_COUNT

UNION

select 
   'DEATH_CAUSE' as TABLE_NAME,
   (select count(*) from DEATH_CAUSE JOIN N3C_COHORT ON DEATH_CAUSE.PATID = N3C_COHORT.PATID) as ROW_COUNT

UNION

select 
   'DIAGNOSIS' as TABLE_NAME,
   (select count(*) from DIAGNOSIS JOIN N3C_COHORT ON DIAGNOSIS.PATID = N3C_COHORT.PATID AND (DX_DATE >= '1/1/2018' OR ADMIT_DATE >= '1/1/2018')) as ROW_COUNT

UNION

select 
   'DISPENSING' as TABLE_NAME,
   (select count(*) from DISPENSING JOIN N3C_COHORT ON DISPENSING.PATID = N3C_COHORT.PATID AND DISPENSE_DATE >= '1/1/2018') as ROW_COUNT

UNION
   
select 
   'IMMUNIZATION' as TABLE_NAME,
   (select count(*) from IMMUNIZATION JOIN N3C_COHORT ON IMMUNIZATION.PATID = N3C_COHORT.PATID) as ROW_COUNT

UNION
   
select 
   'LAB_RESULT_CM' as TABLE_NAME,
   (select count(*) from LAB_RESULT_CM JOIN N3C_COHORT ON LAB_RESULT_CM.PATID = N3C_COHORT.PATID AND (LAB_ORDER_DATE >= '1/1/2018' OR RESULT_DATE >= '1/1/2018')) as ROW_COUNT

UNION
   
select 
   'LDS_ADDRESS_HISTORY' as TABLE_NAME,
   (select count(*) from LDS_ADDRESS_HISTORY JOIN N3C_COHORT ON LDS_ADDRESS_HISTORY.PATID = N3C_COHORT.PATID
	AND (ADDRESS_PERIOD_END is null OR ADDRESS_PERIOD_END >= '1/1/2018')) as ROW_COUNT

UNION
   
select 
   'MED_ADMIN' as TABLE_NAME,
   (select count(*) from MED_ADMIN JOIN N3C_COHORT ON MED_ADMIN.PATID = N3C_COHORT.PATID AND MEDADMIN_START_DATE >= '1/1/2018') as ROW_COUNT

UNION
   
select 
   'OBS_CLIN' as TABLE_NAME,
   (select count(*) from OBS_CLIN JOIN N3C_COHORT ON OBS_CLIN.PATID = N3C_COHORT.PATID AND OBSCLIN_DATE >= '1/1/2018') as ROW_COUNT

UNION
   
select 
   'OBS_GEN' as TABLE_NAME,
   (select count(*) from OBS_GEN JOIN N3C_COHORT ON OBS_GEN.PATID = N3C_COHORT.PATID and OBSGEN_DATE >= '1/1/2018') as ROW_COUNT

UNION
   
select 
   'PRESCRIBING' as TABLE_NAME,
   (select count(*) from PRESCRIBING JOIN N3C_COHORT ON PRESCRIBING.PATID = N3C_COHORT.PATID AND RX_START_DATE >= '1/1/2018') as ROW_COUNT

UNION
   
select 
   'PRO_CM' as TABLE_NAME,
   (select count(*) from PRO_CM JOIN N3C_COHORT ON PRO_CM.PATID = N3C_COHORT.PATID AND PRO_DATE >= '1/1/2018') as ROW_COUNT

UNION
   
select 
   'PROCEDURES' as TABLE_NAME,
   (select count(*) from PROCEDURES JOIN N3C_COHORT ON PROCEDURES.PATID = N3C_COHORT.PATID AND PX_DATE >= '1/1/2018') as ROW_COUNT

UNION
   
select 
   'PROVIDER' as TABLE_NAME,
   (select count(*) from PROVIDER) as ROW_COUNT

UNION
   
select 
   'VITAL' as TABLE_NAME,
   (select count(*) from VITAL JOIN N3C_COHORT ON VITAL.PATID = N3C_COHORT.PATID AND MEASURE_DATE >= '1/1/2018') as ROW_COUNT
);

--MANIFEST TABLE: CHANGE PER YOUR SITE'S SPECS
--OUTPUT_FILE: MANIFEST.csv
select
   'UNC' as SITE_ABBREV,
   'Jane Doe' as CONTACT_NAME,
   'jane_doe@unc.edu' as CONTACT_EMAIL,
   'PCORNET' as CDM_NAME,
   '5.1' as CDM_VERSION,
   'Y' as N3C_PHENOTYPE_YN,
   '1.3' as N3C_PHENOTYPE_VERSION,
   CONVERT(VARCHAR(20), GETDATE(), 120) as RUN_DATE,
   CONVERT(VARCHAR(20), GETDATE() -2, 120) as UPDATE_DATE,		--change integer based on your site's data latency
   CONVERT(VARCHAR(20), GETDATE() +3, 120) as NEXT_SUBMISSION_DATE					--change integer based on your site's load frequency
;
