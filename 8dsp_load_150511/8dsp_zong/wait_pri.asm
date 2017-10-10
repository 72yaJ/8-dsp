#include "defts201.h"
#include "cache_macros.h"
#include "UserDef.h"

.global _wait_pri;
.extern _PriFlag;
.extern _Inter_Num;
.extern _wait_pri_stack;

.section program;

_wait_pri:
	[j31+_wait_pri_stack+0] = cjmp;;

	nop;;nop;;nop;;nop;;
_wait_p:

  	xr0 = [j31 + _Inter_Num];;//闪灯
  	xr1 = 0x00000200;;
  	xr2 = r0 and r1;;
  	xcomp(r1,r2);;
.align_code 4;
  	if xaeq,jump _mie;;
_liang: 
  	xr0 = FLAGREG;; 
	xr1 = bset r0 by 0;;
	FLAGREG = xr1;; 
.align_code 4;
 	jump _shandeng_end;;
_mie:
  	xr0 = FLAGREG;; 
	xr1 = bclr r0 by 0;;
	FLAGREG = xr1;; 
_shandeng_end:

#if Debug == 0				//调试标志：0不调试，1调试
	jump _zhengchang;;
#endif	
///* 
//=================调试用，模拟pri中断============================// 
	xr0 = SQCTLCL;;						
	xr0 = bclr r0 by SQCTL_GIE_P;;
	xr0 = bset r0 by SQCTL_NMOD_P;;
	SQCTLCL = xr0;;
	xr3 = [j31+_Inter_Num];; 	
	xr3 = inc r3;;
	[j31+_Inter_Num] = xr3;;
	xr0 = 1;;
	[j31+_PriFlag] = xr0;;
//*/
//------------------等待pri到来-----------------------------------------------------------
_zhengchang:	
  	xr0 = [j31+_PriFlag+0];;			//判断pri中断是否到来
  	xr1 = 1;;
  	xcomp(r0,r1);;
.align_code 4;
  	if nxaeq,jump _wait_p;;

  	xr0 = 0;;						
	[j31+_PriFlag] = xr0;;			//清零pri中断到来flag 
	
	xr0 = [j31+_wait_pri_stack+0];;
	cjmp = xr0;; 
.align_code 4;						
	cjmp(np)(abs);;						
_wait_pri.end:   
