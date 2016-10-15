OCOBOL >>SOURCE FORMAT IS FIXED
      ******************************************************************
      * Author:    Brian Tiffin, Francois Hiniger
      * Date:      30-Aug-2008
      * Purpose:   Display the CGI environment space
      * Tectonics: cobc -x cgienv.cob
      *   Move cgienv to the cgi-bin directory as cgienv.cgi
      *   browse http://localhost/cgi-bin/cgienv.cgi or cgienvform.html
      ******************************************************************
       identification division.
       program-id. cgienv.

       environment division.
       input-output section.
       file-control.
           select webinput assign to KEYBOARD.

       data division.
       file section.
       fd webinput.
          01 postchunk       pic x(1024).

       working-storage section.
       78 name-count      value 34.
       01 newline         pic x   value x'0a'.
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

      * Always send out the Content-type before any other IO

       display
           "Content-type: text/html"
           newline
       end-display.
       display
           "<html><body>"
       end-display.
       display
           "<h3>CGI environment with OpenCOBOL</h3>"
       end-display.
       display
           '<a href="/cgienvform.html">To cgienvform.html</a>'
           "<p><table>"
       end-display.
      * Accept and display some of the known CGI environment values
       perform varying name-index from 1 by 1
           until name-index > name-count
               accept value-string from environment
                   name-string(name-index)
               end-accept
               display
                   "<tr><td>"
                   name-string(name-index)
                   ": </td><td>"
                   function trim (value-string trailing)
                   "</td></tr>"
               end-display
               if (name-string(name-index) = "REQUEST_METHOD")
                  and (value-string = "POST")
                      open input webinput
                      read webinput
                          at end move spaces to postchunk
                      end-read
                      close webinput
                      display
                          '<tr><td align="right">'
                          "First chunk of POST:</td><td>"
                          postchunk(1:72)
                          "</td></tr>"
                      end-display
               end-if
       end-perform.
       display "</table></p></body></html>" end-display.
COOL   goback.
