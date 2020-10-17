#ifndef __PLOT_BYMATLAB_H__
#define __PLOT_BYMATLAB_H__

#include <cstdlib>
#include <cstdio>
#include <cstring>
#include "engine.h"
#include <string>

using namespace std;

int8_t Plot_MatlabInit(void);
void Close_PlotAlgo(void);
void clf(void);
void hold_on(void);
void title_str(string *str);
void title_num(int32_t *num);
void title_num(float *numf);
void setfigure(void);
void subplot211(void);
void subplot212(void);
void Plot_ByMatlabOne(int32_t* data1, uint32_t data_len);
void Plot_ByMatlabDouble(int32_t* data1, int32_t* data2, uint32_t data_len);
void Plot_ByMatlabDoubleAndPoint( int32_t*  data1,
                                  int32_t*  data2, 
                                  uint32_t  data_len,
                                  uint32_t* x1,
                                  uint32_t* x2,
                                  uint32_t  point_len
                                );

#endif

                                                  