/*****************************************************************************

时间：
作者：
说明: 
 *****************************************************************************/

#include "defts201.h"
#include "cache_macros.h"
#include "UserDef.h"

//调用的子函数
.extern _MTI_MTD_Data;
.extern _gene_sim_data;
.extern _ASLC;
.extern _initial_dsp;
.extern _wait_pri;
.extern _PRI_int;
.extern _dong_mu_biao1;
.extern _dong_mu_biao2;
.extern _dong_mu_biao3;
.extern _can;
//调用的存储空间
.extern _MTI_MTD_Data1;
.extern _MTI_MTD_Data2;
.extern _MTI_MTD_Data3;
.extern _MTI_MTD_Data4;
.extern _MTI_MTD_Data5;
.extern _MTI_MTD_Data6;
.extern _ChuLi_Flag;
.extern _CFAR_Flag;
.extern _JianCe_Flag;
.extern _CFAR_baoluo;
.extern _Inter_Num;
.extern _jiance_data1;
.extern _jiance_data2;
.extern _zhentou;
.extern _zijian_kongzhi;
.extern _jiance_FPGA;
.extern _led;
.extern _add_zhentou;
.extern _pinlvjiebian_flag;
.extern _pinlvjiebian_stack;
.extern _jiebian_zijian;

.global _main_asm;
//.global _main_asm_end;


.section program;
.align_code 4;



_main_asm:

///* 
//=================调试用，模拟自检标志位============================//
	xr0 = 2;;						//手动选择生成方式:0:传输模式；1：自检模式；2：ASLC模式
	[j31+_ChuLi_Flag+0] = xr0;;
	xr0 = 0;;						//手动选择通道1自检波形:0 自检MTD；1 本帧数据点频；2 斜线；3 距离单元点频；4 动目标检测
	[j31+_zijian_kongzhi+0] = xr0;;
//=================调试用，模拟CFAR包络标志位============================//
	xr0 = 0;;						//手动选择CFAR自检方式:0:无CFAR自检包络；1：有CFAR自检包络
	[j31+_CFAR_Flag] = xr0;;
//=================调试用，模拟检测标志位============================//
	xr0 = 0;;						//选择检测模式:0:不检测模式；1：检测模式
	[j31+_JianCe_Flag] = xr0;;
//*/

.align_code 4;
  	call _initial_dsp;;

_wait:

.align_code 4;
  	call _wait_pri;;

#if TestJianceDebug == 1
.align_code 4;
 	jump _wait;;
#endif	
 	
.align_code 4;
  	call _can;;
//------------------信号处理-----------------------------------------------------------		
	xr0 = [j31+_ChuLi_Flag];;
 	xr1 = 0;;//检验传输模式标志位
	xcomp(r0,r1);;
.align_code 4;
 	if xaeq,jump _pass0;;
	xr2 = 1;;//检验自检模式标志位
	xcomp(r0,r2);;
.align_code 4;
  	if xaeq,jump _pass1;;
  	xr3 = 2;;//检验ASLC模式标志位
	xcomp(r0,r3);;
.align_code 4;
  	if xaeq,jump _pass2;;
  	
_pass0://传输模式
	j4 = _ReData1_buffer2;;//处理接收到的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j4 = _ReData1_buffer1;;
#if ID_NUM == 0 || ID_NUM == 2
	j4 = j4 + LengthBoshu*2;;
#endif	
#if ID_NUM == 5 || ID_NUM == 7
	j4 = j4 + LengthBoshu*3;;
#endif	

	j6 = _TrData1_buffer2;;//发送处理后的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j6 = _TrData1_buffer1;;	
	
#if ID_NUM == 1 || ID_NUM == 3 || ID_NUM == 2 || ID_NUM == 0
	xr0 = LengthBoshu*2;;
#endif	
#if ID_NUM == 4 || ID_NUM == 6 || ID_NUM == 5 || ID_NUM == 7
	xr0 = LengthBoshu*3;;
#endif	
	xr1 = lshift r0 by -2;;
	lc0 = xr1;;
	j5 = j6;;
_chuanshu_loop:
	r1:0 = q[j4+=4];;
	q[j5+=4] = r1:0;;
.align_code 4;
  	if nlc0e,jump _chuanshu_loop;;
 	
#if ID_NUM == 2 || ID_NUM == 7
	xr0 = [j31+_ChuLi_Flag+1];;
  	xr4 = 0;;//检验标志位
	xcomp(r0,r4);;
.align_code 4;
  	if nxaeq,jump _pass3;;
#endif	

	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
  	if nxaeq,call _jiance_FPGA(np)(abs);;	
.align_code 4;
	jump  _wait;;
  	
_pass1://自检模式
	j6 = _TrData1_buffer2;;//发送处理后的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j6 = _TrData1_buffer1;;	

//在缓存区生成自检数据
#if ID_NUM == 1 || ID_NUM == 3//
_kuantongdao1:
	xr0 = [j31+_zijian_kongzhi+0];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _kuanMTD_rukou1;;
	j4 = 40;;
	j3 = j6;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao1(np)(abs);;
.align_code 4;
	jump _kuantongdao2;;
_kuanMTD_rukou1:
	j4 = 40;;
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
	if xaeq;do,j4 = 440;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,j4 = 440;;
	j3 = j6;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data1(np)(abs);;
	
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
	if xaeq,jump _MTDzijian1_xiao;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq,jump _MTDzijian1_xiao;;
.align_code 4;
	jump _kuantongdao2;;
_MTDzijian1_xiao:
 	j4 = 4440;;
	j3 = j6;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data1(np)(abs);;
	
_kuantongdao2:
	xr0 = [j31+_zijian_kongzhi+2];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _kuanMTD_rukou2;;
	j4 = 40;;
	j3 = j6 + LengthBoshu;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao2(np)(abs);;
.align_code 4;
	jump _kuanCFAR_rukou13;;
_kuanMTD_rukou2:
	j4 = 40;;
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
	if xaeq;do,j4 = 440;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,j4 = 440;;	
	j3 = j6 + LengthBoshu;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data2(np)(abs);;
	
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
	if xaeq,jump _MTDzijian2_xiao;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq,jump _MTDzijian2_xiao;;
.align_code 4;
	jump _kuanCFAR_rukou13;;
_MTDzijian2_xiao:
	j4 = 4440;;
	j3 = j6 + LengthBoshu;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data2(np)(abs);;
	
//加上CFAR自检包络
_kuanCFAR_rukou13:	
	xr0 = [j31+_CFAR_Flag];;
 	xr1 = 1;;//判断是否加CFAR自检包络：0 不加；1 加
	xcomp(r0,r1);;
.align_code 4;
 	if xaeq,call _kuanCFAR(np)(abs);;
#endif	

#if ID_NUM == 2 || ID_NUM == 0//宽波束从片
_kuantongdao3:
	xr0 = [j31+_zijian_kongzhi+4];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _kuanMTD_rukou3;;
	j4 = 40;;
	j3 = j6;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao3(np)(abs);;
.align_code 4;
	jump _kuantongdao4;;
_kuanMTD_rukou3:
	j4 = 40;;
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
	if xaeq;do,j4 = 440;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,j4 = 440;;
	j3 = j6;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data3(np)(abs);;
	
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
	if xaeq,jump _MTDzijian3_xiao;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq,jump _MTDzijian3_xiao;;
.align_code 4;
	jump _kuantongdao4;;
_MTDzijian3_xiao:
 	j4 = 4440;;
	j3 = j6;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data3(np)(abs);;

_kuantongdao4:
	xr0 = [j31+_zijian_kongzhi+6];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _kuanMTD_rukou4;;
	j4 = 40;;
	j3 = j6 + LengthBoshu;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao4(np)(abs);;
.align_code 4;
	jump _kuanCFAR_rukou20;;
_kuanMTD_rukou4:
	j4 = 40;;
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
	if xaeq;do,j4 = 440;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq;do,j4 = 440;;
	j3 = j6 + LengthBoshu;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data4(np)(abs);;
	
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
	if xaeq,jump _MTDzijian4_xiao;;
	xr10 = 13;;
	xcomp(r10,r6);;
.align_code 4;
	if xaeq,jump _MTDzijian4_xiao;;
.align_code 4;
	jump _kuanCFAR_rukou20;;
_MTDzijian4_xiao:
	j4 = 4440;;
	j3 = j6 + LengthBoshu;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data4(np)(abs);;
	
//加上CFAR自检包络
_kuanCFAR_rukou20:	
	xr0 = [j31+_CFAR_Flag];;
 	xr1 = 1;;//判断是否加CFAR自检包络：0 不加；1 加
	xcomp(r0,r1);;
.align_code 4;
 	if xaeq,call _kuanCFAR(np)(abs);;
#endif	
	
	
#if ID_NUM == 4 || ID_NUM == 6//窄波束主片
_zhaitongdao1:
	xr0 = [j31+_zijian_kongzhi+0];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _zhaiMTD_rukou1;;
	j4 = 40;;
	j3 = j6;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao1(np)(abs);;
	j10 = j6 + 2440;;
.align_code 4;
	call _dong_mu_biao1(np)(abs);;
.align_code 4;
	jump _zhaitongdao2;;
_zhaiMTD_rukou1:
	j4 = 40;;
	j3 = j6;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data1(np)(abs);;
.align_code 4;
	call _MTI_MTD_Data1(np)(abs);;
	
_zhaitongdao2:
	xr0 = [j31+_zijian_kongzhi+2];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _zhaiMTD_rukou2;;
	j4 = 40;;
	j3 = j6 + LengthBoshu;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao2(np)(abs);;
	j3 = j6 + 2440;;
	j10 = j3 + LengthBoshu;;
.align_code 4;
	call _dong_mu_biao2(np)(abs);;
.align_code 4;
	jump _zhaitongdao3;;
_zhaiMTD_rukou2:
	j4 = 40;;
	j3 = j6 + LengthBoshu;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data2(np)(abs);;
.align_code 4;
	call _MTI_MTD_Data2(np)(abs);;
	
_zhaitongdao3:
	xr0 = [j31+_zijian_kongzhi+4];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _zhaiMTD_rukou3;;
	j4 = 40;;
	j3 = j6 + LengthBoshu*2;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao3(np)(abs);;
	j3 = j6 + 2440;;
	j10 = j3 + LengthBoshu*2;;
.align_code 4;
	call _dong_mu_biao3(np)(abs);;
.align_code 4;
	jump _zhaiCFAR_rukou46;;
_zhaiMTD_rukou3:
	j4 = 40;;
	j3 = j6 + LengthBoshu*2;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data3(np)(abs);;
.align_code 4;
	call _MTI_MTD_Data3(np)(abs);;

//加上CFAR自检包络
_zhaiCFAR_rukou46:	
	xr0 = [j31+_CFAR_Flag];;
 	xr1 = 1;;//判断是否加CFAR自检包络：0 不加；1 加
	xcomp(r0,r1);;
.align_code 4;
 	if xaeq,call _zhaiCFAR(np)(abs);;
#endif	

#if ID_NUM == 5 || ID_NUM == 7
_zhaitongdao4:
	xr0 = [j31+_zijian_kongzhi+6];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _zhaiMTD_rukou4;;
	j4 = 40;;
	j3 = j6;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao4(np)(abs);;
	j3 = j6 + 2440;;
	j10 = j3;;
.align_code 4;
	call _dong_mu_biao4(np)(abs);;
.align_code 4;
	jump _zhaitongdao5;;
