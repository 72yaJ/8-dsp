/*****************************************************************************

ʱ�䣺
���ߣ�
˵��: 
 *****************************************************************************/

#include "defts201.h"
#include "cache_macros.h"

//������ַ�ռ�
.global _DATA;			
.global _zijian_DATA_buffer;	//����������ɵ�ַ
.global _ChuLi_Flag;	//ȷ���źŴ���ʽ�ı�־λ
.global _JianCe_Flag;	//������ģʽ�ı�־λ
.global _ZhenShu;		//���ɵ�֡��
.global _ZiJianStack;	//��ջ��ַ
//���õı���
.global _PriFlag;//�жϱ�־
.global _Inter_Num;//�жϸ���
//.global _PRI_int;//�жϸ���
.global _zijian_kongzhi;//�Լ����
.global _CFAR_baoluo;//���ݰ���
.global _fuzhu_zxg;			//����ͨ�������ϵ��
.global _zhufuzhu_hxg;		//����ͨ�������ϵ��
.global _zuijiaquanzhi;		//���Ȩֵ
.global _jiance_data1;		//���������ݻ���1
.global _jiance_data2;		//���������ݻ���2
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
.global _dongmubiao_stack;//���ɶ�Ŀ�����Ķ�ջ
.global _canshubiao;//���ɶ�Ŀ�����Ĳ���
.global _dmb_fuduxishu;//��Ŀ�����ϵ��
.global _jiance_stack;//ʾ������ʾͼ�����Ķ�ջ
.global _add_zhentou_stack;//��֡ͷ����Ķ�ջ
.global _ASLC_stack;//�԰��������Ķ�ջ
.global _can_stack;//can�����������Ķ�ջ
.global _wait_pri_stack;//�жϵȴ�����Ķ�ջ
.global _sin_stack;//��ȡsin����Ķ�ջ
.global _cfar_zijian_stack;//����CFAR�Լ�������Ķ�ջ
.global _zijian_zhenjishu;//�Լ췽ʽ�е�֡����
.global _pinlvjiebian_stack;//Ƶ�ʽݱ�����ջ
.global _aslc_caiyangweizhi;//�����������λ��
.global _aslc_shuchu;//��������������ѡ��

//======================�洢�ռ�����============================================================	
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
.var _TCB_DMA09_R1[4] = { _ReData1_buffer1,(57344<<16)|4,0,0x57000000 };//��·�ڽ�������buffer1
.align 4;
.var _TCB_DMA09_R2[4] = { _ReData1_buffer2,(57344<<16)|4,0,0x57000000 };//��·�ڽ�������buffer2
.align 4;
.var _TCB_DMA07_T1[4] = { _ReData1_buffer1,(57344<<16)|4,0,0x56000000 };//��Ƭ��·�ڷ�������buffer1
.align 4;
.var _TCB_DMA07_T2[4] = { _ReData1_buffer2,(57344<<16)|4,0,0x56000000 };//��Ƭ��·�ڷ�������buffer2
.align 4;
.var _TCB_DMA11_R1[4] = { (_TrData1_buffer1),(16384<<16)|4,0,0x57000000 };//��Ƭ��·�ڽ�������buffer1
.align 4;
.var _TCB_DMA11_R2[4] = { (_TrData1_buffer2),(16384<<16)|4,0,0x57000000 };//��Ƭ��·�ڽ�������buffer2
.align 4;
.var _TCB_DMA05_T1[4] = { _TrData1_buffer1,(32768<<16)|4,0,0x56000000 };//��·�ڷ�������buffer1
.align 4;
.var _TCB_DMA05_T2[4] = { _TrData1_buffer2,(32768<<16)|4,0,0x56000000 };//��·�ڷ�������buffer2
.align 4;
.var _TCB_DMA10_R1[4] = { (_ReData1_buffer1),(57344<<16)|4,0,0x57000000 };//��Ƭ��·�ڽ�������buffer1
.align 4;
.var _TCB_DMA10_R2[4] = { (_ReData1_buffer2),(57344<<16)|4,0,0x57000000 };//��Ƭ��·�ڽ�������buffer2
.align 4;
.var _TCB_DMA06_T1[4] = { _TrData1_buffer1,(16384<<16)|4,0,0x56000000 };//��Ƭ��·�ڷ�������buffer1
.align 4;
.var _TCB_DMA06_T2[4] = { _TrData1_buffer2,(16384<<16)|4,0,0x56000000 };//��Ƭ��·�ڷ�������buffer2
.align 4;
.var _TCB_DMA03_DCS1[4] = { _jiance_data1,(4000<<16)|4,0,0x56000000 };//Դ�ⲿDMA��������buffer1
.align 4;
.var _TCB_DMA03_DCS2[4] = { _jiance_data2,(4000<<16)|4,0,0x56000000 };//Դ�ⲿDMA��������buffer2
.align 4;
.var _TCB_DMA03_DCD[4] = { 0x38000000,(4000<<16)|0,0,0x96000000 };//Ŀ���ⲿDMA��������
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
.var _dongmubiao_stack[8];//���ɶ�Ŀ�����Ķ�ջ
.align 4;
.var _canshubiao[120];//���ɶ�Ŀ�����Ĳ���
.align 4;
.var _dmb_fuduxishu[8];//��Ŀ�����ϵ��
.align 4;
.var _jiance_stack[4];//ʾ������ʾͼ�����Ķ�ջ
.align 4;
.var _add_zhentou_stack[4];//��֡ͷ����Ķ�ջ
.align 4;
.var _ASLC_stack[4];//�԰��������Ķ�ջ
.align 4;
.var _can_stack[4];//can�����������Ķ�ջ
.align 4;
.var _wait_pri_stack[4];//�жϵȴ�����Ķ�ջ
.align 4;
.var _sin_stack[4];//��ȡsin����Ķ�ջ
.align 4;
.var _cfar_zijian_stack[4];//����CFAR�Լ�������Ķ�ջ
.align 4;
.var _zijian_zhenjishu[4];//�Լ췽ʽ�е�֡����
.align 4;
.var _aslc_caiyangweizhi[4];//�����������λ��
.align 4;
.var _aslc_shuchu[4];//��������������ѡ��

//---------------------data10b -----------------------------
.section data10b;
//------------------------------------------------------------------------