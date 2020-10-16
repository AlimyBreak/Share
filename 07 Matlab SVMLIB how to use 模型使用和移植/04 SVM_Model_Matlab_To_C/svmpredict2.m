function [ predict_label,accuracy,dec_values] = svmpredict2(heart_scale_label,heart_scale_inst,model)
    predict_label = [];
    accuracy      = [];
    dec_values    = [];
    if model.Parameters(1)~=0
       fprintf('暂不支持') 
       return;
    end
    b = -model.rho;
    g = model.Parameters(4);
    
    % 以下u,v均为列向量 1*特征数
    LineSum = @(u,v)(u*v');
    PolySum = @(u,v,gamma,coef0,degree)( gamma*u*v'+coef0)^degree;
    RBFSum = @(u,v,gamma)(exp(-gamma*sum((u-v).^2)));
    SigSum = @(u,v,gamma,coef0)(tanh(gamma*u*v'+coef0));
    
    %  样本遍历
    for i = 1:size(heart_scale_inst,1)
       vector = heart_scale_inst(i,:);  % size(vector) = [ 1 , 特征数 ]
       y = 0;
       % 支持向量遍历
       for j = 1:length(model.sv_coef)  
           u = model.SVs(j,:);% size(u) = [ 1 , 特征数 ]
           temp = RBFSum(u,vector,g);
           y = y + model.sv_coef(j)*temp; 
       end
        dec_values(i,1) = y + b;
    end
    for i = 1:length(dec_values)
        if dec_values(i) > 0    % 判决
            predict_label(i,1) = model.Label(1);
        else
            predict_label(i,1) = model.Label(2);
        end
    end
    total = length(heart_scale_label);
    valid_count = sum(heart_scale_label == predict_label);
    
    accuracy = valid_count / total;
    fprintf('Accuracy = %.4f%%(%d/%d)\n',accuracy*100,valid_count,total);
end