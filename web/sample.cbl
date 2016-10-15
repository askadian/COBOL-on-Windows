       identification division.
       program-id. sample.

       environment division.
       input-output section.
       data division.
       file section.
       working-storage section.
       01 current-time-raw.
          05 ct-hours      pic 99.
          05 ct-minutes    pic 99.
          05 ct-seconds    pic 99.
          05 ct-hundredths pic 99.
       01 ws-pgm.
          05 ws-pgm-name   pic x(08)
                 value SPACES.

       procedure division.
	      move 12345678 to current-time-raw.
              move 'pgm' to ws-pgm-name.
              call ws-pgm-name.
       goback.
       end program sample.
