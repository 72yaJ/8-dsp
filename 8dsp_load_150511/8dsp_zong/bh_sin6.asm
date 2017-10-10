/*----------------------------------------------------------------------
	文件名：	sin.asm
	作  者：	王喆
	版本号：	V1.0
	创建时间：	2013年8月12日
	软件环境：	Windows XP/DSP Visual
	描  述：	利用6阶泰勒级数计算sin，映射到-pi~pi
	相关参数定义：
				xr31  	输入数据长度
				j3		输入数据地址
				j5		输出数据地址
	注意：		输入数据应为浮点型弧度值
----------------------------------------------------------------------*/
/*----------------------------------------------------------------------
	版本号：
	修改人：
	修改时间：
	修改内容：
----------------------------------------------------------------------*/
#include "defts201.h"
#include "UserDef.h"
//子程序声明
.global _sin;
.extern _sin_stack;

.section program;
_sin:

	[j31+_sin_stack+0] = cjmp;;
	
	r11:10 = q[j3+=4];			r7 = pid;;				
	r0 = JieCheng3;				fr16 = r10 * r7;;
	r1 = JieCheng5;				fr17 = r11 * r7;;
	r2 = JieCheng7;										r14 = fix fr16(t);;
	r3 = JieCheng9;										r15 = fix fr17(t);;
	r8 = 0x1;											fr16 = float r14;;
	xr30 = lshift r31 by -2;	r6 = pi;				fr17 = float r15;;
	r4 = JieCheng11;			fr18 = r16 * r6;		xr29 = r30 - r8;;		
	r5 = JieCheng13;			fr19 = r17 * r6;		xr28 = r29 - r8;;		
	lc0 = xr28;					r9 = 1.0;				fr12 = r10 - r18;;
														fr13 = r11- r19;;
														r16 = abs r14;;
														r17 = abs r15;;
														r14 = r16 and r8;;
														r15 = r17 and r8;;
														fr16 = float r14;;
														fr17 = float r15;;
														fr14 = r16 + r16;;
														fr15 = r17 + r17;;
														fr16 = r9 - r14;;
														fr17 = r9 - r15;;
								fr18 = r12 * r16;;
								fr19 = r13 * r17;;
								fr20 = r18 * r18;;
								fr21 = r19 * r19;;
	r11:10 = q[j3+=4];			fr22 = r18 * r20;;
								fr23 = r19 * r21;;
								fr24 = r22 * r0;;
								fr25 = r23 * r0;;
								fr24 = r22 * r20;		fr26 = r18 - r24;;
								fr25 = r23 * r21;		fr27 = r19 - r25;;
								fr28 = r24 * r1;;
								fr29 = r25 * r1;;
	
LOOP:
	
								fr12 = r10 * r7;		fr30 = r26 + r28;;
								fr13 = r11 * r7;		fr31 = r27 + r29;;
								fr22 = r24 * r20;		r14 = fix fr12(t);;
								fr23 = r25 * r21;		r15 = fix fr13(t);;
								fr24 = r22 * r2;		fr16 = float r14;;
								fr25 = r23 * r2;		fr17 = float r15;;
								fr18 = r16 * r6;		fr26 = r30 - r24;;
								fr19 = r17 * r6;		fr27 = r31 - r25;;
								fr24 = r22 * r20;		fr12 = r10 - r18;;
								fr25 = r23 * r21;		fr13 = r11 - r19;;
								fr28 = r24 * r3;		r16 = abs r14;;
								fr29 = r25 * r3;		r17 = abs r15;;
								fr22 = r24 * r20;		r14 = r16 and r8;;
								fr23 = r25 * r21;		r15 = r17 and r8;;
								fr24 = r22 * r4;		fr10 = float r14;;
								fr25 = r23 * r4;		fr11 = float r15;;
								fr30 = r22 * r20;		fr14 = r10 + r10;;
								fr31 = r23 * r21;		fr15 = r11 + r11;;
								fr14 = r30 * r5;		fr16 = r9 - r14;;
								fr15 = r31 * r5;		fr17 = r9 - r15;;
								fr18 = r12 * r16;		fr30 = r26 + r28;;						
								fr19 = r13 * r17;		fr31 = r27 + r29;;					
								fr20 = r18 * r18;		fr28 = r30 - r24;;		
								fr21 = r19 * r19;		fr29 = r31 - r25;;		
	r11:10 = q[j3+=4];			fr22 = r18 * r20;		fr30 = r28 + r14;;
								fr23 = r19 * r21;		fr31 = r29 + r15;;
								fr24 = r22 * r0;;
								fr25 = r23 * r0;;
	q[j5+=4] = r31:30;			fr24 = r22 * r20;		fr26 = r18 - r24;;
								fr25 = r23 * r21;		fr27 = r19 - r25;;
								fr28 = r24 * r1;;
								
