       IDENTIFICATION DIVISION.
       PROGRAM-ID. CreatePersonKsdsFile.
       AUTHOR AMRESH KADIAN.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *  THIS PROGRAM READS THE INDEXED FILE 'PERSONIDX':-            *
      *    - personidx.dat                                            *
      *    - personidx.idx                                            *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
              SELECT PERSON-IDX-FILE
                     ASSIGN TO "personidx"
                     ORGANIZATION IS INDEXED
                     ACCESS MODE IS DYNAMIC
                     RECORD KEY IS 
                            PERSON-IDX-ID
                     FILE STATUS IS 
                            PERSON-IDX-FILE-STATUS-IND.
                     
       DATA DIVISION.
       FILE SECTION.
       FD PERSON-IDX-FILE.
       01 PERSON-IDX-REC.
              10 PERSON-IDX-ID              PIC 9(09).
              10 PERSON-IDX-FIRST-NAME      PIC X(30).
              10 PERSON-IDX-LAST-NAME       PIC X(30).
              10 PERSON-IDX-SEX             PIC X(06).
              10 PERSON-IDX-ETHNICITY       PIC X(15).
              
       WORKING-STORAGE SECTION.
       01 WS-VARS.
              10 WS-PERSON-IDX-KEY   PIC 9(09) VALUE ZEROS.
              
       01 FD-VARS.
              10 PERSON-IDX-FILE-STATUS-IND  
                                   PIC X(01) VALUE 'N'.
                                   
       01 WS-PRSN-REC.
              10 WS-PRSN-ID              PIC 9(09).
              10 WS-PRSN-FIRST-NAME      PIC X(30).
              10 WS-PRSN-LAST-NAME       PIC X(30).
              10 WS-PRSN-SEX             PIC X(06).
              10 WS-PRSN-ETHNICITY       PIC X(15).
      *//
       PROCEDURE DIVISION.
       0000-MAINLINE.
       
              OPEN INPUT PERSON-IDX-FILE.
       
              DISPLAY "ENTER THE KEY: ".
              ACCEPT PERSON-IDX-ID.
              INITIALIZE WS-PRSN-REC.
              
      *       START PERSON-IDX-FILE KEY IS GREATER THAN PERSON-IDX-ID
      *              INVALID KEY  
      *                     DISPLAY "KEY IS NOT VALID"
      *              NOT INVALID KEY 
      *                     DISPLAY "KEY IS VALID"
      *       END-START.
              
              READ PERSON-IDX-FILE 
                     KEY IS
                            PERSON-IDX-ID
                     AT END 
                            MOVE 'Y' 
                              TO PERSON-IDX-FILE-STATUS-IND
              END-READ.
                  
              MOVE PERSON-IDX-ID
                TO WS-PRSN-ID.
              MOVE PERSON-IDX-FIRST-NAME
                TO WS-PRSN-FIRST-NAME.
              MOVE PERSON-IDX-LAST-NAME
                TO WS-PRSN-LAST-NAME.
              MOVE PERSON-IDX-SEX
                TO WS-PRSN-SEX.
              MOVE PERSON-IDX-ETHNICITY
                TO WS-PRSN-ETHNICITY.
              DISPLAY WS-PRSN-REC.
              
      *       PERFORM 5 TIMES      
      *              MOVE PERSON-IDX-ID
      *                TO WS-PRSN-ID
      *              MOVE PERSON-IDX-FIRST-NAME
      *                TO WS-PRSN-FIRST-NAME
      *              MOVE PERSON-IDX-LAST-NAME
      *                TO WS-PRSN-LAST-NAME
      *              MOVE PERSON-IDX-SEX 
      *                TO WS-PRSN-SEX
      *              MOVE PERSON-IDX-ETHNICITY
      *                TO WS-PRSN-ETHNICITY
      *                
      *              READ PERSON-IDX-FILE NEXT RECORD
      *                     AT END 
      *                            MOVE 'Y' 
      *                              TO PERSON-IDX-FILE-STATUS-IND
      *              END-READ
      *              DISPLAY WS-PRSN-REC
      *       END-PERFORM.
              
              CLOSE PERSON-IDX-FILE.
       
              GO TO 0000-EXIT.
       0000-EXIT.
              STOP RUN.
              EXIT.

