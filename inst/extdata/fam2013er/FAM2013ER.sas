/* PSID DATA CENTER *****************************************************
   JOBID            : 327820                            
   DATA_DOMAIN      : FAM                               
   USER_WHERE       : ER53002 = 8684 OR ER53002 = 7300 O
   FILE_TYPE        : NULL                              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : SAS Statements                    
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 3                                 
   N_OF_OBSERVATIONS: 4                                 
   MAX_REC_LENGTH   : 9                                 
   DATE & TIME      : December 29, 2023 @ 15:46:24
************************************************************************/

FILENAME myfile "[path]\FAM2013ER.txt" ;

DATA J327820 ;
   ATTRIB
      ER53001         LABEL="RELEASE NUMBER"                           FORMAT=F1.  
      ER53002         LABEL="2013 FAMILY INTERVIEW (ID) NUMBER"        FORMAT=F5.  
      ER53017         LABEL="AGE OF HEAD"                              FORMAT=F3.  
   ;
   INFILE myfile LRECL = 9 ; 
   INPUT 
      ER53001              1 - 1           ER53002              2 - 6           ER53017              7 - 9     
   ;
run ;
