USE spotify;

SELECT * FROM spotify_churn_dataset;

SELECT 
    subscription_type,  
    AVG(listening_time) AS Average_Listening_time
FROM 
    spotify_churn_dataset
GROUP BY 
    subscription_type;

-- Identifying "High-Potential" Upsell Targets
SELECT * 
FROM 
    spotify_churn_dataset
WHERE subscription_type = 'Free'						-- Target only the Free users
	AND is_churned = 0									-- Target Only the active users
	AND listening_time > (SELECT AVG(listening_time) 
		FROM spotify_churn_dataset 
		WHERE subscription_type = 'Premium')			-- The premium behaviour benchmark
ORDER BY
    listening_time DESC;									-- Show the most engaged users first

/* 

Action: I extracted a list of 755 highly active Free users.

Recommendation: Send this specific segment a '50% off for 3 months' notification. 
Since they already use the app for 2.5+ hours (155 mins), they are highly likely to convert to remove ads.

*/

-- MARKETING ANALYTICS

SELECT 
    user_id,
    listening_time,
    skip_rate,
    CASE 
        -- Logic for Super Fans (High Time, Low Skips)
        WHEN listening_time > 154 AND skip_rate < 0.30 THEN 'Super Fan'
        
        -- Logic for Picky Listeners (High Time, High Skips)
        WHEN listening_time > 154 AND skip_rate >= 0.30 THEN 'Picky Listener'
        
        -- Logic for Casual Users (Low Time)
        ELSE 'Casual User' 
    END AS User_Persona
FROM 
    spotify_churn_dataset;


-- Which group is quitting?

WITH Persona_Data AS (
    SELECT 
        user_id,
        is_churned,
        CASE 
            WHEN listening_time > 154 AND skip_rate < 0.30 THEN 'Super Fan'
            WHEN listening_time > 154 AND skip_rate >= 0.30 THEN 'Picky Listener'
            ELSE 'Casual User' 
        END AS User_Persona
    FROM 
        spotify_churn_dataset
)
SELECT 
    User_Persona,
    COUNT(user_id) AS total_users,
    ROUND(AVG(CAST(is_churned AS FLOAT)),4) * 100 AS churn_rate
FROM 
    Persona_Data
GROUP BY 
    User_Persona;

/*

I segmented the user base using SQL logic. 
The analysis revealed that 'Picky Listeners' (High Usage, High Skips) have a higher churn risk than 'Super Fans'.

Recommendation: 
    We should target 'Picky Listeners' with better recommendation algorithms (e.g., 'Discover Weekly') to reduce their skip rate and improve retention.

*/


-- Is our Mobile app or Website causing people to quit?
SELECT 
    device_type,
    COUNT(user_id) AS total_users,
    ROUND(AVG(skip_rate)*100,4) AS avg_skip_rate,
    ROUND(AVG(CAST(is_churned AS FLOAT)),4) * 100 AS churn_rate
FROM 
    spotify_churn_dataset
GROUP BY 
    device_type
ORDER BY 
    churn_rate DESC;

/*

Key Observation: Mobile has the highest churn (26.89%) even though the skip rate is basically the same as the others. 
This suggests the issue isn't the content (songs), but the app experience itself (e.g., crashes, bugs, or hard-to-use navigation).

*/