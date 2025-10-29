/* PSID DATA CENTER *****************************************************
   JOBID            : 327822                            
   DATA_DOMAIN      : IND                               
   USER_WHERE       : ER30001 = 4 AND (ER30002 = 6 OR ER
   FILE_TYPE        : All Individuals Data              
   OUTPUT_DATA_TYPE : ASCII                             
   STATEMENTS       : SAS Statements                    
   CODEBOOK_TYPE    : PDF                               
   N_OF_VARIABLES   : 11                                
   N_OF_OBSERVATIONS: 5                                 
   MAX_REC_LENGTH   : 32                                
   DATE & TIME      : December 29, 2023 @ 16:31:48
************************************************************************/

FILENAME myfile "[path]\IND2021ER.txt" ;

DATA J327822 ;
   ATTRIB
      ER30000         LABEL="RELEASE NUMBER"                           FORMAT=F1.  
      ER30001         LABEL="1968 INTERVIEW NUMBER"                    FORMAT=F4.  
      ER30002         LABEL="PERSON NUMBER                         68" FORMAT=F3.  
      ER34201         LABEL="2013 INTERVIEW NUMBER"                    FORMAT=F5.  
      ER34202         LABEL="SEQUENCE NUMBER                       13" FORMAT=F2.  
      ER34203         LABEL="RELATION TO HEAD                      13" FORMAT=F2.  
      ER34204         LABEL="AGE OF INDIVIDUAL                     13" FORMAT=F3.  
      ER34501         LABEL="2017 INTERVIEW NUMBER"                    FORMAT=F5.  
      ER34502         LABEL="SEQUENCE NUMBER                       17" FORMAT=F2.  
      ER34503         LABEL="RELATION TO REFERENCE PERSON          17" FORMAT=F2.  
      ER34504         LABEL="AGE OF INDIVIDUAL                     17" FORMAT=F3.  
   ;
   INFILE myfile LRECL = 32 ; 
   INPUT 
      ER30000              1 - 1           ER30001              2 - 5           ER30002              6 - 8     
      ER34201              9 - 13          ER34202             14 - 15          ER34203             16 - 17    
      ER34204             18 - 20          ER34501             21 - 25          ER34502             26 - 27    
      ER34503             28 - 29          ER34504             30 - 32    
   ;
run ;
