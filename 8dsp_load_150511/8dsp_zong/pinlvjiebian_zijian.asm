#include "defts201.h"
#include "UserDef.h"

.global _jiebian_zijian;
.extern _pinlvjiebian_stack;
.extern _pinlvjiebian_flag;

.section program;

_jiebian_zijian:

	[j31+_pinlvjiebian_stack+0] = cjmp;;

	xr0 = [j31 + _pinlvjiebian_flag + 1];;
	xr1 = [j31 + _pinlvjiebian_flag + 2];;
	xr2 = inc r1;;
	xcomp(r2,r0);;
.align_code 4;
	if xaeq;do,xr2 = 0;;
	[j31 + _pinlvjiebian_flag + 2] = xr2;;
	
	j7 = j6;;
	j8 = j6;;
	r4 = 0;;
	xr3 = 0;;
	xcomp(r3,r1);;
.align_code 4;
	if xaeq;do,r4 = 1.0;;
	lc0 = 16384/4;;
_jiebian_loop:
	r7:6 = q[j7+=4];;
	fr8 = r6 * r4;;
	fr9 = r7 * r4;;
	q[j8+=4] = r9:8;;
.align_code 4;
	if nlc0e,jump _jiebian_loop;;

_jiebian_zijian_out:	
	xr0 = [j31+_pinlvjiebian_stack+0];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(abs);;	
	
_jiebian_zijian.end:

