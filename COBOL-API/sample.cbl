       identification division.
       program-id. sample.
       environment division.
       input-output section.
       data division.
       file section.
       working-storage section.
       01 ws-vars.
          05 ws-temp   pic x(01).
       procedure division.
      *     display 'HELLO WORLD!'.
            move SPACE to ws-temp.
       goback.
       end program sample.
