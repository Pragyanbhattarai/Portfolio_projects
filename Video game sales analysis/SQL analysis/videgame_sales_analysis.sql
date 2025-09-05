use Portfolio_project;

select * from ps4gamesales
select * from videogamesales2016
select * from xboxgamesales

-- Identifying null values
SELECT 
    SUM(CASE WHEN Game IS NULL THEN 1 ELSE 0 END) AS null_count_game,
    SUM(CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS null_count_year,					
	SUM(CASE WHEN Genre IS NULL THEN 1 ELSE 0 END) AS null_count_genre,
	SUM(CASE WHEN Publisher IS NULL THEN 1 ELSE 0 END) AS null_count_publisher,			
	SUM(CASE WHEN North_America IS NULL THEN 1 ELSE 0 END) AS null_count_North_America,
	SUM(CASE WHEN Europe IS NULL THEN 1 ELSE 0 END) AS null_count_North_Europe,
	SUM(CASE WHEN Japan IS NULL THEN 1 ELSE 0 END) AS null_count_North_Japan,
	SUM(CASE WHEN Rest_of_World IS NULL THEN 1 ELSE 0 END) AS null_count_world,			
	SUM(CASE WHEN Global IS NULL THEN 1 ELSE 0 END) AS null_count_global				
FROM ps4gamesales


SELECT 
	SUM (CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS null_count_name,
	SUM (CASE WHEN Platform IS NULL THEN 1 ELSE 0 END) AS null_count_platform,
	SUM (CASE WHEN Year_of_release IS NULL THEN 1 ELSE 0 END) AS null_count_yor,
	SUM (CASE WHEN Genre IS NULL THEN 1 ELSE 0 END) AS null_count_genre,
	SUM (CASE WHEN Publisher IS NULL THEN 1 ELSE 0 END) AS null_count_publisher,
	SUM (CASE WHEN NA_Sales IS NULL THEN 1 ELSE 0 END) AS null_count_NAsales,
	SUM (CASE WHEN EU_Sales IS NULL THEN 1 ELSE 0 END) AS null_count_EUsales,
	SUM (CASE WHEN JP_Sales IS NULL THEN 1 ELSE 0 END) AS null_count_JPsales,
	SUM (CASE WHEN Other_Sales IS NULL THEN 1 ELSE 0 END) AS null_count_othersales,
	SUM (CASE WHEN Critic_Score IS NULL THEN 1 ELSE 0 END) AS null_count_criticscore,
	SUM (CASE WHEN Critic_Count IS NULL THEN 1 ELSE 0 END) AS null_count_criticcount,
	SUM (CASE WHEN User_Score IS NULL THEN 1 ELSE 0 END) AS null_count_userscore,
	SUM (CASE WHEN User_Count IS NULL THEN 1 ELSE 0 END) AS null_count_usercount,
	SUM (CASE WHEN Developer IS NULL THEN 1 ELSE 0 END) AS null_count_developer,
	SUM (CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_count_rating
FROM videogamesales2016

SELECT 
	SUM (CASE WHEN Pos IS NULL THEN 1 ELSE 0 END) AS null_count_pos,
	SUM (CASE WHEN Game IS NULL THEN 1 ELSE 0 END) AS null_count_game,
	SUM (CASE WHEN Year IS NULL THEN 1 ELSE 0 END) AS null_count_year,
	SUM (CASE WHEN Genre IS NULL THEN 1 ELSE 0 END) AS null_count_genre,
	SUM (CASE WHEN Publisher IS NULL THEN 1 ELSE 0 END) AS null_count_publisher,
	SUM (CASE WHEN North_America IS NULL THEN 1 ELSE 0 END) AS null_count_NA,
	SUM (CASE WHEN Europe IS NULL THEN 1 ELSE 0 END) AS null_count_EU,
	SUM (CASE WHEN Japan IS NULL THEN 1 ELSE 0 END) AS null_count_JP,
	SUM (CASE WHEN Rest_of_World IS NULL THEN 1 ELSE 0 END) AS null_count_ROW,
	SUM (CASE WHEN Global IS NULL THEN 1 ELSE 0 END) AS null_count_global
FROM xboxgamesales


-- PS4 GAMES ANALYSIS

SELECT * FROM ps4gamesales

-- Top 10 globally best-selling PS4 games based on revenue
SELECT TOP 10 Game, 
	ROUND(Global,2) AS Revenue
FROM ps4gamesales
ORDER BY Global DESC;

-- Top 10 Globally best-selling PS4 games Genre based on revenue and their total published games
SELECT TOP 10 Genre,
	ROUND(SUM(Global),2) AS TOTAL_REVENUE,
	COUNT(Genre) AS TOTAL_NUMBER_OF_GAMES
FROM ps4gamesales
GROUP BY Genre
ORDER BY TOTAL_REVENUE DESC

-- Total annual sales revenue for PlayStation 4 games, broken down by geographical region
SELECT Year,
	ROUND(SUM(North_america),2) AS NA_revenue,
	ROUND(SUM(Europe),2) AS EU_revenue,
	ROUND(SUM(Japan),2) AS JP_revenue,
	ROUND(SUM(Rest_of_World),2) AS RoW_revenue
FROM ps4gamesales
GROUP BY Year
ORDER BY Year ASC

-- Total number of games released by each publisher ordered by most to least
SELECT Publisher,
	COUNT(Publisher) AS Total_Publishes
FROM ps4gamesales
GROUP BY Publisher
ORDER BY Total_Publishes DESC

-- total number of PlayStation 4 games published each year ordered by most to least
SELECT Year, COUNT(Year) AS Total_publishes
FROM ps4gamesales
GROUP BY Year
ORDER BY Total_publishes DESC

-- XBOX GAMES SALES ANALYSIS

SELECT * FROM xboxgamesales

-- Top 10 globally best-selling XBOX games based on revenue
SELECT TOP 10 Game, 
	ROUND(Global,2) AS Revenue
FROM xboxgamesales
ORDER BY Global DESC;

-- Top 10 Globally best-selling XBOX games Genre based on revenue and their total published games
SELECT TOP 10 Genre,
	ROUND(SUM(Global),2) AS TOTAL_REVENUE,
	COUNT(Genre) AS TOTAL_NUMBER_OF_GAMES
FROM xboxgamesales
GROUP BY Genre
ORDER BY TOTAL_REVENUE DESC

-- Total annual sales revenue for xbox games, broken down by geographical region
SELECT Year,
	ROUND(SUM(North_america),2) AS NA_revenue,
	ROUND(SUM(Europe),2) AS EU_revenue,
	ROUND(SUM(Japan),2) AS JP_revenue,
	ROUND(SUM(Rest_of_World),2) AS RoW_revenue
FROM xboxgamesales
GROUP BY Year
ORDER BY Year ASC

-- Total number of xbox games released by each publisher ordered by most to least
SELECT Publisher,
	COUNT(Publisher) AS Total_Publishes
FROM xboxgamesales
GROUP BY Publisher
ORDER BY Total_Publishes DESC

-- Total number of xbox games published each year ordered by most to least
SELECT Year, COUNT(Year) AS Total_publishes
FROM xboxgamesales
GROUP BY Year
ORDER BY Total_publishes DESC


-- VIDEO GAMES SALES ANALYSIS

SELECT * FROM videogamesales2016

-- Ranked list of the top 10 best-selling video games of all time based on their global sales

SELECT TOP 10 Name, Global_Sales 
FROM videogamesales2016
ORDER BY Global_Sales DESC

-- Total global sales revenue for each game genre and ranks them from most to least profitable

SELECT Genre, ROUND(SUM(Global_Sales),2) AS TOTAL_REVENUE
FROM videogamesales2016
GROUP BY Genre
ORDER BY TOTAL_REVENUE DESC


-- Total sales revenue from North America, Europe, Japan, other regions, and globally for all video games

SELECT ROUND(SUM(NA_Sales),2) AS Revenue_in_NA,
	ROUND(SUM(EU_Sales),2) AS Revenue_in_EU,
	ROUND(SUM(JP_Sales),2) AS Revenue_in_JP,
	ROUND(SUM(Other_Sales),2) AS Revenue_in_Other,
	ROUND(SUM(Global_Sales),2) AS Global_Revenue
FROM videogamesales2016

-- Ranks game genres by the number of titles and provides key metrics for each, including game count, user engagement, total revenue, and average user score

SELECT Genre, 
	COUNT(Genre) AS N_Games,
	COUNT(User_Count) AS Total_Users,
	ROUND(SUM(Global_Sales),2) AS Total_Revenue,
	ROUND(AVG(User_Score),2) AS Average_User_Score
FROM videogamesales2016
GROUP BY Genre
ORDER BY COUNT(Genre) DESC


-- A chronological summary of the video game market, showing the annual number of games released, user engagement, and total global revenue

SELECT Year_of_Release,
	COUNT(Name) AS N_Games,
	COUNT(User_Count) AS Total_Users,
	ROUND(SUM(Global_Sales),2) AS Total_Revenue
FROM videogamesales2016
GROUP BY Year_of_Release
ORDER BY Year_of_Release

--  Ranks video game platforms by the size of their game libraries and shows key metrics for each, including game count, user engagement, and average user score

SELECT Platform,
	COUNT(Name) AS N_Games,
	COUNT(User_Count) AS Total_Users,
	ROUND(AVG(User_Score),2) AS Average_Score
FROM videogamesales2016
GROUP BY Platform
ORDER BY COUNT(Name) DESC