_zhaiMTD_rukou4:
	j4 = 40;;
	j3 = j6;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data4(np)(abs);;
.align_code 4;
	call _MTI_MTD_Data4(np)(abs);;

_zhaitongdao5:
	xr0 = [j31+_zijian_kongzhi+8];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _zhaiMTD_rukou5;;
	j4 = 40;;
	j3 = j6 + LengthBoshu;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao5(np)(abs);;
	j3 = j6 + 2440;;
	j10 = j3 + LengthBoshu;;
.align_code 4;
	call _dong_mu_biao5(np)(abs);;
.align_code 4;
	jump _zhaitongdao6;;
_zhaiMTD_rukou5:
	j4 = 40;;
	j3 = j6 + LengthBoshu;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data5(np)(abs);;
.align_code 4;
	call _MTI_MTD_Data5(np)(abs);;

_zhaitongdao6:
	xr0 = [j31+_zijian_kongzhi+10];;
 	xr1 = 4;;//检验自检数据传输类型
	xcomp(r0,r1);;
.align_code 4;
 	if nxaeq,jump _zhaiMTD_rukou6;;
	j4 = 40;;
	j3 = j6 + LengthBoshu*2;;
	j10 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _dong_mu_biao6(np)(abs);;
	j3 = j6 + 2440;;
	j10 = j3 + LengthBoshu*2;;
.align_code 4;
	call _dong_mu_biao6(np)(abs);;
.align_code 4;
	jump _zhaiCFAR_rukou57;;
_zhaiMTD_rukou6:
	j4 = 40;;
	j3 = j6 + LengthBoshu*2;;
	j5 = j3 + j4;;//空40位模拟帧头
.align_code 4;
	call _MTI_MTD_Data6(np)(abs);;
.align_code 4;
	call _MTI_MTD_Data6(np)(abs);;
		
//加上CFAR自检包络
_zhaiCFAR_rukou57:	
	xr0 = [j31+_CFAR_Flag];;
 	xr1 = 1;;//判断是否加CFAR自检包络：0 不加；1 加
	xcomp(r0,r1);;
.align_code 4;
 	if xaeq,call _zhaiCFAR(np)(abs);;
 #endif	
	
_shuchufangda:
#if ID_NUM == 1 || ID_NUM == 3 || ID_NUM == 2 || ID_NUM == 0
	xr0 = LengthBoshu*2;;
#endif	
#if ID_NUM == 4 || ID_NUM == 6 || ID_NUM == 5 || ID_NUM == 7
	xr0 = LengthBoshu*3;;
#endif	
	xr1 = lshift r0 by -2;;
	lc0 = xr1;;
	r2 = 32768.0;;//放大倍数2^15
	j3 = j6;;
	j4 = j6;;
_zijian_fangda:
	r5:4 = q[j3+=4];;
	fr6 = r4 * r2;;
	fr7 = r5 * r2;;
	q[j4+=4] = r7:6;;
.align_code 4;
  	if nlc0e,jump _zijian_fangda;;
  	
	xr0 = [j31+_pinlvjiebian_flag+0];;//频率自检
	xr1 = 1;;
	xcomp(r0,r1);;
.align_code 4;
  	if xaeq,call _jiebian_zijian(abs);;
	
.align_code 4;
	call _add_zhentou(abs);;
  	
#if ID_NUM == 2 || ID_NUM == 7
	xr0 = [j31+_ChuLi_Flag+1];;
  	xr4 = 0;;//检验标志位
	xcomp(r0,r4);;
.align_code 4;
  	if nxaeq,jump _pass3;;
#endif	
	
#if ID_NUM == 1 || ID_NUM == 3 || ID_NUM == 4 || ID_NUM == 6//主片
//------------------判断是否进入检测模式，即给FPGA传输数据-----------------------------------
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
  	if nxaeq,call _jiance_FPGA(np)(abs);;
 #endif	
.align_code 4;
	jump _wait;;

