/* PSID DATA CENTER *****************************************************
   JOBID            : 327821                            
   DATA_DOMAIN      : FAM                               
   USER_WHERE       : ER66002 = 5620 OR ER66002 = 8559 O
   FILE_TYPE        : NULL                              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : SAS Statements                    
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 3                                 
   N_OF_OBSERVATIONS: 5                                 
   MAX_REC_LENGTH   : 9                                 
   DATE & TIME      : December 29, 2023 @ 16:21:51
************************************************************************/

FILENAME myfile "[path]\FAM2017ER.txt" ;

DATA J327821 ;
   ATTRIB
      ER66001         LABEL="RELEASE NUMBER"                           FORMAT=F1.  
      ER66002         LABEL="2017 FAMILY INTERVIEW (ID) NUMBER"        FORMAT=F5.  
      ER66017         LABEL="AGE OF REFERENCE PERSON"                  FORMAT=F3.  
   ;
   INFILE myfile LRECL = 9 ; 
   INPUT 
      ER66001              1 - 1           ER66002              2 - 6           ER66017              7 - 9     
   ;
run ;
