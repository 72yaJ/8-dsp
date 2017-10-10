
/*----------------------------------------------------------------------
	文件名：	test_main.asm
	作  者：	王喆
	版本号：	V1.0
	创建时间：	2014年2月21日
	软件环境：	Windows XP/DSP Visual
	描  述：	生成动目标，8192个方位码中都有目标
----------------------------------------------------------------------*/
/*----------------------------------------------------------------------
	版本号：
	修改人：
	修改时间：
	修改内容：
----------------------------------------------------------------------*/
#include "defts201.h"
#include "UserDef.h"

.global _dong_mu_biao1;
.global _dong_mu_biao2;
.global _dong_mu_biao3;
.extern _canshubiao;
.extern _dongmubiao_stack;
.extern _dmb_fuduxishu;
.extern _leida_zhuanshu;

.section program;

_dong_mu_biao1:
	
	[j31 + _dongmubiao_stack + 0] = cjmp;;

	xr1 = pri;;
	xfr0 = float r0;;
	xr11 = [j31 + _leida_zhuanshu];;
	xr12 = 1;;
	xcomp(r11,r12);;
.align_code 4;
	if xaeq;do,xr3 = w2;;
	xr5 = fix fr4(T);;
	xr6 = lshift r5 by 19;;
	xr7 = lshift r6 by -19;;
	xr8 = [j31 + _canshubiao + 2];;
	xr9 = r7 + r8;;
	
	xr0 = [j31 + _canshubiao + 8];;//距离单元所用的帧数
	xr4 = inc r0;;//当前距离单元所用的帧数
	[j31 + _canshubiao + 8] = xr4;;//当前距离单元所用的帧数
//	[j6 + 3] = xr4;;//输出数据

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//运行时间
	xr11 = [j31 + _canshubiao + 0];;//设置距离单元上的速度
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 1];;//发现目标的距离单元
	xfr14 = r12 + r13;;
	xr15 = fix fr14(T);;
	xr16 = ChangDu;;
	xr17 = 0;;
	xr18 = 1;;
	xcomp(r16,r15);;
.align_code 4;
	if xale;do,xr15 = xr17;;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 8] = xr18;;
	[j31 + _canshubiao + 7] = xr15;;//追到目标时目标所在的距离单元
//	[j6 + 1] = xr15;;//输出数据
	
	j5 = j10;;
	lc1 = ChangDu*2;;
	xr30 = 0;;
_clear1:
	[j5+=1] = xr30;;
.align_code 4;
	if nlc1e,jump _clear1;;
	
	xr24 = [j31 + _canshubiao + 7];;
	xr25 = lshift r24 by 1;;
//	xr26 = dec r25;;
	j3 = xr25;;
	j5 = j10;;
	j7 = j3 + j5;;//目标实部所在距离单元
	
	xr1 = [j31 + _canshubiao + 3];;//取fd
	xr3 = [j31 + _canshubiao + 5];;//帧数
	xfr7 = float r3;;
	xfr8 = r1 * r7;;//fd*zhenshu
	xr9 = pri;;
	xfr10 = r8 * r9;;//fd*zhenshu*pri
	xr2 = 2.0;;
	xfr10 = r10 * r2;;//2*fd*zhenshu*pri
	xr11 = 0.5;;
	xfr12 = r11 - r10;;//0.5-2*fd*zhenshu*pri
	xr13 = pi;;
	xfr14 = r12 * r13;;//(0.5-2*fd*zhenshu*pri)*pi=pi/2-2*pi*fd*zhenshu*pri
	xfr15 = r10 * r13;;//2*pi*fd*zhenshu*pri
	yr15 = xr14;;//pi/2-2*pi*fd*zhenshu*pri
	
	r0 = JieCheng3;;
	r1 = JieCheng5;;
	r2 = JieCheng7;;
	r3 = JieCheng9;;
	r4 = JieCheng11;;
	r5 = JieCheng13;;
	r6 = pi;;
	r7 = pid;;
	r8 = 0x1;;
	r9 = 1.0;;

