
/*----------------------------------------------------------------------
	�ļ�����	test_main.asm
	��  �ߣ�	����
	�汾�ţ�	V1.0
	����ʱ�䣺	2014��2��21��
	���������	Windows XP/DSP Visual
	��  ����	���ɶ�Ŀ�꣬8192����λ���ж���Ŀ��
----------------------------------------------------------------------*/
/*----------------------------------------------------------------------
	�汾�ţ�
	�޸��ˣ�
	�޸�ʱ�䣺
	�޸����ݣ�
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
	
	xr0 = [j31 + _canshubiao + 8];;//���뵥Ԫ���õ�֡��
	xr4 = inc r0;;//��ǰ���뵥Ԫ���õ�֡��
	[j31 + _canshubiao + 8] = xr4;;//��ǰ���뵥Ԫ���õ�֡��
//	[j6 + 3] = xr4;;//�������

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//����ʱ��
	xr11 = [j31 + _canshubiao + 0];;//���þ��뵥Ԫ�ϵ��ٶ�
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 1];;//����Ŀ��ľ��뵥Ԫ
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
	[j31 + _canshubiao + 7] = xr15;;//׷��Ŀ��ʱĿ�����ڵľ��뵥Ԫ
//	[j6 + 1] = xr15;;//�������
	
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
	j7 = j3 + j5;;//Ŀ��ʵ�����ھ��뵥Ԫ
	
	xr1 = [j31 + _canshubiao + 3];;//ȡfd
	xr3 = [j31 + _canshubiao + 5];;//֡��
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

//ӳ����-pi/2��pi/2֮��
//����pi������ȡ��������pi��ԭ����ȥ�˻�
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//����2����z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//̩�ռ���	
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
	[j31 + _canshubiao + 11] = xr0;;//����Ŀ��ľ��뵥Ԫ����������
	xr0 = 1;;
	[j31 + _canshubiao + 12] = xr0;;//����Ŀ��ķ�λ��
	xr0 = 5.0;;
	[j31 + _canshubiao + 13] = xr0;;//��λ�����Ŀ��Ķ�����Ƶ�ʣ�����
	xr0 = [j31 + _dmb_fuduxishu + 1];;
	[j31 + _canshubiao + 14] = xr0;;//��Ŀ��ķ���ϵ�������ڱȷ���ߣ�����
		
	xr0 = [j31 + _canshubiao + 15];;//��λ�����õ�֡��
	xr4 = inc r0;;//��ǰ��λ�����õ�֡��
	[j31 + _canshubiao + 15] = xr4;;//��ǰ��λ�����õ�֡��
//	[j6 + 2] = xr4;;//�������

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//����ʱ��
	xr3 = w1;;//ÿ������ɨ���ķ�λ��
	xr11 = [j31 + _leida_zhuanshu];;
	xr12 = 1;;
	xcomp(r11,r12);;
.align_code 4;
	if xaeq;do,xr3 = w2;;//ÿ������ɨ���ķ�λ��
	xfr4 = r2 * r3;;//׷��Ŀ��ʱĿ���˶��ķ�λ
	xr5 = fix fr4(T);;
	xr6 = lshift r5 by 19;;
	xr7 = lshift r6 by -19;;
	xr8 = [j31 + _canshubiao + 12];;//����Ŀ��ķ�λ��
	xr9 = r7 + r8;;
	[j31 + _canshubiao + 16] = xr9;;//׷��Ŀ��ʱĿ�����ڵķ�λ��
//	[j6 + 0] = xr9;;//�������
	
	xr0 = [j31 + _canshubiao + 18];;//���뵥Ԫ���õ�֡��
	xr4 = inc r0;;//��ǰ���뵥Ԫ���õ�֡��
	[j31 + _canshubiao + 18] = xr4;;//��ǰ���뵥Ԫ���õ�֡��
//	[j6 + 3] = xr4;;//�������

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//����ʱ��
	xr11 = [j31 + _canshubiao + 10];;//���þ��뵥Ԫ�ϵ��ٶ�
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 11];;//����Ŀ��ľ��뵥Ԫ
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
	j7 = j3 + j5;;//Ŀ��ʵ�����ھ��뵥Ԫ
	
	xr1 = [j31 + _canshubiao + 13];;//ȡfd
	xr3 = [j31 + _canshubiao + 15];;//֡��
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

//ӳ����-pi/2��pi/2֮��
//����pi������ȡ��������pi��ԭ����ȥ�˻�
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//����2����z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//̩�ռ���	
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
	[j31 + _canshubiao + 21] = xr0;;//��һȦ����Ŀ��ľ��뵥Ԫ����������
	xr0 = 1;;
	[j31 + _canshubiao + 22] = xr0;;
	xr0 = 5.0;;
	[j31 + _canshubiao + 23] = xr0;;
	xr0 = [j31 + _dmb_fuduxishu + 2];;
	[j31 + _canshubiao + 24] = xr0;;//��Ŀ��ķ���ϵ�������ڱȷ���ߣ�����
		
	xr0 = [j31 + _canshubiao + 25];;//��λ�����õ�֡��
	xr4 = inc r0;;//��ǰ��λ�����õ�֡��
	[j31 + _canshubiao + 25] = xr4;;//��ǰ��λ�����õ�֡��
//	[j6 + 2] = xr4;;//�������
	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//����ʱ��
	xr3 = w1;;//ÿ������ɨ���ķ�λ��
	xr11 = [j31 + _leida_zhuanshu];;
	xr12 = 1;;
	xcomp(r11,r12);;
.align_code 4;
	if xaeq;do,xr3 = w2;;//ÿ������ɨ���ķ�λ��
	xfr4 = r2 * r3;;//׷��Ŀ��ʱĿ���˶��ķ�λ
	xr5 = fix fr4(T);;
	xr6 = lshift r5 by 19;;
	xr7 = lshift r6 by -19;;
	xr8 = [j31 + _canshubiao + 22];;//����Ŀ��ķ�λ��
	xr9 = r7 + r8;;
	[j31 + _canshubiao + 26] = xr9;;//׷��Ŀ��ʱĿ�����ڵķ�λ��
//	[j6 + 0] = xr9;;//�������
	
	xr0 = [j31 + _canshubiao + 28];;//���뵥Ԫ���õ�֡��
	xr4 = inc r0;;//��ǰ���뵥Ԫ���õ�֡��
	[j31 + _canshubiao + 28] = xr4;;//��ǰ���뵥Ԫ���õ�֡��
//	[j6 + 3] = xr4;;//�������

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//����ʱ��
	xr11 = [j31 + _canshubiao + 20];;//���þ��뵥Ԫ�ϵ��ٶ�
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 21];;//����Ŀ��ľ��뵥Ԫ
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
	[j31 + _canshubiao + 27] = xr15;;//׷��Ŀ��ʱĿ�����ڵľ��뵥Ԫ
//	[j6 + 1] = xr15;;//�������
	
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
	j7 = j3 + j5;;//Ŀ��ʵ�����ھ��뵥Ԫ
	
	xr1 = [j31 + _canshubiao + 23];;//ȡfd
	xr3 = [j31 + _canshubiao + 25];;//֡��
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

//ӳ����-pi/2��pi/2֮��
//����pi������ȡ��������pi��ԭ����ȥ�˻�
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//����2����z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//̩�ռ���	
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
	[j31 + _canshubiao + 30] = xr0;;//���þ��뵥Ԫ�ϵ��ٶ�
	xr0 = 0.0;;
	[j31 + _canshubiao + 31] = xr0;;//����Ŀ��ľ��뵥Ԫ����������
	xr0 = 1;;
	[j31 + _canshubiao + 32] = xr0;;//����Ŀ��ķ�λ��
	xr0 = 5.0;;
	[j31 + _canshubiao + 33] = xr0;;//��λ�����Ŀ��Ķ�����Ƶ�ʣ�����
	xr0 = [j31 + _dmb_fuduxishu + 3];;
	[j31 + _canshubiao + 34] = xr0;;//��Ŀ��ķ���ϵ�������ڱȷ���ߣ�����
		
	xr0 = [j31 + _canshubiao + 35];;//��λ�����õ�֡��
	xr4 = inc r0;;//��ǰ��λ�����õ�֡��
	[j31 + _canshubiao + 35] = xr4;;//��ǰ��λ�����õ�֡��
//	[j6 + 2] = xr4;;//�������

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//����ʱ��
	xr3 = w1;;//ÿ������ɨ���ķ�λ��
	xr11 = [j31 + _leida_zhuanshu];;
	xr12 = 1;;
	xcomp(r11,r12);;
.align_code 4;
	if xaeq;do,xr3 = w2;;//ÿ������ɨ���ķ�λ��
	xfr4 = r2 * r3;;//׷��Ŀ��ʱĿ���˶��ķ�λ
	xr5 = fix fr4(T);;
	xr6 = lshift r5 by 19;;
	xr7 = lshift r6 by -19;;
	xr8 = [j31 + _canshubiao + 32];;//����Ŀ��ķ�λ��
	xr9 = r7 + r8;;
	[j31 + _canshubiao + 36] = xr9;;//׷��Ŀ��ʱĿ�����ڵķ�λ��
//	[j6 + 0] = xr9;;//�������
	
	xr0 = [j31 + _canshubiao + 38];;//���뵥Ԫ���õ�֡��
	xr4 = inc r0;;//��ǰ���뵥Ԫ���õ�֡��
	[j31 + _canshubiao + 38] = xr4;;//��ǰ���뵥Ԫ���õ�֡��
//	[j6 + 3] = xr4;;//�������

	xr1 = pri;;
	xfr0 = float r0;;
	xfr2 = r0 * r1;;//����ʱ��
	xr11 = [j31 + _canshubiao + 30];;//���þ��뵥Ԫ�ϵ��ٶ�
	xfr12 = r11 *r2;;
	xr13 = [j31 + _canshubiao + 31];;//����Ŀ��ľ��뵥Ԫ
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
	[j31 + _canshubiao + 37] = xr15;;//׷��Ŀ��ʱĿ�����ڵľ��뵥Ԫ
//	[j6 + 1] = xr15;;//�������
	
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
	j7 = j3 + j5;;//Ŀ��ʵ�����ھ��뵥Ԫ
	
	xr1 = [j31 + _canshubiao + 33];;//ȡfd
	xr3 = [j31 + _canshubiao + 35];;//֡��
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

//ӳ����-pi/2��pi/2֮��
//����pi������ȡ��������pi��ԭ����ȥ�˻�
	fr12 = r15*r7;;//z/(pi)
	r14 = fix fr12(t);;//fix(z/pi)
	fr16 = float r14;;
	fr18 = r16*r6;;//fix(z/pi)*pi
	fr20 = r15-r18;;//x=z-fix(z/pi)*pi
	r22 = abs r14;;
	r24 = r22 and r8;;//����2����z1
	fr26 = float r24;;//z1
	fr28 = r26+r26;;//2*z1
	fr28 = r9-r28;;//1-2*z1
	fr30 = r20*r28;;//y=(1-2*z1)*x
	
//̩�ռ���	
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
	


