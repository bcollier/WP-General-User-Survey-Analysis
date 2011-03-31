SELECT *
  FROM wpsurvey.data
 WHERE A5A = "en" OR A5B = "en"
 LIMIT 1000;
 
 SELECT count(*)
  FROM wpsurvey.data
 WHERE A5A = "en"
   AND filter_1 = 0
   AND filter_8 = 0
 LIMIT 1000;
 
SELECT count(*)
  FROM wpsurvey.data
 WHERE A5B = "en"
 LIMIT 1000;
 
 UPDATE wpsurvey.data
    SET filter_$ = 0;
  
SELECT DISTINCT A12_2  
  FROM wpsurvey.data 
 WHERE A5A = "en"
   AND filter_1 = 0
   AND filter_8 = 0
   AND filter_$ = 0
   AND A1 > -1 /* gender is known */

   
/* need to get the conversion information for these countries, for now I guess we don't include them in our sample */   
   SELECT A12_2, count(id) FROM wpsurvey.data WHERE NOT EXISTS (SELECT 1 FROM cur_to_USD WHERE CountryCode = A12_2) and A12_2 IS NOT NULL and filter_$ = 0 and not A12_2 = -999 GROUP BY A12_2 HAVING count(id) > 5;

   CREATE TEMPORARY TABLE temp_table (count VARCHAR (255));
   
   INSERT INTO temp_table 
   (SELECT DISTINCT (d2.A12_2) FROM wpsurvey.data d2 WHERE NOT EXISTS (SELECT 1 FROM cur_to_USD WHERE CountryCode = A12_2) and d2.A12_2 IS NOT NULL and d2.filter_$ = 0 and not d2.A12_2 = -999);   
   
   SELECT * FROM temp_table;
   
      /* use this block to limit to only people who provided USD non-zero income
   AND LENGTH(TRIM(A12_2)) > 0
   AND A12_2 = 'USD'
   AND A12_1 > 0 */


/*   AND A5B = A5A */ 
/* contribute and read the same language filters out 336 people*/
/* LIMIT 100;
*/
/*TODO: Ask about nationality numeric codes (A3_nationality) */
   
   /*  DATA CLEANING RELATED SELECT STATEMENTS BELOW */  



SELECT B10, count(id) FROM wpsurvey.data GROUP BY B10 ORDER BY B10;



  SELECT DISTINCT (d2.A12_2) FROM wpsurvey.data d2 WHERE NOT EXISTS (SELECT 1 FROM cur_to_USD WHERE CountryCode = d2.A12_2) and d2.A12_2 IS NOT NULL and d2.filter_$ = 0 and not d2.A12_2 = -999;
 
 
SELECT A11a FROM wpsurvey.data WHERE A11a is null and filter_$ = 0;


UPDATE wpsurvey.data
   SET A11a = IFNULL(-999, A11a),
       A12_1 = IFNULL(-999, A12_1),
       A12_2 = IFNULL(-999, A12_2);
   
   
 
   
SELECT * 
  FROM wpsurvey.data
 WHERE filter_1 + filter_2 + filter_3 + filter_4 + filter_5 + filter_6 + filter_7 + filter_8 > 4
   AND A5A = "en";
   
select count(A12_1) from wpsurvey.data WHERE NOT A12_1 REGEXP '^[0-9]+$' ;
select A12_1 from wpsurvey.data WHERE NOT A12_1 REGEXP '^[0-9]+$' ;
SELECT A12_1 FROM wpsurvey.data where LENGTH(TRIM(A12_1)) = 0;

select A12_1,A12_2, LOCATE('.', A12_1), SUBSTRING(A12_1,1,LOCATE('.', A12_1) -1 )  from wpsurvey.data WHERE NOT A12_1 REGEXP '^[0-9]+$' and LOCATE('.', A12_1) > 0 ;


select A12_1,LOCATE('.', A12_1), SUBSTRING(A12_1,0,LENGTH(A12_1) - LOCATE('.', A12_1))  from wpsurvey.data WHERE NOT A12_1 REGEXP '^[0-9]+$' ;
   
