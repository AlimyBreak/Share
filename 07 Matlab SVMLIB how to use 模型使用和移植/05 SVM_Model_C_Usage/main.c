
#include "svm_model.h"
float x_test[] = {0.7083f,1.0000f,1.0000f,-0.3208f,-0.1050f,-1.0000f,1.0000f,-0.4198f,-1.0000f,-0.2258f,0.0000f,1.0000f,-1.0000f};
extern const svm_model_t heart_scale_model_s;
int main(void)
{
    int8_t ret_val = 0  ;
    int8_t result  = 0  ;
    ret_val = Svm_InstallModel(&heart_scale_model_s);
    printf("Svm_InstallModel ret_val = %d\n",ret_val);
    ret_val = Svm_Prediction( &result,x_test); 
    printf("Svm_Prediction ret_val = %d\n",ret_val);
    printf("x_test prediction result = %d\n",result);
    
    return 0;

    
}