_pass2://ASLC模式

	j14 = _ReData1_buffer2;;	//处理接收到的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j14 = _ReData1_buffer1;;

/*辅助通道实虚部调换
	j6 = j14 + 32808;;
_shixubutiaohuan:
	r1:0 = q[j4+=4];;
	r2 = r1;;
	r3 = r0;;
	q[j6+=4] = r3:2;;
.align_code 4;
	if nlc0e,jump _shixubutiaohuan;;
	
	j6 = j14 + 41000;;
	r1:0 = q[j4+=4];;
	r2 = r1;;
	r3 = r0;;
	q[j6+=4] = r3:2;;
.align_code 4;
	if nlc0e,jump _shixubutiaohuan;;
	
_shixubutiaohuan_3:
	r1:0 = q[j4+=4];;
	r2 = r1;;
	r3 = r0;;
	q[j6+=4] = r3:2;;
.align_code 4;
	if nlc0e,jump _shixubutiaohuan_3;;
*/
	j16 = _TrData1_buffer2;;	//发送处理后的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j16 = _TrData1_buffer1;;	
	
	j4 = j14;;
	j6 = j16;;
//.align_code 4;
//	call _add_zhentou(np)(abs);;
	
	
#if ID_NUM == 1 || ID_NUM == 3//主片
	j7 = j6;;//发送地址
	j8 = _zhentou;;//帧头地址
	lc0 = 10;;
_add_ASLC13_zhentou1:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC13_zhentou1;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 40;;
	lc0 = 10;;
_add_ASLC13_zhentou2:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC13_zhentou2;;

	xr31 = 100*2;;		//分段每次做100个点
	j3 = j14 + 0;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*4;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*5;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;	
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + 0;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;

	j3 = j14 + LengthBoshu;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*4;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*5;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + LengthBoshu;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
#endif	
	
#if ID_NUM == 2 || ID_NUM == 0//从片
	j7 = j6 + 0;;
	j8 = _zhentou + 40*2;;
	lc0 = 10;;
_add_ASLC02_zhentou1:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC02_zhentou1;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 40*3;;
	lc0 = 10;;
_add_ASLC02_zhentou2:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC02_zhentou2;;
	
	xr31 = 100*2;;		//分段每次做100个点
	j3 = j14 + LengthBoshu*2;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*4;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*5;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;	
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + 0;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;

	j3 = j14 + LengthBoshu*3;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*4;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*5;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + LengthBoshu;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
#endif	
	
#if ID_NUM == 4 || ID_NUM == 6//主片
	j7 = j6;;//发送地址
	j8 = _zhentou;;//帧头地址
	lc0 = 10;;
_add_ASLC46_zhentou1:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC46_zhentou1;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 40;;
	lc0 = 10;;
_add_ASLC46_zhentou2:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC46_zhentou2;;
	
	j7 = j6 + LengthBoshu*2;;
	j8 = _zhentou + 40*2;;
	lc0 = 10;;
_add_ASLC46_zhentou3:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC46_zhentou3;;
	
	xr31 = 100*2;;		//分段每次做100个点
	j3 = j14 + 0;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + 0;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	j3 = j14 + 0;;
	j7 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 2440;;	//输入数据
	j3 = j16 + 0;;
	j11 = j3 + 2440;;	//输出数据
.align_code 4;
	call _ASLC(np)(abs);;

	j3 = j14 + LengthBoshu;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + LengthBoshu;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	j3 = j14 + LengthBoshu;;
	j7 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 2440;;	//输入数据
	j3 = j16 + LengthBoshu;;
	j11 = j3 + 2440;;	//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	
	j3 = j14 + LengthBoshu*2;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + LengthBoshu*2;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	j3 = j14 + LengthBoshu*2;;
	j7 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 2440;;	//输入数据
	j3 = j16 + LengthBoshu*2;;
	j11 = j3 + 2440;;	//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
#endif	
	