//映射在-pi/2到pi/2之间
//除以pi，向零取整，乘以pi，原数减去乘积
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//除以2余数z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//泰勒级数	
	fr10 = r30*r30;;	//y^2
	fr12 = r30*r10;;	//y^3
	fr14 = r12*r10;;	//y^5
	fr16 = r14*r10;;	//y^7
	fr18 = r16*r10;;	//y^9
	fr20 = r18*r10;;	//y^11
	fr22 = r20*r10;;	//y^13

	fr24 = r12*r0;;		//y^3/3!
	fr26 = r14*r1;;		//y^5/5!
	fr28 = r16*r2;;		//y^7/7!
	fr10 = r18*r3;;		//y^9/9!
	fr12 = r20*r4;;		//y^11/11!
	fr14 = r22*r5;;		//y^13/13!
	
	fr16 = r30-r24;;
	fr18 = r16+r26;;
	fr20 = r18-r28;;
	
	fr22 = r20+r10;;
	fr24 = r22-r12;;
	fr26 = r24+r14;;
	
	r27 = 1000.0;;
	r28 = [j31 + _canshubiao + 4];
	xr0 = 0;;
	r1 = 1.0;;
	xcomp(r0,r28);;
.align_code 4;
	if xaeq;do,r28 = r1;;
	fr27 = r28 * r27;;
	yfr26 = r26 * r27;;
	xfr26 = r26 * r27;;
	
 	[j7+=1] = yr26;;
 	[j7+=1] = xr26;;

	xr31 = [j31 + _dongmubiao_stack + 0];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	
_dong_mu_biao1.end:

_dong_mu_biao2:
	
	[j31 + _dongmubiao_stack + 1] = cjmp;;
	
	xr0 = 10.0;;
	[j31 + _canshubiao + 10] = xr0;;
	xr0 = 0.0;;
	[j31 + _canshubiao + 11] = xr0;;//发现目标的距离单元，浮点整数
	xr0 = 1;;
	[j31 + _canshubiao + 12] = xr0;;//发现目标的方位码
	xr0 = 5.0;;
	[j31 + _canshubiao + 13] = xr0;;//方位宽度内目标的多普勒频率，浮点
	xr0 = [j31 + _dmb_fuduxishu + 1];;
	[j31 + _canshubiao + 14] = xr0;;//动目标的幅度系数，用于比幅测高，浮点
		
	xr0 = [j31 + _canshubiao + 15];;//方位码所用的帧数
	xr4 = inc r0;;//当前方位码所用的帧数
	[j31 + _canshubiao + 15] = xr4;;//当前方位码所用的帧数
//	[j6 + 2] = xr4;;//输出数据

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//运行时间
	xr3 = w1;;//每秒脉冲扫过的方位码
	xr11 = [j31 + _leida_zhuanshu];;
	xr12 = 1;;
	xcomp(r11,r12);;
.align_code 4;
	if xaeq;do,xr3 = w2;;//每秒脉冲扫过的方位码
	xfr4 = r2 * r3;;//追到目标时目标运动的方位
	xr5 = fix fr4(T);;
	xr6 = lshift r5 by 19;;
	xr7 = lshift r6 by -19;;
	xr8 = [j31 + _canshubiao + 12];;//发现目标的方位码
	xr9 = r7 + r8;;
	[j31 + _canshubiao + 16] = xr9;;//追到目标时目标所在的方位码
//	[j6 + 0] = xr9;;//输出数据
	
	xr0 = [j31 + _canshubiao + 18];;//距离单元所用的帧数
	xr4 = inc r0;;//当前距离单元所用的帧数
	[j31 + _canshubiao + 18] = xr4;;//当前距离单元所用的帧数
