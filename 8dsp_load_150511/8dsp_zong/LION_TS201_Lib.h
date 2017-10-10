//////////////////////////////////////////////
// LIONTEK 
// Ver 2.0.1
// 090819: 修改中断处理，添加ChangeIrqNType函数。建议用户根据自己的实际需求参考相关代码实现自己的ISR_Init以及中断回调函数
/////////////////////////////////////////////


#if !defined(__LION_TS201_LIB_H_)
#define __LION_TS201_LIB_H_

//**************************************************
// include

#include "sysreg.h"
#include "builtins.h"
#include "defTS201.h"
#include "signal.h"

asm("#include \"cache_macros.h\"");
asm("#include <defts201.h>");

//**************************************************
// macro
//#define dprintf printf
#define dprintf //

#define wr_dat(addr,data)	(*(volatile int *)(addr))=(data)
#define rd_dat(addr,data)	(data)=(*(volatile int *)(addr))

#define wr_dat64(addr,data)	(*(volatile long long  *)(addr))=(data)
#define rd_dat64(addr,data)	(data)=(*(volatile long long  *)(addr))

#define sdram   		0x40000000	// MSSD
#define fram    		0x38000000	// MS1 
#define freg    		0x31000000	// MS0

#define LinkPort150M	LTCTL_TCLKDIV4
#define LinkPort300M	LTCTL_TCLKDIV2
#define LinkPort400M	LTCTL_TCLKDIV1P5
#define LinkPort600M	LTCTL_TCLKDIV1

//**************************************************
// struct
typedef struct  {
	int *DI;				// index
	int DX;					// count and stride in x direction
	int DY;					// count and stride in y direction
	int DP;					// DMA control word
	} TCB;
	
//**************************************************
// global variables
extern TCB 	link0_T_TCB;
extern TCB 	link1_T_TCB;
extern TCB 	link2_T_TCB;
extern TCB 	link3_T_TCB;
extern TCB 	link0_R_TCB;
extern TCB 	link1_R_TCB;
extern TCB 	link2_R_TCB;
extern TCB 	link3_R_TCB;

extern TCB  dma1_source;
extern TCB	dma1_destination;

extern __builtin_quad q;

//**************************************************
// global variables: interrupt flag
// 建议用户根据实际需求添加自己的中断标志
/*
extern int flagirq0;
extern int flagirq1;
extern int flagirq2;
extern int flagirq3;

extern int flagdma0;
extern int flagdma1;
extern int flagdma2;
extern int flagdma3;

extern int flaglink0T;
extern int flaglink1T;
extern int flaglink2T;
extern int flaglink3T;
extern int flaglink0R;
extern int flaglink1R;
extern int flaglink2R;
extern int flaglink3R;

extern int flagtimer0lp;
extern int flagtimer1lp;
extern int flagtimer0hp;
extern int flagtimer1hp;
*/
// functions

// system
void Enable_cache(void);
void System_Init(void);

// link
// 注意：初始化link时注意delay_mscount的设置，尽量使多dsp执行LinkPort_Init的时间间隔不超过delay_mscount，越同步越好。
void LinkPort_Init(int L0_speed,int L1_speed,int L2_speed,int L3_spee,int delay_mscount);

// 注意: link 收发长度以字(32bit)为单位，必须为4的整数倍，不能大于65536。
void link0_T(int * TX_BaseAdd,int TX_Length);
void link1_T(int * TX_BaseAdd,int TX_Length);
void link2_T(int * TX_BaseAdd,int TX_Length);
void link3_T(int * TX_BaseAdd,int TX_Length);

void link0_R(int * RX_BaseAdd,int RX_Length);
void link1_R(int * RX_BaseAdd,int RX_Length);
void link2_R(int * RX_BaseAdd,int RX_Length);
void link3_R(int * RX_BaseAdd,int RX_Length);

void link0_T_fe(int * TX_BaseAdd,int TX_Length);
void link1_T_fe(int * TX_BaseAdd,int TX_Length);
void link2_T_fe(int * TX_BaseAdd,int TX_Length);
void link3_T_fe(int * TX_BaseAdd,int TX_Length);

void link0_R_te(int * RX_BaseAdd,int RX_Length);
void link1_R_te(int * RX_BaseAdd,int RX_Length);
void link2_R_te(int * RX_BaseAdd,int RX_Length);
void link3_R_te(int * RX_BaseAdd,int RX_Length);

// Interrupt:
bool ChangeIrqNType(int irqnum,bool edgetype);	// irqnum: 0-irq0,1-irq1,2-irq2,3-irq3; edgetype: true-边沿出发,false-电平触发

// 建议用户使用时参考该代码实现自己的ISR_Init和中断处理函数
void ISR_Init(void);
/*
void irq0_int(int sig);
void irq1_int(int sig);
void irq2_int(int sig);
void irq3_int(int sig);

void dma0_int(int sig);
void dma1_int(int sig);
void dma2_int(int sig);
void dma3_int(int sig);

void dma4_int(int sig);
void dma5_int(int sig);
void dma6_int(int sig);
void dma7_int(int sig);
void dma8_int(int sig);
void dma9_int(int sig);
void dma10_int(int sig);
void dma11_int(int sig);

void timer0lp_int(int sig);
void timer1lp_int(int sig);
void timer0hp_int(int sig);
void timer1hp_int(int sig);
*/

// dma
// 注意: dma长度以字(32bit)为单位，必须为4的整数倍，不能大于65536。
void dma1_i2e(long *iAddress,long *eAddress,int n);
void dma1_e2i(long *eAddress,long *iAddress,int n);
inline void start_dma1(TCB Source,TCB Destin);

// dsp timer
void runTime1(void);
void readTimeStart(unsigned long long *Stime);
void readTimeEnd(float *result,unsigned long long *Stime);

// fpga timer
long long read_GCount(void);
float read_GCount_Time(long long Start_Count);

// led
void set_flag_out(int n);
void set_flag_in(int n);
void set_flag_H(int n);
void set_flag_L(int n);
void flash_led(int n,int delay_ms);

// delay 最大4294s
extern void asmdelay(int us01);
void Delay_us(int count_us);
void Delay_ms(int count_ms);
void Delay_s(int count_s);

// 发送PCI中断: dsp -> pc
void SentIrqToHost(void);

#endif /* !defined(__LION_TS201_LIB_H_) */
