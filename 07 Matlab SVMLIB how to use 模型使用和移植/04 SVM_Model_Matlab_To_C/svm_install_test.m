
close all;
clear;
clc;

[heart_scale_label,heart_scale_inst]=libsvmread('heart_scale');
%model = svmtrain(heart_scale_label,heart_scale_inst, '-c 1 -g 0.07');
model = svmtrain(heart_scale_label,heart_scale_inst);
[predict_label, accuracy, dec_values] = svmpredict(heart_scale_label, heart_scale_inst, model);
[predict_label1, accuracy1, dec_values1] = svmpredict2(heart_scale_label, heart_scale_inst, model);
SVMModelToC(model,'heart_scale.txt');
fprintf('error = %e\n',norm(dec_values-dec_values1));





