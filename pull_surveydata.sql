SELECT filter_2 as 'occasional_editor',
	   filter_3 as 'content_author',
	   filter_4 as 'editor',
	   filter_5 as 'administrator',
	   filter_6 as 'ex-contributor',
	   case A1 when 'male' then 1 when 'female' then 0 else -1 end as 'male',
	   A2 as 'age',
	   A3_nationality as 'nationality',
	   A4_Residence as 'residence',
	   A5A as 'contrib_lang',
	   A5B as 'read_lang',
	   A7 as 'high_educ',
	   A8 as 'years_educ',
	   case A9 when 1 then 1 when 2 then 0 end as 'partner',
	   case A10 when 1 then 1 when 2 then 0 end as 'children',
	   A11 as 'employment_stat',
	   IFNULL(A11a, -999) as 'occupation',
	   /* A12_1 as 'inc_amt', */
	   /* A12_2 as 'inc_currency', */
	   case A12_1 when -999 then -999 else (SELECT (A12_1 * USDPerUnits) FROM cur_to_USD WHERE A12_2 = CountryCode) end as inc_amt_adj,
	   /* case A12_1 when -999 then -999 else (SELECT (USDPerUnits) FROM cur_to_USD WHERE A12_2 = CountryCode) end as USDPerUnits, */
	   IFNULL(A12_3, 0) as 'noincomereponse',
	   B2 as 'access_level',
	   B8 as 'wp_interaction',
	   B8a as 'wp_f2f_interaction',
	   B9 as 'art_started',
	   B10 as 'art_edited',
	   B11 as 'art_translated'
  FROM wpsurvey.data
 WHERE A5A = "en"
   AND filter_1 = 0 /* filters out 21845 readers only 40079 down to 18234*/
   AND filter_8 = 0 /* filters out 510 other non-contributors 40079 down to 39569 */
   AND filter_$ = 0 /* used for data cleaning and filtering out non-english participants */
   AND A1 > -1  /* gender is known filters 93 */
   AND B2 > 1   /* filters 5154 where data access level is unregistered */   

