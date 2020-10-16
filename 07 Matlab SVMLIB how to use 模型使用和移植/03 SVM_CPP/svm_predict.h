/*******************Copyright(c)*********************************
** Veepoo Tech
** COPYRIGHT (C) 2014-2018
**----------------------FileInfo---------------------------------
** File name          : svm_predict.h
** Last modified Date : 2018-09-26
** Last SYS_VERSION   : 0.0.0.1
** Descriptions       : svm predict algorithm header file 
**---------------------------------------------------------------
** Createdby          : YQW
** Createddate        : 2018-09-26
** SYS_VERSION        : 0.0.0.1
** Descriptions       : svm predict algorithm
data and functions definitions
**---------------------------------------------------------------
** Modified by        :
** Modified date      :
** SYS_VERSION        :
** Descriptions       :
****************************************************************/

#include <stdint.h>

#ifndef __SVM_PREDICT_H__
#define __SVM_PREDICT_H__

#define SVM_DRINK_VERSIN    (0x01010101)
#define SVM_LABLE_DRINK     (1)
#define SVM_LABLE_UNDRINK   (SVM_LABLE_DRINK - 1)


// Memory need
// Global:45611+1(Bytes) = 44.54(KB), Local:(10+15)Bytes , Malloc:0 



/*
* svm model structure
*/
typedef struct svm_drink_model{
    uint8_t  dim_input;
    float    gamma;
    float    bias;
    uint16_t num_sv;
    float*   sv_coef;
    float*   SVs;
}svm_drink_model_t; // Not useful in this version 

/*
* svm drink prediction input structure
*/
typedef struct svm_drink_predict{
	double*   input;
}svm_drink_predict_t;

/*
* svm drink predication output structure
*/
typedef struct svm_drink_result{
    uint8_t classfy_result;
}svm_drink_result_t;

/*
* extern functions declarations  
*/
extern uint32_t svm_DrinkGetVersion(void);
extern void     svm_DrinkInit(void);
extern void     svm_DrinkPredictEntry(svm_drink_predict_t* svm_predict_s);
extern void     svm_DrinkGetPredictResult(svm_drink_result_t* result_s);

#endif