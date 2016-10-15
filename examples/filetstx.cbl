       Identification Division.
        Program-Id. filetstx.
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
      *  This is a "silly little program" that is really just         * 
      *      intended to validate that all the required Berkley       * 
      *      database stuff is installed and working correctly        *
      *  If it works correctly, there should be two "pass messages"   * 
      *      at  the end of compiling and running it                  * 
      *  Make certain to comment out the "ALL" subscript lines        * 
      *      until/unless OC supports this.                           * 
      * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * 
       Environment Division.
        Input-Output Section.
         File-Control.
           Select IndFile Assign IndName
               Access Dynamic
               Organization Indexed
               Status Ind-FS
               Record Key IndKey .
           Select RelFile Assign RelName
               Access Dynamic
               Organization Relative
               Status Rel-FS
               Relative Key RelKey .
       Data Division.
        File Section.
       FD  RelFile
           Record Varying in Size
               From 1 to 999
               Depending on RelLen.
       01  RelRec.
           05  RR-Elem occurs 1 to 999 times
                   Depending on RelLen
                              Pic X(01).      
       FD  IndFile
           Record 50.
       01  IndRec.
           05  RelNum         Pic 9(03).
           05                 Pic X(01).
           05  IndKey.
               10       Pic X(13).
               10  SHH        Pic 9(03).
               10       Pic X(05).
           05                 Pic X(25).
        Working-Storage Section.
       01  IF-Stuff.
           05  IndName        Pic X(08)   Value "indftest".
           05  Ind-FS         Pic X(02).
               88  IFS-OK                 Value "00".
               88  IFS-DupKey             Value "22".
       01  RF-Stuff.
           05  RelName        Pic X(08)   Value "relftest".
           05  Rel-FS         Pic X(02).
               88  RFS-OK                 Value "00".
               88  RFS-DupKey             Value "22".
           05  RelKey         Pic 9(03).
           05  RelLen         Pic 9(03).
       01  RelTabl.
           05  Each-RelKey
                 Occurs 10 times
                 indexed by RelInd.
               10 aRelKey     Pic 9(03).
               10 Rel-OK      Pic X(01)   Value "N".
       01  IndTabl.
           05  Each-IndKey
                 Occurs 10 times
                 indexed by IndInd.
               10 anIndKey    Pic X(21).
               10 Ind-OK      Pic X(01)   Value "N".
       01  TempStuff.
      *  NumFld is used because Fujitsu truncates FUNCTION RANDOM if
      *         all receiving fields are integers
           05  NumFld         Pic 9(09)V9(09).
           05  Int            Pic 9(04).
           05  Save-Current-Date Pic X(21)      Value Spaces.
       01  EOF-Markers.
           05                 Pic X(01)   Value "N".
                88 IF-EOF                 Value "Y".          
           05                 Pic X(01)   Value "N".
                88 RF-EOF                 Value "Y".
       Procedure Division.
        Mainline.
      *    move 'indftest2' to IndName
           Perform rfile
           If RFS-OK
               Perform ifile
               If IFS-OK
                  Open I-O IndFile
                           RelFile
                  Perform Read-From-IndFile
                  Perform Read-From-RelFile
                  Close IndFile
                        RelFile
               End-If
           End-If
      *  Comment Out the next lines until OC supports ALL subscript
      *        If Function Min (Rel-OK (all)) = "Y"
      *         Display "For IndFile tests, '" with no advancing
      *            Display Function Max (Rel-OK (all))
      *                    "' means this test passed"
      *        End-IF
      *
           Set RelInd to 1
           Search Each-RelKey
             At End
               Display "Random Access of IndFile Passed"
             When Rel-OK (RelInd) = "N"
               Display "Random Access of IndFile Failed"
               Display "  RelKey:" aRelKey (RelInd) " not checked off"
           End-Search
      *  Comment Out the next lines until OC supports ALL subscrip
      *     If Function Min (Ind-OK (all)) = "Y"
      *         Display "For RelFile tests, '" with no advancing
      *            Display Function Max (Ind-OK (all))
      *                    "' means this test passed"
      *        End-IF
      *
           Set IndInd to 1
           Search Each-IndKey
             At End
               Display "Random Access of RelFile Passed"
             When Ind-OK (IndInd) = "N"
               Display "Random Access of RelFile Failed"
               Display "  IndKey:" anIndKey (IndInd) " not checked off"
           End-Search          
           GoBack
            .
        Read-From-IndFile.
           If IFS-Ok
               Perform Until IF-EOF
                   Read IndFile Next
                       At End
                           Set IF-EOF to True
                       Not At End
      *                     Display "IndRec (in order)" IndRec
                           Move RelNum to RelKey
                           Set RelInd to 1
                           Search Each-RelKey
                             At End
                                 Display "RelKey not found:" RelKey
                             When aRelKey (RelInd) = RelKey
                                 Move "Y" to Rel-OK (RelInd)
                           End-Search
                           Read RelFile
                               Invalid Key
                                   Display "Related RelRec not found"
                               Not Invalid Key
      *                            Display
      *                                "RelRec for " RelKey "=" RelRec
                                   Move IndKey to RelRec (1:22)
                                   Rewrite RelRec
                                   If not RFS-OK
                                       Display "Bad RFS:" Rel-FS
                                   End-If 
                           End-Read
                   End-Read
                End-Perform
            End-If
             .
        Read-From-RelFile.
           Move 1 to RelKey
           Start RelFile
             Key >= RelKey
               Invalid Key
                   Display "Inv Key for START" RelKey
           End-Start
           If RFS-Ok
               Perform until RF-EOF
                   Read RelFile Next
                       At End
                           Set RF-EOF to True
                       Not At End
      *                    Display "RelRed #" RelKey " is:" RelRec
                           Move RelRec (1:21) to IndKey
                           Set IndInd to 1
                           Search Each-IndKey
                             At End
                                 Display "IndKey not found:" IndKey
                             When anIndKey (IndInd) = IndKey
                                 Move "Y" to Ind-OK (IndInd)
                           End-Search     
                           Read IndFile
                               Invalid Key
                                   Display "Related IndRec not found"
                               Not Invalid Key
      *                            Display "Related IndRec=" IndRec
                                   Continue
                           End-Read                                                                                 
                   End-Read
                End-Perform
            End-If
             .
         rfile.
           Set RelInd to 1
           Open Output RelFile
           Move Function Current-Date to Save-Current-Date
           If RFS-OK
               Perform Create-rFile
                   Varying RelInd
                     From +1 by +1
                     Until (RelInd > 10)
                        or (not RFS-OK)  
           Else
               Display "Bad FS on OPEN:" Rel-FS
           End-IF
           Close RelFile
            .
         Create-rFile.
           Move Zero to RelKey
           Perform until RelKey Not = Zero
               Compute RelKey NumFld = ((Function Random) * 1000)
           End-Perform
           Compute RelLen = Function Mod (RelKey 22) + 23
           Move all "-" to RelRec
           Perform
             until (Function Current-Date > Save-Current-Date)
               Continue
           End-Perform
           Move Function Current-Date to RelRec (1:22)
                                         Save-Current-Date
           Write RelRec
               Invalid Key
                  If not RFS-DupKey
                       Display "Invalid Key, FS:"  Rel-FS
                       Exit Paragraph
                   Else
                        Display "Duplicate RelKey"
                   End-If
               Not Invalid Key
                   Move RelKey to aRelKey (RelInd)
           End-Write
           If   (not RFS-OK)
            and (not RFS-DupKey)
               Display "Bad FS on WRITE:" Rel-FS
           End-If
            .
        ifile.
           Open Output IndFile
           If IFS-OK
               Perform Create-iFile
                   Varying RelInd
                     from +1 by +1
                     Until (RelInd > 10)
                        or (not IFS-OK)
           Else
               Display "Bad FS on OPEN:" Ind-FS
           End-IF
           Close IndFile
            .
        Create-iFile.
           Move all "-" to IndRec
           Move aRelKey (RelInd) to RelNum
           Perform
             until (Function Current-Date > Save-Current-Date)
               Move Function Current-Date to Save-Current-Date
           End-Perform
           Move Function Current-Date to IndKey
           Compute Int NumFld = (Function Random) * 10000
           Compute SHH = Function Mod (Int 1000)
           Set IndInd to RelInd
           Move IndKey to anIndKey (IndInd)
           Write IndRec
               Invalid Key
                   If not IFS-DupKey
                       Display "Invalid Key, FS:"  Ind-FS
                       Exit Paragraph
                   Else
                       Display "Duplicate IndKey:" IndKey
                       Set RelInd down by +1
                       Set IFS-OK to True
                   End-If
           End-Write
           If   (not IFS-OK)
            and (not IFS-DupKey)
               Display "Bad FS on WRITE:" Ind-FS
           End-If
            .      
       End Program filetstx.   
