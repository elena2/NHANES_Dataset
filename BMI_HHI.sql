SELECT 

CASE WHEN "BMDBMIC" = 1 THEN 'Underweight'
	 WHEN "BMDBMIC" = 2 THEN 'Normal Weight'
	 WHEN "BMDBMIC" = 3 THEN 'Overweight'
	 WHEN "BMDBMIC" = 4 THEN 'Obese'
	 END AS BMI_Category,
	 
CASE WHEN "INDHHIN2" = 1 or "INDHHIN2" =2 or "INDHHIN2" =3 or "INDHHIN2" =4 or "INDHHIN2" =13 then '$ 0 to $ 19,999'
     WHEN "INDHHIN2" = 5 or "INDHHIN2" = 6 or "INDHHIN2" =7 or "INDHHIN2" =8 or "INDHHIN2" =9 or "INDHHIN2" =12 then '$20,000 to $64,999'
     WHEN "INDHHIN2" = 10 or "INDHHIN2" = 14 or "INDHHIN2" =15 then '$65,000 to $100,000 and Over'
     WHEN "INDHHIN2" = 77 or "INDHHIN2" = 99 then 'Refused or dont know'

      Else 'missing'
	 END AS hhi,
count(*),
(SELECT COUNT(*)
FROM demographic AS D
LEFT JOIN examination AS E
ON D."SEQN" = E."SEQN"
WHERE NOT "BMDBMIC" IS NULL ) AS total,

(COUNT(*)::float / (SELECT COUNT(*)
FROM examination  WHERE "BMDBMIC" IS NOT NULL )::FLOAT) AS Percent_Total

	 
FROM demographic AS D
LEFT JOIN examination AS E
ON D."SEQN" = E."SEQN"
WHERE "BMDBMIC" IS NOT NULL
GROUP BY BMI_category, hhi
ORDER BY hhi
