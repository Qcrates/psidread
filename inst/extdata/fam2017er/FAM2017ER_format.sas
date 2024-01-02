PROC FORMAT ; 
   VALUE ER66001F
         1 = 'Release number 1, February 2019'
         2 = 'Release number 2, August 2019'
         3 = 'Release number 3, June 2023'
   ;
RUN ;

FORMAT 
    ER66001    ER66001F.
;
