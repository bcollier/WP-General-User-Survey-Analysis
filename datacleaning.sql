UPDATE wpsurvey.data set filter_$ = 0;

UPDATE wpsurvey.data
   SET filter_$ = 1
 WHERE filter_1 + filter_2 + filter_3 + filter_4 + filter_5 + filter_6 + filter_7 + filter_8 > 4
   AND A5A = "en";
   
UPDATE wpsurvey.data
   SET filter_$ = 1
 WHERE NOT A5A = "en"
     
UPDATE wpsurvey.data
   SET A12_1 = case when LENGTH(TRIM(A12_1)) > 0 then A12_1 else null end,
       A12_2 = case when LENGTH(TRIM(A12_2)) > 0 then A12_2 else null end;  

UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, ',', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, '$', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, '-', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, ' ', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, '*', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, '(', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, ')', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(A12_1, '+', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'USD', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'US', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'EUR', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'DOL', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'P', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'K', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'PES', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'Ð', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'DO', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'RM', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'RE', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'DE', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'K', '') WHERE A12_1 is not null;
UPDATE wpsurvey.data SET A12_1 = REPLACE(UPPER(A12_1), 'Ñ', '') WHERE A12_1 is not null;

UPDATE wpsurvey.data SET A12_1 = SUBSTRING(A12_1,1,LOCATE('.', A12_1) -1 ) WHERE NOT A12_1 REGEXP '^[0-9]+$' and LOCATE('.', A12_1) > 0 ;

UPDATE wpsurvey.data
   SET A12_1 = case when LENGTH(TRIM(A12_1)) > 0 then A12_1 else null end,
       A12_2 = case when LENGTH(TRIM(A12_2)) > 0 then A12_2 else null end; 
       
UPDATE wpsurvey.data SET filter_$ = 1 WHERE NOT A12_1 REGEXP '^[0-9]+$' ;       
      
UPDATE wpsurvey.data SET A11a = -999 WHERE A11a is null and filter_$ = 0;
UPDATE wpsurvey.data SET A12_1 = -999 WHERE A12_1 is null and filter_$ = 0;
UPDATE wpsurvey.data SET A12_2 = -999 WHERE A12_2 is null and filter_$ = 0;
UPDATE wpsurvey.data SET B8 = -999 WHERE B8 is null and filter_$ = 0;
UPDATE wpsurvey.data SET B8a = -999 WHERE B8a is null and filter_$ = 0;
UPDATE wpsurvey.data SET B9 = -999 WHERE B9 is null and filter_$ = 0;
UPDATE wpsurvey.data SET B10 = -999 WHERE B10 is null and filter_$ = 0;
UPDATE wpsurvey.data SET B11 = -999 WHERE B11 is null and filter_$ = 0;

/* these 4 statements need to be run together to filter countries that we don't have conversion rates for */
CREATE TEMPORARY TABLE temp_table (country VARCHAR (255));
INSERT INTO temp_table (SELECT DISTINCT (d2.A12_2) FROM wpsurvey.data d2 WHERE NOT EXISTS (SELECT 1 FROM cur_to_USD WHERE CountryCode = A12_2) and d2.A12_2 IS NOT NULL and d2.filter_$ = 0 and not d2.A12_2 = -999);   
UPDATE wpsurvey.data SET filter_$ = 1 WHERE A12_2 IN (SELECT country from temp_table) AND filter_$ = 0;
DROP TABLE temp_table;





   
   