//	[j6 + 3] = xr4;;//输出数据

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//运行时间
	xr11 = [j31 + _canshubiao + 10];;//设置距离单元上的速度
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 11];;//发现目标的距离单元
	xfr14 = r12 + r13;;
	xr15 = fix fr14(T);;
	xr16 = ChangDu;;
	xr17 = 0;;
	xr18 = 1;;
	xcomp(r16,r15);;
.align_code 4;
	if xale;do,xr15 = xr17;;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 18] = xr18;;
	[j31 + _canshubiao + 17] = xr15;;
	
	j5 = j10;;
	lc1 = ChangDu*2;;
	xr30 = 0;;
_clear2:
	[j5+=1] = xr30;;
.align_code 4;
	if nlc1e,jump _clear2;;
	
	xr24 = [j31 + _canshubiao + 17];;
	xr25 = lshift r24 by 1;;
//	xr26 = dec r25;;
	j3 = xr25;;
	j5 = j10;;
	j7 = j3 + j5;;//目标实部所在距离单元
	
	xr1 = [j31 + _canshubiao + 13];;//取fd
	xr3 = [j31 + _canshubiao + 15];;//帧数
	xfr7 = float r3;;
	xfr8 = r1 * r7;;//fd*zhenshu
	xr9 = pri;;
	xfr10 = r8 * r9;;//fd*zhenshu*pri
	xr2 = 2.0;;
	xfr10 = r10 * r2;;//2*fd*zhenshu*pri
	xr11 = 0.5;;
	xfr12 = r11 - r10;;//0.5-2*fd*zhenshu*pri
	xr13 = pi;;
	xfr14 = r12 * r13;;//(0.5-2*fd*zhenshu*pri)*pi=pi/2-2*pi*fd*zhenshu*pri
	xfr15 = r10 * r13;;//2*pi*fd*zhenshu*pri
	yr15 = xr14;;//pi/2-2*pi*fd*zhenshu*pri
	
	r0 = JieCheng3;;
	r1 = JieCheng5;;
	r2 = JieCheng7;;
	r3 = JieCheng9;;
	r4 = JieCheng11;;
	r5 = JieCheng13;;
	r6 = pi;;
	r7 = pid;;
	r8 = 0x1;;
	r9 = 1.0;;

//映射在-pi/2到pi/2之间
//除以pi，向零取整，乘以pi，原数减去乘积
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//除以2余数z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//泰勒级数	
	fr10 = r30*r30;;	//y^2
	fr12 = r30*r10;;	//y^3
	fr14 = r12*r10;;	//y^5
	fr16 = r14*r10;;	//y^7
	fr18 = r16*r10;;	//y^9
	fr20 = r18*r10;;	//y^11
	fr22 = r20*r10;;	//y^13

	fr24 = r12*r0;;		//y^3/3!
	fr26 = r14*r1;;		//y^5/5!
	fr28 = r16*r2;;		//y^7/7!
	fr10 = r18*r3;;		//y^9/9!
	fr12 = r20*r4;;		//y^11/11!
	fr14 = r22*r5;;		//y^13/13!
	
	fr16 = r30-r24;;
	fr18 = r16+r26;;
	fr20 = r18-r28;;
	
	fr22 = r20+r10;;
	fr24 = r22-r12;;
	fr26 = r24+r14;;
	
	r27 = 1000.0;;
	r28 = [j31 + _canshubiao + 14];
	xr0 = 0;;
	r1 = 1.0;;
	xcomp(r0,r28);;
.align_code 4;
	if xaeq;do,r28 = r1;;
	fr27 = r28 * r27;;
	yfr26 = r26 * r27;;
	xfr26 = r26 * r27;;
	
 	[j7+=1] = yr26;;
 	[j7+=1] = xr26;;

	xr31 = [j31 + _dongmubiao_stack + 1];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	
_dong_mu_biao2.end:

_dong_mu_biao3:
	
	[j31 + _dongmubiao_stack + 2] = cjmp;;
	
	xr0 = 10.0;;
	[j31 + _canshubiao + 20] = xr0;;
	[j31 + _canshubiao + 21] = xr0;;//第一圈发现目标的距离单元，浮点整数
	xr0 = 1;;
	[j31 + _canshubiao + 22] = xr0;;
	xr0 = 5.0;;
	[j31 + _canshubiao + 23] = xr0;;
	xr0 = [j31 + _dmb_fuduxishu + 2];;
	[j31 + _canshubiao + 24] = xr0;;//动目标的幅度系数，用于比幅测高，浮点
		
	xr0 = [j31 + _canshubiao + 25];;//方位码所用的帧数
	xr4 = inc r0;;//当前方位码所用的帧数
	[j31 + _canshubiao + 25] = xr4;;//当前方位码所用的帧数
//	[j6 + 2] = xr4;;//输出数据
	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//运行时间
	xr3 = w1;;//每秒脉冲扫过的方位码
	xr11 = [j31 + _leida_zhuanshu];;
	xr12 = 1;;
	xcomp(r11,r12);;
.align_code 4;
	if xaeq;do,xr3 = w2;;//每秒脉冲扫过的方位码
	xfr4 = r2 * r3;;//追到目标时目标运动的方位
	xr5 = fix fr4(T);;
	xr6 = lshift r5 by 19;;
	xr7 = lshift r6 by -19;;
	xr8 = [j31 + _canshubiao + 22];;//发现目标的方位码
	xr9 = r7 + r8;;
	[j31 + _canshubiao + 26] = xr9;;//追到目标时目标所在的方位码
//	[j6 + 0] = xr9;;//输出数据
	
	xr0 = [j31 + _canshubiao + 28];;//距离单元所用的帧数
	xr4 = inc r0;;//当前距离单元所用的帧数
	[j31 + _canshubiao + 28] = xr4;;//当前距离单元所用的帧数
//	[j6 + 3] = xr4;;//输出数据

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//运行时间
	xr11 = [j31 + _canshubiao + 20];;//设置距离单元上的速度
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 21];;//发现目标的距离单元
	xfr14 = r12 + r13;;
	xr15 = fix fr14(T);;
	xr16 = ChangDu;;
	xr17 = 0;;
	xr18 = 1;;
	xcomp(r16,r15);;
.align_code 4;
	if xale;do,xr15 = xr17;;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 28] = xr18;;
	[j31 + _canshubiao + 27] = xr15;;//追到目标时目标所在的距离单元
//	[j6 + 1] = xr15;;//输出数据
	
	j5 = j10;;
	lc1 = ChangDu*2;;
	xr30 = 0;;
_clear3:
	[j5+=1] = xr30;;
.align_code 4;
	if nlc1e,jump _clear3;;
	
	xr24 = [j31 + _canshubiao + 27];;
	xr25 = lshift r24 by 1;;
//	xr26 = dec r25;;
	j3 = xr25;;
	j5 = j10;;
	j7 = j3 + j5;;//目标实部所在距离单元
	
	xr1 = [j31 + _canshubiao + 23];;//取fd
	xr3 = [j31 + _canshubiao + 25];;//帧数
	xfr7 = float r3;;
	xfr8 = r1 * r7;;//fd*zhenshu
	xr9 = pri;;
	xfr10 = r8 * r9;;//fd*zhenshu*pri
	xr2 = 2.0;;
	xfr10 = r10 * r2;;//2*fd*zhenshu*pri
	xr11 = 0.5;;
	xfr12 = r11 - r10;;//0.5-2*fd*zhenshu*pri
	xr13 = pi;;
	xfr14 = r12 * r13;;//(0.5-2*fd*zhenshu*pri)*pi=pi/2-2*pi*fd*zhenshu*pri
	xfr15 = r10 * r13;;//2*pi*fd*zhenshu*pri
	yr15 = xr14;;//pi/2-2*pi*fd*zhenshu*pri
	
	r0 = JieCheng3;;
	r1 = JieCheng5;;
	r2 = JieCheng7;;
	r3 = JieCheng9;;
	r4 = JieCheng11;;
	r5 = JieCheng13;;
	r6 = pi;;
	r7 = pid;;
	r8 = 0x1;;
	r9 = 1.0;;

