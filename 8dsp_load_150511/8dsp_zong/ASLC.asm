#include "defts201.h"
#include "UserDef.h"
//子程序声明
.global _ASLC;

.extern _fuzhu_zxg;
.extern _zhufuzhu_hxg;
.extern _zuijiaquanzhi;
.extern _fuzhu_zxg_ni;
.extern _ASLC_stack;
.extern _aslc_caiyangweizhi;
.extern _aslc_shuchu;
.extern _main_asm_end;

.section program;
_ASLC:

	[j31+_ASLC_stack+0] = cjmp;;
	
	
	k15 = j7;; 	//主1输入数据
	k16 = j8;; 	//辅1输入数据
	k17 = j9;; 	//辅2输入数据
	k18 = j10;;	//辅3输入数据
	j6 = j11;;	//输出数据

	xr2 = yr31;;
	xr3 = r1 - r2;;
	xr4 = 200;;
	xr5 = r3 * r4(I);;
	j12 = xr5;;
	k12 = xr5;;
	
	j4 = k15;; 	//主1输入数据
	k4 = k16;; 	//辅1输入数据
	
	j4 = j4 + j12;; 	//主1输入数据
	k4 = k4 + k12;; 	//辅1输入数据
		
	k6 = 0;;
	j8 = 0;;
	k7 = k4 + k6;;//辅1采样数据
	j10 = j4 + j8;;//主1采样数据
	
	xr28 = lshift r30 by -1;;
	xr27 = lshift r28 by -1;;
	
//======================辅助通道自相关系数============================================================
	lc0 = xr27;;
	r6 = 0;;
	k9 = k7;;
zxg_LOOP11:
	r1:0 = q[k9+=4];;
	fr2 = r0 * r0;;
	fr3 = r1 * r1;;
	fr4 = r2 + r3;;
	fr6 = r4 + r6;;
//	r6 = r5;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP11;;
	yr7 = xr6;;
	yfr8 = r6 + r7;;
	yr9 = 0;;
	j9 = _fuzhu_zxg;;
	[j9+=1] = yr8;;
	[j9+=1] = yr9;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	k9 = k7;;
	j8 = j7;;
zxg_LOOP12:
	r1:0 = q[k9+=4];;
	r3:2 = q[j8+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r7 - r6;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP12;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j9+=1] = yr16;;
	[j9+=1] = yr17;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	k9 = k7;;
	k6 = k8;;
zxg_LOOP13:
	r1:0 = q[k9+=4];;
	r3:2 = q[k6+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r7 - r6;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP13;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j9+=1] = yr16;;
	[j9+=1] = yr17;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	j8 = j7;;
	k9 = k7;;
zxg_LOOP21:
	r1:0 = q[j8+=4];;
	r3:2 = q[k9+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r7 - r6;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP21;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j9+=1] = yr16;;
	[j9+=1] = yr17;;
	
	lc0 = xr27;;
	r6 = 0;;
	j8 = j7;;
zxg_LOOP22:
	r1:0 = q[j8+=4];;
	fr2 = r0 * r0;;
	fr3 = r1 * r1;;
	fr4 = r2 + r3;;
	fr5 = r4 + r6;;
	r6 = r5;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP22;;
	yr7 = xr6;;
	yfr8 = r6 + r7;;
	yr9 = 0;;
	[j9+=1] = yr8;;
	[j9+=1] = yr9;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	j8 = j7;;
	k6 = k8;;
zxg_LOOP23:
	r1:0 = q[j8+=4];;
	r3:2 = q[k6+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r7 - r6;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP23;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j9+=1] = yr16;;
	[j9+=1] = yr17;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	k6 = k8;;
	k9 = k7;;
zxg_LOOP31:
	r1:0 = q[k6+=4];;
	r3:2 = q[k9+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r7 - r6;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP31;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j9+=1] = yr16;;
	[j9+=1] = yr17;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	k6 = k8;;
	j8 = j7;;
zxg_LOOP32:
	r1:0 = q[k6+=4];;
	r3:2 = q[j8+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r7 - r6;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP32;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j9+=1] = yr16;;
	[j9+=1] = yr17;;
	
	lc0 = xr27;;
	r6 = 0;;
	k6 = k8;;
zxg_LOOP33:
	r1:0 = q[k6+=4];;
	fr2 = r0 * r0;;
	fr3 = r1 * r1;;
	fr4 = r2 + r3;;
	fr5 = r4 + r6;;
	r6 = r5;;
.align_code 4;	
	if nlc0e,jump zxg_LOOP33;;
	yr7 = xr6;;
	yfr8 = r6 + r7;;
	yr9 = 0;;
	[j9+=1] = yr8;;
	[j9+=1] = yr9;;
	
