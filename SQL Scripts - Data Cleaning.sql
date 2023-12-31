--Datasets overview

SELECT*
FROM movies1
SELECT*
FROM movies2


--Filtering data of interest from the main dataset (movies1) and renaming column titles for better aestetics

SELECT movies1.title as Title, year as Year, genre as Genre, production_cost as Production_Cost, worldwide_gross as Worldwide_Gross, runtime as Runtime
FROM movies1
Order by year DESC


--Joining movies2 into movies1 based on movie title and the release year, and creating a new table "FinalTop" with the final clean data

CREATE TABLE FinalTop (Title nvarchar(100), Genre nvarchar(50), Year smallint, Production_cost int, Wordlwide_Gross bigint, Runtime tinyint, RatingAVG real)
INSERT INTO FinalTop
SELECT movies1.title as Title, genre as Genre, year as Year, production_cost as Production_Cost, worldwide_gross as Worldwide_Gross, runtime as Runtime, movies2.vote_average as RatingAVG
FROM movies1
Left Join Top500..movies2
On movies1.title=movies2.title AND movies1.year=YEAR(movies2.release_date)

SELECT*
FROM FinalTop
Order by Year DESC


--Creating a categorical variable based on Production Cost for future statistical analysis in R, and filtering Action and Adventure movies

SELECT*,
CASE
	WHEN Production_cost BETWEEN 50000000 AND 99999999 THEN 'Low'
	WHEN Production_cost BETWEEN 100000000 AND 149999999 THEN 'Medium'
	WHEN Production_cost BETWEEN 150000000 AND 199999999 THEN 'High'
	ELSE 'Very High'
	END as Cost_range
FROM FinalTop
WHERE Genre='Action' OR Genre='Adventure'
Order by Production_Cost DESC