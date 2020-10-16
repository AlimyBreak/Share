/*
* File Info  : svm_model.h
* Created By : YQW(20190509)
***********************************************
* Version:  0x00000001_20190509
* Des:      1.svm_model使用的第一个库,利用MATLAB生成的模型参数来进行SVM分类
            2.目前仅支持SVM_TYPE_C_SVC,其他种类暂时不支持
* Author:   YQW
***********************************************
*/


#ifndef __SVM_MODEL_H__
#define __SVM_MODEL_H__

#include <stdint.h>
#include <stdio.h>

#define SVM_MODEL_H_FILE_VERSION    ( 0x00000001    )
#define SVM_MDOEL_H_FILE_AUTHOR     ( "YQW"         )
#define SVM_MODEL_H_FILE_TIME       ( "20190509"    )
#define NEED_PRINT_INFO             ( 1             )
/* -s parameter, svm type */
#ifndef SVM_TYPE_C_SVC
#define SVM_TYPE_C_SVC              ( 0             )
#define SVM_TYPE_NU_SVC             ( 1             )
#define SVM_TYPE_ONE_CLASS          ( 2             )
#define SVM_TYPE_EPSILON_SVR        ( 3             )
#define SVM_TYPE_NU_SVR             ( 4             )
#define SVM_TYPE_VALID_MIN          SVM_TYPE_C_SVC
#define SVM_TYPE_VALID_MAX          SVM_TYPE_C_SVC
#endif

/* -t patamter, kernel function */
#ifndef SVM_KF_LINEAR
#define SVM_KF_LINEAR               ( 0             )
#define SVM_KF_POLYNOMIAL           ( 1             )
#define SVM_KF_RBF                  ( 2             )
#define SVM_KF_SIGMOID              ( 3             )
#define SVM_KF_SELF_DEFINE          ( 4             )   /* 自定义核函数,本版本暂不支持,要支持的话需要在svm_model.c中增加函数定义,并在全局数组中绑定函数 */
#define SVM_KF_VALID_MIN            SVM_KF_LINEAR
#define SVM_KF_VALID_MAX            SVM_KF_SIGMOID      /* 若支持了自定义核函数,此宏应做相应修改(SVM_KF_SIGMOID ---- > SVM_KF_SELF_DEFINE)*/
#endif

#ifndef SVM_MODEL_T
#define SVM_MODEL_T
/* svm model type definitions */
typedef struct tag_svm_model
{
    uint8_t            svm_type                 ;/* -s parameter, svm type                                  */
    uint8_t            svm_kf_type              ;/* -t patamter, kernel function,不支持自定义核函数           */
    float              svm_degree               ;/* -d degree in kernel function(default 3)                 */
    float              svm_gamma                ;/* -g gamma,in kernel function(default 1/num_features)     */
    float              svm_coef0                ;/* -r coef0,in kernel function(default 0)                  */
    uint8_t            svm_nr_class             ;/* 分类种数                                                 */
    const int8_t*      svm_labels               ;/* 结果标签数组(数组size为svm_nr_class)                      */
    uint16_t           svm_totalSV              ;/* 支持向量个数                                             */
    uint8_t            svm_num_features         ;/* 特征数量                                                 */
    const float*       svm_sv_coef              ;/* 支持向量系数数组(数组size为svm_totalSV)                   */
    const float*       svm_SVs                  ;/* 支持向量数组(数组size为svm_totalSV*svm_num_features)      */     
    float              svm_rho                  ;/* b = -svm_rho                                            */
    /*
        sizeof(svm_model_t)  ---> 1+1+4*3+1+4+2+1+4*3 =  34(Bytes)
    */
}svm_model_t;
#endif




/*
* function declarations for external call
*/
extern int8_t Svm_InstallModel                    ( const svm_model_t*  sim_svm_model_s                     );
extern int8_t Svm_Prediction                      ( int8_t*             sp_result_output ,
                                                    float*              sp_vector_input                 
                                                  );

#endif /* !__SVM_MODEL_H__ */

