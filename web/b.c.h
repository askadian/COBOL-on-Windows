/* Generated by            cobc 1.1.0 */
/* Generated from          b.cbl */
/* Generated at            Sep 22 2016 11:09:20 IST */
/* OpenCOBOL build date    Nov 02 2013 00:16:01 */
/* OpenCOBOL package date  Feb 06 2009 10:30:55 CET */
/* Compile command         cobc -m -C b.cbl */

/* Frame stack declaration */
struct cob_frame {
	int	perform_through;
	void	*return_address;
};

/* Union for CALL statement */
union cob_call_union {
	void *(*funcptr)();
	int  (*funcint)();
	void *func_void;
};
union cob_call_union	cob_unifunc;


/* Storage */

/* PROGRAM-ID : b */
static unsigned char b_1[4] __attribute__((aligned));	/* RETURN-CODE */
static unsigned char b_5[12] __attribute__((aligned));	/* ws-vars */

/* End of storage */

