-- =============================================
-- DEVELOPER:		OSIM JEREMIAH
-- Create date: 02-16-2026
-- Description:	4th Assignment. ETL SSIS 
-- Revise Date: 02-16-2026 
-- Version:		v1.0
-- ============================================= 

use EmadeDev


--1. How many encounters did we have before the year 2020?
SELECT COUNT(*) AS Total_Encounters
FROM [dbo].[EmadeEncounters]
WHERE START < '2020-01-01'


--2. How many distinct patients did we treat before the year 2020?
SELECT COUNT(DISTINCT PATIENT) AS Total_Patients
FROM [dbo].[EmadeEncounters]
WHERE START < '2020-01-01';


--3. How many distinct encounter classes are documented in the encounter table?
SELECT COUNT(DISTINCT ENCOUNTERCLASS) AS Encounter_Classes
FROM [dbo].[EmadeEncounters]
;

--4. How many inpatient and ambulatory encounters did we have before 2020?
SELECT ENCOUNTERCLASS, COUNT(*) AS Total
FROM [dbo].[EmadeEncounters]
WHERE START < '2020-01-01'
  AND ENCOUNTERCLASS IN ('inpatient', 'ambulatory')
GROUP BY ENCOUNTERCLASS
;


--5. What is our patient mix by gender, race and ethnicity?
SELECT gender, race, ethnicity, COUNT(*) AS Total
FROM [dbo].[EmadeFluDemoData]
GROUP BY gender, race, ethnicity
;


--6. How many states and zip codes do we treat patients from?
SELECT COUNT(DISTINCT org_state) AS total_states, COUNT(DISTINCT org_zip) AS total_zips
FROM [dbo].[EmadeHealthcareDemoData]


--7. Which county had the highest number of patients?
SELECT TOP 1 COUNTY, COUNT(*) AS Patient_Count
FROM [dbo].[EmadeFluDemoData]
WHERE COUNTY IS NOT NULL
GROUP BY COUNTY
ORDER BY Patient_Count DESC;


--8. Patient mix for patients who had an inpatient encounter in 2019
SELECT 
    p.GENDER,
    p.RACE,
    p.ETHNICITY,
    COUNT(DISTINCT e.PATIENT) AS Patient_Count
FROM dbo.EmadeEncounters e
JOIN dbo.EmadeFluDemoData p
    ON p.ID = e.PATIENT
WHERE e.ENCOUNTERCLASS = 'inpatient'
  AND e.START >= '2019-01-01'
  AND e.START <  '2020-01-01'
GROUP BY p.GENDER, p.RACE, p.ETHNICITY
ORDER BY Patient_Count DESC;

--9. How many inpatient encounters did we have in the entire dataset 
--where the patient was at least 21 years old at the time of the encounter start?
SELECT COUNT(*) AS Total_Encounters
FROM [dbo].[EmadeEncounters] e
JOIN [dbo].[EmadeHealthcareDemoData] p ON e.id = p.patient_id
WHERE e.ENCOUNTERCLASS = 'inpatient'
  AND DATEDIFF(YEAR, p.BIRTHDATE, e.START) >= 21;

 --10. many emergency encounters did we have in 2019?
 SELECT COUNT(*) AS Emergency_Encounters
FROM [dbo].[EmadeEncounters]
WHERE ENCOUNTERCLASS = 'emergency'
  AND YEAR(START) = 2019;


  --11. Conditions treated in emergency encounters in 2019
SELECT 
    c.DESCRIPTION,
    COUNT(*) AS Times_Documented
FROM dbo.EmadeEncounters e
JOIN dbo.EmadeConditions c
    ON c.ENCOUNTER = e.ID
WHERE e.ENCOUNTERCLASS = 'emergency'
  AND e.START >= '2019-01-01'
  AND e.START <  '2020-01-01'
  AND c.DESCRIPTION IS NOT NULL
GROUP BY c.DESCRIPTION
ORDER BY Times_Documented DESC;


