      *$ SET SOURCEFORMAT"FREE"
       IDENTIFICATION DIVISION.
       PROGRAM-ID.   LibRoyaltyRpt.
       AUTHOR.  MICHAEL COUGHLAN.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *  Exam paper model answer. Each time a book is borrowed, the   *
      *  Pascal Memorial Library pays the author a small sum of money *
      *  as royalty.  Royalties are paid to authors through their     *
      *  agents. A report is required which processes the Authors file*
      *  and the Books File to produce a report which shows the amount*
      *  to be sent to each agent, shows the breakdown of the agent   *
      *  payment into author payments, and shows the breakdown of each*
      *  author payment into royalty payments per book. Read the      *
      *  program specification first. The required data files may be  *
      *  downloaded from there.                                       *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      * DP291-1991-Exam.
      * Originally written for VAX COBOL 1991
      * Converted to Microfocus NetExpress 2002

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT BOOK-FILE ASSIGN TO "BOOKS.DAT"
                   ORGANIZATION IS INDEXED
                   ACCESS MODE IS DYNAMIC
                   RECORD KEY IS BOOK-NUMBER-FA
                   ALTERNATE RECORD KEY IS AUTHOR-NUMBER-FA
                       WITH DUPLICATES
                   FILE STATUS IS BOOK-ERROR-STATUS.

           SELECT AUTHOR-FILE ASSIGN TO "AUTHOR.DAT"
                   ORGANIZATION IS INDEXED
                   ACCESS MODE IS DYNAMIC
                   RECORD KEY IS AUTHOR-NUM-FB
                   ALTERNATE RECORD KEY IS AGENT-NAME-FB
                                       WITH DUPLICATES
                   FILE STATUS IS AUTHOR-ERROR-STATUS.

           SELECT PRINT-FILE ASSIGN TO "ROYALTIES.RPT".


       DATA DIVISION.
       FILE SECTION.
           
       FD  BOOK-FILE.
       01  BOOK-REC-FA.
           02 BOOK-NUMBER-FA            PIC 9(7).
           02 BOOK-NAME-FA              PIC X(25).
           02 AUTHOR-NUMBER-FA          PIC 9(7).
           02 ROYALTY-RATE-FA           PIC V999.
           02 QTR-BORROWINGS-FA         PIC 999.

       FD  AUTHOR-FILE.
       01  AUTHOR-REC-FB.            
           02 AUTHOR-NUM-FB             PIC 9(7).
           02 AUTHOR-NAME-FB            PIC X(25).
           02 AGENT-NAME-FB             PIC X(25).


       FD  PRINT-FILE.
       01  PRINT-LINE-FC                PIC X(130).

       WORKING-STORAGE SECTION.
       01  ERROR-STATES.
           02 BOOK-ERROR-STATUS         PIC X(2).
              88 RECORD-ALREADY-EXISTS  VALUE "22".
              88 RECORD-DOES-NOT-EXIST  VALUE "23".
           02 AUTHOR-ERROR-STATUS       PIC X(2).
              88 RECORD-ALREADY-EXISTS  VALUE "22".
              88 RECORD-DOES-NOT-EXIST  VALUE "23".

       01  INTERMEDIATE-VARIABLES.
           02 BOOK-ROYALTY              PIC 9(3)V99.
           02 QTR-AUTHOR-BORROWS        PIC 9(4).
           02 AUTHOR-ROYALTIES          PIC 9(4)V99.
           02 AGENT-PAYMENT             PIC 9(6)V99.
           02 PREV-AUTHOR               PIC 9(7).
           02 PREV-AGENT                PIC X(25).

       01  EOF-FLAGS.
           02 FILLER                    PIC 9 VALUE 0.
              88 END-OF-AUTHOR-FILE     VALUE 1.
           02 FILLER                    PIC 9 VALUE 0.
              88 END-OF-BOOK-FILE       VALUE 1.
              88 NOT-END-OF-BOOK-FILE   VALUE 0.

       01  REPORT-LINES.
           02 REPORT-HEADER.
              03 FILLER                 PIC X(37) VALUE SPACES.
              03 FILLER                 PIC X(24) VALUE
                       "ROYALTY  PAYMENT  REPORT".

           02 UNDER-LINE.
              03 FILLER                 PIC X(36) VALUE SPACES.
              03 FILLER                 PIC X(25) VALUE ALL "-".

           02 FIELD-HEADERS.
              03 FILLER                 PIC X(9) VALUE SPACES.
              03 FILLER                 PIC X(5) VALUE "AGENT".
              03 FILLER                 PIC X(21) VALUE SPACES.
              03 FILLER                 PIC X(6) VALUE "AUTHOR".
              03 FILLER                 PIC X(20) VALUE SPACES.
              03 FILLER                 PIC X(4) VALUE "BOOK".
              03 FILLER                 PIC X(16) VALUE SPACES.
              03 FILLER                 PIC X(7) VALUE "QTR.BRW".
              03 FILLER                 PIC X(9) VALUE "  ROYALTY".

           02 BOOK-LINE.
              03 AGENT-NAME-PRN         PIC X(25).
              03 AUTHOR-NAME-PRN        PIC BBX(25).
              03 BOOK-NAME-PRN          PIC BBX(25).
              03 BOOK-QTR-BORROWS-PRN   PIC BBBBZZ9.
              03 BOOK-ROYALTY-PRN       PIC BBBB$$$9.99.

           02 AUTHOR-LINES.
              03 QTR-BORROWS-LINE.
                 04 FILLER              PIC X(54) VALUE SPACES.
                 04 FILLER              PIC X(36) VALUE
                           "QUARTER BORROWINGS FOR THIS AUTHOR =".
                 04 QTR-BORROWS-PRN     PIC BBBBBZ,ZZ9.

              03 QTR-ROYALTIES-LINE.
                 04 FILLER              PIC X(54) VALUE SPACES.
                 04 FILLER              PIC X(36) VALUE
                           "ROYALTIES OWED TO THIS AUTHOR      =".
                 04 QTR-ROYALTIES-PRN   PIC B$$,$$9.99.

           02 AGENT-LINE.
              03 FILLER                 PIC X(55) VALUE SPACES.
              03 FILLER                 PIC X(33) VALUE
                       "AMOUNT TO BE PAID TO THIS AGENT =".
              03 AGENT-ROYALTIES-PRN    PIC B$$$$,$$9.99.



       PROCEDURE DIVISION.
       10-BEGIN.
           OPEN  I-O  BOOK-FILE.
           OPEN  I-O AUTHOR-FILE.
           OPEN OUTPUT PRINT-FILE.
           MOVE SPACES TO PRINT-LINE-FC.
           WRITE PRINT-LINE-FC AFTER ADVANCING PAGE.
           WRITE PRINT-LINE-FC FROM REPORT-HEADER AFTER ADVANCING 1  LINE.
               WRITE PRINT-LINE-FC FROM UNDER-LINE AFTER ADVANCING 1 LINE.
           WRITE PRINT-LINE-FC FROM FIELD-HEADERS AFTER ADVANCING 3 LINES.
           MOVE SPACES TO PRINT-LINE-FC.
           WRITE PRINT-LINE-FC AFTER ADVANCING 1 LINE.
           MOVE SPACES TO AGENT-NAME-FB.
           START AUTHOR-FILE KEY IS GREATER THAN AGENT-NAME-FB
               INVALID KEY DISPLAY "OH DEAR SOMETHING WRONG IN 10-START"
           END-START.
           READ AUTHOR-FILE NEXT RECORD 
               AT END SET END-OF-AUTHOR-FILE TO TRUE
           END-READ.
           PERFORM 20-PROCESS-AGENTS UNTIL END-OF-AUTHOR-FILE.
           CLOSE BOOK-FILE.
           CLOSE AUTHOR-FILE.
           CLOSE PRINT-FILE.
           STOP RUN.    

       20-PROCESS-AGENTS.
           MOVE AGENT-NAME-FB TO AGENT-NAME-PRN, PREV-AGENT.
           MOVE ZEROS TO AGENT-PAYMENT.

           PERFORM 30-PROCESS-AUTHORS 
               UNTIL END-OF-AUTHOR-FILE
                   OR AGENT-NAME-FB NOT EQUAL TO PREV-AGENT.

           MOVE AGENT-PAYMENT TO AGENT-ROYALTIES-PRN.
           WRITE PRINT-LINE-FC FROM AGENT-LINE AFTER ADVANCING 1 LINE.
           MOVE SPACES TO PRINT-LINE-FC.
           WRITE PRINT-LINE-FC AFTER ADVANCING 2 LINES.

               


       30-PROCESS-AUTHORS.
           MOVE ZEROS TO QTR-AUTHOR-BORROWS, AUTHOR-ROYALTIES.
           MOVE AUTHOR-NUM-FB TO AUTHOR-NUMBER-FA, PREV-AUTHOR.
           DISPLAY "AUTHOR NUMBER " AUTHOR-NUMBER-FA.
           MOVE AUTHOR-NAME-FB TO AUTHOR-NAME-PRN.
           READ BOOK-FILE 
               KEY IS AUTHOR-NUMBER-FA
               INVALID KEY
                DISPLAY "ERROR IN 20-PROCESS-AGENTS = " BOOK-ERROR-STATUS
           END-READ.
           DISPLAY "BOOK RECORD IN 20-PROCESS-AGENTS "  BOOK-REC-FA.
           PERFORM 40-PROCESS-BOOKS 
               UNTIL END-OF-BOOK-FILE 
                   OR AUTHOR-NUMBER-FA NOT EQUAL TO PREV-AUTHOR.
           SET NOT-END-OF-BOOK-FILE TO TRUE.
           MOVE QTR-AUTHOR-BORROWS TO QTR-BORROWS-PRN.
           MOVE AUTHOR-ROYALTIES    TO QTR-ROYALTIES-PRN.
           WRITE PRINT-LINE-FC FROM QTR-BORROWS-LINE AFTER ADVANCING 2 LINES.
           WRITE PRINT-LINE-FC FROM QTR-ROYALTIES-LINE AFTER ADVANCING 1 LINE.
           MOVE SPACES TO PRINT-LINE-FC.
           WRITE PRINT-LINE-FC AFTER ADVANCING 2 LINES.
           READ AUTHOR-FILE NEXT RECORD 
               AT END SET END-OF-AUTHOR-FILE TO TRUE
           END-READ.

       40-PROCESS-BOOKS.
           PERFORM 50-PROCESS-ONE-BOOK.
           READ BOOK-FILE    NEXT RECORD
               AT END SET END-OF-BOOK-FILE TO TRUE
           END-READ.
           MOVE SPACES TO AUTHOR-NAME-PRN, AGENT-NAME-PRN.

       50-PROCESS-ONE-BOOK.
           MULTIPLY QTR-BORROWINGS-FA BY ROYALTY-RATE-FA 
               GIVING BOOK-ROYALTY ROUNDED.
           ADD QTR-BORROWINGS-FA  TO QTR-AUTHOR-BORROWS.
           ADD BOOK-ROYALTY  TO AUTHOR-ROYALTIES, AGENT-PAYMENT.
           MOVE BOOK-NAME-FA TO BOOK-NAME-PRN.
           MOVE QTR-BORROWINGS-FA TO BOOK-QTR-BORROWS-PRN.
           MOVE BOOK-ROYALTY TO BOOK-ROYALTY-PRN.
           WRITE PRINT-LINE-FC FROM BOOK-LINE
                    AFTER ADVANCING 1 LINE.

           MOVE ZEROS TO QTR-BORROWINGS-FA.
           REWRITE BOOK-REC-FA
               INVALID KEY
               DISPLAY "REWRITE 50-PROCESS-ONE-BOOK " BOOK-ERROR-STATUS
           END-REWRITE.
