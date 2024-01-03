/* PSID DATA CENTER *****************************************************
   JOBID            : 327825                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : ER30001 = 4 AND (ER30002 = 6 OR ER
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : SAS Statements                    
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 14                                
   N_OF_OBSERVATIONS: 5                                 
   MAX_REC_LENGTH   : 37                                
   DATE & TIME      : December 29, 2023 @ 22:20:54
************************************************************************/

FILENAME myfile "[path]\J327825.txt" ;

DATA J327825 ;
   ATTRIB
      ER30000         LABEL="RELEASE NUMBER"                           FORMAT=F1.  
      ER30001         LABEL="1968 INTERVIEW NUMBER"                    FORMAT=F4.  
      ER30002         LABEL="PERSON NUMBER                         68" FORMAT=F3.  
      ER53001         LABEL="RELEASE NUMBER"                           FORMAT=F1.  
      ER53017         LABEL="AGE OF HEAD"                              FORMAT=F3.  
      ER34201         LABEL="2013 INTERVIEW NUMBER"                    FORMAT=F5.  
      ER34202         LABEL="SEQUENCE NUMBER                       13" FORMAT=F2.  
      ER34203         LABEL="RELATION TO HEAD                      13" FORMAT=F2.  
      ER34204         LABEL="AGE OF INDIVIDUAL                     13" FORMAT=F3.  
      ER66001         LABEL="RELEASE NUMBER"                           FORMAT=F1.  
      ER66017         LABEL="AGE OF REFERENCE PERSON"                  FORMAT=F3.  
      ER34501         LABEL="2017 INTERVIEW NUMBER"                    FORMAT=F5.  
      ER34502         LABEL="SEQUENCE NUMBER                       17" FORMAT=F2.  
      ER34503         LABEL="RELATION TO REFERENCE PERSON          17" FORMAT=F2.  
   ;
   INFILE myfile LRECL = 37 ; 
   INPUT 
      ER30000              1 - 1           ER30001              2 - 5           ER30002              6 - 8     
      ER53001              9 - 9           ER53017             10 - 12          ER34201             13 - 17    
      ER34202             18 - 19          ER34203             20 - 21          ER34204             22 - 24    
      ER66001             25 - 25          ER66017             26 - 28          ER34501             29 - 33    
      ER34502             34 - 35          ER34503             36 - 37    
   ;
run ;
