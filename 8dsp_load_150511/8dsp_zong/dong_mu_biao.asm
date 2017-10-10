/*----------------------------------------------------------------------
	文件名：	test_main.asm
	作  者：	王喆
	版本号：	V1.0
	创建时间：	2013年12月30日
	软件环境：	Windows XP/DSP Visual
	描  述：	生成动目标
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
//.extern _data_out;
.extern _dongmubiao_stack;
.extern _dmb_fuduxishu;

.section program;
_dong_mu_biao1:
	
	[j31 + _dongmubiao_stack + 0] = cjmp;;
	
	xr0 = 10;;
	[j31 + _canshubiao + 0] = xr0;;//设置扫描圈数
	xr0 = 8192;;
	[j31 + _canshubiao + 1] = xr0;;//设置方位宽度
	xr0 = 10;;
	[j31 + _canshubiao + 2] = xr0;;//设置距离单元上的速度
	xr0 = 10;;
	[j31 + _canshubiao + 3] = xr0;;//设置方位上的速度
	xr0 = 0;;
	[j31 + _canshubiao + 4] = xr0;;//第一圈发现目标的距离单元
	xr0 = 1;;
	[j31 + _canshubiao + 5] = xr0;;//第一圈发现目标的方位码
	xr0 = 5.0;;
	[j31 + _canshubiao + 11] = xr0;;//方位宽度内目标的多普勒频率，浮点
		
	xr0 = [j31 + _canshubiao + 1];;//方位宽度
	xr1 = fangweimajingdu;;//单个方位码对应弧度
	xfr2 = float r0;;
	xfr3 = r2 * r1;;//方位宽度（弧度）
	xr4 = w11;;
	xfr5 = r3 * r4;;
	xr6 = zhouqi1;;
	xfr7 = r5 + r6;;
	[j31 + _canshubiao + 6] = xr7;;//每次追到目标所需的时间
	xr8 = pri1;;
	xfr9 = r5 * r8;;
	xr10 = fix fr9(T);;
	[j31 + _canshubiao + 7] = xr10;;//方位宽度中的帧数
	
	xr0 = [j31 + _canshubiao + 12];;//当前帧数
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
	if xaeq,jump _yiquan1;;
	xcomp(r0,r10);;
.align_code 4;
	if nxaeq,jump _clear_rukou1;;

_yiquan1:
	
	xr2 = [j31 + _canshubiao + 6];;//每次追到目标所需的时间
	xfr3 = float r0;;
	xfr4 = r3 * r2;;//追到目标到当前圈追到目标所需的时间
	
	xr5 = [j31 + _canshubiao + 2];;
	xfr6 = float r5;;
	xfr7 = r4 * r6;;//追到目标时目标运动的距离
	xr8 = [j31 + _canshubiao + 4];;//发现目标的距离单元
	xfr9 = float r8;;
	xfr10 = r7 + r9;;
	xr11 = fix fr10(T);;//追到目标时目标所在的距离单元
	[j31 + _canshubiao + 9] = xr11;;//追到目标时目标所在的距离单元
//判断距离单元溢出则循环	
 	xr0 = [j31 + _canshubiao + 9];;//当前距离单元
	xr1 = [j31 + _canshubiao + 4];;//第一圈发现目标的距离单元
	xr2 = ChangDu;;
	xr3 = 0;;
	xcomp(r2,r0);;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 9] = xr1;;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 8] = xr3;;
	
	xr12 = [j31 + _canshubiao + 3];;
	xfr13 = float r12;;
	xfr14 = r4 * r13;;//追到目标时目标运动的方位
	xr15 = fix fr14(T);;
	xr16 = lshift r15 by 19;;
	xr18 = [j31 + _canshubiao + 5];;//发现目标的方位码
	xr19 = r17 + r18;;
	[j31 + _canshubiao + 10] = xr19;;//追到目标时目标所在的方位码

_clear_rukou1:
	j5 = j10;;
	lc1 = ChangDu*2;;
	xr30 = 0;;
_clear1:
	[j5+=1] = xr30;;
.align_code 4;
	if nlc1e,jump _clear1;;
	
	xr24 = [j31 + _canshubiao + 9];;
	xr25 = lshift r24 by 1;;
	xr26 = dec r25;;
	j3 = xr26;;
	j5 = j10;;
	j7 = j3 + j5;;//目标实部所在距离单元
	
_zhen1:
	xr1 = [j31 + _canshubiao + 8];;//当前扫描的圈数
	[j6 + 0] = xr1;;//输出数据第1个点记录当前扫描圈数、、、、、、、
	xr21 = [j31 + _canshubiao + 10];;
	[j6 + 1] = xr21;;//输出数据第2个点记录当前帧追到目标时目标所在的方位码、、、、、、、
	xr22 = inc r21;;
	[j31 + _canshubiao + 10] = xr22;;//下一帧的方位码
	xr23 = [j31 + _canshubiao + 9];;
	[j6 + 2] = xr23;;//输出数据第3个点记录当前帧追到目标时目标所在的距离单元、、、、、、
	
	xr4 = inc r3;;//当前帧数
	[j31 + _canshubiao + 12] = xr4;;//当前帧数
	xfr7 = float r4;;
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
	r28 = [j31+_dmb_fuduxishu+0];
	xr0 = 0;;
	r1 = 1.0;;
	xcomp(r0,r28);;
.align_code 4;
	if xaeq;do,r28 = r1;;
	fr27 = r28 *r27;;
	yfr26 = r26 * r27;;
	xfr26 = r26 * r27;;
	
 	[j7+=1] = yr26;;
 	[j7+=1] = xr26;;

 	xr0 = [j31 + _canshubiao + 12];;//当前帧数
	xr1 = [j31 + _canshubiao + 7];;//每圈生成的帧数
	xr2 = 0;;
	xcomp(r0,r1);;
.align_code 4;
	if xaeq;do,[j31 + _canshubiao + 12] = xr2;;

	xr31 = [j31 + _dongmubiao_stack + 0];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	
_dong_mu_biao1.end:

_dong_mu_biao2:
	
	[j31 + _dongmubiao_stack + 1] = cjmp;;
	
	xr0 = 10;;
	[j31 + _canshubiao + 20] = xr0;;//设置扫描圈数
	xr0 = 8192;;
	[j31 + _canshubiao + 21] = xr0;;//设置方位宽度
	xr0 = 10;;
	[j31 + _canshubiao + 22] = xr0;;//设置距离单元上的速度
	xr0 = 10;;
	[j31 + _canshubiao + 23] = xr0;;//设置方位上的速度
	xr0 = 0;;
	[j31 + _canshubiao + 24] = xr0;;//第一圈发现目标的距离单元
	xr0 = 1;;
	[j31 + _canshubiao + 25] = xr0;;//第一圈发现目标的方位码
	xr0 = 5.0;;
	[j31 + _canshubiao + 31] = xr0;;//方位宽度内目标的多普勒频率，浮点
		
	xr0 = [j31 + _canshubiao + 21];;//方位宽度
	xr1 = fangweimajingdu;;//单个方位码对应弧度
	xfr2 = float r0;;
	xfr3 = r2 * r1;;//方位宽度（弧度）
	xr4 = w11;;
	xfr7 = r5 + r6;;
	[j31 + _canshubiao + 26] = xr7;;//追到目标所需的时间
	xr8 = pri1;;
	xfr9 = r5 * r8;;
	xr10 = fix fr9(T);;
	
	xr0 = [j31 + _canshubiao + 32];;//当前帧数
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
	if xaeq,jump _yiquan2;;
	xcomp(r0,r10);;
.align_code 4;
	if nxaeq,jump _clear_rukou2;;

_yiquan2:
	
	xr0 = [j31 + _canshubiao + 28];;
	xr1 = inc r0;;
	[j31 + _canshubiao + 28] = xr1;;//当前扫描的圈数
	
	xr2 = [j31 + _canshubiao + 26];;//追到目标所需的时间
	xfr3 = float r0;;
	xfr4 = r3 * r2;;//追到目标到当前圈追到目标所需的时间
	
	xr5 = [j31 + _canshubiao + 22];;
	xfr6 = float r5;;
	xfr7 = r4 * r6;;//追到目标时目标运动的距离
	xr8 = [j31 + _canshubiao + 24];;//发现目标的距离单元
	xfr9 = float r8;;
	xfr10 = r7 + r9;;
	xr11 = fix fr10(T);;//当圈追到目标时目标所在的距离单元
	[j31 + _canshubiao + 29] = xr11;;//当圈追到目标时目标所在的距离单元
//判断距离单元溢出则循环	
 	xr0 = [j31 + _canshubiao + 29];;//当前距离单元
	xr1 = [j31 + _canshubiao + 24];;//发现目标的距离单元
	xr2 = ChangDu;;
	xr3 = 0;;
	xcomp(r2,r0);;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 29] = xr1;;
.align_code 4;
	if xale;do,[j31 + _canshubiao + 28] = xr3;;
	
	xr12 = [j31 + _canshubiao + 23];;
	xfr13 = float r12;;
	xfr14 = r4 * r13;;//追到目标时目标运动的方位
	xr15 = fix fr14(T);;
	xr16 = lshift r15 by 19;;
	xr18 = [j31 + _canshubiao + 25];;//发现目标的方位码
	xr19 = r17 + r18;;
	[j31 + _canshubiao + 30] = xr19;;//追到目标时目标所在的方位码

_clear_rukou2:
	j5 = j10;;
	lc1 = ChangDu*2;;
	xr30 = 0;;
_clear2:
	[j5+=1] = xr30;;
.align_code 4;
	if nlc1e,jump _clear2;;
	
	xr24 = [j31 + _canshubiao + 29];;
	xr25 = lshift r24 by 1;;
	xr26 = dec r25;;
	j3 = xr26;;
	j5 = j10;;
	j7 = j3 + j5;;//目标实部所在距离单元
	
_zhen2:
	xr1 = [j31 + _canshubiao + 28];;//当前扫描的圈数
//	[j10 + 0] = xr1;;//输出数据第1个点记录当前扫描圈数
	xr21 = [j31 + _canshubiao + 30];;
//	[j10 + 4] = xr21;;//输出数据第5个点记录当前帧追到目标时目标所在的方位码
	xr22 = inc r21;;
	[j31 + _canshubiao + 30] = xr22;;//下一帧的方位码

	xr3 = [j31 + _canshubiao + 32];;//每圈生成的帧数
	xr4 = inc r3;;//当前帧数
	[j31 + _canshubiao + 32] = xr4;;//当前帧数
	xfr7 = float r4;;
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
	r28 = [j31+_dmb_fuduxishu+1];
	xr0 = 0;;
	r1 = 1.0;;
	xcomp(r0,r28);;
.align_code 4;
	if xaeq;do,r28 = r1;;
	fr27 = r28 *r27;;
	yfr26 = r26 * r27;;
	xfr26 = r26 * r27;;
	
 	[j7+=1] = yr26;;
 	[j7+=1] = xr26;;

 	xr0 = [j31 + _canshubiao + 32];;//当前帧数
	xr1 = [j31 + _canshubiao + 27];;//每圈生成的帧数
	xr2 = 0;;
	xcomp(r0,r1);;
.align_code 4;
	if xaeq;do,[j31 + _canshubiao + 32] = xr2;;

	xr31 = [j31 + _dongmubiao_stack + 1];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	
_dong_mu_biao2.end:

_dong_mu_biao3:
	
	[j31 + _dongmubiao_stack + 2] = cjmp;;
	


	xr31 = [j31 + _dongmubiao_stack + 5];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	
_dong_mu_biao6.end:

