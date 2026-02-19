--ETL SSIS EH_ENCOUNTER– 3rd Assignment

Use EmadeDev

--1. Lists out number of patients in descending order
--Does not include Quincy
--Must have at least 2 patients from that city
SELECT 
    City,
    COUNT(Id) AS NumberOfPatients
FROM [dbo].[EHR_patients]
WHERE City <> 'Quincy'
GROUP BY City
HAVING COUNT(Id) >= 2
ORDER BY NumberOfPatients DESC;

--2.To find out the Top 10 patients with the most visits to the hospital
SELECT TOP 10
    e.Patient,
    COUNT(e.Id) AS TotalVisits
FROM [dbo].[EHREncounter] e
GROUP BY e.Patient
ORDER BY TotalVisits DESC;

--3.To find out the number of times patients from each city visited the hospital.
SELECT 
    p.City,
    COUNT(e.Id) AS TotalVisits
FROM [dbo].[EHREncounter] e
JOIN [dbo].[EHR_patients] p
    ON e.Patient = p.Id
GROUP BY p.City
ORDER BY TotalVisits DESC;

--4. To find out the cities with up to 50 counts of emergency cases.
SELECT 
    p.City,
    COUNT(e.Id) AS EmergencyCount
FROM [dbo].[EHREncounter] e
JOIN [dbo].[EHR_patients] p
    ON e.Patient = p.Id
WHERE e.EncounterClass = 'emergency'
GROUP BY p.City
HAVING COUNT(e.Id) <= 50
ORDER BY EmergencyCount DESC;

--5. Now to find out the number of patients from Boston who came in 2020.
SELECT 
    COUNT(DISTINCT e.Patient) AS BostonPatients2020
FROM [dbo].[EHREncounter] e
JOIN [dbo].[EHR_patients] p
    ON e.Patient = p.Id
WHERE p.City = 'Boston'
AND YEAR(e.Start) = 2020;

--6.To find out the top recurring conditions.
SELECT TOP 10
    Description,
    COUNT(*) AS OccurrenceCount
FROM [dbo].[EmadeConditions]
GROUP BY Description
ORDER BY OccurrenceCount DESC;

--7. To find out the month with the highest number of ambulatory cases since 2010.
SELECT TOP 1
    YEAR(Start) AS Year,
    MONTH(Start) AS Month,
    COUNT(*) AS AmbulatoryCount
FROM [dbo].[EHREncounter]
WHERE EncounterClass = 'ambulatory'
AND YEAR(Start) >= 2010
GROUP BY YEAR(Start), MONTH(Start)
ORDER BY AmbulatoryCount DESC;

--8.To find out the month with the highest number of emergency cases since 2010.
SELECT TOP 1
    YEAR(Start) AS Year,
    MONTH(Start) AS Month,
    COUNT(*) AS EmergencyCount
FROM [dbo].[EHREncounter]
WHERE EncounterClass = 'emergency'
AND YEAR(Start) >= 2010
GROUP BY YEAR(Start), MONTH(Start)
ORDER BY EmergencyCount DESC;

--9. Now to find out the Top 15 years with the most immunizations.
SELECT TOP 15
    YEAR(Date) AS Year,
    COUNT(*) AS ImmunizationCount
FROM [dbo].[EmadeImmunizations]
GROUP BY YEAR(Date)
ORDER BY ImmunizationCount DESC;