.align_code 4;
	if nlc0e,jump LOOP;			fr29 = r25 * r1;;			
	
								fr12 = r10 * r7;		fr30 = r26 + r28;;
								fr13 = r11 * r7;		fr31 = r27 + r29;;
								fr22 = r24 * r20;		r14 = fix fr12(t);;
								fr23 = r25 * r21;		r15 = fix fr13(t);;
								fr24 = r22 * r2;		fr16 = float r14;;
								fr25 = r23 * r2;		fr17 = float r15;;
								fr18 = r16 * r6;		fr26 = r30 - r24;;
								fr19 = r17 * r6;		fr27 = r31 - r25;;
								fr24 = r22 * r20;		fr12 = r10 - r18;;
								fr25 = r23 * r21;		fr13 = r11 - r19;;
								fr28 = r24 * r3;		r16 = abs r14;;
								fr29 = r25 * r3;		r17 = abs r15;;
								fr22 = r24 * r20;		r14 = r16 and r8;;
								fr23 = r25 * r21;		r15 = r17 and r8;;
								fr24 = r22 * r4;		fr10 = float r14;;
								fr25 = r23 * r4;		fr11 = float r15;;
								fr30 = r22 * r20;		fr14 = r10 + r10;;
								fr31 = r23 * r21;		fr15 = r11 + r11;;
								fr14 = r30 * r5;		fr16 = r9 - r14;;
								fr15 = r31 * r5;		fr17 = r9 - r15;;
								fr18 = r12 * r16;		fr30 = r26 + r28;;						
								fr19 = r13 * r17;		fr31 = r27 + r29;;					
								fr20 = r18 * r18;		fr28 = r30 - r24;;		
								fr21 = r19 * r19;		fr29 = r31 - r25;;		
								fr22 = r18 * r20;		fr30 = r28 + r14;;
								fr23 = r19 * r21;		fr31 = r29 + r15;;
	q[j5+=4] = r31:30;			fr24 = r22 * r0;;
								fr25 = r23 * r0;;
								fr24 = r22 * r20;		fr26 = r18 - r24;;
								fr25 = r23 * r21;		fr27 = r19 - r25;;
								fr28 = r24 * r1;;
								fr29 = r25 * r1;;
								fr22 = r24 * r20;		fr30 = r26 + r28;;
								fr23 = r25 * r21;		fr31 = r27 + r29;;
								fr24 = r22 * r2;;
								fr25 = r23 * r2;;
								fr24 = r22 * r20;		fr26 = r30 - r24;;
								fr25 = r23 * r21;		fr27 = r31 - r25;;
								fr28 = r24 * r3;;
								fr29 = r25 * r3;;
								fr22 = r24 * r20;		fr30 = r26 + r28;;
								fr23 = r25 * r21;		fr31 = r27 + r29;;
								fr26 = r22 * r4;;
								fr27 = r23 * r4;;
								fr24 = r22 * r20;		fr28 = r30 - r26;;
								fr25 = r23 * r21;		fr29 = r31 - r27;;
								fr26 = r24 * r5;;
								fr27 = r25 * r5;;
														fr30 = r28 + r26;;
														fr31 = r29 + r27;;

_Exit:
	xr0 = [j31+_sin_stack+0];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);				q[j5+=4] = r31:30;;
	
_sin.end:
