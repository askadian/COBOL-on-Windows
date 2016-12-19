/* Generated by            cobc 1.1.0 */
/* Generated from          pgm.cbl */
/* Generated at            Sep 22 2016 13:13:40 IST */
/* OpenCOBOL build date    Nov 02 2013 00:16:01 */
/* OpenCOBOL package date  Feb 06 2009 10:30:55 CET */
/* Compile command         cobc -m -C pgm.cbl */

#define  __USE_STRING_INLINES 1
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <libcob.h>

#define COB_SOURCE_FILE		"pgm.cbl"
#define COB_PACKAGE_VERSION	"1.1"
#define COB_PATCH_LEVEL		0

/* Global variables */
#include "pgm.c.h"

/* Function prototypes */

int pgm (void);
static int pgm_ (const int);

/* Functions */

int
pgm ()
{
  return pgm_ (0);
}

static int
pgm_ (const int entry)
{
  /* Local variables */
  #include "pgm.c.l.h"

  static int initialized = 0;
  static cob_field *cob_user_parameters[COB_MAX_FIELD_PARAMS];
  static struct cob_module module = { NULL, NULL, NULL, NULL, cob_user_parameters, 0, '.', '$', ',', 1, 1, 1, 0 };

  /* Start of function code */

  /* CANCEL callback handling */
  if (unlikely(entry < 0)) {
  	if (!initialized) {
  		return 0;
  	}
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
      if (module.next)
        cob_set_cancel ((const char *)"pgm", (void *)pgm, (void *)pgm_);
      (*(int *) (b_1)) = 0;
      memset (b_5, 48, 8);
      initialized = 1;
    }

  cob_save_call_params = cob_call_params;

  /* Entry dispatch */
  goto l_2;

  /* PROCEDURE DIVISION */

  /* Entry pgm */

  l_2:;

  /* MAIN SECTION */

  /* MAIN PARAGRAPH */

  /* pgm.cbl:16: MOVE */
  {
    memcpy (b_5, "98765433", 8);
  }
  /* pgm.cbl:17: GOBACK */
  {
    goto exit_program;
  }

  /* Program exit */

  exit_program:

  /* Pop module stack */
  cob_current_module = cob_current_module->next;

  /* Program return */
  return (*(int *) (b_1));
}

/* End functions */
