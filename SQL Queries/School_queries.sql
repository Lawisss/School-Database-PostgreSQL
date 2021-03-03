--  SQL Queries

------------------------------------------------------------
-- [1] List the names, first names and dates of birth of all the students.
------------------------------------------------------------
SELECT NOM, PRENOM, DATE_NAISSANCE FROM ELEVES;
SELECT ELEVES.NOM, ELEVES.PRENOM, ELEVES.DATE_NAISSANCE FROM ELEVES;

------------------------------------------------------------
-- [2] Provide full information on all activities.
------------------------------------------------------------

SELECT * FROM ACTIVITES;
SELECT ACTIVITES.* FROM ACTIVITES;

------------------------------------------------------------
-- [3] List the specialties of the teachers.
------------------------------------------------------------

SELECT SPECIALITE FROM PROFESSEURS;
SELECT PROFESSEURS.SPECIALITE FROM PROFESSEURS;

------------------------------------------------------------
-- [4] Obtain the name and surname of students weighing less than 45 kilos and enrolled in 1st year or of students enrolled in 2nd year.
------------------------------------------------------------

SELECT ELEVES.NOM, ELEVES.PRENOM FROM ELEVES
WHERE ELEVES.POIDS < 45 AND (ELEVES.ANNEE = 1 OR ELEVES.ANNEE = 2);

------------------------------------------------------------
-- [5] Obtain the names of the students whose weight is between 60 and 80 kilos.
------------------------------------------------------------

SELECT ELEVES.NOM FROM ELEVES 
WHERE ELEVES.POIDS BETWEEN 60 AND 80;

------------------------------------------------------------
-- [6] Obtain the names of professors whose specialty is "poésie" or SQL.
------------------------------------------------------------

SELECT PROFESSEURS.NOM FROM PROFESSEURS 
WHERE (SPECIALITE = 'poésie' OR SPECIALITE = 'sql');

------------------------------------------------------------
-- [7] Obtain the names of students whose names begin with "L".
------------------------------------------------------------

SELECT * FROM ELEVES 
WHERE ELEVES.NOM = 'L%';

------------------------------------------------------------
-- [8] Obtain the names of professors whose specialties are unknown.
------------------------------------------------------------

SELECT PROFESSEURS.* FROM PROFESSEURS
WHERE PROFESSEURS.SPECIALITE = '';

------------------------------------------------------------
-- [9] Obtain the name and surname of students weighing less than 45 kilos and enrolled in 1st year.
------------------------------------------------------------

SELECT ELEVES.NOM, ELEVES.PRENOM FROM ELEVES 
WHERE (ELEVES.POIDS < 45 AND ELEVES.ANNEE = 1);

------------------------------------------------------------
-- [10] Obtain, for each professor, his name and his specialty. If the latter is unknown, we want to display the character string: `****'.
------------------------------------------------------------

SELECT PROFESSEURS.NOM, PROFESSEURS.SPECIALITE FROM PROFESSEURS;

------------------------------------------------------------
-- [11] What are the first and last names of the students who practice surfing at level 1. Write this request in five different ways.
------------------------------------------------------------

SELECT ELEVES.NOM, ELEVES.PRENOM FROM ELEVES
INNER JOIN ACTIVITES_PRATIQUEES ON ACTIVITES_PRATIQUEES.NUM_ELEVE = ELEVES.NUM_ELEVE
WHERE (ACTIVITES_PRATIQUEES.NOM = 'Surf' AND ACTIVITES_PRATIQUEES.NIVEAU = 1);

------------------------------------------------------------
-- [12] Obtain the names of the students of the AMC INDUS team.
------------------------------------------------------------

SELECT ELEVES.NOM FROM ELEVES
INNER JOIN ACTIVITES_PRATIQUEES ON ACTIVITES_PRATIQUEES.NUM_ELEVE = ELEVES.NUM_ELEVE
INNER JOIN ACTIVITES ON ACTIVITES.NOM = ACTIVITES_PRATIQUEES.NOM
WHERE ACTIVITES.EQUIPE = 'Amc Indus';

------------------------------------------------------------
-- [13] Obtain peer names of professors who have the same specialty.
------------------------------------------------------------

SELECT SPECIALITE, NOM FROM PROFESSEURS
ORDER BY SPECIALITE;

------------------------------------------------------------
-- [14] For each sql / SQL specialty, you are asked to get its name, its current monthly salary and its monthly increase from its base salary.
------------------------------------------------------------

SELECT PROFESSEURS.NOM, PROFESSEURS.SALAIRE_ACTUEL/12 FROM PROFESSEURS
WHERE PROFESSEURS.SPECIALITE = 'sql';

------------------------------------------------------------
-- [15] Obtain the names of professors whose base salary increase exceeds 25
------------------------------------------------------------

SELECT PROFESSEURS.* FROM PROFESSEURS 
WHERE PROFESSEURS.SALAIRE_BASE > 25;

------------------------------------------------------------
-- [16] Display the Tsuno points obtained in each course out of 100 rather than 20.
------------------------------------------------------------

SELECT RESULTATS.POINTS*5 FROM RESULTATS
INNER JOIN ELEVES ON ELEVES.NUM_ELEVE = RESULTATS.NUM_ELEVE
WHERE ELEVES.NOM = 'Tsuno'
ORDER BY NUM_COURS;

------------------------------------------------------------
-- [17] Obtain the average weight of the 1st year students.
------------------------------------------------------------

SELECT AVG(POINTS) FROM RESULTATS
INNER JOIN ELEVES ON ELEVES.NUM_ELEVE = RESULTATS.NUM_ELEVE
WHERE ELEVES.ANNEE = 1;

------------------------------------------------------------
-- [18] Obtain the total points for student number 3.
------------------------------------------------------------

SELECT SUM(POINTS) FROM RESULTATS 
WHERE NUM_ELEVE = 3;

------------------------------------------------------------
-- [19] Obtain the smallest and greatest odds from Student Brisefer.
------------------------------------------------------------

SELECT MIN(RESULTATS.POINTS), MAX(RESULTATS.POINTS) FROM RESULTATS
INNER JOIN ELEVES ON ELEVES.NUM_ELEVE = RESULTATS.NUM_ELEVE
WHERE ELEVES.NOM = 'Brisefer';

------------------------------------------------------------
-- [20] Obtain the number of students enrolled in the second year.
------------------------------------------------------------

SELECT COUNT(*) FROM eleves
WHERE annee = 2

------------------------------------------------------------
-- [21] What is the average monthly salary increase for SQL teachers?
------------------------------------------------------------

SELECT AVG (salaire_actuel) FROM professeurs
WHERE specialite = 'sql';

------------------------------------------------------------
-- [22] Obtain the year of Professor Pucette's last promotion.
------------------------------------------------------------

SELECT der_prom FROM professeurs 

WHERE nom = 'Pucette';
------------------------------------------------------------
-- [23] For each professor, display his draft date, his date of last promotion as well as the number of years elapsed between these two dates.
------------------------------------------------------------

SELECT nom, date_entree, der_prom, (Extract (year FROM der_prom) - Extract (year FROM date_entree)) AS years_elapsed FROM professeurs

------------------------------------------------------------
-- [24] Display the average age of students. This average age will be expressed in years.
------------------------------------------------------------

SELECT AVG(2021 - Extract (year FROM date_naissance)) FROM eleves

------------------------------------------------------------
-- [26] Obtain the list of students who will be at least 24 years old in less than 4 months.
------------------------------------------------------------

SELECT * FROM eleves
WHERE YEAR(CURDATE())-YEAR(DATE_ADD(DATE_NAISSANCE, INTERVAL 4 MONTH));

------------------------------------------------------------
-- [27] Obtain a list of students classified by grade and alphabetically.
------------------------------------------------------------

SELECT * from eleves 
INNER JOIN resultats ON resultats.NUM_ELEVE=eleves.NUM_ELEVE 
ORDER BY resultats.POINTS, eleves.NOM

------------------------------------------------------------
-- [28] Display in descending order the Tsuno points obtained in each course out of 100 rather than out of 20.
------------------------------------------------------------

SELECT * FROM eleves
INNER JOIN resultats ON resultats.NUM_ELEVE=eleves.NUM_ELEVE
WHERE NOM = 'Tsuno'
ORDER BY resultats.POINTS*5 DESC

------------------------------------------------------------
-- [29] Obtain his name and his average for each 1st year pupil.
------------------------------------------------------------
SELECT Nom,AVG(resultats.POINTS) FROM eleves
INNER JOIN resultats ON resultats.NUM_ELEVE=eleves.NUM_ELEVE
WHERE eleves.annee = 1
------------------------------------------------------------
-- [30] Obtain the average points for each 1st year student whose total points are greater than 40.
------------------------------------------------------------

SELECT Nom,AVG(resultats.POINTS) FROM eleves
INNER JOIN resultats ON resultats.NUM_ELEVE=eleves.NUM_ELEVE
WHERE eleves.annee = 1
GROUP BY eleves.NUM_ELEVE
HAVING SUM(resultats.POINTS) > 40

------------------------------------------------------------
-- [31] Obtain the maximum among the totals for each student.
------------------------------------------------------------

SELECT *,SUM(resultats.POINTS) FROM eleves INNER JOIN resultats ON resultats.NUM_ELEVE=eleves.NUM_ELEVE GROUP BY eleves.NUM_ELEVE

------------------------------------------------------------
-- [32] Obtain the names of the students who play on the AMC INDUS team.
------------------------------------------------------------

SELECT DISTINCT eleves.nom FROM eleves
INNER JOIN activites_pratiquees ON activites_pratiquees.NUM_ELEVE=eleves.NUM_ELEVE
INNER JOIN activites ON activites_pratiquees.NIVEAU=activites.NIVEAU
WHERE activites.EQUIPE = 'Amc Indus'

------------------------------------------------------------
-- [33] Which 1st year students have an average higher than the 1st year average?
------------------------------------------------------------

SELECT * FROM eleves
INNER JOIN resultats on resultats.NUM_ELEVE = eleves.NUM_ELEVE
WHERE ANNEE = 1
GROUP BY eleves.NUM_ELEVE
HAVING AVG(resultats.POINTS) > (SELECT AVG(resultats.POINTS) FROM resultats
                                INNER JOIN eleves on resultats.NUM_ELEVE = eleves.NUM_ELEVE
                                WHERE ANNEE = 1)

------------------------------------------------------------
-- [34] Obtain the name and weight of grade 1 students heavier than any grade 2 student.
------------------------------------------------------------

SELECT eleves.NOM, POIDS FROM eleves
INNER JOIN activites_pratiquees ON eleves.NUM_ELEVE = activites_pratiquees.NUM_ELEVE
WHERE Niveau = 1
GROUP BY eleves.NUM_ELEVE
HAVING POIDS > ANY (SELECT POIDS FROM eleves
                    INNER JOIN activites_pratiquees ON eleves.NUM_ELEVE = activites_pratiquees.NUM_ELEVE
                    WHERE Niveau = 2)

------------------------------------------------------------
-- [35] Obtain the name and weight of grade 1 students heavier than any grade 2 student.
------------------------------------------------------------

SELECT eleves.NOM, POIDS FROM eleves
INNER JOIN activites_pratiquees ON eleves.NUM_ELEVE = activites_pratiquees.NUM_ELEVE
WHERE Niveau = 1
GROUP BY eleves.NUM_ELEVE
HAVING POIDS > ANY (SELECT POIDS FROM eleves
                    INNER JOIN activites_pratiquees ON eleves.NUM_ELEVE = activites_pratiquees.NUM_ELEVE
                    WHERE Niveau = 2)
------------------------------------------------------------
-- [36] Obtain the name, weight and grade of students weighing more than the average weight of students in the same grade.
------------------------------------------------------------

SELECT eleves.NOM, POIDS, NIVEAU FROM eleves
INNER JOIN activites_pratiquees ON eleves.NUM_ELEVE = activites_pratiquees.NUM_ELEVE
GROUP BY NIVEAU
HAVING POIDS >  (SELECT AVG(POIDS) FROM eleves
                INNER JOIN activites_pratiquees ON eleves.NUM_ELEVE = activites_pratiquees.NUM_ELEVE
                GROUP BY NIVEAU)

------------------------------------------------------------
-- [37] Obtain the names of teachers who are not teaching class 1.
------------------------------------------------------------

SELECT professeurs.NOM from professeurs
INNER JOIN COURS ON professeurs.SPECIALITE = cours.NOM
WHERE ANNEE !=1

------------------------------------------------------------
-- [38] Obtain the names of grade 1 students who have obtained more than 60
------------------------------------------------------------

SELECT eleves.nom FROM eleves
INNER JOIN activites_pratiquees on activites_pratiquees.NUM_ELEVE = eleves.NUM_ELEVE
INNER JOIN resultats ON resultats.NUM_ELEVE = eleves.NUM_ELEVE
WHERE NIVEAU = 1
GROUP BY eleves.NUM_ELEVE
HAVING SUM(resultats.POINTS) > 60

------------------------------------------------------------
-- [39] Teachers who take charge of all the second year courses; we ask for the Number and the name.
------------------------------------------------------------

SELECT professeurs.NUM_PROF, professeurs.NOM FROM professeurs
INNER JOIN cours on cours.NOM = professeurs.SPECIALITE
WHERE ANNEE = 2

------------------------------------------------------------
-- [40] Students who practice all the activities; we ask for the Number and the name.
------------------------------------------------------------