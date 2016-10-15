       identification division.
       program-id. pgm.

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

       procedure division.
	      move 98765433 to current-time-raw.
	      display "Hello AMRESH KADIAN " 
                 current-time-raw.
              display "Enjoy!! and Cheers!! ".
       goback.
       end program pgm.
