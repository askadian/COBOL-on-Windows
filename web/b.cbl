      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       PROGRAM-ID. b.
       ENVIRONMENT DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       CONFIGURATION SECTION.
      *-----------------------
       INPUT-OUTPUT SECTION.
      *-----------------------
       DATA DIVISION.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       FILE SECTION.
      *-----------------------
       WORKING-STORAGE SECTION.
       01 ws-vars.
           05 ws-name.
               10 ws-fname   pic x(06).
               10 ws-lname   pic x(06).

       linkage section.
       01 ls-vars.
           05 ls-vars-len    pic s9(5) comp.
           05 ls-vars-val    pic x(12).
      *-----------------------
       PROCEDURE DIVISION using ls-vars.
      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
       MAIN-PROCEDURE.
      **
      * The main procedure of the program
      **
            INITIALIZE ws-vars.
            if ls-vars-len > 0 then
                move ls-vars-val
                  to ws-name
                move "KADIAN"
                  to ws-lname
                move ws-name
                  to ls-vars-val
            else
                move "AMRESH"
                  to ws-fname
            end-if.
      *     DISPLAY "Hello world".
      *     STOP RUN.
      ** add other procedures here
       END PROGRAM b.
