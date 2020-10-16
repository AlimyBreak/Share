/*******************Copyright(c)*********************************
** Veepoo Tech
** COPYRIGHT (C) 2014-2018
**----------------------FileInfo---------------------------------
** File name          : svm_predict.c
** Last modified Date : 2018-09-26
** Last SYS_VERSION   : 0.0.0.1
** Descriptions       : svm predict algorithm .c file
**---------------------------------------------------------------
** Createdby          : YQW
** Createddate        : 2018-09-26
** SYS_VERSION        : 0.0.0.1
** Descriptions       : svm predict algorithm data and functions definitions
**---------------------------------------------------------------
** Modified by        :
** Modified date      :
** SYS_VERSION        :
** Descriptions       :
****************************************************************/
#include "svm_predict.h"
#include <math.h>
#include <string.h>

/*
*   local  global variablies definitions
* & extern gloabl variablies declarations  
*/
//static svm_drink_model_t svm_drink_model_s; // Not useful in this version 
static svm_drink_result_t svm_drink_result_s;  // G:1Byte
extern uint8_t      svm_dim_input;  // define in svm_model_para.c
extern float        svm_gamma;      // define in svm_model_para.c
extern float        svm_bias;       // define in svm_model_para.c
extern uint16_t     svm_num_sv;     // define in svm_model_para.c
extern float        svm_sv_coef[];  // define in svm_model_para.c
extern float        svm_SVs[];      // define in svm_model_para.c

/*
*   local  functions declarations
* & extern functions declarations  
*/

// G:0 , L:4, M:0
uint32_t     svm_DrinkGetVersion(void);
// G:0 , L:0 , M:0
void         svm_DrinkInit(void);
// G:45611(Bytes) = 44.54(KB), L:(10+15)Bytes , M:0
void         svm_DrinkPredictEntry(svm_drink_predict_t* svm_predict_s);
// G:0, L:4Bytes , M:0
void         svm_DrinkGetPredictResult(svm_drink_result_t* result_s);
// G:0 , L:15Bytes , M:0
static float svm_DrinkSumRbf(float* value_u , float* value_v,uint16_t length);

//-------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------//

/****************************************************************
** Function name     : svm_DrinkGetVersion
** Descriptions      : get svm algorithm version
** input parameters  : void
** output parameters : void
** Returned value    : void
** Created by        : YQW
** Created Date      : 2018-09-26
**---------------------------------------------------------------
** Modified by       :
** Modified date     :
** Descriptions      :
**---------------------------------------------------------------
****************************************************************/
// G:0 , L:4, M:0
uint32_t svm_DrinkGetVersion(void)
{
    return (SVM_DRINK_VERSIN);
}

/****************************************************************
** Function name     : svm_DrinkInit
** Descriptions      : svm algorithm initialization
** input parameters  : void
** output parameters : void
** Returned value    : void
** Created by        : YQW
** Created Date      : 2018-09-26
**---------------------------------------------------------------
** Modified by       :
** Modified date     :
** Descriptions      :
**---------------------------------------------------------------
****************************************************************/
// G:0 , L:0 , M:0
void svm_DrinkInit(void)
{
    memset(&svm_drink_result_s,0,sizeof(svm_drink_result_t));
    svm_drink_result_s.classfy_result  = SVM_LABLE_UNDRINK;
    return ;
}

/****************************************************************
** Function name     : svm_DrinkSumRbf
** Descriptions      : svm algorithm rbf summation
** input parameters  : void
** output parameters : void
** Returned value    : void
** Created by        : YQW
** Created Date      : 2018-09-26
**---------------------------------------------------------------
** Modified by       :
** Modified date     :
** Descriptions      :
**---------------------------------------------------------------
****************************************************************/
// G:0 , L:15Bytes , M:0
static float svm_DrinkSumRbf(float* value_u , double* value_v,uint16_t length)
{
    /* matlab code
     * RBF = @(u,v)(exp(-gamma.*sum((u-v).^2)));
    */
    uint8_t i = 0;
    float sum = 0;
    for(i = 0 ; i < length ; i++)
    {
        sum += (float)(pow(value_u[i]-value_v[i],2));
    }
    return (float)(exp(-svm_gamma*sum));
}


/****************************************************************
** Function name     : svm_DrinkPredictEntry
** Descriptions      : entry of svm algorithm
** input parameters  : void
** output parameters : void
** Returned value    : void
** Created by        : YQW
** Created Date      : 2018-09-26
**---------------------------------------------------------------
** Modified by       :
** Modified date     :
** Descriptions      :
**---------------------------------------------------------------
****************************************************************/
// G:45611(Bytes) = 44.54(KB), L:10Bytes , M:0
void svm_DrinkPredictEntry(svm_drink_predict_t* svm_drink_predict_s)
{
    uint16_t i   = 0;
    float    sum = 0;


    if (svm_drink_predict_s->input == NULL)
    {
        memset(&svm_drink_result_s, 0, sizeof(svm_drink_result_t));
        return;
    }

    for(i = 0; i < svm_num_sv; i++)
    {
        sum += svm_sv_coef[i] * svm_DrinkSumRbf(&svm_SVs[i*svm_dim_input], svm_drink_predict_s->input, svm_dim_input);
    }
    sum = sum + svm_bias;
    if(sum > 0)
    {
        svm_drink_result_s.classfy_result = SVM_LABLE_DRINK;
    }
	else
    {
        svm_drink_result_s.classfy_result = SVM_LABLE_UNDRINK;
	}
    return ;
}

/****************************************************************
** Function name     : svm_DrinkGetPredictResult
** Descriptions      : get result of svm algorithm
       You can only make one prediction and get one result at a time
** input parameters  : void
** output parameters : void
** Returned value    : void
** Created by        : YQW
** Created Date      : 2018-09-26
**---------------------------------------------------------------
** Modified by       :
** Modified date     :
** Descriptions      :
**---------------------------------------------------------------
****************************************************************/
// G:0, L:4Bytes , M:0
void svm_DrinkGetPredictResult(svm_drink_result_t* sdgpr_result_s)
{
    memcpy(sdgpr_result_s,&svm_drink_result_s,sizeof(svm_drink_result_t));
    return;
}



//-------------------------------------------------------------------------------//
//---------------------------------file end--------------------------------------//