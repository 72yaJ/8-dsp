#include "defts201.h"
#include "cache_macros.h"
#include "UserDef.h"

.global _can;
.extern _can_mingling;
.extern _Inter_Num;
.extern _zhentou;
.extern _ReData1_buffer1;
.extern _ReData1_buffer2;
.extern _CFAR_Flag;
.extern _ChuLi_Flag;
.extern _JianCe_Flag;
.extern _zijian_kongzhi;
.extern _can_stack;
.extern ID_num;
.extern _aslc_caiyangweizhi;
.extern _aslc_shuchu;

.section program;

_can:

	[j31+_can_stack+0] = cjmp;;

	j4 = _ReData1_buffer2;;//处理接收到的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j4 = _ReData1_buffer1;;
	
	j5 = j4;;
	j3 = _zhentou;;
	lc0 = 10;;
_qu_zhentou1:
	r1:0 = q[j5+=4];;
	q[j3+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _qu_zhentou1;;
	
	j5 = j4 + LengthBoshu;;
_qu_zhentou2:
	r1:0 = q[j5+=4];;
	q[j3+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _qu_zhentou2;;
	
	j5 = j4 + LengthBoshu*2;;
	lc0 = 10;;
_qu_zhentou3:
	r1:0 = q[j5+=4];;
	q[j3+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _qu_zhentou3;;
	
	j5 = j4 + LengthBoshu*3;;
	j3 = _zhentou + 120;;
	lc0 = 10;;
_qu_zhentou4:
	r1:0 = q[j5+=4];;
	q[j3+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _qu_zhentou4;;
	
//#if ID_NUM == 4 || ID_NUM == 6	//窄波束
	j5 = j4 + LengthBoshu*4;;
	j3 = _zhentou + 160;;
	lc0 = 10;;
_qu_zhentou5:
	r1:0 = q[j5+=4];;
	q[j3+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _qu_zhentou5;;
		
	j5 = j4 + LengthBoshu*5;;
	lc0 = 10;;
_qu_zhentou6:
	r1:0 = q[j5+=4];;
	q[j3+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _qu_zhentou6;;
//#endif	

#if TestCan == 1	//can调试
//写入can命令，调试时用	
	j3 = _zhentou;;
	xr2 = [j31+_can_mingling+1];;
	xr3 = [j31+_can_mingling+2];;
	xr0 = [j31+_can_mingling+0];;
//	xr1 = 0x0e00;;//其他板号
	xr1 = 0x13a8;;//本板号
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _can_out;;
	[j31+_zhentou+6] = xr0;;
	[j31+_zhentou+7] = xr2;;
	[j31+_zhentou+8] = xr3;;
	[j31+_zhentou+46] = xr0;;
	[j31+_zhentou+47] = xr2;;
	[j31+_zhentou+48] = xr3;;
	[j31+_zhentou+86] = xr0;;
	[j31+_zhentou+87] = xr2;;
	[j31+_zhentou+88] = xr3;;
	[j31+_zhentou+126] = xr0;;
	[j31+_zhentou+127] = xr2;;
	[j31+_zhentou+128] = xr3;;
	[j31+_zhentou+166] = xr0;;
	[j31+_zhentou+167] = xr2;;
	[j31+_zhentou+168] = xr3;;
	[j31+_zhentou+206] = xr0;;
	[j31+_zhentou+207] = xr2;;
	[j31+_zhentou+208] = xr3;;
#endif	

//读取can命令
_jiexi_can:
	j3 = _can_mingling;;
	xr2 = [j31+_zhentou+7];;
	xr3 = [j31+_zhentou+8];;
	xr0 = [j31+_zhentou+6];;
	xr1 = 0x13a8;;//本板号
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _can_out;;
	[j3+=1] = xr0;;
	[j3+=1] = xr2;;
	[j3+=1] = xr3;;
	
	
_can_30xx://检测can命令

	xr0 = [j31+_can_mingling+1];;
	xr1 = 0;;
	xr9 = 0x1808;;
	xr1 = fext r0 by r9;;//D0
	xr2 = 0;;
	xr9 = 0x1008;;
	xr2 = fext r0 by r9;;//D1
	xr3 = 0;;
	xr9 = 0x0808;;
	xr3 = fext r0 by r9;;//D2
	xr4 = 0;;
	xr9 = 0x0008;;
	xr4 = fext r0 by r9;;//D3
	xr0 = [j31+_can_mingling+2];;
	xr5 = 0;;
	xr9 = 0x1808;;
	xr5 = fext r0 by r9;;//D4
	xr6 = 0;;
	xr9 = 0x1008;;
	xr6 = fext r0 by r9;;//D5
	xr7 = 0;;
	xr9 = 0x0808;;
	xr7 = fext r0 by r9;;//D6
	xr8 = 0;;
	xr9 = 0x0008;;
	xr8 = fext r0 by r9;;//D7

	xr18 = 0x30;;
	xcomp(r3,r18);;//判断检测命令
.align_code 4;
	if nxaeq,jump _qitan_can;;
	xr0 = [j31+_can_mingling+1];;
	xr11 = 0;;
	xr9 = 0x0404;;
	xr11 = fext r0 by r9;;//ID_NUM
	xr12 = 0;;
	xr9 = 0x0004;;
		
	xr21 = 0;;
	xr18 = ID_NUM;;
//	xr18 = [j31 + ID_num + 0];;
	xcomp(r11,r18);;
.align_code 4;
	if xaeq;do,[j31+_JianCe_Flag+0] = xr12;;
.align_code 4;
	if nxaeq;do,[j31+_JianCe_Flag+0] = xr21;;

	
//识别can命令
_qitan_can:
	xr0 = [j31+_can_mingling+2];;
	xr8 = 0;;
	xr9 = 0x0004;;
	xr8 = fext r0 by r9;;//D7低
	xr7 = 0;;
	xr9 = 0x0404;;
	xr7 = fext r0 by r9;;//D7高
	xr6 = 0;;
	xr9 = 0x0804;;
	xr6 = fext r0 by r9;;//D6低
	xr5 = 0;;
	xr9 = 0x0c04;;
	xr5 = fext r0 by r9;;//D6高
	xr4 = 0;;
	xr9 = 0x1004;;
	xr4 = fext r0 by r9;;//D5低
	xr3 = 0;;
	xr9 = 0x1404;;
	xr3 = fext r0 by r9;;//D5高
	xr2 = 0;;
	xr9 = 0x1804;;
	xr2 = fext r0 by r9;;//D4低
	xr1 = 0;;
	xr9 = 0x1c04;;
	xr1 = fext r0 by r9;;//D4高

	xr15 = [j31+_can_mingling+1];;
	xr16 = 0xf000;;
	xr17 = r15 and r16;;
	xcomp(r16,r17);;
.align_code 4;
	if xaeq,jump _can_changmingling;;
	
	xr15 = [j31+_can_mingling+1];;
	xr16 = 0x0401aaaa;;
	xcomp(r15,r16);;
.align_code 4;
	if xaeq,jump _can_kuaijiemingling;;
	
	xr15 = [j31+_can_mingling+1];;
	xr16 = 0xffff;;
	xr17 = r15 and r16;;
_can_1:
	xr18 = 0x1;;//_ChuLi_Flag
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_ChuLi_Flag+0] = xr8;;
	xcomp(r17,r18);;
.align_code 4;
	if nxaeq,jump _can_2;;
	
	xr10 = [j31+_ChuLi_Flag+0];;
	xr9 = 0x1008;;
	xr26 = fext r0 by r9;;//D5
	xr18 = 0x2;;
	xcomp(r10,r18);;//ASLC模式
.align_code 4;
	if xaeq;do,[j31+_aslc_caiyangweizhi+0] = xr26;;
	xr9 = 0x0808;;
	xr27 = fext r0 by r9;;//D6
	xcomp(r10,r18);;//ASLC模式
.align_code 4;
	if xaeq;do,[j31+_aslc_shuchu+0] = xr27;;
	
_can_2:
	xr18 = 0x2;;//_CFAR_Flag
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_CFAR_Flag+0] = xr8;;
_can_3:
	xr18 = 0x3;;//_zijian_kongzhi
	xcomp(r17,r18);;
.align_code 4;
	if xaeq,jump _can_zijian_kongzhi;;
_can_5:
	xr18 = 0x5;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+0] = xr0;;
	xr18 = 0x6;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+1] = xr0;;
	xr18 = 0x7;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+2] = xr0;;
	xr18 = 0x8;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+3] = xr0;;
	xr18 = 0x9;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+4] = xr0;;
	xr18 = 0xa;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+5] = xr0;;
_can_b:
	xr18 = 0xb;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j31+_leida_zhuanshu+0] = xr8;;
_can_c:
	xr18 = 0xc;;
	xcomp(r17,r18);;
.align_code 4;
	if nxaeq,jump _can_c_end;;
	[j31+_pinlvjiebian_flag+0] = xr6;;
	xr28 = 0;;
	xr29 = 0x0008;;
	xr28 = fext r0 by r29;;//D7
	[j31+_pinlvjiebian_flag+1] = xr28;;
_can_c_end:	

.align_code 4;
	jump _can_out;;
	
_can_changmingling:

	j3 = [j31+_can_mingling+3];;
	xr15 = [j31+_can_mingling+1];;
	xr16 = 0x0fffffff;;
	xr17 = r15 and r16;;
	xr18 = 0x3;;
	xcomp(r17,r18);;
.align_code 4;
	if xaeq;do,[j3+=1] = xr5;;
.align_code 4;
	if xaeq;do,[j3+=1] = xr6;;
.align_code 4;
	if xaeq;do,[j3+=1] = xr7;;
.align_code 4;
	if xaeq;do,[j3+=1] = xr8;;
.align_code 4;
	if xaeq;do,[j31+_can_mingling+3] = j3;;
.align_code 4;
	jump _can_out;;
	
_can_kuaijiemingling:
	xr15 = [j31+_can_mingling+2];;
	xr16 = 0x1;;
	xr20 = 0;;
	xcomp(r15,r16);;
.align_code 4;
	if xaeq;do,[j31+_ChuLi_Flag+0] = xr20;;
	xr16 = 0x2;;
	xr20 = 0;;
	xr21 = 1;;
	xcomp(r15,r16);;
.align_code 4;
	if xaeq;do,[j31+_ChuLi_Flag+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_CFAR_Flag+0] = xr20;;
.align_code 4;
	if xaeq;do,[j31+_pinlvjiebian_flag+0] = xr20;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+0] = xr20;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+2] = xr20;;
	xr16 = 0x3;;
	xr20 = 0;;
	xr21 = 1;;
	xr22 = 2;;
	xr23 = 3;;
	xr24 = 4;;
	xr25 = 5;;
	xr26 = 6;;
	xcomp(r15,r16);;
.align_code 4;
	if xaeq;do,[j31+_ChuLi_Flag+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_CFAR_Flag+0] = xr20;;
.align_code 4;
	if xaeq;do,[j31+_pinlvjiebian_flag+0] = xr20;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+1] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+2] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+3] = xr22;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+4] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+5] = xr23;;
	xr21 = 1;;
	xr22 = 2;;
	xr23 = 3;;
	xr24 = 4;;
	xr25 = 5;;
	xr26 = 6;;
	xr27 = 7;;
	xr28 = 0;;
	xcomp(r15,r16);;
.align_code 4;
	if xaeq;do,[j31+_ChuLi_Flag+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_CFAR_Flag+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_pinlvjiebian_flag+0] = xr28;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+0] = xr23;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+1] = xr22;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+2] = xr23;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+3] = xr23;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+4] = xr23;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+5] = xr24;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+6] = xr23;;
	xr20 = 1;;
	xr24 = 4;;
	xr21 = 1.0;;
	xr22 = 1.0;;
	xr23 = 1.0;;
	xr25 = 1.0;;
	xr26 = 1.0;;
	xr27 = 1.0;;
	xr28 = 0;;
	xcomp(r15,r16);;
.align_code 4;
	if xaeq;do,[j31+_ChuLi_Flag+0] = xr20;;
.align_code 4;
	if xaeq;do,[j31+_pinlvjiebian_flag+0] = xr28;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+0] = xr24;;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+2] = xr24;;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+1] = xr22;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+4] = xr24;;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+2] = xr23;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+6] = xr24;;
.align_code 4;
	if xaeq;do,[j31+_dmb_fuduxishu+3] = xr25;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+8] = xr24;;
	xr20 = 0;;
	xr21 = 1;;
	xr22 = 2;;
	xr23 = 3;;
	xr24 = 4;;
	xr25 = 5;;
	xr26 = 6;;
	xr27 = 24;;
	xcomp(r15,r16);;
.align_code 4;
	if xaeq;do,[j31+_ChuLi_Flag+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_CFAR_Flag+0] = xr20;;
.align_code 4;
	if xaeq;do,[j31+_pinlvjiebian_flag+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_pinlvjiebian_flag+1] = xr27;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+0] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+1] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+2] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+3] = xr22;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+4] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+5] = xr23;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+6] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+7] = xr24;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+8] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+9] = xr25;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+10] = xr21;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+11] = xr26;;
	
.align_code 4;
	jump _can_out;;

	xcomp(r7,r15);;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+0] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+2] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+4] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+6] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+8] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+10] = xr7;;
	xcomp(r6,r15);;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+0] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+1] = xr8;;
	xcomp(r6,r15);;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+2] = xr7;;
	xcomp(r6,r15);;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+6] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+7] = xr8;;
	xcomp(r6,r15);;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+8] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+9] = xr8;;
	xcomp(r6,r15);;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+10] = xr7;;
.align_code 4;
	if xaeq;do,[j31+_zijian_kongzhi+11] = xr8;;
.align_code 4;
	jump _can_5;;
		
_can_out:
	xr0 = [j31+_can_stack+0];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;
					
_can.end:   