--12. Emergency throughput (minutes) and how it varies by condition treated
SELECT
    c.DESCRIPTION,
    COUNT(DISTINCT e.ID) AS Emergency_Encounter_Count,
    AVG(CAST(DATEDIFF(MINUTE, e.START, e.STOP) AS DECIMAL(18,2))) AS Avg_Throughput_Minutes
FROM dbo.EmadeEncounters e
LEFT JOIN dbo.EmadeConditions c
    ON c.ENCOUNTER = e.ID
WHERE e.ENCOUNTERCLASS = 'emergency'
  AND e.START < '2020-01-01'
  AND e.STOP IS NOT NULL
  AND c.DESCRIPTION IS NOT NULL
GROUP BY c.DESCRIPTION
ORDER BY Avg_Throughput_Minutes DESC;


--13. How many emergency encounters did we have before 2020?
SELECT COUNT(*) AS Total
FROM [dbo].[EmadeEncounters]
WHERE ENCOUNTERCLASS = 'emergency'
  AND START < '2020-01-01';

 --14.  Other than nulls (where no condition was documented), 
 -- which condition was most documented for emergency encounters before 2020?
 SELECT TOP 1 c.DESCRIPTION, COUNT(*) AS Total
FROM [dbo].[EmadeConditions] c
JOIN [dbo].[EmadeEncounters] e ON c.ENCOUNTER = e.ID
WHERE e.ENCOUNTERCLASS = 'emergency'
  AND e.START < '2020-01-01'
  AND c.DESCRIPTION IS NOT NULL
GROUP BY c.DESCRIPTION
ORDER BY Total DESC;


--15. How many conditions (non-null) for emergency encounters before 2020
--had average ER throughput above 100 minutes?
SELECT COUNT(*) AS Conditions_Above_100_Min_Avg_Throughput
FROM (
    SELECT 
        c.DESCRIPTION
    FROM dbo.EmadeEncounters e
    JOIN dbo.EmadeConditions c
        ON c.ENCOUNTER = e.ID
    WHERE e.ENCOUNTERCLASS = 'emergency'
      AND e.START < '2020-01-01'
      AND e.STOP IS NOT NULL
      AND c.DESCRIPTION IS NOT NULL
    GROUP BY c.DESCRIPTION
    HAVING AVG(CAST(DATEDIFF(MINUTE, e.START, e.STOP) AS DECIMAL(18,2))) > 100
) x;




--16. What is total claim cost for each encounter in 2019?
SELECT ID AS ENCOUNTER_ID, TOTAL_CLAIM_COST, [DESCRIPTION],[START]
FROM [dbo].[EmadeEncounters]
WHERE YEAR(START) = 2019
ORDER BY TOTAL_CLAIM_COST DESC;

--17.  What is total payer coverage for each encounter in 2019?
SELECT ID AS ENCOUNTER_ID, PAYER_COVERAGE AS Total_Payer_Coverage
FROM [dbo].[EmadeEncounters]
WHERE YEAR(START) = 2019
ORDER BY PAYER_COVERAGE DESC;

--18. Which encounter types had the highest cost?
SELECT ENCOUNTERCLASS, 
SUM(CAST(TOTAL_CLAIM_COST AS DECIMAL(18,2))) AS Total_Cost
FROM [dbo].[EmadeEncounters] 
GROUP BY ENCOUNTERCLASS
ORDER BY Total_Cost DESC;

--19. Which encounter types had the highest cost covered by payers?
SELECT ENCOUNTERCLASS, 
SUM(CAST(PAYER_COVERAGE AS DECIMAL(18,2))) AS Total_Payer_Coverage
FROM [dbo].[EmadeEncounters] 
GROUP BY ENCOUNTERCLASS
ORDER BY Total_Payer_Coverage DESC;

--20. Which payer had the highest claim coverage percentage 
--(total payer coverage/ total claim cost) for encounters before 2020?
SELECT TOP 1 payer,
    AVG(
        CAST(payer_coverage AS DECIMAL(18,2))
        /
        CAST(total_claim_cost AS DECIMAL(18,2))
    ) * 100 AS coverage_pct
