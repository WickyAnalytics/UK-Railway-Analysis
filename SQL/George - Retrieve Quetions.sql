USE UK_Railway;

-- 1. What is the monthly trend of total ticket sales?
-- Helps track sales performance over time and identify peak and low seasons.
SELECT 
    C.Year,
    C.Month,
    C.Month_Name,
    COUNT(DISTINCT T.Journey_ID) AS Total_Ticket_Sales
FROM 
    Transactions T
JOIN 
    Calendar C ON T.Date_of_Purchase = C.Date
WHERE 
    C.Year <> 2023 -- Exclude data for the year 2023
GROUP BY 
    C.Year, C.Month, C.Month_Name
ORDER BY 
    C.Year, C.Month;

-- 2. What percentage of ticket purchases come from online sales vs. station sales?
-- Shows the popularity of online bookings and whether improvements are needed for station sales.
SELECT 
    Purchase_Type,
    COUNT(T.Journey_ID) * 100.0 / (SELECT COUNT(Journey_ID) FROM Transactions T JOIN Calendar C ON T.Date_of_Purchase = C.Date WHERE C.Year <> 2023) AS Percentage
FROM 
    Transactions T
JOIN 
    Calendar C ON T.Date_of_Purchase = C.Date
WHERE 
    C.Year <> 2023 -- Exclude data for the year 2023
GROUP BY 
    Purchase_Type;

-- 3. What percentage of customers use Railcards? (e.g., Adult, Senior, Disabled, None)
-- Helps analyze the impact of discount cards on sales and customer loyalty.
SELECT 
    Railcard,
    COUNT(T.Journey_ID) * 100.0 / (SELECT COUNT(Journey_ID) FROM Transactions T JOIN Calendar C ON T.Date_of_Purchase = C.Date WHERE C.Year <> 2023) AS Percentage
FROM 
    Transactions T
JOIN 
    Calendar C ON T.Date_of_Purchase = C.Date
WHERE 
    C.Year <> 2023 -- Exclude data for the year 2023
GROUP BY 
    Railcard;

-- 4. What is the total revenue generated from ticket sales?
-- Provides insights into overall financial performance and profitability.
SELECT 
    SUM(Price) AS Total_Revenue
FROM 
    Transactions;