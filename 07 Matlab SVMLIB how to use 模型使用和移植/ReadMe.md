# 利用MATLAB R2018b + Libsvm-3.23 进行分类模型搭建和利用
## 0. 准备工作
+ 已经在Win7 64bit下部署(MATLAB R2018b + Libsvm-3.23)
+ 官方自带测试用例运行通过(Ref1.4)
## 1. 接口函数
### 1.1 svmtrain
#### 1.1.1 输入参数1:heart_scale_label
+ 样本标签
#### 1.1.2 输入参数2:heart_scale_inst
+ 样本数据(样本个数x样本特征数)
#### 1.1.3 输入参数(可选,字符串)
+ -s: SVM设置类型(默认0)
+ 0 -- C-SVC: C-支持向量分类机;参数C为惩罚系数,C越大表示对错误分类的惩罚越大,适当的参数C对分类Accuracy很关键,用于惩罚系数的.
+ 1 -- v-SVC: v-支持向量分类机;由于C的选取比较困难,用另一个参数v代替C.C是"无意义"的,v是有意义的.(与C_SVC其实采用的模型相同,但是它们的参数C的范围不同,C_SVC采用的是0到正无穷，该类型是[0,1].),v用于惩罚支持向量的个数.
+ 2 -- one class SVM: 单类别-支持向量机,不需要类标号,用于支持向量的密度估计和聚类.也就是训练数据只有一个类标签,可以用于检测异常点.
+ 3 -- e-SVR: epsilon-支持向量回归机,不敏感损失函数,对样本点来说,存在着一个不为目标函数提供任何损失值的区域,用于回归.
+ 4 -- v-SVR: nu-支持向量回归机,由于EPSILON_SVR需要事先确定参数,然而在某些情况下选择合适的参数却不是一件容易的事情,而NU_SVR能够自动计算参数,用于回归.
+ -t: 核函数类别(默认为2)
+ 0 -- 线性:u'*v
+ 1 -- 多项式:(gamma*u'*v + coef0)^degree
+ 2 -- 径向基:exp(-gamma*|u-v|^2)
+ 3 -- S函数:tanh(gamma*u'*v + coef0)
+ 4 -- 用户自定义核函数??
+ -d degree: set degree in kernel function (default 3)
+ -g gamma: set gamma in kernel function (default 1/num_features)
+ -r coef0: set coef0 in kernel function (default 0)
+ -c cost: set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
+ -n nu: set the parameter nu of nu-SVC, one-class SVM, and nu-SVR (default 0.5)
+ -p epsilon: set the epsilon in loss function of epsilon-SVR (default 0.1)
+ -m cachesize: set cache memory size in MB (default 100)
+ -e epsilon: set tolerance of termination criterion (default 0.001)
+ -h shrinking: whether to use the shrinking heuristics, 0 or 1 (default 1)
+ -b probability_estimates: whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
+ -wi weight: set the parameter C of class i to weight*C, for C-SVC (default 1)
+ -v n:n-fold cross validation mode
+ -q: quiet mode (no outputs)
#### 1.1.4 输出参数:model:1x1 struct
+ SVM模型结构体
##### 1.1.4.1 model.Parameters
+ 结构体变量,依次保存的是 -s -t -d -g -r等参数
+ -s 0      C-SVC
+ -t 2      exp(-gamma*|u-v|^2)
+ -d 3      set degree in kernel function (default 3)
+ -g 0.0769 set gamma in kernel function (default 1/num_features)
+ -r 0      set coef0 in kernel function (default 0)
##### 1.1.4.2 model.nr_class
+ 分类的个数
##### 1.1.4.3 model.totalSV
+ 总的支持向量个数
##### 1.1.4.4 model.rho
+ b=-model.rho
##### 1.1.4.5 model.Label
+ 结果标签.如果是分类,则为类标签,如果是回归则为真实值
##### 1.1.4.6 model.sv_indices
+ ????
##### 1.1.4.7 model.ProbA
+ ????
##### 1.1.4.8 model.ProbB
+ ????
##### 1.1.4.9 model.nSV
+ ????
##### 1.1.4.10 model.sv_coef
+ 支持向量的系数
##### 1.1.4.11 model.SVs
+ 具体的支持向量,以稀疏矩阵的形式存储
### 1.2 svmpredict
#### 1.2.1 输入参数1:heart_scale_label
+ 样本实际标签
#### 1.2.2 输入参数2:heart_scale_inst
+ 需要预测的样本数据(样本个数x样本特征数)
#### 1.2.3 输入参数3:model
+ svmtrain生存的分类模型结构体
#### 1.2.4 输入参数4: 可选字符串
+ 略
#### 1.2.5 输出参数1:predict_label
+ 预测得到的结果(样本个数x1)
#### 1.2.6 输出参数2:accuracy(Ref5.2)
+ 准确率1 -- 用于分类问题,(TP+TN)/(TP+TN+FP+FN)
+ 准确率2 -- 用于回归问题, MSE
+ 准确率3 -- 用于回归问题,平方相关系数
+ 也就是说,如果分类的话,看第一个数字就可以了;回归的话,看后两个数字.
#### 1.2.7 输出参数3:decision_values
+ 判决前的数值结果(样本个数x1)
## 2.利用Model来进行预测(默认参数分类)
+ 见文件夹 02 模型利用测试 svm_install_test.m 中的svmpredict2 函数
## 3.将预测代码移植为C/C++代码
+ 见文件夹 03 SVM_CPP 其中svm_model_para.cpp的参数需要Matlab根据模型生成

## Ref
+ 1. https://blog.csdn.net/June_Xixi/article/details/85253079 windows64位系统下Matlab R2018b安装libsvm工具箱 倏然希然_
+ 2. https://blog.csdn.net/weixin_33947521/article/details/85829348 matlab里的svmtrain的输出model里,各参数的含义 weixin_33947521
+ 3. https://blog.csdn.net/Aoulun/article/details/79566536 libsvm中各参数介绍（包括里面结构体参数的介绍） 麻呱智能
+ 4. svm-train.c
+ 5. http://blog.sina.com.cn/s/blog_4d7c97a00101bwz1.html svmtrain和svmpredict简介