FROM [dbo].[EmadeEncounters]
WHERE start < '2020-01-01'
  AND TRY_CAST(total_claim_cost AS DECIMAL(18,2)) > 0
GROUP BY payer
ORDER BY coverage_pct DESC;

--21. Which payer had the highest claim coverage percentage 
--(total payer coverage / total claim cost) for ambulatory encounters before 2020?
SELECT TOP 1 payer,
        AVG(
            CAST(payer_coverage AS DECIMAL(18,2))
            /
            CAST(total_claim_cost AS DECIMAL(18,2))
          ) * 100 AS coverage_pct
FROM [dbo].[EmadeEncounters]
WHERE encounterclass = 'ambulatory' AND start < '2020-01-01'
AND CAST(total_claim_cost AS DECIMAL(18,2)) > 0
GROUP BY payer
ORDER BY coverage_pct DESC;


--22. How many different types of procedures did we perform in 2019?
SELECT COUNT(DISTINCT [DESCRIPTION]) AS different_procedure_types_2019
FROM [dbo].[EmadeConditions]
WHERE START >= '2019-01-01'
    AND START < '2020-01-01';


  --23. How many procedures were performed across each care setting (inpatient/ambulatory)?
SELECT e.ENCOUNTERCLASS AS Care_Setting, COUNT(c.code) AS Procedure_Count
FROM [dbo].[EmadeConditions] c
JOIN [dbo].[EmadeEncounters] e ON c.ENCOUNTER = e.Id
WHERE e.ENCOUNTERCLASS IN ('inpatient', 'ambulatory')
GROUP BY e.ENCOUNTERCLASS;

--24. Which organizations performed the most inpatient procedures in 2019?
SELECT ORGANIZATION,
COUNT(*) AS procedure_count
FROM [dbo].[EmadeEncounters] WHERE ENCOUNTERCLASS = 'inpatient'
AND START BETWEEN '2019-01-01' AND '2019-12-31'
GROUP BY ORGANIZATION
ORDER BY procedure_count DESC;

--25. How many Colonoscopy procedures were performed before 2020?
-- Colonoscopy Reference N/A IN DATESET CHECKED ALL TABLES USING

SELECT [DESCRIPTION], COUNT([DESCRIPTION]) AS ProceduresReason
FROM [dbo].[EmadeEncounters]
GROUP BY [DESCRIPTION]

--26. Compare our total number of procedures in 2018 to 2019. Did we perform more procedures in 2019 or less?
SELECT
    SUM(CASE WHEN YEAR(CAST(START AS DATE)) = 2018 THEN 1 ELSE 0 END) AS procedures_2018,
    SUM(CASE WHEN YEAR(CAST(START AS DATE)) = 2019 THEN 1 ELSE 0 END) AS procedures_2019,
    CASE
        WHEN SUM(CASE WHEN YEAR(CAST(START AS DATE)) = 2019 THEN 1 ELSE 0 END) >
             SUM(CASE WHEN YEAR(CAST(START AS DATE)) = 2018 THEN 1 ELSE 0 END)
        THEN 'INCREASE'
        ELSE 'DECREASE'
    END AS comparison_result
FROM [dbo].[EmadeConditions]
WHERE YEAR(CAST(START AS DATE)) IN (2018, 2019);

--27. Which organizations performed the most Auscultation of the fetal heart procedures before 2020? 
--Give answer with Organization ID.
--Auscultation Reference N/A IN DATESET CHECKED ALL TABLES USING
SELECT [REASONDESCRIPTION], COUNT([REASONDESCRIPTION]) AS ProceduresReason
FROM [dbo].[EmadeCareplans]
GROUP BY [REASONDESCRIPTION]

--28. Which race had the highest number of procedures done in 2019?
SELECT TOP 1 p.RACE, COUNT(DISTINCT PATIENT) AS Procedure_Count
FROM [dbo].[EmadeEncounters] PY
INNER JOIN [dbo].[EmadeFluDemoData] p ON PY.PATIENT = p.Id
WHERE PY.START >= '2019-01-01' AND PY.START < '2020-01-01'
GROUP BY p.RACE
ORDER BY Procedure_Count DESC;

SELECT TOP 1 p.RACE, COUNT(DISTINCT P.PATIENT) AS Procedure_Count
FROM [dbo].[EmadeEncounters] pr
INNER JOIN [dbo].[EmadeFluDemoData] p ON pr.PATIENT = p.Id
WHERE pr.START >= '2019-01-01' AND pr.START < '2020-01-01'
GROUP BY p.RACE
ORDER BY Procedure_Count DESC;

Select *
From  [dbo].[EmadeEncounters]

--29. Which race had the highest number of Colonoscopy procedures performed before 2020?
-- Colonoscopy Reference N/A IN DATESET CHECKED ALL TABLES USING
SELECT [DESCRIPTION], COUNT([DESCRIPTION]) AS ProceduresReason
FROM [dbo].[EmadeEncounters]
GROUP BY [DESCRIPTION];

--30. How many patients had documented uncontrolled hypertension at any time in
--2018 and 2019? (140/90 is cutoff)
SELECT F.[REASONDESCRIPTION], COUNT(DISTINCT F.[PATIENT]) AS Patient_Count
FROM [dbo].[EmadeCareplans] f
JOIN [dbo].[EmadeEncounters] e ON f.patient = e.PATIENT
WHERE F.[REASONDESCRIPTION] = 'Hypertension'
AND e.START BETWEEN '2018-01-01' AND '2019-12-31'
GROUP BY F.[REASONDESCRIPTION];

SELECT F.[REASONDESCRIPTION], COUNT(DISTINCT F.[PATIENT]) AS Patient_Count
FROM [dbo].[EmadeMedications] f
WHERE F.[REASONDESCRIPTION] = 'Hypertension'
AND F.START BETWEEN '2018-01-01' AND '2019-12-31'
GROUP BY F.[REASONDESCRIPTION];

--31. Which providers treated patients with uncontrolled hypertension in 2018 and 2019?
--/**Logic:
--i. In the table: [observations], use the fields: DESCRIPTION and VALUE
--ii. Build a data flow logic to show:
--iii. Diastolic Blood Pressure would be value not up to 90
--iv. Systolic Blood Pressure  would be value more than up 140
--**/



--32. What medications were given to patients with uncontrolled hypertension?

SELECT [DESCRIPTION], [REASONDESCRIPTION], COUNT(DISTINCT [REASONDESCRIPTION]) AS Patient_Count
FROM [dbo].[EmadeMedications] f
WHERE F.[REASONDESCRIPTION] = 'Hypertension'
GROUP BY [DESCRIPTION],[REASONDESCRIPTION];

--33. What was the most commonly prescribed medication to the patients with hypertension (as identified as having a BP over 140/90 at any point in 2018 or 2019)?
SELECT TOP 1 [DESCRIPTION], [REASONDESCRIPTION],
COUNT(DISTINCT [PATIENT]) AS Patient_Count
FROM [dbo].[EmadeMedications] f
WHERE [REASONDESCRIPTION] = 'Hypertension'
AND START BETWEEN '2018-01-01' AND '2019-12-31'
GROUP BY [DESCRIPTION],[REASONDESCRIPTION];

--34. Which race had the highest total number of patients with a BP of 140/90 before 2020?
SELECT TOP 1 p.RACE, COUNT(DISTINCT PATIENT) AS Patients_Count
FROM [dbo].[EmadeEncounters] pr
INNER JOIN [dbo].[EmadeFluDemoData] p ON pr.PATIENT = p.Id
WHERE pr.START >= '2019-01-01' AND pr.START < '2020-01-01'
GROUP BY p.RACE
ORDER BY Patients_Count DESC;