#if ID_NUM == 5 || ID_NUM == 7//从片
	j7 = j6;;//发送地址
	j8 = _zhentou + 40*3;;//帧头地址
	lc0 = 10;;
_add_ASLC57_zhentou1:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC57_zhentou1;;
	
	j7 = j6 + LengthBoshu;;
	j8 = _zhentou + 40*4;;
	lc0 = 10;;
_add_ASLC57_zhentou2:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC57_zhentou2;;
	
	j7 = j6 + LengthBoshu*2;;
	j8 = _zhentou + 40*5;;
	lc0 = 10;;
_add_ASLC57_zhentou3:
	r1:0 = q[j8+=4];;
	q[j7+=4] = r1:0;;
.align_code 4;
	if nlc0e,jump _add_ASLC57_zhentou3;;
	
	xr31 = 100*2;;		//分段每次做100个点
	j3 = j14 + LengthBoshu*3;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + 0;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	j3 = j14 + LengthBoshu*3;;
	j7 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 2440;;	//输入数据
	j3 = j16 + 0;;
	j11 = j3 + 2440;;	//输出数据
.align_code 4;
	call _ASLC(np)(abs);;

	j3 = j14 + LengthBoshu*4;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + LengthBoshu;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	j3 = j14 + LengthBoshu*4;;
	j7 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 2440;;	//输入数据
	j3 = j16 + LengthBoshu;;
	j11 = j3 + 2440;;	//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	
	j3 = j14 + LengthBoshu*5;;
	j7 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 40;;		//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 40;;		//输入数据
	j3 = j16 + LengthBoshu*2;;
	j11 = j3 + 40;;		//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
	j3 = j14 + LengthBoshu*5;;
	j7 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*6;;		
	j8 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*7;;		
	j9 = j3 + 2440;;	//输入数据
	j3 = j14 + LengthBoshu*8;;		
	j10 = j3 + 2440;;	//输入数据
	j3 = j16 + LengthBoshu*2;;
	j11 = j3 + 2440;;	//输出数据
.align_code 4;
	call _ASLC(np)(abs);;
#endif	

#if ID_NUM == 2 || ID_NUM == 7
	xr0 = [j31+_ChuLi_Flag+1];;
  	xr4 = 0;;//检验匿影模式标志位
	xcomp(r0,r4);;
.align_code 4;
  	if nxaeq,jump _pass3;;
#endif	

#if ID_NUM == 1 || ID_NUM == 3 || ID_NUM == 4 || ID_NUM == 6//主片
//------------------判断是否进入检测模式，即给FPGA传输数据-----------------------------------
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
  	if nxaeq,call _jiance_FPGA(np)(abs);;
#endif	
.align_code 4;
	jump _wait;;

_pass3://匿影模式
	j4 = _ReData1_buffer2;;//处理接收到的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j4 = _ReData1_buffer1;;

	j6 = _TrData1_buffer2;;//发送处理后的数据首地址
	xr0 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r0 by r5;;
	xcomp(r5,r6);;
.align_code 4;
	if xaeq;do,j6 = _TrData1_buffer1;;
	
#if ID_NUM == 2
	j4 = j4 + LengthBoshu*5;;
	j5 = j6 + LengthBoshu;;
#endif	
#if ID_NUM == 7
	j4 = j4 + LengthBoshu*7;;
	j5 = j6 + LengthBoshu*2;;
#endif	
	xr0 = LengthBoshu;;
	xr1 = lshift r0 by -2;;
	lc0 = xr1;;
_niying_loop:
	r1:0 = q[j4+=4];;
	q[j5+=4] = r1:0;;
.align_code 4;
  	if nlc0e,jump _niying_loop;;
  	
	xr0 = [j31+_JianCe_Flag+0];;
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
  	if nxaeq,call _jiance_FPGA(np)(abs);;
.align_code 4;
	jump  _wait;;

//_main_asm_end:
_main_asm.end:

