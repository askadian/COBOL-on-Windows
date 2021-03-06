/* Generated by            cobc 2.0.20131031 */
/* Generated from              gnucobol-fastcgi-sample.cbl */
/* Generated at                Sep 13 2016 06:14:08 */
/* GNU Cobol C++ build date    May 16 2016 14:03:52 */
/* GNU Cobol C++ package date  May 03 2014 21:13:34 UTC */
/* Compile command         cobc -x -C gnucobol-fastcgi-sample.cbl */

extern "C" int FCGI_Accept(...);

/* Module path */
static const char		*cob_module_path = NULL;

/* Attributes */

static const cob_field_attr _a_1(0x11,   9,   0, 0x0041, NULL);
static const cob_field_attr _a_2(0x01,   0,   0, 0x0000, NULL);
static const cob_field_attr _a_3(0x10,   2,   0, 0x0000, NULL);
static const cob_field_attr _a_4(0x24,   2,   0, 0x0000, "Z\001\000\000\0009\001\000\000\000");
static const cob_field_attr _a_5(0x21,   0,   0, 0x0000, NULL);

static const cob_field_attr cob_all_attr(0x22, 0, 0, 0, NULL);


/* Constants */
static const cob_field _c_1(23, (cob_u8_ptr)"Content-type: text/html", &_a_5);
static const cob_field _c_2(12, (cob_u8_ptr)"<html><body>", &_a_5);
static const cob_field _c_3(43, (cob_u8_ptr)"<h3>FastCGI environment with GNU Cobol</h3>", &_a_5);
static const cob_field _c_4(53, (cob_u8_ptr)"<a href=\"/gnucobol-fastcgiform.html\">FastCGI form</a>", &_a_5);
static const cob_field _c_5(10, (cob_u8_ptr)"<p><table>", &_a_5);
static const cob_field _c_6(1, (cob_u8_ptr)"<", &_a_5);
static const cob_field _c_7(1, (cob_u8_ptr)" ", &_a_5);
static const cob_field _c_8(1, (cob_u8_ptr)">", &_a_5);
static const cob_field _c_9(1, (cob_u8_ptr)"&", &_a_5);
static const cob_field _c_10(8, (cob_u8_ptr)"<tr><td>", &_a_5);
static const cob_field _c_11(11, (cob_u8_ptr)": </td><td>", &_a_5);
static const cob_field _c_12(10, (cob_u8_ptr)"</td></tr>", &_a_5);
static const cob_field _c_13(14, (cob_u8_ptr)"REQUEST_METHOD", &_a_5);
static const cob_field _c_14(4, (cob_u8_ptr)"POST", &_a_5);
static const cob_field _c_15(22, (cob_u8_ptr)"<tr><td align=\"right\">", &_a_5);
static const cob_field _c_16(29, (cob_u8_ptr)"First chunk of POST:</td><td>", &_a_5);
static const cob_field _c_17(12, (cob_u8_ptr)"</table></p>", &_a_5);
static const cob_field _c_18(14, (cob_u8_ptr)"Current time: ", &_a_5);
static const cob_field _c_19(14, (cob_u8_ptr)"</body></html>", &_a_5);
static const cob_field _c_20(5, (cob_u8_ptr)"stdin", &_a_5);

static cob_field cob_all_zero(1, (cob_u8_ptr)"0", &cob_all_attr);

static COB_INLINE COB_A_INLINE int
cob_cmp_u8(const void *p, const cob_s64_t n)
{
	if(unlikely(n < 0)) {
		return 1;
	}
	return(*(const unsigned char *)p < n) ? -1 :(*(const unsigned char *)p > n);
}

static COB_INLINE COB_A_INLINE int
cob_cmp_s32(const void *p, const cob_s64_t n)
{
	int	val;
	val = *(const int __unaligned *)p;
	return(val < n) ? -1 :(val > n);
}

