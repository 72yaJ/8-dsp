#include "defts201.h"
#include "UserDef.h"

.global _add_zhentou;
.extern _zhentou;
.extern _add_zhentou_stack;
.extern ID_num;
.extern _zijian_zhenjishu;
.extern _leida_zhuanshu;

.section program;

_add_zhentou:

	[j31+_add_zhentou_stack+0] = cjmp;;
/*
	xr1 = 1;;
	xcomp(r0,r1);;
.align_code 4;
	xr7 = [j31 + _zijian_zhenjishu + 0];;
	xfr8 = float r7;;
	xfr9 = r8 * r4;;
	xr10 = fix fr9(T);;
	xr14 = [j31 + _zhentou + 3];;
	xr14 += MASK r12 by r13;; 
	[j31 + _zhentou + 3] = xr14;;
	xr14 = [j31 + _zhentou + 43];;
	xr14 += MASK r12 by r13;; 
	[j31 + _zhentou + 43] = xr14;;
	xr14 = [j31 + _zhentou + 83];;
	xr14 += MASK r12 by r13;; 
	[j31 + _zhentou + 83] = xr14;;
	xr14 = [j31 + _zhentou + 123];;
	xr14 += MASK r12 by r13;; 
	[j31 + _zhentou + 123] = xr14;;
	xr14 = [j31 + _zhentou + 163];;
	xr14 += MASK r12 by r13;; 
	[j31 + _zhentou + 163] = xr14;;
	xr14 = [j31 + _zhentou + 203];;
	xr14 += MASK r12 by r13;; 
	[j31 + _zhentou + 203] = xr14;;

	xr8 = inc r7;;
	[j31 + _zijian_zhenjishu + 0] = xr8;;
*/	
	
	
	lc0 = 10;;
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou1;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 40;;
	lc0 = 10;;
_add_zhentou2:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou2;;
#endif

	lc0 = 10;;
_add_zhentou3:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou3;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 120;;
	lc0 = 10;;
_add_zhentou4:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou4;;
#endif	

	lc0 = 10;;
_add_zhentou1:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou1;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 40;;
	lc0 = 10;;
_add_zhentou2:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou2;;

	lc0 = 10;;
_add_zhentou3:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou3;;
#endif	

	lc0 = 10;;
_add_zhentou4:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou4;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 160;;
	lc0 = 10;;
_add_zhentou5:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou5;;

	lc0 = 10;;
_add_zhentou6:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_zhentou6;;
#endif	


_add_zhentou_out:	
	xr0 = [j31+_add_zhentou_stack+0];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
	
_add_zhentou.end:

