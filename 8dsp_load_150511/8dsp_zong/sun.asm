#include "defts201.h"
#include "UserDef.h"

.extern _ZiJianStack;
.global _MTI_MTD_Data1;
.global _MTI_MTD_Data2;
.global _MTI_MTD_Data3;
.global _MTI_MTD_Data4;
.global _MTI_MTD_Data5;
.global _MTI_MTD_Data6;
.extern _sin;
.extern _DATA;
.extern _ZhenShu;
.extern _PriFlag;
.extern _zijian_kongzhi;
.extern _ReData1_buffer1;
.extern _ReData1_buffer2;
.extern _Inter_Num;

.section program;

_MTI_MTD_Data1:
	[j31+_ZiJianStack+0] = cjmp;;
//产生相位
	xr0 = [j31+_ZhenShu+0];;// w (angular frequency &circular frequency)
	xr2 = ChangDu;;//frequency resolving(2*pi/ChangDu)
	xr7 = MTDxishu;;//2*pi/ChangDu
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3	
	xr1 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r1 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j14 = _ReData1_buffer1;;
	xr1 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r1 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
#endif	
	xr3 = lshift r2 by -2;;//(pi/2)
	lc0 = xr2;;
	j2 = _DATA;;//产生相位地址
	xr1 = 0;;//t (initial time)
///*	
	xr9 = [j31+_zijian_kongzhi+0];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
.align_code 4;
	if xaeq;do,j2 = j5;;
	xr9 = [j31+_zijian_kongzhi+0];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
.align_code 4;
	if xale,jump loop_2p_1;;
	
	xr9 = [j31+_zijian_kongzhi+0];;//控制输出距离单元点频
	xr10 = 3;;
	xcomp(r9,r10);;
.align_code 4;
	if xaeq;do, xr1 = [j31+_zijian_kongzhi+1];;//t //距离单元点频频率

loop_1p_1:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_1p_1; l[j2+=2] = xr5:4;;
.align_code 4;
	jump loop_1p_1out;;
//*/	
loop_2p_1:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xr1 = inc r1;;//t
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_2p_1; l[j2+=2] = xr5:4;;
///*	
loop_1p_1out:	
	xr9 = [j31+_zijian_kongzhi+0];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq,jump _MTD_out1;;
//*/
//time+1	
	xr0 = inc r0;;/////////////////////////////////////
	xr9 = [j31+_zijian_kongzhi+0];;//控制输出点频或者MTD自检信号
	xr10 = 1;;
	xcomp(r9,r10);;
	if xaeq;do,xr0 = [j31+_zijian_kongzhi+1];;
	
	xr1 = ChangDu;;
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3	//宽波束
	xr7 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r7 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
#endif	
	xcomp(r1,r0);;
	if xale;do,xr0 = r0 - r1;;
	[j31+_ZhenShu+0] = xr0;;
//计算sin值	
	j3 = _DATA;;//->输入数据首地址
//	j5 = _mtd_self_test_data;;//->输出数据首地址
	xr31 = r1 + r1;;//->输入数据个数，需是4的倍数
.align_code 4;
	call _sin;;
_MTD_out1:	
	xr0 = [j31+_ZiJianStack+0];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
_MTI_MTD_Data1.end:

_MTI_MTD_Data2:
	[j31+_ZiJianStack+1] = cjmp;;
//产生相位
	xr0 = [j31+_ZhenShu+1];;// w (angular frequency &circular frequency)
	xr2 = ChangDu;;//frequency resolving(2*pi/ChangDu)
	xr7 = MTDxishu;;//2*pi/ChangDu 
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3	
	j14 = _ReData1_buffer2;;//处理接收到的数据首地址
	xr1 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r1 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j14 = _ReData1_buffer1;;
	xr1 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r1 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
#endif
	xr3 = lshift r2 by -2;;//(pi/2)
	lc0 = xr2;;
	j2 = _DATA;;//产生相位地址
	xr1 = 0;;//t (initial time)
	
	xr9 = [j31+_zijian_kongzhi+2];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq;do,j2 = j5;;
	xr9 = [j31+_zijian_kongzhi+2];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xale,jump loop_2p_2;;
	
	xr9 = [j31+_zijian_kongzhi+2];;//控制输出距离单元点频
	xr10 = 3;;
	xcomp(r9,r10);;
	if xaeq;do, xr1 = [j31+_zijian_kongzhi+3];;//t //距离单元点频频率

loop_1p_2:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_1p_2; l[j2+=2] = xr5:4;;
.align_code 4;
	jump loop_1p_2out;;
	
loop_2p_2:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xr1 = inc r1;;//t
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_2p_2; l[j2+=2] = xr5:4;;
	
loop_1p_2out:	
	xr9 = [j31+_zijian_kongzhi+2];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq,jump _MTD_out2;;
//time+1	
	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
	xr9 = [j31+_zijian_kongzhi+2];;//控制输出点频或者MTD自检信号
	xr10 = 1;;
	xcomp(r9,r10);;
	if xaeq;do,xr0 = [j31+_zijian_kongzhi+3];;

	xr1 = ChangDu;;
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3
	xr7 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r7 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
#endif	
	xcomp(r1,r0);;
	if xale;do,xr0 = r0 - r1;;
	[j31+_ZhenShu+1] = xr0;;
//计算sin值	
	j3 = _DATA;;//->输入数据首地址
//	j5 = _mtd_self_test_data;;//->输出数据首地址
	xr31 = r1 + r1;;//->输入数据个数，需是4的倍数
.align_code 4;
	call _sin;;
_MTD_out2:	
	xr0 = [j31+_ZiJianStack+1];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
_MTI_MTD_Data2.end:

_MTI_MTD_Data3:
	[j31+_ZiJianStack+2] = cjmp;;
//产生相位
	xr0 = [j31+_ZhenShu+2];;// w (angular frequency &circular frequency)
	xr2 = ChangDu;;//frequency resolving(2*pi/ChangDu)
	xr7 = MTDxishu;;//2*pi/ChangDu 
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3
	j14 = _ReData1_buffer2;;//处理接收到的数据首地址
	xr1 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r1 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j14 = _ReData1_buffer1;;
	xr1 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r1 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
#endif	
	xr3 = lshift r2 by -2;;//(pi/2)
	lc0 = xr2;;
	j2 = _DATA;;//产生相位地址
	xr1 = 0;;//t (initial time)
	
	xr9 = [j31+_zijian_kongzhi+4];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq;do,j2 = j5;;
	xr9 = [j31+_zijian_kongzhi+4];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xale,jump loop_2p_3;;
	
	xr9 = [j31+_zijian_kongzhi+4];;//控制输出距离单元点频
	xr10 = 3;;
	xcomp(r9,r10);;
	if xaeq;do, xr1 = [j31+_zijian_kongzhi+5];;//t //距离单元点频频率

loop_1p_3:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_1p_3; l[j2+=2] = xr5:4;;
.align_code 4;
	jump loop_1p_3out;;
	
loop_2p_3:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xr1 = inc r1;;//t
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_2p_3; l[j2+=2] = xr5:4;;
	
loop_1p_3out:	
	xr9 = [j31+_zijian_kongzhi+4];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq,jump _MTD_out3;;
//time+1	
	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
	xr9 = [j31+_zijian_kongzhi+4];;//控制输出点频或者MTD自检信号
	xr10 = 1;;
	xcomp(r9,r10);;
	if xaeq;do,xr0 = [j31+_zijian_kongzhi+5];;

	xr1 = ChangDu;;
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3
	xr7 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r7 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
#endif	
	xcomp(r1,r0);;
	if xale;do,xr0 = r0 - r1;;
	[j31+_ZhenShu+2] = xr0;;
//计算sin值	
	j3 = _DATA;;//->输入数据首地址
//	j5 = _mtd_self_test_data;;//->输出数据首地址
	xr31 = r1 + r1;;//->输入数据个数，需是4的倍数
.align_code 4;
	call _sin;;
_MTD_out3:	
	xr0 = [j31+_ZiJianStack+2];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
_MTI_MTD_Data3.end:

_MTI_MTD_Data4:
	[j31+_ZiJianStack+3] = cjmp;;
//产生相位
	xr0 = [j31+_ZhenShu+3];;// w (angular frequency &circular frequency)
	xr2 = ChangDu;;//frequency resolving(2*pi/ChangDu)
	xr3 = lshift r2 by -2;;//(pi/2)
	xr7 = MTDxishu;;//2*pi/ChangDu 
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3
	j14 = _ReData1_buffer2;;//处理接收到的数据首地址
	xr1 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r1 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j14 = _ReData1_buffer1;;
	xr1 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r1 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr7 = MTDxishu_xiao;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr2 = 1600;;
#endif	
	lc0 = xr2;;
	j2 = _DATA;;//产生相位地址
	xr1 = 0;;//t (initial time)
	
	xr9 = [j31+_zijian_kongzhi+6];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq;do,j2 = j5;;
	xr9 = [j31+_zijian_kongzhi+6];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xale,jump loop_2p_4;;
	
	xr9 = [j31+_zijian_kongzhi+6];;//控制输出距离单元点频
	xr10 = 3;;
	xcomp(r9,r10);;
	if xaeq;do, xr1 = [j31+_zijian_kongzhi+7];;//t //距离单元点频频率

loop_1p_4:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_1p_4; l[j2+=2] = xr5:4;;
.align_code 4;
	jump loop_1p_4out;;
	
loop_2p_4:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xr1 = inc r1;;//t
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_2p_4; l[j2+=2] = xr5:4;;
	
loop_1p_4out:	
	xr9 = [j31+_zijian_kongzhi+6];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq,jump _MTD_out4;;
//time+1	
	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
	xr9 = [j31+_zijian_kongzhi+6];;//控制输出点频或者MTD自检信号
	xr10 = 1;;
	xcomp(r9,r10);;
	if xaeq;do,xr0 = [j31+_zijian_kongzhi+7];;

	xr1 = ChangDu;;
#if ID_NUM == 0 || ID_NUM == 1 || ID_NUM == 2 || ID_NUM == 3
	xr7 = [j14 + 4];;
	xr5 = 0x1007;;
	xr6 = fext r7 by r5;;
	xr10 = 12;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,xr1 = 1600;;
#endif	
	xcomp(r1,r0);;
	if xale;do,xr0 = r0 - r1;;
	[j31+_ZhenShu+3] = xr0;;
//计算sin值	
	j3 = _DATA;;//->输入数据首地址
//	j5 = _mtd_self_test_data;;//->输出数据首地址
	xr31 = r1 + r1;;//->输入数据个数，需是4的倍数
.align_code 4;
	call _sin;;
_MTD_out4:	
	xr0 = [j31+_ZiJianStack+3];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
_MTI_MTD_Data4.end:

_MTI_MTD_Data5:
	[j31+_ZiJianStack+4] = cjmp;;
//产生相位
	xr0 = [j31+_ZhenShu+4];;// w (angular frequency &circular frequency)
	xr2 = ChangDu;;//frequency resolving(2*pi/ChangDu)
	xr3 = lshift r2 by -2;;//(pi/2)
	xr7 = MTDxishu;;//2*pi/ChangDu 
	lc0 = xr2;;
	j2 = _DATA;;//产生相位地址
	xr1 = 0;;//t (initial time)
	
	xr9 = [j31+_zijian_kongzhi+8];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq;do,j2 = j5;;
	xr9 = [j31+_zijian_kongzhi+8];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xale,jump loop_2p_5;;
	
	xr9 = [j31+_zijian_kongzhi+8];;//控制输出距离单元点频
	xr10 = 3;;
	xcomp(r9,r10);;
	if xaeq;do, xr1 = [j31+_zijian_kongzhi+9];;//t //距离单元点频频率

loop_1p_5:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_1p_5; l[j2+=2] = xr5:4;;
.align_code 4;
	jump loop_1p_5out;;
	
loop_2p_5:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xr1 = inc r1;;//t
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_2p_5; l[j2+=2] = xr5:4;;
	
loop_1p_5out:	
	xr9 = [j31+_zijian_kongzhi+8];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq,jump _MTD_out5;;
//time+1	
	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
	xr9 = [j31+_zijian_kongzhi+8];;//控制输出点频或者MTD自检信号
	xr10 = 1;;
	xcomp(r9,r10);;
	if xaeq;do,xr0 = [j31+_zijian_kongzhi+9];;

	xr1 = ChangDu;;
	xcomp(r1,r0);;
	if xale;do,xr0 = r0 - r1;;
	[j31+_ZhenShu+4] = xr0;;
//计算sin值	
	j3 = _DATA;;//->输入数据首地址
//	j5 = _mtd_self_test_data;;//->输出数据首地址
	xr31 = ChangDu*2;;//->输入数据个数，需是4的倍数
.align_code 4;
	call _sin;;
_MTD_out5:	
	xr0 = [j31+_ZiJianStack+4];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
_MTI_MTD_Data5.end:

_MTI_MTD_Data6:
	[j31+_ZiJianStack+5] = cjmp;;
//产生相位
	xr0 = [j31+_ZhenShu+5];;// w (angular frequency &circular frequency)
	xr2 = ChangDu;;//frequency resolving(2*pi/ChangDu)
	xr3 = lshift r2 by -2;;//(pi/2)
	xr7 = MTDxishu;;//2*pi/ChangDu 
	lc0 = xr2;;
	j2 = _DATA;;//产生相位地址
	xr1 = 0;;//t (initial time)
	
	xr9 = [j31+_zijian_kongzhi+10];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq;do,j2 = j5;;
	xr9 = [j31+_zijian_kongzhi+10];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xale,jump loop_2p_6;;
	
	xr9 = [j31+_zijian_kongzhi+10];;//控制输出距离单元点频
	xr10 = 3;;
	xcomp(r9,r10);;
	if xaeq;do, xr1 = [j31+_zijian_kongzhi+11];;//t //距离单元点频频率

loop_1p_6:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_1p_6; l[j2+=2] = xr5:4;;
.align_code 4;
	jump loop_1p_6out;;
	
loop_2p_6:
	xr5 = r0 * r1(i);;//x
	xr4 = r5 + r3;;//x+pi/2
	xr1 = inc r1;;//t
	xfr4 = float r4;;
	xfr5 = float r5;;
	xfr4 = r4 * r7;;
	xfr5 = r5 * r7;;
.align_code 4;
	if nlc0e,jump loop_2p_6; l[j2+=2] = xr5:4;;
	
loop_1p_6out:	
	xr9 = [j31+_zijian_kongzhi+10];;//控制输出斜线
	xr10 = 2;;
	xcomp(r9,r10);;
	if xaeq,jump _MTD_out6;;
//time+1	
	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
//	xr0 = inc r0;;/////////////////////////////////////
	xr9 = [j31+_zijian_kongzhi+10];;//控制输出点频或者MTD自检信号
	xr10 = 1;;
	xcomp(r9,r10);;
	if xaeq;do,xr0 = [j31+_zijian_kongzhi+11];;

	xr1 = ChangDu;;
	xcomp(r1,r0);;
	if xale;do,xr0 = r0 - r1;;
	[j31+_ZhenShu+5] = xr0;;
//计算sin值	
	j3 = _DATA;;//->输入数据首地址
//	j5 = _mtd_self_test_data;;//->输出数据首地址
	xr31 = ChangDu*2;;//->输入数据个数，需是4的倍数
.align_code 4;
	call _sin;;
_MTD_out6:	
	xr0 = [j31+_ZiJianStack+5];;
	cjmp = xr0;; 
.align_code 4;
	cjmp(np)(abs);;	
_MTI_MTD_Data6.end:
