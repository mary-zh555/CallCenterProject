# CALL CENTER PROJECT

### Stack 
PostgreSQL
SQL
DATA CLEANING
EDA
Tableau

## Process

1. Importing csv data to database

    ```sql
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
    ```

2. Data cleaning

    ```sql
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
    ```
    ![column comparison](screenshot1.jpg)

    ### Result table:

    ![Result table](screemshot2.jpg) 

3. EDA 



