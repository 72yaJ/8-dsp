

//#include "stdio.h"
//#include "math.h"
//#include "sysreg.h"
//#include "builtins.h"
#include "defTS201.h"
//#include "signal.h"
#include "cache_macros.h"
//#include "LION_TS201_Lib.h"
//#include "UserDef.h"
#include <math.h>
#include <sysreg.h>
#include <defts201.h>

#include "LHNetLoadLib.h"
#include "LION_TS201_Lib.h"


//extern void asmdelay(void);
extern void main_asm(void);

main()
{
	
//	LHNetLoad();//����ldr�ļ�ʱȡ��ע�ͣ�����dxe�ļ�ʱ����ע��
	
	while(1)
	
	{
		main_asm();
	}
}
