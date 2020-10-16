
#include "svm_model.h"
#include <math.h>



/*
    核函数类型定义:
    输入: 
        float*  :计算结果输出
        float*  :输入特征向量
        float*  :支持特征向量
        uint8_t :输入向量和支持向量长度
    输出:
        int8_t : [0] 计算正常,[!0] 计算出现错误
*/
#ifndef KERNEL_FUNCTION_T
#define KERNEL_FUNCTION_T
typedef int8_t(*kernel_function_t)(float*,float*,float*,uint8_t);
#endif

/*
* 函数声明
*/
int8_t   Svm_InstallModel                   ( const svm_model_t*  sim_svm_model_s                   );
int8_t   Svm_Prediction                     ( int8_t*             sp_result_output ,
                                              float*              sp_vector_input                 
                                            );
uint32_t Svm_GetVersion                     ( void                                                  );                      

static int8_t Svm_CheckModelValid          (  const svm_model_t*  sim_svm_model_s                    );
static int8_t Svm_KernelFunction_Linear    (  float*              skfr_output_result       ,
                                              float*              skfr_input_vector        ,
                                              float*              skfr_support_vector      ,
                                              uint8_t             skft_vector_length
                                            );
static int8_t Svm_KernelFunction_Polynomial ( float*              skfr_output_result       ,
                                              float*              skfr_input_vector        ,
                                              float*              skfr_support_vector      ,
                                              uint8_t             skft_vector_length
                                            );
static int8_t Svm_KernelFunction_rbf       (  float*              skfr_output              ,
                                              float*              skfr_input_vector        ,
                                              float*              skfr_support_vector      ,
                                              uint8_t             skft_vector_length
                                           );
static int8_t Svm_KernelFunction_sigmoid   (  float*              skfr_output_result       ,
                                              float*              skfr_input_vector        ,
                                              float*              skfr_support_vector      ,
                                              uint8_t             skft_vector_length
                                           );


/*
* 全局变量声明
*/
static const svm_model_t*      g_svm_model_s          = NULL;
static const kernel_function_t g_kernel_function_s[5] = { Svm_KernelFunction_Linear                         , 
                                                          Svm_KernelFunction_Polynomial                     ,
                                                          Svm_KernelFunction_rbf                            ,
                                                          Svm_KernelFunction_sigmoid                        ,
                                                          NULL  /*若用户自定义了核函数,请在此处替换绑定*/
                                                        };



                                                
/*
* 安装SVM模型
*/
int8_t Svm_InstallModel(const svm_model_t* sim_svm_model_s)
{
    int8_t ret_val = 0;
    do
    {
        if(sim_svm_model_s == NULL)
        {
            ret_val = -1;
            break;
        }
        if(Svm_CheckModelValid(sim_svm_model_s)!=0)
        {
            ret_val = -2;
            break;
        }
        g_svm_model_s = sim_svm_model_s;
    } while (0);

    return ret_val;
}



/*
* 预测函数
*/
int8_t Svm_Prediction( int8_t*  sp_result_output    ,
                       float*   sp_vector_input
                    )
{
    int8_t              ret_val                    = 0         ;
    const float*        svm_sv_coef                = NULL      ;
    const float*        svm_SVs                    = NULL      ;
    uint8_t             svm_kf_type                = 0         ;
    uint16_t            svm_totalSV                = 0         ;
    uint8_t             svm_num_features           = 0         ;
    uint16_t            i                          = 0         ;
    float               sum_temp                   = 0.0f      ;
    float               temp                       = 0.0f      ;
    kernel_function_t   kernel_function_s          = NULL      ;
    do
    {
        if(  (sp_result_output  == NULL )
           ||(sp_vector_input   == NULL )
           ||(g_svm_model_s     == NULL )
        )
        {
            ret_val = -1;
            break;
        }

        svm_sv_coef       = g_svm_model_s->svm_sv_coef          ;
        svm_SVs           = g_svm_model_s->svm_SVs              ;
        svm_kf_type       = g_svm_model_s->svm_kf_type          ;
        svm_totalSV       = g_svm_model_s->svm_totalSV          ;
        svm_num_features  = g_svm_model_s->svm_num_features     ;
        kernel_function_s = g_kernel_function_s[svm_kf_type]    ;


        for(i=0;i<svm_totalSV;i++)
        {
            kernel_function_s(&temp,sp_vector_input,&svm_SVs[svm_num_features*i],svm_num_features);
            sum_temp    += svm_sv_coef[i]*temp;
        }
        sum_temp -= g_svm_model_s->svm_rho;
        #if NEED_PRINT_INFO == 1
        printf("decision_value = %f\n",sum_temp);
        #endif 
        if(sum_temp > 0.0f)
        {
            *sp_result_output = g_svm_model_s->svm_labels[0];
        }
        else
        {
            *sp_result_output = g_svm_model_s->svm_labels[1];
        }
        
    } while (0);
    return ret_val;
}




/*获取算法文件版本*/
uint32_t Svm_GetVersion( void )
{
    return SVM_MODEL_H_FILE_VERSION;
}


/*********************************************************************************************
 * 以下为内部函数,不对外开放
 * *******************************************************************************************
*/

/*
检查模型有效性
*/
static int8_t Svm_CheckModelValid(const svm_model_t* sim_svm_model_s)
{
    int8_t ret_val = 0;
    do
    {
        if(  (sim_svm_model_s->svm_type < SVM_TYPE_VALID_MIN )
           ||(sim_svm_model_s->svm_type > SVM_TYPE_VALID_MAX )
        )
        {
            ret_val = -1;
            break;
        }

        if(  (sim_svm_model_s->svm_kf_type < SVM_KF_VALID_MIN )
           ||(sim_svm_model_s->svm_kf_type > SVM_KF_VALID_MAX )
        )
        {
            ret_val = -2;
            break;
        }
        if(  (sim_svm_model_s->svm_labels   == NULL )
           ||(sim_svm_model_s->svm_sv_coef  == NULL )
           ||(sim_svm_model_s->svm_SVs      == NULL )
        )
        {
            ret_val = -3;
            break;
        }
    } while (0);
    
    return ret_val;
}



/* 核函数 Linear <----> -t == 0 */
static int8_t Svm_KernelFunction_Linear( float*   skfr_output_result   ,
                                         float*   skfr_input_vector    ,
                                         float*   skfr_support_vector  ,
                                         uint8_t  skft_vector_length
                                        )
{
    int8_t  ret_val  = 0        ;
    uint8_t i        = 0        ;
    float   sum_temp = 0.0f     ;
    do
    {
        if(  ( skfr_output_result  == NULL )
           ||( skfr_input_vector   == NULL )
           ||( skfr_support_vector == NULL )
           ||( skft_vector_length  == 0    )
        )
        {
            ret_val = -1;
            break;
        }
        /* u'*v */
        for (i = 0; i < skft_vector_length; i++)
        {
            sum_temp += skfr_input_vector[i]*skfr_support_vector[i];
        }
        *skfr_output_result = sum_temp;
    }while (0);
    return ret_val;
}

/* 核函数 ploy <----> -t == 1 */
static int8_t Svm_KernelFunction_Polynomial( float*   skfr_output_result   ,
                                             float*   skfr_input_vector    ,
                                             float*   skfr_support_vector  ,
                                             uint8_t  skft_vector_length
                                            )
{
    int8_t  ret_val  = 0        ;
    uint8_t i        = 0        ;
    float   sum_temp = 0.0f     ;
    do
    {
        if(  ( skfr_output_result  == NULL )
           ||( skfr_input_vector   == NULL )
           ||( skfr_support_vector == NULL )
           ||( skft_vector_length  == 0    )
        )
        {
            ret_val = -1;
            break;
        }


        /* (gamma*u'*v + coef0)^degree */
        for (i = 0; i < skft_vector_length; i++)
        {
            sum_temp += skfr_input_vector[i]*skfr_support_vector[i];
        }
        sum_temp            *= g_svm_model_s->svm_gamma;
        sum_temp            += g_svm_model_s->svm_coef0;
        sum_temp            =  powf(sum_temp,g_svm_model_s->svm_degree);
        *skfr_output_result =  sum_temp;
    }while (0);
    return ret_val;
}


/* 核函数 rbf <----> -t == 2 */
static int8_t Svm_KernelFunction_rbf( float*   skfr_output_result   ,
                                      float*   skfr_input_vector    ,
                                      float*   skfr_support_vector  ,
                                      uint8_t  skft_vector_length
                                    )
{
    int8_t  ret_val  = 0        ;
    uint8_t i        = 0        ;
    float   sum_temp = 0.0f     ;
    do
    {
        if(  ( skfr_output_result  == NULL )
           ||( skfr_input_vector   == NULL )
           ||( skfr_support_vector == NULL )
           ||( skft_vector_length  == 0    )
        )
        {
            ret_val = -1;
            break;
        }
        /* 求和 */
        for (i = 0; i < skft_vector_length; i++)
        {
            sum_temp += powf(skfr_input_vector[i]-skfr_support_vector[i],2);
        }
        /* 求指数*/
        sum_temp            = expf(-g_svm_model_s->svm_gamma*sum_temp); 
        *skfr_output_result = sum_temp;
        break;
    } while (0);
    return ret_val;
}


/* 核函数 Sigmoid <----> -t == 3 */
static int8_t Svm_KernelFunction_sigmoid( float*   skfr_output_result   ,
                                          float*   skfr_input_vector    ,
                                          float*   skfr_support_vector  ,
                                          uint8_t  skft_vector_length
                                        )
{
    int8_t  ret_val  = 0        ;
    uint8_t i        = 0        ;
    float   sum_temp = 0.0f     ;
    do
    {
        if(  ( skfr_output_result  == NULL )
           ||( skfr_input_vector   == NULL )
           ||( skfr_support_vector == NULL )
           ||( skft_vector_length  == 0    )
        )
        {
            ret_val = -1;
            break;
        }

        /* tanh(gamma*u'*v + coef0) */
        for (i = 0; i < skft_vector_length; i++)
        {
            sum_temp += skfr_input_vector[i]*skfr_support_vector[i];
        }
        sum_temp            *= g_svm_model_s->svm_gamma ;
        sum_temp            += g_svm_model_s->svm_coef0 ;
        sum_temp            =  tanhf(sum_temp)      ;
        *skfr_output_result =  sum_temp             ;
    } while (0);
    return ret_val;
}


