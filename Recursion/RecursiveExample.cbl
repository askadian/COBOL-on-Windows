      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. RecursiveExample RECURSIVE.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-AS400.
       OBJECT-COMPUTER. IBM-AS400.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 RESULT       PIC s9(4) comp.
       01 CALL-RESULT  PIC s9(4) comp.
       01 N-MINUS-1    PIC s9(4) comp.
       LINKAGE SECTION.
       01 N            PIC s9(4) comp.

       PROCEDURE DIVISION USING BY VALUE N RETURNING RESULT.
           IF N = 0
              COMPUTE RESULT = 1
           ELSE
              COMPUTE N-MINUS-1 = N - 1
              CALL 'RecursiveExample'
                   USING BY VALUE N-MINUS-1
                   RETURNING INTO CALL-RESULT
              COMPUTE  RESULT = N * CALL-RESULT
           END-IF.
           GOBACK.
