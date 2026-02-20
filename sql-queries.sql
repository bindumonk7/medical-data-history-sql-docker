-- 1. Show first name, last name, and gender of male patients
SELECT first_name, last_name, gender
FROM patients
WHERE gender = 'M';

-- 2. Show first name and last name of patients whose last name starts with 'C'
SELECT first_name, last_name
FROM patients
WHERE last_name LIKE 'C%';

-- 3. Show patients whose weight is between 100 and 120
SELECT *
FROM patients
WHERE weight BETWEEN 100 AND 120;

-- 4. Update patients with NULL allergies to 'NKA'
-- NOTE: May not execute due to read-only permissions
UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

-- 5. Show full name of patients
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM patients;

-- 6. Show first name, last name, and province name
SELECT p.first_name, p.last_name, pr.province_name
FROM patients p
JOIN province_names pr
ON p.province_id = pr.province_id;

-- 7. Count total number of patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- 8. Show patients born in the year 1970
SELECT *
FROM patients
WHERE YEAR(birth_date) = 1970;

-- 9. Show patient with the maximum height
SELECT first_name, last_name, height
FROM patients
ORDER BY height DESC
LIMIT 1;

-- 10. Count total number of admissions
SELECT COUNT(*) AS total_admissions
FROM admissions;

-- 11. Show admissions where admission date equals discharge date
SELECT *
FROM admissions
WHERE admission_date = discharge_date;

-- 12. Show patient IDs with more than one admission
SELECT patient_id, COUNT(*) AS admission_count
FROM admissions
GROUP BY patient_id
HAVING COUNT(*) > 1;

-- 13. Show city and number of patients in each city
SELECT city, COUNT(*) AS patient_count
FROM patients
GROUP BY city;

-- 14. Show unique first names
SELECT DISTINCT first_name
FROM patients;

-- 15. Show first name, last name, and diagnosis
SELECT p.first_name, p.last_name, a.diagnosis
FROM patients p
JOIN admissions a
ON p.patient_id = a.patient_id;

-- 16. Show number of patients by gender
SELECT gender, COUNT(*) AS total
FROM patients
GROUP BY gender;

-- 17. Show doctors and their specialties
SELECT first_name, last_name, specialty
FROM doctors;

-- 18. Show admissions with diagnosis 'Epilepsy'
SELECT *
FROM admissions
WHERE diagnosis = 'Epilepsy';

-- 19. Show epilepsy patients treated by doctor Lisa
SELECT p.first_name, p.last_name
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN doctors d ON a.attending_doctor_id = d.doctor_id
WHERE a.diagnosis = 'Epilepsy'
AND d.first_name = 'Lisa';

-- 20. Show total height of patients per province
SELECT pr.province_name, SUM(p.height) AS total_height
FROM patients p
JOIN province_names pr
ON p.province_id = pr.province_id
GROUP BY pr.province_name;

-- 21. Show total male and female patients in one row
SELECT
SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) AS males,
SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) AS females
FROM patients;

-- 22. Show patients with weight groups
SELECT first_name, last_name,
CASE
WHEN weight < 100 THEN 'Underweight'
WHEN weight BETWEEN 100 AND 150 THEN 'Normal'
ELSE 'Overweight'
END AS weight_group
FROM patients;

-- 23. Show number of admissions per day of the month
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS total_admissions
FROM admissions
GROUP BY DAY(admission_date);

-- 24. Show patients ordered by height in descending order
SELECT first_name, last_name, height
FROM patients
ORDER BY height DESC;

-- 25. Show patients without allergies
SELECT *
FROM patients
WHERE allergies IS NULL OR allergies = 'NKA';

-- 26. Show patients older than 50 years
SELECT *
FROM patients
WHERE YEAR(CURDATE()) - YEAR(birth_date) > 50;

-- 27. Count total number of doctors
SELECT COUNT(*) AS total_doctors
FROM doctors;

-- 28. Show diagnosis and number of admissions for each diagnosis
SELECT diagnosis, COUNT(*) AS diagnosis_count
FROM admissions
GROUP BY diagnosis;

-- 29. Show patients admitted more than once
SELECT patient_id
FROM admissions
GROUP BY patient_id
HAVING COUNT(*) > 1;

-- 30. Show earliest and latest admission dates
SELECT MIN(admission_date) AS first_admission,
MAX(admission_date) AS last_admission
FROM admissions;

-- 31. Show number of admissions handled by each doctor
SELECT attending_doctor_id, COUNT(*) AS total_admissions
FROM admissions
GROUP BY attending_doctor_id;

-- 32. Show patient names with their province names
SELECT p.first_name, p.last_name, pr.province_name
FROM patients p
JOIN province_names pr
ON p.province_id = pr.province_id;

-- 33. Show obesity flag using BMI calculation
SELECT first_name, last_name,
CASE
WHEN weight / POWER(height/100, 2) >= 30 THEN 1
ELSE 0
END AS isObese
FROM patients;

-- 34. Show BMI value for each patient
SELECT first_name, last_name,
(weight / POWER(height/100, 2)) AS BMI
FROM patients;

-- 35. Generate temporary password for each patient
SELECT DISTINCT
CONCAT(patient_id, LENGTH(last_name), YEAR(birth_date)) AS temp_password
FROM patients;

