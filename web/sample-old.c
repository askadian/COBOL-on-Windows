#define  __USE_STRING_INLINES 1
/*#include <fcgiapp.h>*/
#include <fcgi_stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <libcob.h>

#define COB_SOURCE_FILE		"sample.cbl"
#define COB_PACKAGE_VERSION	"1.1"
#define COB_PATCH_LEVEL		0

#include "sample.c.h"

int sample ();
static int sample_ (const int);

int
main (int argc, char **argv)
{
  cob_init (argc, argv);
  cob_stop_run (sample ());
}

int
sample ()
{
  return sample_ (0);
}

static int sample_ (const int entry)
{
  #include "sample.c.l.h"
//AMRESH KADIAN - changes start
  FCGX_Stream *in, *out, *err;
  FCGX_ParamArray envp;
  while (FCGX_Accept(&in, &out, &err, &envp) >= 0) {
    char *q = FCGX_GetParam("QUERY_STRING", envp);
    FCGX_FPrintF(out, "Content-type: text/plain\r\n\r\n");
    if (!q) {
      FCGX_FPrintF(out,
          "no query string: check web server configuration\n");
    };

    FCGX_FPrintF(out, "INSIDE sample_()");
    FCGX_FPrintF(out, "My Simple Query: '%s'\n", q);


  static int initialized = 0;
  static cob_field *cob_user_parameters[COB_MAX_FIELD_PARAMS];
  static struct cob_module module = { NULL, NULL, NULL, NULL, cob_user_parameters, 0, '.', '$', ',', 1, 1, 1, 0 };
  if (unlikely(entry < 0)) {
  	if (!initialized) {
  		return 0;
  	}
  	initialized = 0;
  	return 0;
  }
  frame_ptr = &frame_stack[0];
  frame_ptr->perform_through = 0;
  module.next = cob_current_module;
  cob_current_module = &module;
  if (unlikely(initialized == 0))
    {
      if (!cob_initialized) {
        cob_fatal_error (COB_FERROR_INITIALIZED);
      }
      cob_check_version (COB_SOURCE_FILE, COB_PACKAGE_VERSION, COB_PATCH_LEVEL);
      (*(int *) (b_1)) = 0;
      memset (b_5, 48, 8);
      memset (b_10, 32, 8);
      initialized = 1;
    }

  cob_save_call_params = cob_call_params;
  goto l_2;

  l_2:;
  {
    memcpy (b_5, "12345678", 8);
  }
  {
    memcpy (b_10, "pgm     ", 8);
  }
  {
    {

      module.cob_procedure_parameters[0] = NULL;
      module.cob_procedure_parameters[1] = NULL;
      module.cob_procedure_parameters[2] = NULL;
      module.cob_procedure_parameters[3] = NULL;
      cob_call_params = 0;
      cob_unifunc.func_void = cob_call_resolve_1 (&f_11);
      (*(int *) (b_1)) = cob_unifunc.funcint ();
    }
  }
  {
    goto exit_program;
  }
  exit_program:
  cob_current_module = cob_current_module->next;
}
  return (*(int *) (b_1));
}
