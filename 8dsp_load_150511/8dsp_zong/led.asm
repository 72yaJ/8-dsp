#include "defts201.h"
#include "UserDef.h"

.global _led;
.extern _Inter_Num;

.section program;

_led:

  	xr0 = [j31 + _Inter_Num];;
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

.align_code 4;
	cjmp(np)(abs);;	
_led.end:

