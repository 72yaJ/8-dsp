#include "defts201.h"
#include "cache_macros.h"
#include "UserDef.h"

.global _PRI_int;
.extern _PriFlag;
.extern _Inter_Num;
.extern _stack_PRI_int;
.extern _ChuLi_Flag;
.extern _JianCe_Flag;
.extern _TCB_DMA03_DCD;
.extern _TCB_DMA03_DCS1;
.extern _TCB_DMA03_DCS2;
.extern _TCB_DMA05_T1;
.extern _TCB_DMA05_T2;
.extern _TCB_DMA07_T1;
.extern _TCB_DMA07_T2;
.extern _TCB_DMA06_T1;
.extern _TCB_DMA06_T2;
.extern _TCB_DMA09_R1;
.extern _TCB_DMA09_R2;
.extern _TCB_DMA11_R1;
.extern _TCB_DMA11_R2;
.extern _TCB_DMA10_R1;
.extern _TCB_DMA10_R2;
.extern ID_num;
.extern _jiance_data1;
.extern _jiance_data2;

.section program;

//======================PRI中断服务程序==============================================================================	
_PRI_int:
//------------------入栈----------------------------------------------------------------		
	[j31+_stack_PRI_int+0] = xr0;;
    [j31+_stack_PRI_int+1] = yr0;;
    xr0 = xstat;;
    [j31+_stack_PRI_int+2] = xr0;;
    yr0 = ystat;;
    [j31+_stack_PRI_int+3] = yr0;;
    [j31+_stack_PRI_int+4] = xr1;;
    [j31+_stack_PRI_int+5] = xr2;;
    [j31+_stack_PRI_int+6] = xr3;;
    [j31+_stack_PRI_int+7] = xr4;;
    [j31+_stack_PRI_int+8] = xr5;;
    [j31+_stack_PRI_int+9] = xr6;;
    [j31+_stack_PRI_int+10] = cjmp;;
    
///* 
#if TestJianceDebug == 1
xr0 = 0;;
xr1 = 100;;
j4 = _jiance_data1;;
j5 = _jiance_data2;;
lc0 = 2000;;
_looop:
xr0 = r0+r1;;
[j4+=1] = xr0;;
[j5+=1] = xr0;;
.align_code 4;
  	if nlc0e,jump _looop;;
.align_code 4;
  	jump _fpga_dma_peizhi;;
#endif
//*/

//----------------中断计数器加1---------------------------------------------------------
	xr0 = [j31+_Inter_Num];;
	xr1 = inc r0;;
	[j31+_Inter_Num] = xr1;;
//------------------设置pri到来标志-----------------------------------------------------	
	xr0 = 1;; 							
	[j31+_PriFlag] = xr0;;
//------------------判断是否进入链路口配置-----------------------------------------------		
#if ID_NUM == 0 || ID_NUM == 2 || ID_NUM == 5 || ID_NUM == 7
.align_code 4;
	jump _fupian_dma_peizhi;;
#endif

//-------------------配置DMA9(链路口1接收)----------------------------------------------
	xr0 = LRCTL1;; 
	xr1 = bclr r0 by 0;;
	LRCTL1 = xr1;; 						 		//关闭链路口
	
	xr0 = 0;;
	xr1 = 0;; 
	xr2 = 0;; 
	xr3 = 0;;
	dc9 = xr3:0;;					
	xr1:0 = DSTATC;;							//清除DMA状态寄存器
	xr0 = LRSTATC1;;							//清除链路口状态寄存器
	xr0 = LRSTATC1;;							//清除链路口状态寄存器
 	
	xr3:0 = q[j31+_TCB_DMA09_R1];;				//选择接收buffer
	xr4 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r4 by r5;;
	xcomp(r5,r6);;
	if xaeq;do,xr3:0 = q[j31+_TCB_DMA09_R2];;
		
	dc9 = xr3:0;;								//配置DMA
	xr0 = LRCTL1;; 
	xr1 = bset r0 by 0;;
	LRCTL1 = xr1;;								//打开链路口		
//------------------配置DMA7(链路口3发送)-----------------------------------------------		
 	xr0 = LTCTL3;;
	xr1 = bclr r0 by 0;;
	LTCTL3 = xr1;;								//关闭链路口
	
	xr0 = 0;;
	xr1 = 0;;
	xr2 = 0;;
	xr3 = 0;;
	dc7 = xr3:0;;								//disable dma
 	xr1:0 = DSTATC;;							//清DMA错误状态
	xr0 = LTSTATC3;;							//清除链路口状态寄存器
	xr0 = LTSTATC3;;							//清除链路口状态寄存器

	xr3:0 = q[j31+_TCB_DMA07_T1];;				//选择发送buffer				
	xr4 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r4 by r5;;
	xcomp(r5,r6);;
	if xaeq;do,xr3:0 = q[j31+_TCB_DMA07_T2];;   
	
	dc7 = xr3:0;;								//配置DMA
	xr0 = LTCTL3;;
	xr1 = bset r0 by 0;; 
	LTCTL3 = xr1;;								//打开链路口
//-------------------配置DMA11(链路口3接收)----------------------------------------------
	xr0 = LRCTL3;; 
	xr1 = bclr r0 by 0;;
	LRCTL3 = xr1;; 						 		//关闭链路口
	
	xr0 = 0;;
	xr1 = 0;; 
	xr2 = 0;; 
	xr3 = 0;;
	dc11 = xr3:0;;					
	xr1:0 = DSTATC;;							//清除DMA状态寄存器
	xr0 = LRSTATC3;;							//清除链路口状态寄存器
	xr0 = LRSTATC3;;							//清除链路口状态寄存器
	
	xr3:0 = q[j31+_TCB_DMA11_R1];;				//选择接收buffer				
	xr4 = [j31+_Inter_Num];;
	xr5 = 0x00000001;;
	xr6 = fext r4 by r5;;
	xcomp(r5,r6);;
	if xaeq;do,xr3:0 = q[j31+_TCB_DMA11_R2];;

	xr4 = LengthBoshu*3;;
	xr0 = r0 + r4;;

	dc11 = xr3:0;;								//配置DMA
	xr0 = LRCTL3;; 
	xr1 = bset r0 by 0;;
	LRCTL3 = xr1;;								//打开链路口		
	
	
//------------------出栈-----------------------------------------------------------------
_pri_int_out:	
  	xr0 = [j31+_stack_PRI_int+10];;
	cjmp = xr0;;
	xr6 = [j31+_stack_PRI_int+9];;
	xr5 = [j31+_stack_PRI_int+8];;
	xr4 = [j31+_stack_PRI_int+7];;
	xr3 = [j31+_stack_PRI_int+6];;
	xr2 = [j31+_stack_PRI_int+5];;
	xr1 = [j31+_stack_PRI_int+4];;
	yr0 = [j31+_stack_PRI_int+3];;
	ystat = r0;;
	xr0 = [j31+_stack_PRI_int+2];;
	xstat = r0;;
	yr0 = [j31+_stack_PRI_int+1];;
	xr0 = [j31+_stack_PRI_int+0];;
.align_code 4;
	rds;;
	rti(np)(abs);;nop;;nop;;nop;;	
_PRI_int.end:

