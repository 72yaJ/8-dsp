
/*----------------------------------------------------------------------
	文件名：	jiance_FPGA.asm
	作  者：	王喆
	版本号：	V1.0
	创建时间：	2014年2月5日
	软件环境：	Windows XP/DSP Visual
	描  述：	通过示波器显示检测图像
----------------------------------------------------------------------*/
/*----------------------------------------------------------------------
	版本号：
	修改人：
	修改时间：
	修改内容：
----------------------------------------------------------------------*/
#include "defts201.h"
#include "UserDef.h"

.global _jiance_FPGA;
.extern _JianCe_Flag;
.extern _CFAR_Flag;
.extern _ChuLi_Flag;
.extern _Inter_Num;
.extern _jiance_data1;
.extern _jiance_data2;
.extern _jiance_stack;

.section program;
//------------------判断是否进入检测模式，即给FPGA传输数据-----------------------------------
_jiance_FPGA:
	
_jiance0:

	[j31 + _jiance_stack + 0] = cjmp;;

//	xr0 = [j31+_JianCe_Flag+0];;
//	xr1 = 0;;
//	xcomp(r0,r1);;
//.align_code 4;
//	if xaeq,jump _wait;;
  	
	j7 = _jiance_data2;;//发送检测的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j7 = _jiance_data1;;	
	
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 1;;
	xcomp(r0,r1);;
.align_code 4;
  	if xaeq;do,j5 = j6;;//处理数据首地址
  	
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 2;;
	xcomp(r0,r1);;
.align_code 4;
// 	if xaeq;do,j5 = j6 + 8040;;//处理数据首地址
  	if xaeq;do,j5 = j6 + LengthBoshu;;//处理数据首地址
  	
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 3;;
	xcomp(r0,r1);;
.align_code 4;
// 	if xaeq;do,j5 = j6 + 16080;;//处理数据首地址
  	if xaeq;do,j5 = j6 + LengthBoshu*2;;//处理数据首地址
  	
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 4;;
	xcomp(r0,r1);;
.align_code 4;
// 	if xaeq;do,j5 = j6 + 24120;;//处理数据首地址
  	if xaeq;do,j5 = j6 + LengthBoshu*3;;//处理数据首地址

#if ID_NUM == 4 || ID_NUM == 6	
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 5;;
	xcomp(r0,r1);;
.align_code 4;
  	if xaeq;do,j5 = j6 + LengthBoshu*4;;//处理数据首地址
		
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 6;;
	xcomp(r0,r1);;
.align_code 4;
  	if xaeq;do,j5 = j6 + LengthBoshu*5;;//处理数据首地址
#endif	

  	j8 = j7;;//发送数据首地址
  	
	lc0 = xr1;;
	r2 = 2047.0;;//
	xr0 = [j31+_CFAR_Flag+0];;
	xr1 = 1;;
	xcomp(r0,r1);;
.align_code 4;
	if xaeq;do,r2 = 7.0;;//CFAR时AD放大倍数
	xr0 = [j31+_ChuLi_Flag+0];;
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
	if xaeq;do,r2 = 2047.0;;//传输时AD放大倍数
	r3 = 0xffff0000;;
_jiance0_fix:
	r5:4 = q[j5+=4];;
	fr6 = r4 * r2;;
	fr7 = r5 * r2;;
	r8 = fix fr6;;
	r9 = fix fr7;;
	r10 = lshift r8 by 16;;
	r9 += mask r10 by r3;;
	l[j8+=2] = r9;;
.align_code 4;
  	if nlc0e,jump _jiance0_fix;;
  	
  	xr31 = [j31 + _jiance_stack + 0];;
	cjmp = xr31;;
.align_code 4;
	cjmp(np)(abs);;	
	

_jiance_FPGA.end: