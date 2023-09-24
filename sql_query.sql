----------------------------------------------------------------------------
---------------------------- 1. IMPORT CSV DATA ----------------------------
----------------------------------------------------------------------------

-- in the created database call_center_project --

-- create table
CREATE TABLE Calls (
	id CHAR(50) PRIMARY KEY,
	customer_name CHAR(50),
	sentiment CHAR(20),
	csat_score INT,
	call_date CHAR(10),
	reason CHAR(20),
	city CHAR(50),
	state CHAR(20),
	channel CHAR(20),
	response_time CHAR(20),
	duration INT,
	call_center CHAR(20)
);

-- import csv file into table
COPY Calls
FROM 'E:\DataAnalytics\PROJECTS\PROJECT\CallCenterProject\call-center.csv'
DELIMITER ',' 
CSV HEADER;

-- checking import result
SELECT *
FROM Calls
LIMIT 10;


----------------------------------------------------------------------------
----------------------------- 2. DATA CLEANING -----------------------------
----------------------------------------------------------------------------

-- change call_date type from char(10) to date

ALTER TABLE Calls
ADD COLUMN new_call_date DATE;

UPDATE Calls
SET new_call_date = TO_DATE(call_date, 'MM/DD/YYYY');

ALTER TABLE Calls
drop column call_date;

ALTER TABLE Calls
rename column new_call_date to call_date;

select * 
from calls
limit 10;


--------------------------------------------------------------------------
---------------------- EDA -----------------------------------------------

-- What is the shape of the table?
SELECT 'Rows' AS category, COUNT(*) AS count
    FROM Calls

UNION ALL

SELECT 'Columns' AS category, COUNT(*) AS count
    FROM information_schema.columns
    WHERE table_name = 'calls';

---- (Here can be table or screenshot)


-- distinct values

-- percentages 

-- channel % sentiment and reasons
SELECT
    channel,
    sentiment,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY channel)), 2) AS pct
FROM
    calls
GROUP BY
    channel, sentiment
ORDER BY
    channel, pct DESC;
---- All of them are mostly negative-neutral-very_negative

SELECT
    channel,
    reason,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY channel)), 2) AS pct
FROM
    calls
GROUP BY
    channel, reason
ORDER BY
    channel, pct DESC;
---- payments are only in call_center channel


-- which day has the most calls?
select to_char(call_date, 'Day' ) as day_of_call,
	round((count(*)*100.0)/(select count(*) from calls),2) as percentage
from calls
group by 1
order by 2 desc;
------ friday, thursday the most; sunday the least


-- AGGREGATIONS

-- avr duration for channels
SELECT
    channel,
    ROUND(AVG(duration), 2) AS avg_duration
FROM
    calls
GROUP BY
    channel
ORDER BY
	avg_duration;