/*****************************************************************************

时间：
作者：
说明: 
 *****************************************************************************/

#include "defts201.h"
#include "cache_macros.h"

//声明地址空间
.global _DATA;			
.global _zijian_DATA_buffer;	//检测数据生成地址
.global _ChuLi_Flag;	//确定信号处理方式的标志位
.global _JianCe_Flag;	//进入检测模式的标志位
.global _ZhenShu;		//生成的帧数
.global _ZiJianStack;	//入栈地址
//引用的变量
.global _PriFlag;//中断标志
.global _Inter_Num;//中断个数
//.global _PRI_int;//中断个数
.global _zijian_kongzhi;//自检控制
.global _CFAR_baoluo;//数据包络
.global _fuzhu_zxg;			//辅助通道自相关系数
.global _zhufuzhu_hxg;		//辅助通道互相关系数
.global _zuijiaquanzhi;		//最佳权值
.global _jiance_data1;		//输出检测数据缓冲1
.global _jiance_data2;		//输出检测数据缓冲2
.global _CFAR_Flag;		
.global _ReData1_buffer1;		
.global _ReData1_buffer2;		
.global _TCB_DMA03_DCD;		
.global _TCB_DMA03_DCS1;		
.global _TCB_DMA03_DCS2;		
.global _TCB_DMA05_T1;		
.global _TCB_DMA05_T2;		
.global _TCB_DMA07_T1;		
.global _TCB_DMA07_T2;				
.global _TrData1_buffer1;		
.global _TrData1_buffer2;		
.global _stack_PRI_int;		
.global _dongmubiao_stack;//生成动目标程序的堆栈
.global _canshubiao;//生成动目标程序的参数
.global _dmb_fuduxishu;//动目标幅度系数
.global _jiance_stack;//示波器显示图像程序的堆栈
.global _add_zhentou_stack;//加帧头程序的堆栈
.global _ASLC_stack;//旁瓣对消程序的堆栈
.global _can_stack;//can命令解析程序的堆栈
.global _wait_pri_stack;//中断等待程序的堆栈
.global _sin_stack;//求取sin程序的堆栈
.global _cfar_zijian_stack;//加上CFAR自检包络程序的堆栈
.global _zijian_zhenjishu;//自检方式中的帧计数
.global _pinlvjiebian_stack;//频率捷变程序堆栈
.global _aslc_caiyangweizhi;//副瓣对消采样位置
.global _aslc_shuchu;//副瓣对消输出数据选择

