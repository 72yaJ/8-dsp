#include "defts201.h"
#include "UserDef.h"

.extern _CFAR_baoluo;
.extern _cfar_zijian_stack;

.section program;

_kuanCFAR:

	[j31+_cfar_zijian_stack+0] = cjmp;;

	j3 = j6;;
	j7 = _CFAR_baoluo;;
	j8 = j3 + j4;;
	xr31 = ChangDu;;
	xr30 = lshift r31 by -1;;
	lc0 = xr30;;
_baoluo1:
	r1:0 = q[j5+=4];;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo1;;
  	
	j4 = 40;;
	j7 = _CFAR_baoluo;;
	j8 = j3 + j4;;
	xr31 = ChangDu;;
	xr30 = lshift r31 by -1;;
	lc0 = xr30;;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo2;;

CFAR_out:	
	xr0 = [j31+_cfar_zijian_stack+0];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
	
_CFAR.end:

_CFAR:

	[j31+_cfar_zijian_stack+1] = cjmp;;

 	j4 = 40;;
	j3 = j6;;
	j7 = _CFAR_baoluo;;
	j8 = j3 + j4;;
	xr31 = ChangDu;;
	xr30 = lshift r31 by -1;;
	lc0 = xr30;;
_baoluo1:
	r1:0 = q[j5+=4];;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo1;;
  	
	j7 = _CFAR_baoluo;;
	lc0 = xr30;;
_baoluo11:
	r1:0 = q[j5+=4];;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo11;;
  	
	j4 = 40;;
	j3 = j6 + LengthBoshu;;
	j5 = j3 + j4;;//空40位模拟帧头
	j7 = _CFAR_baoluo;;
	j8 = j3 + j4;;
	xr31 = ChangDu;;
	xr30 = lshift r31 by -1;;
	lc0 = xr30;;
_zhaibaoluo2:
	r1:0 = q[j5+=4];;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo2;;
  	
 	j7 = _CFAR_baoluo;;
	lc0 = xr30;;
_baoluo21:
	r1:0 = q[j5+=4];;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo21;;
 	
	j4 = 40;;
	j3 = j6 + LengthBoshu*2;;
	j5 = j3 + j4;;//空40位模拟帧头
	j7 = _CFAR_baoluo;;
	j8 = j3 + j4;;
	xr30 = lshift r31 by -1;;
	lc0 = xr30;;
_baoluo3:
	r1:0 = q[j5+=4];;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo3;;
  	
	j7 = _CFAR_baoluo;;
	lc0 = xr30;;
_baoluo31:
	r1:0 = q[j5+=4];;
	r2 = l[j7+=2];;
	fr4 = r0 * r2;;
	fr5 = r1 * r2;;
	q[j8+=4] = r5:4;;
.align_code 4;
  	if nlc0e,jump _baoluo31;;

_CFAR_out:	
	xr0 = [j31+_cfar_zijian_stack+1];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
	
_CFAR.end:

