//////////////////////////////////////////////
// LIONTEK 
// Ver 2.0.1
// 090819: �޸��жϴ������ChangeIrqNType�����������û������Լ���ʵ������ο���ش���ʵ���Լ���ISR_Init�Լ��жϻص�����
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
// �����û�����ʵ����������Լ����жϱ�־
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
// ע�⣺��ʼ��linkʱע��delay_mscount�����ã�����ʹ��dspִ��LinkPort_Init��ʱ����������delay_mscount��Խͬ��Խ�á�
void LinkPort_Init(int L0_speed,int L1_speed,int L2_speed,int L3_spee,int delay_mscount);

// ע��: link �շ���������(32bit)Ϊ��λ������Ϊ4�������������ܴ���65536��
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
bool ChangeIrqNType(int irqnum,bool edgetype);	// irqnum: 0-irq0,1-irq1,2-irq2,3-irq3; edgetype: true-���س���,false-��ƽ����

// �����û�ʹ��ʱ�ο��ô���ʵ���Լ���ISR_Init���жϴ�����
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
// ע��: dma��������(32bit)Ϊ��λ������Ϊ4�������������ܴ���65536��
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

// delay ���4294s
extern void asmdelay(int us01);
void Delay_us(int count_us);
void Delay_ms(int count_ms);
void Delay_s(int count_s);

// ����PCI�ж�: dsp -> pc
void SentIrqToHost(void);

#endif /* !defined(__LION_TS201_LIB_H_) */
