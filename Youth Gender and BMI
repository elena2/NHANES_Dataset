-- The percent total column divides youth gender and BMI_Category (Male, Normal Weight) by the total number of participants who had BMI measured. The percenatge of youth males and females in the BMI categories are similar, suggesting youth gender does effect BMI.  



SELECT
CASE WHEN "RIAGENDR" = 1 THEN 'Male'
	 WHEN "RIAGENDR" = 2 THEN 'Female'
	 ELSE 'other'
	 END AS Gender,
CASE WHEN "BMDBMIC" = 1 THEN 'Underweight'
	 WHEN "BMDBMIC" = 2 THEN 'Normal Weight'
	 WHEN "BMDBMIC" = 3 THEN 'Overweight'
	 WHEN "BMDBMIC" = 4 THEN 'Obese'
	 Else 'missing'
	 END AS BMI_Category,

-- (SELECT COUNT(*)
-- FROM examination) AS total_count,

(COUNT(*)::float / (SELECT COUNT(*)
FROM examination  WHERE "BMDBMIC" IS NOT NULL)::FLOAT) AS Percent_Total


FROM demographic AS D
INNER JOIN examination AS E
ON D."SEQN" = E."SEQN"
WHERE "BMDBMIC" IS NOT NULL
GROUP BY gender, BMI_Category
ORDER BY BMI_Category;
