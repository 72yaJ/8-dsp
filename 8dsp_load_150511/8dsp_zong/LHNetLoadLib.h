#ifndef _LHNETLOADLIB_H_

///////////////////////////////////////
// function

// 加载接口函数，必须在所有节点main开始处调用
bool LHNetLoad(void);


///////////////////////////////////////
// param

// 节点编号
extern volatile int _node_id;

// 加载参数
extern volatile int _param[33];

#endif
