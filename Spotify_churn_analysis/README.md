# 🎵 Spotify Churn & Retention Analysis (End-to-End Project)

## 📌 Executive Summary
This project analyzes a dataset of 8,000 Spotify users to identify why customers cancel their subscriptions ("churn") and provides actionable strategies to improve retention. 

Using **Excel, SQL, and Power BI**, I identified that the "Family Plan" is the primary source of revenue loss, discovered a segment of **755 high-potential users** for upselling, and diagnosed a critical UX friction point on the Mobile app.

## 🛠️ Tools & Technologies
* **Excel:** Used `VLOOKUP` for financial modeling (mapping subscription pricing) and Pivot Tables for ad-threshold analysis.
* **SQL (MSSQL):** utilized **CTEs**, **Window Functions**, and **Nested Subqueries** for customer segmentation and benchmarking.
* **Power BI:** Interactive dashboarding with DAX measures for user behavior benchmarking.

## 📊 Key Findings & Insights

### 1. The "Revenue Bleed" Estimation (Excel)
* **Problem:** Raw data contained subscription types (e.g., "Family") but not revenue.
* **Method:** I created a pricing dimension table and used **`VLOOKUP`** to map each user to their monthly financial value.
* **Insight:** While "Free" users have high churn counts, the **Family Plan** tier accounts for the majority of *financial* loss. Losing one Family plan user is equivalent to losing three Student plan users, shifting the retention priority to high-value tiers.

### 2. The "Upsell" Opportunity (SQL)
* **Strategy:** Targeted "Free" users who behave like "Premium" users.
* **Analysis:** I used a dynamic SQL subquery to calculate the *Average Listening Time of Premium Users* (Benchmark) and filtered for Free users who exceeded this threshold.
* **Result:** Identified a cohort of **755 highly active users** (listening > 155 mins) who are prime targets for a "50% off" conversion campaign.

### 3. User Segmentation: The "Picky Listener" Problem (SQL)
* **Method:** Used SQL `CASE WHEN` logic to segment users into "Super Fans" (High Listen, Low Skip) vs. "Picky Listeners" (High Listen, High Skip).
* **Insight:** "Picky Listeners" are engaged but frustrated—they listen for long periods but skip 30%+ of songs.
* **Impact:** This segment has a significantly higher churn risk. The data suggests they are leaving due to poor content relevance, not a lack of interest in music.

### 4. Mobile Experience Audit (Power BI + SQL)
* **Observation:** Mobile users churn at **26.89%**, which is **1.9% higher** than Web users.
* **Root Cause:** By overlaying the "Skip Rate" in Power BI, I found that content dissatisfaction is identical across devices (~30%).
* **Conclusion:** Since users on all devices dislike the music equally, the higher churn on Mobile proves the issue is **App Stability or UI Friction**, not the recommendation algorithm.

## 📂 Project Structure
* `data/`: Contains the raw `spotify_churn_dataset.csv`.
* `sql_scripts/`: Contains `Spotify.sql` files for Segmentation, Upsell Logic (CTEs), and Device Audits.
* `excel_analysis/`: Excel workbook with VLOOKUP pricing models and Ad Threshold pivot tables.
* `dashboard/`: The Power BI `Churn_rate_by_device.pbix` file.

## 🚀 Recommendations based on Data
1.  **Launch the Upsell Campaign:** Immediately target the **755 users** identified in the SQL analysis with a premium trial offer.
2.  **Optimize for "Picky Listeners":** Adjust the "Discover Weekly" algorithm for the High-Skip segment to prioritize familiar tracks over new ones.
3.  **Mobile Technical Sprint:** Initiate a QA audit for the Mobile App to resolve the stability issues driving the 26.89% churn rate.

---
*Author: Pragyan Bhattarai*
*Connect with me on LinkedIn: www.linkedin.com/in/pragyanbh*
