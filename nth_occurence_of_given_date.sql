--  Q) Write a query to provide the date for the nth occurence of the sunday in future for the given date. (Ankit Bansal) (MySQL Version)
-- WEEKDAY Return Values:
-- 0: Monday
-- 1: Tuesday
-- 2: Wednesday
-- 3: Thursday
-- 4: Friday    
-- 5: Saturday
-- 6: Sunday


set @today_date = '2024-09-15';
set @n =3;

SELECT 
    CASE WHEN WEEKDAY(@today_date) = 6
        THEN DATE_ADD(
             DATE_ADD(@today_date, INTERVAL 7 DAY) , 
             INTERVAL (@n-1) WEEK
            )
        ELSE DATE_ADD(
             DATE_ADD(@today_date, INTERVAL(6 - WEEKDAY(@today_date)) DAY) , 
             INTERVAL @n WEEK
            )
        END AS next_sunday;