//映射在-pi/2到pi/2之间
//除以pi，向零取整，乘以pi，原数减去乘积
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//除以2余数z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//泰勒级数	
	fr10 = r30*r30;;	//y^2
	fr12 = r30*r10;;	//y^3
	fr14 = r12*r10;;	//y^5
	fr16 = r14*r10;;	//y^7
	fr18 = r16*r10;;	//y^9
	fr20 = r18*r10;;	//y^11
	fr22 = r20*r10;;	//y^13

	fr24 = r12*r0;;		//y^3/3!
	fr26 = r14*r1;;		//y^5/5!
	fr28 = r16*r2;;		//y^7/7!
	fr10 = r18*r3;;		//y^9/9!
	fr12 = r20*r4;;		//y^11/11!
	fr14 = r22*r5;;		//y^13/13!
	
	fr16 = r30-r24;;
	fr18 = r16+r26;;
	fr20 = r18-r28;;
	
	fr22 = r20+r10;;
	fr24 = r22-r12;;
	fr26 = r24+r14;;
	
	r27 = 1000.0;;
	r28 = [j31 + _canshubiao + 24];
	xr0 = 0;;
	r1 = 1.0;;
	xcomp(r0,r28);;
.align_code 4;
	if xaeq;do,r28 = r1;;
	fr27 = r28 * r27;;
	yfr26 = r26 * r27;;
	xfr26 = r26 * r27;;
	
 	[j7+=1] = yr26;;
 	[j7+=1] = xr26;;

	xr31 = [j31 + _dongmubiao_stack + 2];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	
_dong_mu_biao3.end:

_dong_mu_biao4:
	
	[j31 + _dongmubiao_stack + 3] = cjmp;;
	
	xr0 = 10.0;;
	[j31 + _canshubiao + 30] = xr0;;//设置距离单元上的速度
	xr0 = 0.0;;
	[j31 + _canshubiao + 31] = xr0;;//发现目标的距离单元，浮点整数
	xr0 = 1;;
	[j31 + _canshubiao + 32] = xr0;;//发现目标的方位码
	xr0 = 5.0;;
	[j31 + _canshubiao + 33] = xr0;;//方位宽度内目标的多普勒频率，浮点
	xr0 = [j31 + _dmb_fuduxishu + 3];;
	[j31 + _canshubiao + 34] = xr0;;//动目标的幅度系数，用于比幅测高，浮点
		
	xr0 = [j31 + _canshubiao + 35];;//方位码所用的帧数
	xr4 = inc r0;;//当前方位码所用的帧数
	[j31 + _canshubiao + 35] = xr4;;//当前方位码所用的帧数
//	[j6 + 2] = xr4;;//输出数据

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//运行时间
	xr3 = w1;;//每秒脉冲扫过的方位码
	xr11 = [j31 + _leida_zhuanshu];;
	xr12 = 1;;
	xcomp(r11,r12);;
.align_code 4;
	if xaeq;do,xr3 = w2;;//每秒脉冲扫过的方位码
	xfr4 = r2 * r3;;//追到目标时目标运动的方位
	xr5 = fix fr4(T);;
	xr6 = lshift r5 by 19;;
	xr7 = lshift r6 by -19;;
	xr8 = [j31 + _canshubiao + 32];;//发现目标的方位码
	xr9 = r7 + r8;;
	[j31 + _canshubiao + 36] = xr9;;//追到目标时目标所在的方位码
//	[j6 + 0] = xr9;;//输出数据
	
	xr0 = [j31 + _canshubiao + 38];;//距离单元所用的帧数
	xr4 = inc r0;;//当前距离单元所用的帧数
	[j31 + _canshubiao + 38] = xr4;;//当前距离单元所用的帧数