//======================存储空间配置============================================================	
.section data;
//----------------------data2a-------------------------------
.section data2a;
.align 4;
.var _ReData1_buffer1[57344];//8192*7>4840*9
//----------------------data2b -------------------------------
.section data2b;
.align 4;
.var _ReData1_buffer2[57344];//8192*7>4840*9
//----------------------data4a ----------------------------
.section data4a;
.align 4;
.var _TrData1_buffer1[32768];//8192*4>4840*6
//----------------------data4b --------------------------------
.section data4b;
.align 4;
.var _TrData1_buffer2[32768];//8192*4>4840*6
//----------------------data6a --------------------------------
.section data6a;
.align 4;
.var _DATA[5000*2];
.align 4;
.var _zijian_DATA_buffer[5000*2];
.align 4;
.var _fuzhu_zxg[20];
//----------------------data6b --------------------------------
.section data6b;
//----------------------data8a -----------------------------
.section data8a;
.align 4;
.var _CFAR_baoluo[5000] = "cfar_baoluo.dat";
.align 4;
.var _zhufuzhu_hxg[8];
.align 4;
.var _zuijiaquanzhi[8];
.align 4;
.var _jiance_data1[5000];
//---------------------data8b ------------------------------
.section data8b;
.align 4;
.var _jiance_data2[5000];
//----------------------data10a ----------------------------
.section data10a;
.align 4;
.var _stack_PRI_int[40];
.align 4;
.var _ZiJianStack[8];
.align 4;
.var _ZhenShu[8];
.align 4;
.var _ChuLi_Flag[4];
.align 4;
.var _TCB_DMA09_R1[4] = { _ReData1_buffer1,(57344<<16)|4,0,0x57000000 };//链路口接收数据buffer1
.align 4;
.var _TCB_DMA09_R2[4] = { _ReData1_buffer2,(57344<<16)|4,0,0x57000000 };//链路口接收数据buffer2
.align 4;
.var _TCB_DMA07_T1[4] = { _ReData1_buffer1,(57344<<16)|4,0,0x56000000 };//主片链路口发送数据buffer1
.align 4;
.var _TCB_DMA07_T2[4] = { _ReData1_buffer2,(57344<<16)|4,0,0x56000000 };//主片链路口发送数据buffer2
.align 4;
.var _TCB_DMA11_R1[4] = { (_TrData1_buffer1),(16384<<16)|4,0,0x57000000 };//主片链路口接收数据buffer1
.align 4;
.var _TCB_DMA11_R2[4] = { (_TrData1_buffer2),(16384<<16)|4,0,0x57000000 };//主片链路口接收数据buffer2
.align 4;
.var _TCB_DMA05_T1[4] = { _TrData1_buffer1,(32768<<16)|4,0,0x56000000 };//链路口发送数据buffer1
.align 4;
.var _TCB_DMA05_T2[4] = { _TrData1_buffer2,(32768<<16)|4,0,0x56000000 };//链路口发送数据buffer2
.align 4;
.var _TCB_DMA10_R1[4] = { (_ReData1_buffer1),(57344<<16)|4,0,0x57000000 };//副片链路口接收数据buffer1
.align 4;
.var _TCB_DMA10_R2[4] = { (_ReData1_buffer2),(57344<<16)|4,0,0x57000000 };//副片链路口接收数据buffer2
.align 4;
.var _TCB_DMA06_T1[4] = { _TrData1_buffer1,(16384<<16)|4,0,0x56000000 };//副片链路口发送数据buffer1
.align 4;
.var _TCB_DMA06_T2[4] = { _TrData1_buffer2,(16384<<16)|4,0,0x56000000 };//副片链路口发送数据buffer2
.align 4;
.var _TCB_DMA03_DCS1[4] = { _jiance_data1,(4000<<16)|4,0,0x56000000 };//源外部DMA发送数据buffer1
.align 4;
.var _TCB_DMA03_DCS2[4] = { _jiance_data2,(4000<<16)|4,0,0x56000000 };//源外部DMA发送数据buffer2
.align 4;
.var _TCB_DMA03_DCD[4] = { 0x38000000,(4000<<16)|0,0,0x96000000 };//目的外部DMA发送数据
.align 4;
.var _Inter_Num[4];
.align 4;
.var _PriFlag[4];
.align 4;
.var _JianCe_Flag[4];
.align 4;
.var _CFAR_Flag[4];
.align 4;
.var _zijian_kongzhi[16];
.align 4;
.var _dongmubiao_stack[8];//生成动目标程序的堆栈
.align 4;
.var _canshubiao[120];//生成动目标程序的参数
.align 4;
.var _dmb_fuduxishu[8];//动目标幅度系数
.align 4;
.var _jiance_stack[4];//示波器显示图像程序的堆栈
.align 4;
.var _add_zhentou_stack[4];//加帧头程序的堆栈
.align 4;
.var _ASLC_stack[4];//旁瓣对消程序的堆栈
.align 4;
.var _can_stack[4];//can命令解析程序的堆栈
.align 4;
.var _wait_pri_stack[4];//中断等待程序的堆栈
.align 4;
.var _sin_stack[4];//求取sin程序的堆栈
.align 4;
.var _cfar_zijian_stack[4];//加上CFAR自检包络程序的堆栈
.align 4;
.var _zijian_zhenjishu[4];//自检方式中的帧计数
.align 4;
.var _aslc_caiyangweizhi[4];//副瓣对消采样位置
.align 4;
.var _aslc_shuchu[4];//副瓣对消输出数据选择

//---------------------data10b -----------------------------
.section data10b;
//------------------------------------------------------------------------