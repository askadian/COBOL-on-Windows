       IDENTIFICATION DIVISION.
       PROGRAM-ID.  MainMenu.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      *                                                               *
      *  This example program is used for displaying the Main Menu    *
      *  of the inventory application. The options are:               *
      *       1. Stock Management                                     *
      *       2. Supplier Management                                  *
      *       3. Purchase Management                                  *
      *       4. Customer Management                                  *
      *       5. Sales Management                                     *
      *       6. Reports                                              *
      *       7. For Future Use                                       *
      *       Enter your choice:                                      *
      *                                                               *
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-VARS.
              10 WS-MENU-OPTION     PIC X(01)
                            VALUE SPACE.
              10 WS-EXIT-OPTION     PIC X(01)
                            VALUE "7".
       PROCEDURE DIVISION.
       DisplayPrompt.
       
              PERFORM 1000-INITIALIZE
                 THRU 1000-EXIT.
              PERFORM 2000-DISPLAY
                 THRU 2000-EXIT
                UNTIL WS-MENU-OPTION IS EQUAL TO WS-EXIT-OPTION.
                
           STOP RUN.
              
       1000-INITIALIZE.
              MOVE SPACE TO WS-MENU-OPTION.
       1000-EXIT.
              EXIT.
              
       2000-DISPLAY.
           DISPLAY " ".
           DISPLAY "Inventory Management System".
           DISPLAY "----------------------------".
           DISPLAY "1. Stock Management".
           DISPLAY "2. Supplier Management".
           DISPLAY "3. Purchase Management".
           DISPLAY "4. Customer Management".
           DISPLAY "5. Sales Management".
           DISPLAY "6. Reports".
           DISPLAY "7. Exit".
           DISPLAY " ".
           DISPLAY "Enter your choice:".
           
           ACCEPT WS-MENU-OPTION.
           DISPLAY 
              "You selected: " 
              WS-MENU-OPTION
               WITH NO ADVANCING.
       2000-EXIT.
              EXIT.