//	[j6 + 3] = xr4;;//输出数据

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//运行时间
	xr11 = [j31 + _canshubiao + 30];;//设置距离单元上的速度
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 31];;//发现目标的距离单元
	xfr14 = r12 + r13;;
	xr15 = fix fr14(T);;
	xr16 = ChangDu;;
	xr17 = 0;;
	xr18 = 1;;
	xcomp(r16,r15);;
.align_code 4;
	if xale;do,xr15 = xr17;;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 38] = xr18;;
	[j31 + _canshubiao + 37] = xr15;;//追到目标时目标所在的距离单元
//	[j6 + 1] = xr15;;//输出数据
	
	j5 = j10;;
	lc1 = ChangDu*2;;
	xr30 = 0;;
_clear4:
	[j5+=1] = xr30;;
.align_code 4;
	if nlc1e,jump _clear4;;
	
	xr24 = [j31 + _canshubiao + 37];;
	xr25 = lshift r24 by 1;;
//	xr26 = dec r25;;
	j3 = xr25;;
	j5 = j10;;
	j7 = j3 + j5;;//目标实部所在距离单元
	
	xr1 = [j31 + _canshubiao + 33];;//取fd
	xr3 = [j31 + _canshubiao + 35];;//帧数
	xfr7 = float r3;;
	xfr8 = r1 * r7;;//fd*zhenshu
	xr9 = pri;;
	xfr10 = r8 * r9;;//fd*zhenshu*pri
	xr2 = 2.0;;
	xfr10 = r10 * r2;;//2*fd*zhenshu*pri
	xr11 = 0.5;;
	xfr12 = r11 - r10;;//0.5-2*fd*zhenshu*pri
	xr13 = pi;;
	xfr14 = r12 * r13;;//(0.5-2*fd*zhenshu*pri)*pi=pi/2-2*pi*fd*zhenshu*pri
	xfr15 = r10 * r13;;//2*pi*fd*zhenshu*pri
	yr15 = xr14;;//pi/2-2*pi*fd*zhenshu*pri
	
	r0 = JieCheng3;;
	r1 = JieCheng5;;
	r2 = JieCheng7;;
	r3 = JieCheng9;;
	r4 = JieCheng11;;
	r5 = JieCheng13;;
	r6 = pi;;
	r7 = pid;;
	r8 = 0x1;;
	r9 = 1.0;;

//映射在-pi/2到pi/2之间
//除以pi，向零取整，乘以pi，原数减去乘积
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//除以2余数z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//泰勒级数	
	fr10 = r30*r30;;	//y^2
	fr12 = r30*r10;;	//y^3
	fr14 = r12*r10;;	//y^5
	fr16 = r14*r10;;	//y^7
	fr18 = r16*r10;;	//y^9
	fr20 = r18*r10;;	//y^11
	fr22 = r20*r10;;	//y^13

	fr24 = r12*r0;;		//y^3/3!
	fr26 = r14*r1;;		//y^5/5!
	fr28 = r16*r2;;		//y^7/7!
	fr10 = r18*r3;;		//y^9/9!
	fr12 = r20*r4;;		//y^11/11!
	fr14 = r22*r5;;		//y^13/13!
	
	fr16 = r30-r24;;
	fr18 = r16+r26;;
	fr20 = r18-r28;;
	
	fr22 = r20+r10;;
	fr24 = r22-r12;;
	fr26 = r24+r14;;
	
	r27 = 1000.0;;
	r28 = [j31 + _canshubiao + 34];
	xr0 = 0;;
	r1 = 1.0;;
	xcomp(r0,r28);;
.align_code 4;
	if xaeq;do,r28 = r1;;
	fr27 = r28 * r27;;
	yfr26 = r26 * r27;;
	xfr26 = r26 * r27;;
	
 	[j7+=1] = yr26;;
 	[j7+=1] = xr26;;

	xr31 = [j31 + _dongmubiao_stack + 3];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	
_dong_mu_biao4.end:
	


