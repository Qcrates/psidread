PROC FORMAT ; 
   VALUE ER30000F
         1 = 'Release number 1, June 2023'
   ;
   VALUE ER34202F
    1 - 20 = 'Individuals in the family at the time of the 2013 interview'
   51 - 59 = 'Individuals in institutions at the time of the 2013 interview'
   71 - 80 = 'Individuals who moved out of the FU or out of institutions and established their own households between the 2011 and 2013 interviews'
   81 - 89 = 'Individuals who were living in 2011 but died by the time of the 2013 interview'
         0 = 'Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2013 or mover-out nonresponse by 2011 (ER34201=0)'
   ;
   VALUE ER34203F
        10 = 'Head in 2013; 2011 Head who was mover-out nonresponse by the time of the 2013 interview'
        20 = 'Legal Wife in 2013; 2011 Wife who was mover-out nonresponse by the time of the 2013 interview'
        22 = '"Wife"--female cohabitor who has lived with Head for 12 months or more; 2011 "Wife" who was mover-out nonresponse by the time of the 2013 interview'
        30 = 'Son or daughter of Head (includes adopted children but not stepchildren)'
        33 = 'Stepson or stepdaughter of Head (children of legal Wife [code 20] who are not children of Head)'
        35 = 'Son or daughter of "Wife" but not Head (includes only those children of mothers whose relationship to Head is 22 but who are not children of Head)'
        37 = 'Son-in-law or daughter-in-law of Head (includes stepchildren-in-law)'
        38 = 'Foster son or foster daughter, not legally adopted'
        40 = 'Brother or sister of Head (includes step and half sisters and brothers)'
        47 = 'Brother-in-law or sister-in-law of Head; i.e., brother or sister of legal Wife, or spouse of Head''s brother or sister'
        48 = 'Brother or sister of Head''s cohabitor (the cohabitor is coded 22 or 88)'
        50 = 'Father or mother of Head (includes stepparents)'
        57 = 'Father-in-law or mother-in-law of Head (includes parents of legal wives [code 20] only)'
        58 = 'Father or mother of Head''s cohabitor (the cohabitor is coded 22 or 88)'
        60 = 'Grandson or granddaughter of Head (includes grandchildren of legal Wife [code 20] only; those of a cohabitor are coded 97)'
        65 = 'Great-grandson or great-granddaughter of Head (includes great-grandchildren of legal Wife [code 20]; those of a cohabitor are coded 97)'
        66 = 'Grandfather or grandmother of Head (includes stepgrandparents)'
        67 = 'Grandfather or grandmother of legal Wife (code 20)'
        68 = 'Great-grandfather or great-grandmother of Head'
        69 = 'Great-grandfather or great-grandmother of legal Wife (code 20)'
        70 = 'Nephew or niece of Head'
        71 = 'Nephew or niece of legal Wife (code 20)'
        72 = 'Uncle or Aunt of Head'
        73 = 'Uncle or Aunt of legal Wife (code 20)'
        74 = 'Cousin of Head'
        75 = 'Cousin of legal Wife (code 20)'
        83 = 'Children of first-year cohabitor but not of Head (the parent of this child is coded 88)'
        88 = 'First-year cohabitor of Head'
        90 = 'Legal husband of Head'
        95 = 'Other relative of Head'
        96 = 'Other relative of legal Wife (code 20)'
        97 = 'Other relative of cohabitor (the cohabitor is code 22 or 88)'
        98 = 'Other nonrelatives (includes homosexual partners, friends of children of the FU, etc.)'
         0 = 'Inap.:  from Latino sample (ER30001=7001-9308); from Immigrant 2017 sample (ER30001=4001-4851); main family nonresponse by 2013 or mover-out nonresponse by 2011 (ER34202=0)'
   ;
   VALUE ER34502F
    1 - 20 = 'Individuals in the family at the time of the 2017 interview'
   51 - 59 = 'Individuals in institutions at the time of the 2017 interview'
   71 - 80 = 'Individuals who moved out of the FU or out of institutions and established their own households between the 2015 and 2017 interviews'
   81 - 89 = 'Individuals who were living in 2015 but died by the time of the 2017 interview'
         0 = 'Inap.:  from Immigrant 17 recontact sample (ER30001=4700-4851) or Multiplicity sample (ER30001=4001-4462 and ER32052=2019); from Latino sample (ER30001=7001-9308); main family nonresponse by 2017 or m'
             'over-out nonresponse by 2015 (ER34501=0)'
   ;
   VALUE ER34503F
        10 = 'Reference Person in 2017; 2015 Reference Person who was mover-out nonresponse by the time of the 2017 interview'
        20 = 'Legal Spouse in 2017; 2015 Spouse who was mover-out nonresponse by the time of the 2017 interview'
        22 = 'Partner--cohabitor who has lived with Reference Person for 12 months or more; 2015 Partner who was mover-out nonresponse by the time of the 2017 interview'
        30 = 'Son or daughter of Reference Person (includes adopted children but not stepchildren)'
        33 = 'Stepson or stepdaughter of Reference Person (children of legal Spouse [code 20] who are not children of Reference Person)'
        35 = 'Son or daughter of Partner but not Reference Person (includes only those children of mothers whose relationship to Reference Person is 22 but who are not children of Reference Person)'
        37 = 'Son-in-law or daughter-in-law of Reference Person (includes stepchildren-in-law)'
        38 = 'Foster son or foster daughter, not legally adopted'
        40 = 'Brother or sister of Reference Person (includes step and half sisters and brothers)'
        47 = 'Brother-in-law or sister-in-law of Reference Person (i.e., brother or sister of legal Spouse; spouse of HD''s brother or sister; spouse of legal Spouse''s brother or sister)'
        48 = 'Brother or sister of Reference Person''s cohabitor (the cohabitor is coded 22 or 88)'
        50 = 'Father or mother of Reference Person (includes stepparents)'
        57 = 'Father-in-law or mother-in-law of Reference Person (includes parents of legal spouses [code 20] only)'
        58 = 'Father or mother of Reference Person''s cohabitor (the cohabitor is coded 22 or 88)'
        60 = 'Grandson or granddaughter of Reference Person (includes grandchildren of legal Spouse [code 20] only; those of a cohabitor are coded 97)'
        65 = 'Great-grandson or great-granddaughter of Reference Person (includes great-grandchildren of legal Spouse [code 20]; those of a cohabitor are coded 97)'
        66 = 'Grandfather or grandmother of Reference Person (includes stepgrandparents)'
        67 = 'Grandfather or grandmother of legal Spouse (code 20)'
        68 = 'Great-grandfather or great-grandmother of Reference Person'
        69 = 'Great-grandfather or great-grandmother of legal Spouse (code 20)'
        70 = 'Nephew or niece of Reference Person'
        71 = 'Nephew or niece of legal Spouse (code 20)'
        72 = 'Uncle or Aunt of Reference Person'
        73 = 'Uncle or Aunt of legal Spouse (code 20)'
        74 = 'Cousin of Reference Person'
        75 = 'Cousin of legal Spouse (code 20)'
        83 = 'Children of first-year cohabitor but not of Reference Person (the parent of this child is coded 88)'
        88 = 'First-year cohabitor of Reference Person'
        90 = 'Uncooperative legal spouse of Reference Person (this individual is unable or unwilling to be designated as Reference Person or Spouse)'
        92 = 'Uncooperative partner of Reference Person (this individual is unable or unwilling to be designated as Partner)'
        95 = 'Other relative of Reference Person'
        96 = 'Other relative of legal Spouse (code 20)'
        97 = 'Other relative of cohabitor (the cohabitor is code 22 or 88)'
        98 = 'Other nonrelatives (includes friends of children of the FU, boyfriend/girlfriend of son/daughter, et al.)'
         0 = 'Inap.:  from Immigrant 17 recontact sample (ER30001=4700-4851) or Multiplicity sample (ER30001=4001-4462 and ER32052=2019); from Latino sample (ER30001=7001-9308); main family nonresponse by 2017 or m'
             'over-out nonresponse by 2015 (ER34502=0)'
   ;
RUN ;

FORMAT 
    ER30000    ER30000F.
    ER34202    ER34202F.
    ER34203    ER34203F.
    ER34502    ER34502F.
    ER34503    ER34503F.
;
