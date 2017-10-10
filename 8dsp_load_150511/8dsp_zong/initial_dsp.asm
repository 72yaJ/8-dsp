#include "defts201.h"
#include "cache_macros.h"


.global _initial_dsp;
.extern _PriFlag;
.extern _Inter_Num;
.extern _PRI_int;

.section program;
//======================DSP��ʼ������========================================================================	
_initial_dsp:
	xr0 = 0x00189067;;//ϵͳ���üĴ����ָ�Ĭ��ֵ
	SYSCON = xr0;;
//------------------��ʼ����ID��----------------------------------------------------------------	
/*
	xr0 = flagreg;;
	xr1 = 0xf;;
	xr0 = r0 and r1;;
	xr0 = lshift r0 by -1;;
	xr1 = 0;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_next1;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP1
	xr1 = 4000;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
.align_code 4;
	jump _ID_end;;
_ID_next1:
	xr1 = 1;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_next2;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP3
	xr1 = 4000;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
.align_code 4;
	jump _ID_end;;
_ID_next2:
	xr1 = 2;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_next3;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP5
	xr1 = 4000;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
.align_code 4;
	jump _ID_end;;
_ID_next3:
	xr1 = 3;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_next4;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP7
	xr1 = 4000;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
.align_code 4;
	jump _ID_end;;
_ID_next4:
	xr1 = 4;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_next5;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP6
	xr1 = 1200;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
.align_code 4;
	jump _ID_end;;
_ID_next5:
	xr1 = 5;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_next6;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP4
	xr1 = 1200;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
.align_code 4;
	jump _ID_end;;
_ID_next6:
	xr1 = 6;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_next7;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP2
	xr1 = 1200;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
.align_code 4;
	jump _ID_end;;
_ID_next7:
	xr1 = 7;;
	xcomp(r0,r1);;
.align_code 4;
	if nxaeq,jump _ID_end;;
	[j31 + ID_num + 0] = xr1;;			//DeviceID�ţ���ӦP0
	xr1 = 1200;;
	[j31 + ID_num + 1] = xr1;;			//�����Լ����ݳ���
_ID_end:
*/
//------------------��ʼ��flag----------------------------------------------------------------	
	xr1 = FLAGREG;;                          
    xr1 = bset r1 by FLAGREG_FLAG0_EN_P;;   
    xr1 = bset r1 by FLAGREG_FLAG1_EN_P;;
    xr1 = bset r1 by FLAGREG_FLAG2_EN_P;;
    xr1 = bset r1 by FLAGREG_FLAG3_EN_P;;
    FLAGREG = xr1;;                        
	xr1 = FLAGREG;;                            
    xr1 = bclr r1 by FLAGREG_FLAG0_OUT_P;;			//�������е�flag����Ϊ0   
    xr1 = bclr r1 by FLAGREG_FLAG1_OUT_P;;
    xr1 = bclr r1 by FLAGREG_FLAG2_OUT_P;;
    xr1 = bclr r1 by FLAGREG_FLAG3_OUT_P;;
    FLAGREG = xr1;;	
//------------------��ʼ����·��----------------------------------------------------------------		

	xr0 = 0x10;;
	LRCTL1 = xr0;;
	LRCTL3 = xr0;;
	LRCTL0 = xr0;;
	LRCTL2 = xr0;;
	xr0 = 0x90;;
	LTCTL1 = xr0;;
	LTCTL3 = xr0;;
	LTCTL0 = xr0;;
	LTCTL2 = xr0;;
//	xr0 = 0x0;; 
//	LRCTL1 = xr0;;
//	LTCTL1 = xr0;;
//	LRCTL3 = xr0;;
//	LTCTL3 = xr0;;
//------------------��ʼ�����Ʊ���----------------------------------------------------------------	
	xr0 = 0;;
	[j31+_PriFlag] = xr0;;
	[j31+_Inter_Num] = xr0;;
//------------------��ֹȫ���ж�----------------------------------------------------------------	
    xr0 = SQCTLCL;;						
	xr0 = bclr r0 by SQCTL_GIE_P;;
	xr0 = bset r0 by SQCTL_NMOD_P;;
	SQCTLCL = xr0;;						
//------------------ʹ��cache--------------------------------------------------------------------	
  	cache_enable(750);				
    xr0 = 0xFF01;;										
	TEST_MODES = xr0;;	
//------------------�����жϿ��ƼĴ���-------------------------------------------------------------		
	xr0 = INTCTL;;
	xr1 = 0xfffffff0;;
	xr3 = r1 and r0;;								
	INTCTL = xr3;;
//------------------�����ж��ж�������-------------------------------------------------------------		
	j10 = _PRI_int;;									
//	ivirq1 = j10;;
	ivirq0 = j10;;
//------------------��IRQ0�ж�-------------------------------------------------------------	   
	xr0 = 0x00000000;;								
	IMASKL = xr0;;
    IMASKH = xr0;;
//	xr0 = bset r0 by INT_IRQ1_P;;
	xr0 = bset r0 by INT_IRQ0_P;;
    IMASKH = xr0;; 
//------------------��ȫ���ж�----------------------------------------------------------------
	xr0 = SQCTLST;;									
	xr0 = bset r0 by SQCTL_GIE_P;;
	SQCTLST = xr0;;	
//------------------��ʼ�����������򷵻�---------------------------------------------------------
.align_code 4;						
	cjmp(np)(abs);;						
_initial_dsp.end:   
