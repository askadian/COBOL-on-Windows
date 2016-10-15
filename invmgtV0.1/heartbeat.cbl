       IDENTIFICATION DIVISION.
       PROGRAM-ID.  HeartBeat.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *  This example program is used for HeartBeat i.e. continuous   *
      *  check to see if the application is Online or not. Various    *
      *  COBODES i.e. Cobol Nodes can do health checks and talk to    *                                                    *
      *  each other.                                                  *                                                    *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
       PROCEDURE DIVISION.
       DisplayPrompt.
           DISPLAY "This is a HeartBeat! I am alive.".
           STOP RUN.
