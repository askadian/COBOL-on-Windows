int main (int argc, char **argv)
{
  cob_init (argc, argv);
  cob_stop_run (gnucobol__fastcgi__sample ());
}

/* Functions */

int
gnucobol__fastcgi__sample ()
{
  return gnucobol__fastcgi__sample_ (0);
}

static int
gnucobol__fastcgi__sample_ (const int entry)
{
  /* Local variables */
  #include "gnucobol-fastcgi-sample.c.l.h"

  static int initialized = 0;
  static cob_field *cob_user_parameters[COB_MAX_FIELD_PARAMS];
  static struct cob_module module = { NULL, NULL, NULL, NULL, cob_user_parameters, 0, '.', '$', ',', 1, 1, 1, 0 };

  /* Start of function code */

  /* CANCEL callback handling */
  if (unlikely(entry < 0)) {
  	if (!initialized) {
  		return 0;
  	}
  	cob_close (h_WEBINPUT, 0, NULL);
  	initialized = 0;
  	return 0;
  }

  /* Initialize frame stack */
  frame_ptr = &frame_stack[0];
  frame_ptr->perform_through = 0;

  /* Push module stack */
  module.next = cob_current_module;
  cob_current_module = &module;

  /* Initialize program */
  if (unlikely(initialized == 0))
    {
      if (!cob_initialized) {
        cob_fatal_error (COB_FERROR_INITIALIZED);
      }
      cob_check_version (COB_SOURCE_FILE, COB_PACKAGE_VERSION, COB_PATCH_LEVEL);
      (*(int *) (b_1)) = 0;
      memset (b_7, 48, 8);
      cob_move (&cob_zero, (f0.size = 2, f0.data = b_12, f0.attr = &a_1, &f0));
      *(unsigned char *) (b_12 + 2) = 58;
      memset (b_12 + 3, 48, 2);
      *(unsigned char *) (b_12 + 5) = 58;
      memset (b_12 + 6, 48, 2);
      *(unsigned char *) (b_12 + 8) = 46;
      memset (b_12 + 9, 48, 2);
      memset (b_20, 0, 4);
      *(unsigned char *) (b_22) = 10;
      *(unsigned char *)(b_23) = 0;
      memset (b_24, 32, 256);
      memcpy (b_25, "AUTH_TYPE", 9);
      memset (b_25 + 9, 32, 11);
      memcpy (b_25 + 20, "CONTENT_LENGTH", 14);
      memset (b_25 + 20 + 14, 32, 6);
      memcpy (b_25 + 40, "CONTENT_TYPE", 12);
      memset (b_25 + 40 + 12, 32, 8);
      memcpy (b_25 + 60, "DOCUMENT_ROOT", 13);
      memset (b_25 + 60 + 13, 32, 7);
      memcpy (b_25 + 80, "GATEWAY_INTERFACE", 17);
      memset (b_25 + 80 + 17, 32, 3);
      memcpy (b_25 + 100, "HTTP_ACCEPT", 11);
      memset (b_25 + 100 + 11, 32, 9);
      memcpy (b_25 + 120, "HTTP_ACCEPT_CHARSET ", 20);
      memcpy (b_25 + 140, "HTTP_ACCEPT_ENCODING", 20);
      memcpy (b_25 + 160, "HTTP_ACCEPT_LANGUAGE", 20);
      memcpy (b_25 + 180, "HTTP_COOKIE", 11);
      memset (b_25 + 180 + 11, 32, 9);
      memcpy (b_25 + 200, "HTTP_CONNECTION", 15);
      memset (b_25 + 200 + 15, 32, 5);
      memcpy (b_25 + 220, "HTTP_HOST", 9);
      memset (b_25 + 220 + 9, 32, 11);
      memcpy (b_25 + 240, "HTTP_REFERER", 12);
      memset (b_25 + 240 + 12, 32, 8);
      memcpy (b_25 + 260, "HTTP_USER_AGENT", 15);
      memset (b_25 + 260 + 15, 32, 5);
      memcpy (b_25 + 280, "LIB_PATH", 8);
      memset (b_25 + 280 + 8, 32, 12);
      memcpy (b_25 + 300, "PATH", 4);
      memset (b_25 + 300 + 4, 32, 16);
      memcpy (b_25 + 320, "PATH_INFO", 9);
      memset (b_25 + 320 + 9, 32, 11);
      memcpy (b_25 + 340, "PATH_TRANSLATED", 15);
      memset (b_25 + 340 + 15, 32, 5);
      memcpy (b_25 + 360, "QUERY_STRING", 12);
      memset (b_25 + 360 + 12, 32, 8);
      memcpy (b_25 + 380, "REMOTE_ADDR", 11);
      memset (b_25 + 380 + 11, 32, 9);
      memcpy (b_25 + 400, "REMOTE_HOST", 11);
      memset (b_25 + 400 + 11, 32, 9);
      memcpy (b_25 + 420, "REMOTE_IDENT", 12);
      memset (b_25 + 420 + 12, 32, 8);
      memcpy (b_25 + 440, "REMOTE_PORT", 11);
      memset (b_25 + 440 + 11, 32, 9);
      memcpy (b_25 + 460, "REQUEST_METHOD", 14);
      memset (b_25 + 460 + 14, 32, 6);
      memcpy (b_25 + 480, "REQUEST_URI", 11);
      memset (b_25 + 480 + 11, 32, 9);
      memcpy (b_25 + 500, "SCRIPT_FILENAME", 15);
      memset (b_25 + 500 + 15, 32, 5);
      memcpy (b_25 + 520, "SCRIPT_NAME", 11);
      memset (b_25 + 520 + 11, 32, 9);
      memcpy (b_25 + 540, "SERVER_ADDR", 11);
      memset (b_25 + 540 + 11, 32, 9);
      memcpy (b_25 + 560, "SERVER_ADMIN", 12);
      memset (b_25 + 560 + 12, 32, 8);
      memcpy (b_25 + 580, "SERVER_NAME", 11);
      memset (b_25 + 580 + 11, 32, 9);
      memcpy (b_25 + 600, "SERVER_PORT", 11);
      memset (b_25 + 600 + 11, 32, 9);
      memcpy (b_25 + 620, "SERVER_PROTOCOL", 15);
      memset (b_25 + 620 + 15, 32, 5);
      memcpy (b_25 + 640, "SERVER_SIGNATURE", 16);
      memset (b_25 + 640 + 16, 32, 4);
      memcpy (b_25 + 660, "SERVER_SOFTWARE", 15);
      memset (b_25 + 660 + 15, 32, 5);

      if (!h_WEBINPUT)
      {
        h_WEBINPUT = cob_malloc (sizeof(cob_file));
      }
      h_WEBINPUT->select_name = (const char *)"webinput";
      h_WEBINPUT->file_status = h_WEBINPUT_status;
      memset (h_WEBINPUT_status, '0', 2);
      h_WEBINPUT->assign = NULL;
      h_WEBINPUT->record = &f_6;
      h_WEBINPUT->record_size = NULL;
      h_WEBINPUT->record_min = 0;
      h_WEBINPUT->record_max = 1024;
      h_WEBINPUT->nkeys = 0;
      h_WEBINPUT->keys = NULL;
      h_WEBINPUT->file = NULL;
      h_WEBINPUT->organization = 1;
      h_WEBINPUT->access_mode = 1;
      h_WEBINPUT->lock_mode = 0;
      h_WEBINPUT->open_mode = 0;
      h_WEBINPUT->flag_optional = 0;
      h_WEBINPUT->last_open_mode = 0;
      h_WEBINPUT->special = 1;
      h_WEBINPUT->flag_nonexistent = 0;
      h_WEBINPUT->flag_end_of_file = 0;
      h_WEBINPUT->flag_begin_of_file = 0;
      h_WEBINPUT->flag_first_read = 0;
      h_WEBINPUT->flag_read_done = 0;
      h_WEBINPUT->flag_select_features = 0;
      h_WEBINPUT->flag_needs_nl = 0;
      h_WEBINPUT->flag_needs_top = 0;
      h_WEBINPUT->file_version = 0;

      initialized = 1;
    }

  cob_save_call_params = cob_call_params;

  /* Entry dispatch */
  goto l_2;

  /* PROCEDURE DIVISION */

  /* Entry gnucobol-fastcgi-sample */

  l_2:;

  /* MAIN SECTION */

  /* MAIN PARAGRAPH */

  /* gnucobol-fastcgi-sample.cob:91: CALL */
  {
    {

      module.cob_procedure_parameters[0] = NULL;
      module.cob_procedure_parameters[1] = NULL;
      module.cob_procedure_parameters[2] = NULL;
      module.cob_procedure_parameters[3] = NULL;
      cob_call_params = 0;
      if (unlikely(call_FCGI_Accept.func_void == NULL)) {
        call_FCGI_Accept.func_void = cob_resolve ((const char *)"FCGI_Accept");
      }
      if (unlikely(call_FCGI_Accept.func_void == NULL))
        {
          /* gnucobol-fastcgi-sample.cob:94: DISPLAY */
          {
            cob_display (0, 1, 1, &c_1);
          }
        }
      else
        {
          (*(int *) (b_1)) = call_FCGI_Accept.funcint ();
          cob_set_int (&f_20, (*(int *) (b_1)));
        }
    }
  }
  /* gnucobol-fastcgi-sample.cob:99: PERFORM */
  {
    while (1)
      {
        if (((int)cob_cmp_s32_binary (b_20, 0) <  0))
          break;
        {
          /* gnucobol-fastcgi-sample.cob:101: ACCEPT */
          {
            cob_accept_time (&f_7);
          }
          /* gnucobol-fastcgi-sample.cob:102: MOVE */
          {
            cob_move ((f0.size = 2, f0.data = b_7, f0.attr = &a_5, &f0), (f1.size = 2, f1.data = b_12, f1.attr = &a_1, &f1));
            memcpy (b_12 + 3, b_7 + 2, 2);
            memcpy (b_12 + 6, b_7 + 4, 2);
            memcpy (b_12 + 9, b_7 + 6, 2);
          }
          /* gnucobol-fastcgi-sample.cob:105: DISPLAY */
          {
            cob_display (0, 1, 2, &c_2, &f_22);
          }
          /* gnucobol-fastcgi-sample.cob:107: DISPLAY */
          {
            cob_display (0, 1, 1, &c_3);
          }
          /* gnucobol-fastcgi-sample.cob:108: DISPLAY */
          {
            cob_display (0, 1, 1, &c_4);
          }
          /* gnucobol-fastcgi-sample.cob:111: DISPLAY */
          {
            cob_display (0, 1, 2, &c_5, &c_6);
          }
          /* gnucobol-fastcgi-sample.cob:117: PERFORM */
          {
            (*(unsigned char *) (b_23)) = 1;
            while (1)
              {
                if (((int)cob_cmp_u8_binary (b_23, 34) >  0))
                  break;
                {
                  /* gnucobol-fastcgi-sample.cob:120: ACCEPT */
                  {
                    cob_get_environment ((f0.size = 20, f0.data = b_25 + 20 * ((*(unsigned char *) (b_23)) - 1), f0.attr = &a_2, &f0), &f_24);
                  }
                  /* gnucobol-fastcgi-sample.cob:125: MOVE */
                  {
                    cob_move (cob_intr_substitute (0, 0, 7, &f_24, &c_7, &c_8, &c_9, &c_8, &c_10, &c_8), &f_24);
                  }
                  /* gnucobol-fastcgi-sample.cob:129: DISPLAY */
                  {
                    cob_display (0, 1, 5, &c_11, (f0.size = 20, f0.data = b_25 + 20 * ((*(unsigned char *) (b_23)) - 1), f0.attr = &a_2, &f0), &c_12, cob_intr_trim (0, 0, &f_24, 2), &c_13);
                  }
                  /* gnucobol-fastcgi-sample.cob:137: IF */
                  {
                    if ((((int)cob_cmp ((f0.size = 20, f0.data = b_25 + 20 * ((*(unsigned char *) (b_23)) - 1), f0.attr = &a_2, &f0), &c_14) == 0) && ((int)cob_cmp (&f_24, &c_15) == 0)))
                      {
                        /* gnucobol-fastcgi-sample.cob:141: OPEN */
                        {
                          cob_exception_code = 0;
                          {
                            cob_open (h_WEBINPUT, 1, 0, NULL);
                          }
                          if (unlikely(cob_exception_code != 0))
                            {
                              /* PERFORM Default Error Handler */
                              frame_ptr++;
                              frame_ptr->perform_through = 1;
                              frame_ptr->return_address = &&l_5;
                              goto l_1;
                              l_5:
                              frame_ptr--;
                            }
                        }
                        /* gnucobol-fastcgi-sample.cob:142: READ */
                        cob_exception_code = 0;
                        {
                          cob_read (h_WEBINPUT, 0, NULL, 1);
                        }
                        if (unlikely(cob_exception_code != 0))
                          {
                            if (cob_exception_code == 0x0501)
                              {
                                {
                                  /* gnucobol-fastcgi-sample.cob:143: MOVE */
                                  {
                                    memset (b_6, 32, 1024);
                                  }
                                }
                              }
                            else
                              {
                                /* PERFORM Default Error Handler */
                                frame_ptr++;
                                frame_ptr->perform_through = 1;
                                frame_ptr->return_address = &&l_6;
                                goto l_1;
                                l_6:
                                frame_ptr--;
                              }
                          }
                        /* gnucobol-fastcgi-sample.cob:145: CLOSE */
                        {
                          cob_exception_code = 0;
                          {
                            cob_close (h_WEBINPUT, 0, NULL);
                          }
                          if (unlikely(cob_exception_code != 0))
                            {
                              /* PERFORM Default Error Handler */
                              frame_ptr++;
                              frame_ptr->perform_through = 1;
                              frame_ptr->return_address = &&l_7;
                              goto l_1;
                              l_7:
                              frame_ptr--;
                            }
                        }
                        /* gnucobol-fastcgi-sample.cob:148: DISPLAY */
                        {
                          cob_display (0, 1, 4, &c_16, &c_17, cob_intr_substitute (0, 0, 7, (f0.size = 72, f0.data = b_6 + 0, f0.attr = &a_2, &f0), &c_7, &c_8, &c_9, &c_8, &c_10, &c_8), &c_13);
                        }
                      }
                  }
                }
                (*(unsigned char *) (b_23)) = ((*(unsigned char *) (b_23)) + 1);
              }
          }
          /* gnucobol-fastcgi-sample.cob:159: DISPLAY */
          {
            cob_display (0, 1, 6, &c_18, &f_22, &c_19, &f_12, &f_22, &c_20);
          }
          /* gnucobol-fastcgi-sample.cob:168: CALL */
          {
            {

              module.cob_procedure_parameters[0] = NULL;
              module.cob_procedure_parameters[1] = NULL;
              module.cob_procedure_parameters[2] = NULL;
              module.cob_procedure_parameters[3] = NULL;
              cob_call_params = 0;
              if (unlikely(call_FCGI_Accept.func_void == NULL)) {
                call_FCGI_Accept.func_void = cob_resolve ((const char *)"FCGI_Accept");
              }
              if (unlikely(call_FCGI_Accept.func_void == NULL))
                {
                  /* gnucobol-fastcgi-sample.cob:170: MOVE */
                  {
                    (*(int *)(b_20)) = -1;
                  }
                }
              else
                {
                  (*(int *) (b_1)) = call_FCGI_Accept.funcint ();
                  cob_set_int (&f_20, (*(int *) (b_1)));
                }
            }
          }
        }
      }
  }
  /* gnucobol-fastcgi-sample.cob:175: GOBACK */
  {
    goto exit_program;
  }

  /* Program exit */

  exit_program:

  /* Pop module stack */
  cob_current_module = cob_current_module->next;

  /* Program return */
  return (*(int *) (b_1));


  /* Default Error Handler */

  l_1:;

  if (!(cob_error_file->flag_select_features & COB_SELECT_FILE_STATUS)) {
  	cob_default_error_handle ();
  	cob_stop_run (1);
  }

  if (frame_ptr->perform_through == 1)
    goto *frame_ptr->return_address;

  cob_fatal_error (COB_FERROR_CODEGEN);

}
