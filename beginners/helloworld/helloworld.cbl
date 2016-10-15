      *$ SET SOURCEFORMAT"FREE"
       IDENTIFICATION DIVISION.
       PROGRAM-ID.  HelloWorld.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *  This example program is almost the shortest COBOL program we *
      *  can have. We could make it shorter still by leaving out the  *
      *  STOP RUN.                                                    *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       PROCEDURE DIVISION.
       DisplayPrompt.
           DISPLAY "Hello World!".
           STOP RUN.