//======================主辅通道互相关系数============================================================
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	j8 = j10;;
	k6 = k7;;
hxg_LOOP11:
	r1:0 = q[j8+=4];;
	r3:2 = q[k6+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r6 - r7;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump hxg_LOOP11;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	j11 = _zhufuzhu_hxg;;
	[j11+=1] = yr16;;
	[j11+=1] = yr17;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	j8 = j10;;
	j12 = j7;;
hxg_LOOP21:
	r1:0 = q[j8+=4];;
	r3:2 = q[j12+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r6 - r7;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump hxg_LOOP21;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j11+=1] = yr16;;
	[j11+=1] = yr17;;
	
	lc0 = xr27;;
	r12 = 0;;
	r13 = 0;;
	j8 = j10;;
	k6 = k8;;
hxg_LOOP31:
	r1:0 = q[j8+=4];;
	r3:2 = q[k6+=4];;
	fr4 = r0 * r2;;
	fr5 = r1 * r3;;
	fr6 = r0 * r3;;
	fr7 = r1 * r2;;
	fr8 = r4 + r5;;
	fr9 = r6 - r7;;
	fr10 = r8 + r12;;
	fr11 = r9 + r13;;
	r12 = r10;;
	r13 = r11;;
.align_code 4;	
	if nlc0e,jump hxg_LOOP31;;
	yr14 = xr12;;
	yr15 = xr13;;
	yfr16 = r12 + r14;;
	yfr17 = r13 + r15;;
	[j11+=1] = yr16;;
	[j11+=1] = yr17;;
	
//======================输入自相关互相关矩阵进行放缩============================================================
///*
	r0 = 0.00000000000001;;
	r3 = 2;;
	lc0 = xr1;;
	j7 = _fuzhu_zxg;;
	j8 = _fuzhu_zxg;;
	k7 = _zhufuzhu_hxg;;
	k8 = _zhufuzhu_hxg;;
fs1_LOOP:
	r5:4 = q[j7+=4];;
	fr6 = r4 * r0;;
	fr7 = r5 * r0;;
	q[j8+=4] = r7:6;;
.align_code 4;	
	if nlc0e,jump fs1_LOOP;;
	lc0 = xr3;;
fs2_LOOP:
	r9:8 = q[k7+=4];;
	fr10 = r8 * r0;;
	fr11 = r9 * r0;;
	q[k8+=4] = r11:10;;
.align_code 4;	
	if nlc0e,jump fs2_LOOP;;
//*/
	j9 = _fuzhu_zxg;;
	j10 = _zhufuzhu_hxg;;
	
///*
	xr0 = 1.0;;
	xr1 = 0.0;;
//	xr0 = 0x427b7822;;
//	xr1 = 0x00000000;;
	l[j9 + 0] = xr1:0;;
	xr0 = 2.0;;
	xr1 = -0.0;;
//	xr0 = 0xc1e54d9a;;
//	xr1 = 0x409e7d44;;
	l[j9 + 2] = xr1:0;;
	xr0 = 3.0;;
	xr1 = -0.0;;
//	xr0 = 0xc084aafb;;
//	xr1 = 0xc0a9c541;;
	l[j9 + 4] = xr1:0;;
	xr0 = 4.0;;
	xr1 = 0.0;;
//	xr0 = 0xc1e54d9a;;
//	xr1 = 0xc09e7d44;;
	l[j9 + 6] = xr1:0;;
	xr0 = 5.0;;
	xr1 = 0.0;;
//	xr0 = 0x4157569e;;
//	xr1 = 0x00000000;;
	l[j9 + 8] = xr1:0;;
	xr0 = 6.0;;
	xr1 = -0.0;;
//	xr0 = 0x3fbc73b9;;
//	xr1 = 0x402fb5c2;;
	l[j9 + 10] = xr1:0;;
	xr0 = 8.0;;
	xr1 = -0.0;;
//	xr0 = 0xc084aafb;;
//	xr1 = 0x40a9c541;;
	l[j9 + 12] = xr1:0;;
	xr0 = 7.0;;
	xr1 = -0.0;;
//	xr0 = 0x3fbc73b9;;
//	xr1 = 0xc02fb5c2;;
	l[j9 + 14] = xr1:0;;
	xr0 = 9.0;;
	xr1 = 0.0;;
//	xr0 = 0x3f38a6d3;;
//	xr1 = 0x00000000;;
	l[j9 + 16] = xr1:0;;
	
	xr0 = 6.0;;
	xr1 = 0.0;;
	l[j10 + 0] = xr1:0;;
	xr0 = 3.0;;
	xr1 = -0.0;;
	l[j10 + 2] = xr1:0;;
	xr0 = 9.0;;
	xr1 = 0.0;;
	l[j10 + 4] = xr1:0;;
//*/	
	
	
	r0 = [j9 + 0];;//a
	r1 = [j9 + 8];;//g
	r2 = [j9 + 2];;//c
	r3 = [j9 + 3];;//d
	fr4 = r0 * r1;;//ag
	fr5 = r2 * r2;;//c^2
	fr6 = r3 * r3;;//d^2
	fr7 = r4 - r5;;
	fr8 = r7 - r6;;//ag-c^2-d^2
	[j9 + 8] = yr8;;
	yr9 = [j9 + 16];;//o
	yfr10 = r8 * r9;;//o(ag-c^2-d^2)
	
	yr11 = [j9 + 4];;//e
	xr11 = [j9 + 10];;//m
	yr12 = [j9 + 5];;//f
	xr12 = [j9 + 11];;//n
	fr13 = r11 * r11;;//y:e^2 x:m^2
	fr14 = r12 * r12;;//y:f^2 x:n^2
	fr15 = r13 + r14;;
	xr1 = yr0;;//a
	fr16 = r15 * r1;;//y:g(e^2+f^2) x:a(m^2+n^2)
	yfr17 = r10 - r16;;//o(ag-c^2-d^2)-g(e^2+f^2)
	yr18 = xr16;;
	yfr19 = r17 - r18;;//o(ag-c^2-d^2)-g(e^2+f^2)-a(m^2+n^2)
	
	r20 = 2.0;;
	yr21 = xr11;;//m
	xr21 = yr12;;//f
	fr22 = r11 * r21;;//y:em x:mf
	yr23 = xr12;;//n
	xr23 = yr11;;//e
	fr24 = r12 * r23;;//y:fn x:ne
	yfr25 = r22 + r24;;//em+fn
	xfr25 = r22 - r24;;//fm-en
	xr2 = yr3;;//d
	fr26 = r25 * r2;;//y:c(em+fn) x:d(fm-en)
	fr27 = r20 * r26;;//y:2c(em+fn) x:2d(fm-en)
	yfr4 = r19 + r27;;//o(ag-c^2-d^2)-g(e^2+f^2)-a(m^2+n^2)+2c(em+fn)
	yr5 = xr27;;//2d(fm-en)
	yfr6 = r4 + r5;;//o(ag-c^2-d^2)-g(e^2+f^2)-a(m^2+n^2)+2c(em+fn)+2d(fm-en)
	[j9 + 16] = yr6;;
	
	xr21 = yr23;;//n
	fr7 = r0 * r21;;//y:am x:an
	xr2 = yr2;;//c
	xr11 = yr12;;//f
	fr9 = r2 * r11;;//y:ce x:cf
	xr12 = yr11;;//e
	fr10 = r3 * r12;;//y:df x:de
	fr13 = r7 - r9;;//y:am-ce x:an-cf
	yfr14 = r13 - r10;;//am-ce-df
	xfr14 = r13 + r10;;//an-cf+de
	[j9 + 10] = yr14;;
	[j9 + 11] = xr14;;
	
	
	yr15 = [j10 + 2];;//x2
	xr15 = [j10 + 3];;//y2
	yr16 = [j10 + 0];;//x1
	xr16 = [j10 + 1];;//y1
	yr17 = [j10 + 1];;//y1
	xr17 = [j10 + 0];;//x1
	fr18 = r0 * r15;;//y:ax2 x:ay2
	fr19 = r2 * r16;;//y:cx1 x:cy1
	fr20 = r3 * r17;;//y:dy1 x:dx1
	fr22 = r18 - r19;;//y:ax2-cx1 x:ay2-cy1
	yfr24 = r22 - r20;;//ax2-cx1-dy1
	xfr24 = r22 + r20;;//ay2-cy1+dx1
	[j10 + 2] = yr24;;
	[j10 + 3] = xr24;;
	
	yr25 = [j10 + 4];;//x3
	xr25 = [j10 + 5];;//y3
	fr26 = r25 * r8;;//y:(ag-c^2-d^2)x3 x:(ag-c^2-d^2)y3
	xr14 = [j9 + 10];;//am-ce-df
	fr27 = r14 * r15;;//y:(am-ce-df)x2 x:(am-ce-df)y2
	fr0 = r26 - r27;;//y:(ag-c^2-d^2)x3-(am-ce-df)x2 x:(ag-c^2-d^2)y3-(am-ce-df)y2
	yr4 = [j9 + 11];;//an-cf+de
	xr4 = [j9 + 11];;//an-cf+de
	yr5 = xr15;;//y2
	xr5 = yr15;;//x2
	fr7 = r4 * r5;;//y:(an-cf+de)y2 x:(an-cf+de)x2
	yfr8 = r0 - r7;;//(ag-c^2-d^2)x3-(am-ce-df)x2-(an-cf+de)y2
	xfr8 = r0 + r7;;//(ag-c^2-d^2)y3-(am-ce-df)y2+(an-cf+de)x2
	xr3 = yr2;;//c
	xr21 = yr21;;//m
	fr9 = r3 * r21;;//y:dm x:cm
	xr1 = yr1;;//g
	fr10 = r12 * r1;;//y:fg x:eg
	fr13 = r9 - r10;;//y:dm-fg x:cm-eg
	xr2 = yr3;;//d
	xr23 = yr23;;//n
	fr14 = r2 * r23;;//y:cn x:dn
	yfr15 = r13 + r14;;//dm+cn-fg
	xfr15 = r13 - r14;;//cm-dn-eg
	xr17 = yr17;;//y1
	fr18 = r15 * r17;;//y:(dm+cn-fg)y1 x:(cm-dn-eg)y1
	fr19 = r8 + r18;;//y:(ag-c^2-d^2)x3-(am-ce-df)x2-(an-cf+de)y2+(dm+cn-fg)y1
					 //x:(ag-c^2-d^2)y3-(am-ce-df)y2+(an-cf+de)x2+(cm-dn-eg)y1
	yr20 = xr15;;//cm-dn-eg
	xr20 = yr15;;//dm+cn-fg				 
	xr16 = yr16;;//x1
	fr21 = r20 * r16;;//y:(cm-dn-eg)x1 x:(dm+cn-fg)x1
	yfr22 = r19 + r21;;//(ag-c^2-d^2)x3-(am-ce-df)x2-(an-cf+de)y2+(cm-dn-eg)x1+(dm+cn-fg)y1			
	xfr22 = r19 - r21;;//(ag-c^2-d^2)y3-(am-ce-df)y2+(an-cf+de)x2-(dm+cn-fg)x1+(cm-dn-eg)y1
	[j10 + 4] = yr22;;
	[j10 + 5] = xr22;;
	
//====================================求最佳权值========================================
	yr0 = [j9 + 8];;//a22
	xr0 = [j9 + 16];;//a33
	fr1 = recips r0;;//(1+delta)(1/x)
	fr2 = r1 * r0;;//(1+delta)
	r3 = 2.0;;
	fr4 = r3 - r2;;//(2-(1+delta))=(1-delta)
	fr5 = r4 * r1;;//(1-delta)(1+delta)(1/x)=(1-delta^2)(1/x)
	fr6 = r5 * r0;;//(1-delta^2)
	fr7 = r3 - r6;;//(2-(1-delta^2))=(1+delta^2)
	fr8 = r7 * r5;;//(1+delta^2)(1-delta^2)(1/x)=(1-delta^4)(1/x)
	fr9 = r8 * r0;;//(1-delta^4)
	fr10 = r3 - r9;;//(2-(1-delta^4))=(1+delta^4)
	fr11 = r10 * r8;;//(1+delta^4)(1-delta^4)(1/x)=(1-delta^8)(1/x)
	
	j11 = _zuijiaquanzhi;;
	
	xr13:12 = l[j10 + 4];;
	xfr14 = r12 * r11;;
	xfr15 = r13 * r11;;
	l[j11 + 4] = xr15:14;;//w31
	
	yr13:12 = l[j9 + 10];;//a23
	yr15:14 = l[j11 + 4];;//w31
	yfr16 = r12 * r14;;
	yfr17 = r13 * r15;;
	yfr18 = r13 * r14;;
	yfr19 = r12 * r15;;
	yfr20 = r16 - r17;;
	yfr21 = r18 + r19;;
	yr23:22 = l[j10 + 2];;//b21
	yfr24 = r22 - r20;;
	yfr25 = r23 - r21;;
	yfr26 = r24 * r11;;
	yfr27 = r25 * r11;;
	l[j11 + 2] = yr27:26;;//w21	
	
	yr0 = [j9 + 0];;//a11
	yfr1 = recips r0;;//(1+delta)(1/x)
	yfr2 = r1 * r0;;//(1+delta)
	yfr4 = r3 - r2;;//(2-(1+delta))=(1-delta)
	yfr5 = r4 * r1;;//(1-delta)(1+delta)(1/x)=(1-delta^2)(1/x)
	yfr6 = r5 * r0;;//(1-delta^2)
	yfr7 = r3 - r6;;//(2-(1-delta^2))=(1+delta^2)
	yfr8 = r7 * r5;;//(1+delta^2)(1-delta^2)(1/x)=(1-delta^4)(1/x)
	yfr9 = r8 * r0;;//(1-delta^4)
	yfr10 = r3 - r9;;//(2-(1-delta^4))=(1+delta^4)
	yfr11 = r10 * r8;;//(1+delta^4)(1-delta^4)(1/x)=(1-delta^8)(1/x)
	
	yr13:12 = l[j11 + 4];;//w31
	yr15:14 = l[j9 + 4];;//a13
	xr13:12 = l[j11 + 2];;//w21
	xr15:14 = l[j9 + 2];;//a12
	fr16 = r12 * r14;;
	fr17 = r13 * r15;;
	fr18 = r13 * r14;;
	fr19 = r12 * r15;;
	fr20 = r16 - r17;;
	fr21 = r18 + r19;;
	yr23:22 = l[j10 + 0];;//b11
	yfr24 = r22 - r20;;
	yfr25 = r23 - r21;;
	yr26 = xr20;;
	yr27 = xr21;;
	yfr0 = r24 - r26;;
	yfr1 = r25 - r27;;
	yfr2 = r0 * r11;;
	yfr3 = r1 * r11;;
	l[j11 + 0] = yr3:2;;//w11
	
//======================进行对消==============================================================
_ASLC_duixiao:
	xr20 = [j31 + _aslc_shuchu];;
	xr21 = 0;;//输出对消数据
	xr22 = 1;;//输出原始数据
	xr23 = 2;;//输出计算要减数据
	xcomp(r20,r21);;
.align_code 4;
	if xaeq;do,yr24 = 1.0;;	
	xcomp(r20,r21);;
.align_code 4;
	if xaeq;do,yr25 = 1.0;;
	xcomp(r20,r21);;
.align_code 4;
	if xaeq;do,yr26 = 1.0;;
	xcomp(r20,r22);;
.align_code 4;
	if xaeq;do,yr24 = 1.0;;	
	xcomp(r20,r22);;
.align_code 4;
	if xaeq;do,yr25 = 0.0;;
	xcomp(r20,r22);;
.align_code 4;
	if xaeq;do,yr26 = 1.0;;
	xcomp(r20,r23);;
.align_code 4;
	if xaeq;do,yr24 = 0.0;;	
	xcomp(r20,r23);;
.align_code 4;
	if xaeq;do,yr25 = 1.0;;
	xcomp(r20,r23);;
.align_code 4;
	if xaeq;do,yr26 = -1.0;;

	lc0 = xr30;;
ASLC_LOOP:
	k6 = _zuijiaquanzhi;;
	yr1:0 = l[k6+=2];;
	yr3:2 = l[k4+=2];;
	yfr4 = r0 * r2;;
	yfr5 = r1 * r3;;
	yfr6 = r0 * r3;;
	yfr7 = r1 * r2;;
	yfr8 = r4 + r5;;
	yfr9 = r6 - r7;;
	
	yr1:0 = l[k6+=2];;
	yr3:2 = l[j5+=2];;
	yfr4 = r0 * r2;;
	yfr5 = r1 * r3;;
	yfr6 = r0 * r3;;
	yfr7 = r1 * r2;;
	yfr10 = r4 + r5;;
	yfr11 = r6 - r7;;
	
	yfr12 = r8 + r10;;
	yfr13 = r9 + r11;;
	
	yr1:0 = l[k6+=2];;
	yr3:2 = l[k5+=2];;
	yfr4 = r0 * r2;;
	yfr5 = r1 * r3;;
	yfr6 = r0 * r3;;
	yfr7 = r1 * r2;;
	yfr8 = r4 + r5;;
	yfr9 = r6 - r7;;
	
	yfr10 = r8 + r12;;
	yfr11 = r9 + r13;;

	yr13:12 = l[j4+=2];;
	yfr12 = r12 * r24;;
	yfr13 = r13 * r24;;
	yfr10 = r10 * r25;;
	yfr11 = r11 * r25;;
	yfr14 = r12 - r10;;
	yfr15 = r13 - r11;;
	yfr14 = r14 * r26;;
	yfr15 = r15 * r26;;
	l[j6+=2] = yr15:14;;
.align_code 4;	
	if nlc0e,jump ASLC_LOOP;;
	
	lc0 = yr31;;
.align_code 4;	
	if nlc0e,jump _ASLC_fenduan_loop;;
	
		
ASLC_Exit:
	xr0 = [j31+_ASLC_stack+0];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;
	
_ASLC.end:
