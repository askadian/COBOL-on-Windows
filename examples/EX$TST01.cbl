       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX1TST01.
       AUTHOR. AMRESH KADIAN.
      * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                   *
      * THIS PROGRAM TRIES TO SHOW THE SIZE OF VARIOUS    *
      * COMPUTATIONAL FIELDS IN OPEN COBOL OR GNUCOBOL.   *
      *                                                   *
      * * * * * * * * * * * * * * * * * * * * * * * * * * *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT OUTPUT-FILE 
              ASSIGN TO 'OUT.DAT'.
       DATA DIVISION.
       FILE SECTION.
       FD OUTPUT-FILE.
       01 OUT-REC.
          10 OUT-VAL01   PIC X(20) VALUE SPACES.
      *   10 OUT-FLD01   PIC S9(07) COMP-3.
          10 OUT-FLD01   PIC X(04).
       WORKING-STORAGE SECTION.
       01 WS-VARS.
          05 WS-RANDOM-NBR-C     PIC 9 COMP.
          05 WS-RANDOM-NBR-N     PIC 9(04).
          05 FIELD-01.
              10 WS-VAL01      PIC X(20)
                      VALUE 'PIC S9(7) COMP-3'.
              10 WS-TMP01      PIC S9(7) COMP-3.
          05 FIELD-02.
              10 WS-VAL02      PIC X(20)
                      VALUE 'PIC S9(5)V99 COMP-3'.
              10 WS-TMP02      PIC S9(5)V99 COMP-3.
          05 FIELD-03.
              10 WS-VAL03      PIC X(20)
                      VALUE 'PIC S9(6) COMP-3'.
              10 WS-TMP03      PIC S9(6) COMP-3.
          05 FIELD-04.
              10 WS-VAL04      PIC X(20)
                      VALUE 'PIC 9(7) COMP-3'.
              10 WS-TMP04      PIC 9(7) COMP-3.
          05 FIELD-05.
              10 WS-VAL05      PIC X(20)
                      VALUE ' PIC 9(6) COMP-3'.
              10 WS-TMP05       PIC 9(6) COMP-3.
          05 FIELD-06.
              10 WS-VAL06      PIC X(20)
                      VALUE 'PIC S9(7) COMP'.
              10 WS-TMP06      PIC S9(7) COMP.
          05 FIELD-07.
              10 WS-VAL07      PIC X(20)
                      VALUE 'PIC S9(5)V99 COMP'.
              10 WS-TMP07      PIC S9(5)V99 COMP.
          05 FIELD-08.
              10 WS-VAL08      PIC X(20)
                      VALUE 'PIC S9(6) COMP'.
              10 WS-TMP08      PIC S9(6) COMP.
          05 FIELD-09.
              10 WS-VAL09      PIC X(20)
                      VALUE 'PIC 9(7) COMP'.
              10 WS-TMP09      PIC 9(7) COMP.
          05 FIELD-10.
              10 WS-VAL10      PIC X(20)
                      VALUE ' PIC 9(6) COMP'.
              10 WS-TMP10       PIC 9(6) COMP.
       PROCEDURE DIVISION.
           DISPLAY "HELLO WORLD!".
           
           OPEN OUTPUT OUTPUT-FILE.
           MOVE +1234 TO WS-TMP01.
           DISPLAY WS-VAL01 ' : ' LENGTH OF WS-TMP01
             '(' WS-TMP01 ')'.
           DISPLAY WS-VAL02 ' : ' LENGTH OF WS-TMP02
             '(' WS-TMP02 ')'.
           DISPLAY WS-VAL03 ' : ' LENGTH OF WS-TMP03
             '(' WS-TMP03 ')'.
           DISPLAY WS-VAL04 ' : ' LENGTH OF WS-TMP04
             '(' WS-TMP04 ')'.
           DISPLAY WS-VAL05 ' : ' LENGTH OF WS-TMP05
             '(' WS-TMP05 ')'.
             
             
           DISPLAY WS-VAL06 ' : ' LENGTH OF WS-TMP06
             '(' WS-TMP06 ')'.
           DISPLAY WS-VAL07 ' : ' LENGTH OF WS-TMP07
             '(' WS-TMP07 ')'.
           DISPLAY WS-VAL08 ' : ' LENGTH OF WS-TMP08
             '(' WS-TMP08 ')'.
           DISPLAY WS-VAL09 ' : ' LENGTH OF WS-TMP09
             '(' WS-TMP09 ')'.
           DISPLAY WS-VAL10 ' : ' LENGTH OF WS-TMP10
             '(' WS-TMP10 ')'.
             
           MOVE WS-VAL01 TO OUT-VAL01.
           PERFORM 100 TIMES
               COMPUTE WS-RANDOM-NBR-C =  FUNCTION 
                 RANDOM(FUNCTION SECONDS-PAST-MIDNIGHT) 
               MOVE WS-RANDOM-NBR-C
                 TO WS-RANDOM-NBR-N
               MOVE WS-RANDOM-NBR-N TO OUT-FLD01 
               WRITE OUT-REC 
           END-PERFORM.
           
           CLOSE OUTPUT-FILE.
             
             
       STOP RUN.
