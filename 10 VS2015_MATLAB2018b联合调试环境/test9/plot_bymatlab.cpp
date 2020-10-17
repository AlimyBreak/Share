/*/ =================================================================================================
(1) 使用教程：https://blog.csdn.net/shouzang/article/details/80795945
//  ===============================================================================================*/
#include <cstdlib>
#include <cstdio>
#include <cstring>
#include "engine.h"
#include <string>
#include "plot_bymatlab.h"

int ret = 0;
Engine* eg = NULL;

int8_t Plot_MatlabInit(void)
{
	if (!(eg = engOpen(NULL)))
	{
		printf("Open matlab enging fail!");
		return 1;
	}
}

void Close_PlotAlgo(void)
{
	if (eg)
	{
		engClose(eg);
	}
}

void clf(void)
{
	engEvalString(eg, "clf(figure(1));");//运行绘图命令
}

void hold_on(void)
{
	engEvalString(eg, "hold on;");//运行绘图命令
}

void title_str(string *str)
{
	engEvalString(eg, "title(str);");//运行绘图命令
}

void title_num(int32_t *num)
{
	engEvalString(eg, "title(num);");//运行绘图命令
}

void title_num(float *numf)
{
	engEvalString(eg, "title(numf);");//运行绘图命令
}

void setfigure(void)
{
	engEvalString(eg, "set(figure(1),'position',[0 900 1080 1000])");//运行绘图命令
}

void subplot211(void)
{
	engEvalString(eg, "subplot 211");
}

void subplot212(void)
{
	engEvalString(eg, "subplot 212");
}

void Plot_ByMatlabOne(int32_t* data1, uint32_t data_len)
{
	
	double *mid_red_data = NULL;
	mid_red_data = (double*)malloc(data_len * sizeof(double));
	if (NULL == mid_red_data)
	{
		return;
	}
	memset(mid_red_data, 0, data_len * sizeof(double));

	for (uint16_t sec_i = 0; sec_i < data_len; sec_i++)
	{
		mid_red_data[sec_i] = (double)(data1[sec_i]);
		/*mid_ird_data[sec_i] = (double)(data2[sec_i]);*/
	}
	// =================================================================================================
	mxArray *X = mxCreateDoubleMatrix(1, data_len, mxREAL);//创建matlab存储数据的指针
	//mxArray *Y = mxCreateDoubleMatrix(1, data_len, mxREAL);

	memcpy(mxGetPr(X), mid_red_data, data_len * sizeof(double)); //数据复制
	//memcpy(mxGetPr(Y), mid_ird_data, data_len * sizeof(double));

	if ((ret = engPutVariable(eg, "X", X)) != 0)   //把数据传递到matlab工作空间,并命名为X
		printf("engPutVariable error：%d\n", ret);
	//if ((ret = engPutVariable(eg, "Y", Y)) != 0)
	//	printf("engPutVariable error：%d\n", ret);
	//engEvalString(eg, "set(figure(1),'position',[-1440 300 1200 830])");//运行绘图命令
	//engEvalString(eg, "clf;");//运行绘图命令
	engEvalString(eg, "gcf = figure(1);");
	engEvalString(eg, "plot(X - mean(X),'-o');");//运行绘图命令
	engEvalString(eg, "hold on;");//运行绘图命令
	//engEvalString(eg, "plot(Y - mean(Y),'-co');");//运行绘图命令

	free(mid_red_data); mid_red_data = NULL;
}

void Plot_ByMatlabDouble(int32_t* data1, int32_t* data2, uint32_t data_len)
{
	double *mid_red_data = NULL;
	double *mid_ird_data = NULL;
	mid_red_data = (double*)malloc(data_len * sizeof(double));
	mid_ird_data = (double*)malloc(data_len * sizeof(double));
	if (NULL == mid_red_data)
	{
		return;
	}
	if (NULL == mid_ird_data)
	{
		return;
	}
	memset(mid_red_data, 0.0, data_len * sizeof(double));
	memset(mid_ird_data, 0.0, data_len * sizeof(double));
	for (uint16_t sec_i = 0; sec_i < data_len; sec_i++)
	{
		mid_red_data[sec_i] = (double)(data1[sec_i]);
		mid_ird_data[sec_i] = (double)(data2[sec_i]);
	}
	// =================================================================================================
	mxArray *X = mxCreateDoubleMatrix(1, data_len, mxREAL);//创建matlab存储数据的指针
	mxArray *Y = mxCreateDoubleMatrix(1, data_len, mxREAL);

	memcpy(mxGetPr(X), mid_red_data, data_len * sizeof(double)); //数据复制
	memcpy(mxGetPr(Y), mid_ird_data, data_len * sizeof(double));

	if ((ret = engPutVariable(eg, "X", X)) != 0)   //把数据传递到matlab工作空间,并命名为X
		printf("engPutVariable error：%d\n", ret);
	if ((ret = engPutVariable(eg, "Y", Y)) != 0)
		printf("engPutVariable error：%d\n", ret);

	engEvalString(eg, "plot(X-mean(X),'-ro');");//运行绘图命令
	engEvalString(eg, "hold on;");//运行绘图命令
	engEvalString(eg, "plot(Y-mean(Y),'-co');");//运行绘图命令

	free(mid_red_data); mid_red_data = NULL;
	free(mid_ird_data); mid_ird_data = NULL;
}

void Plot_ByMatlabDoubleAndPoint(int32_t* data1, int32_t* data2, 
	uint32_t data_len, uint32_t* x1, uint32_t* x2, uint32_t point_len)
{

	double *mid_red_data = NULL;
	double *mid_ird_data = NULL;
	double *red_x = NULL;
	double *ird_x = NULL;
	mid_red_data = (double*)malloc(data_len * sizeof(double));
	mid_ird_data = (double*)malloc(data_len * sizeof(double));
	red_x = (double*)malloc(point_len * sizeof(double));
	ird_x = (double*)malloc(point_len * sizeof(double));
	if (NULL == mid_red_data)
	{
		return;
	}
	if (NULL == mid_ird_data)
	{
		return;
	}
	if (NULL == red_x)
	{
		return;
	}
	if (NULL == ird_x)
	{
		return;
	}
	memset(mid_red_data, 0.0, data_len * sizeof(double));
	memset(mid_ird_data, 0.0, data_len * sizeof(double));
	memset(red_x, 0.0, point_len * sizeof(double));
	memset(ird_x, 0.0, point_len * sizeof(double));
	for (uint16_t sec_i = 0; sec_i < data_len; sec_i++)
	{
		mid_red_data[sec_i] = (double)(data1[sec_i]);
		mid_ird_data[sec_i] = (double)(data2[sec_i]);
	}
	for (uint16_t sec_i = 0; sec_i < point_len; sec_i++)
	{
		red_x[sec_i] = (double)(x1[sec_i]);
		ird_x[sec_i] = (double)(x2[sec_i]);
	}
	// =================================================================================================
	mxArray *X = mxCreateDoubleMatrix(1, data_len, mxREAL);//创建matlab存储数据的指针
	mxArray *Y = mxCreateDoubleMatrix(1, data_len, mxREAL);

	mxArray *Xp = mxCreateDoubleMatrix(1, point_len, mxREAL);//创建matlab存储数据的指针
	mxArray *Yp = mxCreateDoubleMatrix(1, point_len, mxREAL);

	memcpy(mxGetPr(X), mid_red_data, data_len * sizeof(double)); //数据复制
	memcpy(mxGetPr(Y), mid_ird_data, data_len * sizeof(double));

	memcpy(mxGetPr(Xp), red_x, point_len * sizeof(double)); //数据复制
	memcpy(mxGetPr(Yp), ird_x, point_len * sizeof(double));

	if ((ret = engPutVariable(eg, "X", X)) != 0)   //把数据传递到matlab工作空间,并命名为X
		printf("engPutVariable error：%d\n", ret);
	if ((ret = engPutVariable(eg, "Y", Y)) != 0)
		printf("engPutVariable error：%d\n", ret);
	engEvalString(eg, "set(figure(1),'position',[-1440 300 700 830])");//运行绘图命令
	engEvalString(eg, "clf;");//运行绘图命令
	engEvalString(eg, "gcf = figure(1);");
	engEvalString(eg, "plot(X-mean(X),'-ro');");//运行绘图命令
	engEvalString(eg, "hold on;");//运行绘图命令
	engEvalString(eg, "plot(Y-mean(Y),'-co');");//运行绘图命令

	//engEvalString(eg, "plot(Xp,X(Xp),'ko','MarkerFaceColor','r');");//运行绘图命令
	//engEvalString(eg, "plot(Yp,Y(Yp),'bo','MarkerFaceColor','b');");//运行绘图命令

	free(mid_red_data); mid_red_data = NULL;
	free(mid_ird_data); mid_ird_data = NULL;
	free(red_x); red_x = NULL;
	free(ird_x); ird_x = NULL;
}