       IDENTIFICATION DIVISION.
       PROGRAM-ID. CreatePersonFile.
       AUTHOR AMRESH KADIAN.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *  THIS PROGRAM READS TWO SEQUENTIAL FILES AND DOES A           *
      *  MANY TO MANY JOIN ON THESE FILES. THE INPUT FILES ARE:       *
      *  FNAME.dat AND LNAME.dat THE OUTPUT FILE IS - PERSON.dat      *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
              SELECT FIRST-NAMES-FILE
                     ASSIGN TO "fname.dat"
                     ORGANIZATION IS LINE SEQUENTIAL.
                     
              SELECT LAST-NAMES-FILE
                     ASSIGN TO "lname.dat"
                     ORGANIZATION IS LINE SEQUENTIAL.
                     
              SELECT PERSON-FILE
                     ASSIGN TO "person.dat"
                     ORGANIZATION IS LINE SEQUENTIAL.
                     
       DATA DIVISION.
       FILE SECTION.
       FD FIRST-NAMES-FILE.
       01 FIRST-NAMES-REC.
              88 END-OF-FIRST-NAMES-FILE VALUE HIGH-VALUES.
              10 FN-SEX            PIC X(06).
              10 FILLER            PIC X(01).
              10 FN-VALUE          PIC X(30).
              
       FD LAST-NAMES-FILE.
       01 LAST-NAMES-REC.
      *              88 END-OF-LAST-NAMES-FILE VALUE HIGH-VALUES.
      *              88 NOT-END-OF-LAST-NAMES-FILE VALUE LOW-VALUES.
              10 LN-ETHNICITY      PIC X(15).
              10 FILLER            PIC X(01).
              10 LN-VALUE          PIC X(30).
              
       FD PERSON-FILE.
       01 PERSON-REC.
              10 PERSON-ID              PIC 9(09).
              10 PERSON-FIRST-NAME      PIC X(30).
              10 PERSON-SECOND-NAME     PIC X(30).
              10 PERSON-SEX             PIC X(06).
              10 PERSON-ETHNICITY       PIC X(15).
              
       WORKING-STORAGE SECTION.
       01 WS-VARS.
              05 WS-TOTAL-COUNT    PIC 9(09) VALUE ZEROS.
              05 WS-FN-COUNT       PIC 9(09) VALUE ZEROS.
              05 WS-LN-COUNT       PIC 9(09) VALUE ZEROS.
              
       01 FD-VARS.
              10 LN-STATUS-IND  PIC X(01) VALUE 'N'.
      *//
       PROCEDURE DIVISION.
       0000-MAINLINE.
       
              OPEN OUTPUT PERSON-FILE.
       
              PERFORM 4000-PROCESS
                 THRU 4000-EXIT.
              
              DISPLAY "COUNT: " WS-TOTAL-COUNT.
              CLOSE PERSON-FILE.
              GO TO 0000-EXIT.
       0000-EXIT.
              STOP RUN.
              EXIT.

       4000-PROCESS.
       
              OPEN INPUT FIRST-NAMES-FILE.
              
              PERFORM UNTIL END-OF-FIRST-NAMES-FILE
                     READ FIRST-NAMES-FILE
                            AT END SET END-OF-FIRST-NAMES-FILE TO TRUE
                            NOT AT END 
                                INITIALIZE PERSON-REC
                                MOVE FN-VALUE TO PERSON-FIRST-NAME
                                MOVE FN-SEX TO PERSON-SEX
                                COMPUTE WS-FN-COUNT = 
                                   WS-FN-COUNT + 1 
                                PERFORM 5000-PROCESS
                                   THRU 5000-EXIT
                                DISPLAY WS-TOTAL-COUNT
                     END-READ
              END-PERFORM.
              
              DISPLAY "COUNTERS: " .
              DISPLAY "F-NAMES: " WS-FN-COUNT.
              DISPLAY "L-NAMES: " WS-LN-COUNT.
              DISPLAY "-----------------------------".
              DISPLAY "TOTAL      " WS-TOTAL-COUNT.
              DISPLAY "-----------------------------".
              
              CLOSE FIRST-NAMES-FILE.
       4000-EXIT.
              EXIT.
       
       5000-PROCESS.
              OPEN INPUT LAST-NAMES-FILE.
              
              MOVE ZEROS TO WS-LN-COUNT.
              MOVE 'N' TO LN-STATUS-IND.
              
              PERFORM UNTIL LN-STATUS-IND IS EQUAL TO 'Y'
                     READ LAST-NAMES-FILE
                            AT END MOVE 'Y' TO LN-STATUS-IND
                            NOT AT END 
                                MOVE LN-VALUE TO PERSON-SECOND-NAME
                                MOVE LN-ETHNICITY TO PERSON-ETHNICITY
                                COMPUTE WS-LN-COUNT = 
                                   WS-LN-COUNT + 1 
                                COMPUTE WS-TOTAL-COUNT = 
                                   WS-TOTAL-COUNT + 1
      *                            WS-FN-COUNT * 
      *                            WS-LN-COUNT 
                                MOVE WS-TOTAL-COUNT
                                  TO PERSON-ID
                                WRITE PERSON-REC
                     END-READ
              END-PERFORM.
              
              CLOSE LAST-NAMES-FILE.
       
       5000-EXIT.
              EXIT.
