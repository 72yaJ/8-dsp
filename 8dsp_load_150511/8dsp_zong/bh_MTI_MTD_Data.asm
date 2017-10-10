#include "defts201.h"
#include "UserDef.h"

.extern _sin;

.section program;
_MTI_MTD_Data:
	[j31 + _ZiJianStack] = cjmp;;

	r3 = [j31+_ZhenShu];;		
																r0 = inc r3;;
	[j31+_ZhenShu] = xr0;;
//	r0 = 1;;//泣撞��霞編喘、、、、、、、、、、、、、、、、、、、、、、、、、、、、、
	r28 = ChangDu;					j4=_DATA;					fr2 = float r0;;
	r1 = XiShu;						r29 = lshift r28 by -1;;
	r4 = 1.0;						fr0 = r2 * r1;				r30 = dec r29;;
	r1 = 0;														r31 = dec r30;;
	lc0 = xr31;;
	r6 = pi22;													r3 = inc r1;;
	yr2 = yr3;;
	r20 = pi2;													r1 = inc r3;;
	xr2 = xr1;;
	r5 = JuLiXiShu;												fr7 = float r2;;
																r3 = inc r1;;
MTDtest_LOOP:
	yr2 = yr3;													fr8 = r7 - r4;;
									fr9 = r8 * r5;;				r1 = inc r3;;
	xr2 = xr1;													fr10 = r9 - r4;;
									fr11 = r10 * r0;;			
									fr29 = r11 * r6;			fr7 = float r2;;			
																fr28 = r20 - r29;;
.align_code 4;
	if nlc0e,jump MTDtest_LOOP;		q[j4+=4] = r29:28;			r3 = inc r1;;
	yr2 = yr3;													fr8 = r7 - r4;;
									fr9 = r8 * r5;				r1 = inc r3;;
	xr2 = xr1;													fr10 = r9 - r4;;
									fr11 = r10 * r0;			fr7 = float r2;;
									fr29 = r11 * r6;			fr8 = r7 - r4;;
									fr9 = r8 * r5;				fr28 = r20 - r29;;
	q[j4+=4] = r29:28;											fr10 = r9-r4;;
	j3 = _DATA;						fr11 = r10*r0;;
									fr29 = r11 * r6;;
	xr30 = ChangDu;												fr28 = r20 - r29;;
	q[j4+=4] = r29:28;				xr27 = 2;;			
.align_code 4;
	call _sin;						xr31 = r27 * r30(I);;
	
_Exit:
.align_code 4;
	xr0 = [j31 + _ZiJianStack];;
	cjmp = xr0;;
	cjmp(np)(abs);;
	
_MTI_MTD_Data.end:
