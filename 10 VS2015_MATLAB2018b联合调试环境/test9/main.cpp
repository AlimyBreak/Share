
#include "main.h"

#ifdef _MATLAB_PLOT_
#include "plot_bymatlab.h"
#endif

int main(void)
{
    int32_t  data_buf[100] = { 0, };
    uint32_t data_len = 100;
#ifdef _MATLAB_PLOT_
    Plot_MatlabInit();
    for(int i = 0 ; i <100;i++)
    {
        data_buf[i] = (i-50)*(i-50);
    }
    clf();
    Plot_ByMatlabOne(data_buf, data_len);
#endif    
    system("pause");
    return 0;
}                               