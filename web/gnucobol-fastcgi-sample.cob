GNU    >>SOURCE FORMAT IS FIXED
Cobol *> *******************************************************
 Fast *> Author:    Brian Tiffin
  CGI *> Date:      20130308, 20131006
      *> Purpose:   Display the GNU Cobol CGI environment space
      *> Tectonics: cobc -x -C gnucobol-fastcgi-sample.cob
      *>            vi gnucobol-fastcgi-sample.c and change
      *>              #include <stdio.h> to
      *>              #include <fcgi_stdio.h> instead
      *>            cobc -x gnucobol-fastcgi-sample.c -lfcgi
      *>   Move gnucobol-fastcgi-sample to the cgi-bin directory
      *>   browse http://localhost/gnucobol-fastcgiform.html
      **********************************************************
       identification division.
       program-id. gnucobol-fastcgi-sample.

       environment division.
       input-output section.
       file-control.
           select webinput assign to KEYBOARD.

       data division.
       file section.
       fd webinput.
          01 chunk-of-post   pic x(1024).

       working-storage section.
       01 current-time-raw.
          05 ct-hours      pic 99.
          05 ct-minutes    pic 99.
          05 ct-seconds    pic 99.
          05 ct-hundredths pic 99.
       01 current-time.
          05 ct-hours      pic Z9.
          05 filler        pic x value ":".
          05 ct-minutes    pic 99.
          05 filler        pic x value ":".
          05 ct-seconds    pic 99.
          05 filler        pic x value ".".
          05 ct-hundredths pic 99.

       01 fastcgi-accept  usage binary-long.

       78 name-count      value 34.
       01 newline         pic x value x'0a'.
       01 name-index      pic 99 usage comp-5.
       01 value-string    pic x(256).

       01 environment-names.
          02 name-strings.
             03 filler    pic x(20) value 'AUTH_TYPE'.
             03 filler    pic x(20) value 'CONTENT_LENGTH'.
             03 filler    pic x(20) value 'CONTENT_TYPE'.
             03 filler    pic x(20) value 'DOCUMENT_ROOT'.
             03 filler    pic x(20) value 'GATEWAY_INTERFACE'.
             03 filler    pic x(20) value 'HTTP_ACCEPT'.
             03 filler    pic x(20) value 'HTTP_ACCEPT_CHARSET'.
             03 filler    pic x(20) value 'HTTP_ACCEPT_ENCODING'.
             03 filler    pic x(20) value 'HTTP_ACCEPT_LANGUAGE'.
             03 filler    pic x(20) value 'HTTP_COOKIE'.
             03 filler    pic x(20) value 'HTTP_CONNECTION'.
             03 filler    pic x(20) value 'HTTP_HOST'.
             03 filler    pic x(20) value 'HTTP_REFERER'.
             03 filler    pic x(20) value 'HTTP_USER_AGENT'.
             03 filler    pic x(20) value 'LIB_PATH'.
             03 filler    pic x(20) value 'PATH'.
             03 filler    pic x(20) value 'PATH_INFO'.
             03 filler    pic x(20) value 'PATH_TRANSLATED'.
             03 filler    pic x(20) value 'QUERY_STRING'.
             03 filler    pic x(20) value 'REMOTE_ADDR'.
             03 filler    pic x(20) value 'REMOTE_HOST'.
             03 filler    pic x(20) value 'REMOTE_IDENT'.
             03 filler    pic x(20) value 'REMOTE_PORT'.
             03 filler    pic x(20) value 'REQUEST_METHOD'.
             03 filler    pic x(20) value 'REQUEST_URI'.
             03 filler    pic x(20) value 'SCRIPT_FILENAME'.
             03 filler    pic x(20) value 'SCRIPT_NAME'.
             03 filler    pic x(20) value 'SERVER_ADDR'.
             03 filler    pic x(20) value 'SERVER_ADMIN'.
             03 filler    pic x(20) value 'SERVER_NAME'.
             03 filler    pic x(20) value 'SERVER_PORT'.
             03 filler    pic x(20) value 'SERVER_PROTOCOL'.
             03 filler    pic x(20) value 'SERVER_SIGNATURE'.
             03 filler    pic x(20) value 'SERVER_SOFTWARE'.
          02 filler redefines name-strings.
             03 name-string   pic x(20) occurs name-count times.

       procedure division.

      *    call static "FCGI_Accept"
          call "FCGI_Accept"
               returning fastcgi-accept
               on exception
                display
                   "FCGI_Accept call error, link with -lfcgi"
                end-display
       end-call

       perform until fastcgi-accept is less than zero

           accept current-time-raw from time
           move corresponding current-time-raw to current-time

      * Always send out the Content-type before any other IO
           display "Content-type: text/html" newline end-display

           display "<html><body>" end-display
           display
               "<h3>FastCGI environment with GNU Cobol</h3>"
           end-display
           display
               '<a href="/gnucobol-fastcgiform.html">FastCGI form</a>'
               "<p><table>"
           end-display

           *> Accept and display some of the known CGI environment values
           perform varying name-index from 1 by 1
               until name-index > name-count

               accept value-string from environment
                   name-string(name-index)
               end-accept

               *> strip out less, greater, ampersand
               move function substitute(
                        value-string "<" " "; ">" " "; "&" " ")
                 to value-string

               display
                   "<tr><td>"
                   name-string(name-index)
                   ": </td><td>"
                   function trim (value-string trailing)
                   "</td></tr>"
               end-display

               if (name-string(name-index) = "REQUEST_METHOD")
                  and (value-string = "POST")

                      *> channel to POST data is through KEYBOARD
                      open input webinput
                      read webinput
                          at end move spaces to chunk-of-post
                      end-read
                      close webinput
                      *> zero defensive programming above, sad COBOL

                      display
                          '<tr><td align="right">'
                          "First chunk of POST:</td><td>"
                          function substitute(
                            chunk-of-post(1:72)
                            "<" " "; ">" " "; "&" " ")
                          "</td></tr>"
                      end-display
               end-if
           end-perform

           display
               "</table></p>"
               newline
               "Current time: " current-time
               newline
               "</body></html>"
           end-display

      *    call static "FCGI_Accept" returning fastcgi-accept
           call "FCGI_Accept" returning fastcgi-accept
               on exception
                   move -1 to fastcgi-accept
           end-call

       end-perform

       goback.
COOL   end program gnucobol-fastcgi-sample.
