       IDENTIFICATION DIVISION.
       PROGRAM-ID. CreatePersonKsdsFile.
       AUTHOR AMRESH KADIAN.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *  THIS PROGRAM READS ONE SEQUENTIAL FILE AND MAKES AN INDEXED  *
      *  FILE OUT OF IT. THE INDEXED FILE WILL HAVE TWO COMPONENTS:   *
      *  person.idx AND personidx.dat                                 *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
              SELECT PERSON-FILE
                     ASSIGN TO "person.dat"
                     ORGANIZATION IS LINE SEQUENTIAL.
              SELECT PERSON-IDX-FILE
                     ASSIGN TO "personidx"
                     ORGANIZATION IS INDEXED
                     ACCESS MODE IS RANDOM
                     RECORD KEY IS PERSON-IDX-ID
      *              ALTERNATE KEY IS PERSON-IDX-FIRST-NAME
      *                            WITH DUPLICATES
      *              RECORD KEY IS PERSON-IDX-FIRST-NAME 
      *                            PERSON-IDX-LAST-NAME
                     FILE STATUS IS PERSON-IDX-FILE-STATUS-IND.
                     
       DATA DIVISION.
       FILE SECTION.
       FD PERSON-FILE.
       01 PERSON-REC.
              10 PERSON-ID              PIC 9(09).
              10 PERSON-FIRST-NAME      PIC X(30).
              10 PERSON-LAST-NAME       PIC X(30).
              10 PERSON-SEX             PIC X(06).
              10 PERSON-ETHNICITY       PIC X(15).
       FD PERSON-IDX-FILE.
       01 PERSON-IDX-REC.
              10 PERSON-IDX-ID              PIC 9(09).
              10 PERSON-IDX-FIRST-NAME      PIC X(30).
              10 PERSON-IDX-LAST-NAME       PIC X(30).
              10 PERSON-IDX-SEX             PIC X(06).
              10 PERSON-IDX-ETHNICITY       PIC X(15).
              
       WORKING-STORAGE SECTION.
       01 WS-VARS.
              05 WS-TOTAL-COUNT    PIC 9(09) VALUE ZEROS.
              05 WS-FN-COUNT       PIC 9(09) VALUE ZEROS.
              05 WS-LN-COUNT       PIC 9(09) VALUE ZEROS.
              
       01 FD-VARS.
              10 PERSON-FILE-STATUS-IND  
                                   PIC X(01) VALUE 'N'.
              10 PERSON-IDX-FILE-STATUS-IND  
                                   PIC X(01) VALUE 'N'.
      *//
       PROCEDURE DIVISION.
       0000-MAINLINE.
       
              OPEN INPUT PERSON-FILE.
              OPEN OUTPUT PERSON-IDX-FILE.
       
              PERFORM 4000-PROCESS
                 THRU 4000-EXIT.
              
      *       DISPLAY "COUNT: " WS-TOTAL-COUNT.
              CLOSE PERSON-FILE
                    PERSON-IDX-FILE.
              GO TO 0000-EXIT.
       0000-EXIT.
              STOP RUN.
              EXIT.

       4000-PROCESS.
       
              PERFORM UNTIL PERSON-FILE-STATUS-IND = 'Y'
                     READ PERSON-FILE
                            AT END 
                                   MOVE 'Y' 
                                     TO PERSON-FILE-STATUS-IND
                                   MOVE 'Y' 
                                     TO PERSON-IDX-FILE-STATUS-IND
                            NOT AT END 
                                COMPUTE WS-TOTAL-COUNT = 
                                   WS-TOTAL-COUNT + 1 
                                PERFORM 5000-PROCESS
                                   THRU 5000-EXIT
                     END-READ
              END-PERFORM.
              
              DISPLAY "COUNTERS: " .
              DISPLAY "F-NAMES: " WS-FN-COUNT.
              DISPLAY "L-NAMES: " WS-LN-COUNT.
              DISPLAY "-----------------------------".
              DISPLAY "TOTAL      " WS-TOTAL-COUNT.
              DISPLAY "-----------------------------".
              
       4000-EXIT.
              EXIT.
       
       5000-PROCESS.
      *
              MOVE PERSON-REC
                TO PERSON-IDX-REC.
      *       DISPLAY "PERSON-IDX-REC: " PERSON-IDX-REC.
                
              WRITE PERSON-IDX-REC
               INVALID KEY 
                    DISPLAY 
                      "INVALID KEY :- ", 
                      PERSON-IDX-ID 
                     MOVE 'Y' 
                       TO PERSON-FILE-STATUS-IND
                     MOVE 'Y' 
                       TO PERSON-IDX-FILE-STATUS-IND
              END-WRITE.
      *
       5000-EXIT.
              EXIT.
