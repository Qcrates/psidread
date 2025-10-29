PROC FORMAT ; 
   VALUE ER53001F
         1 = 'Release number 1, May 2015'
         2 = 'Release number 2, January 2016'
         3 = 'Release number 3, November 2017'
         4 = 'Release number 4, June 2023'
   ;
RUN ;

FORMAT 
    ER53001    ER53001F.
;
