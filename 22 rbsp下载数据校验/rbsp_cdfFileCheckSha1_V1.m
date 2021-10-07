%{
    rbsp_cdfFileCheckSha1_V1: YQW/2021.10.07
    
    输入:
        work_dir    : cdf文件和SHA1SUM文件所在的文件夹
        sha1file    : 'SHA1SUM' 或者 'SHA1SUM.txt'
    输出:
        无.
%}


function [] = rbsp_cdfFileCheckSha1_V1(work_dir,sha1file);

    %work_dir = 'D:\DATA\rbsp\emfisis\HFR\waveform\a\2015\';
    %sha1file = 'SHA1SUM';
    
    if work_dir(end) ~= '\';
        work_dir = [work_dir,'\'];
    end


    % 获取校验文件中的信息
    [file_num,file_str,sha1_str]  = rbsp_SHA1SUMGetInfo_V1([work_dir,sha1file]);

    % 获取cdf文件的信息,准备做校验
    temp            =   dir([work_dir,'*.cdf']);
    cdf_file_names  =   {temp.name};
    FLAGS_NOFILE    =   0;
    FLAGS_FILEEXIST =   1;
    FLAGS_SHA1MATCH =   2;
    flags           =   FLAGS_NOFILE*ones(1,length(file_str));

    % cdf文件逐一做校验(会有耗时)
    for ii = 1:length(cdf_file_names)
        fprintf('现有cdf文件%d个,正在校验第%d个\n',length(cdf_file_names),ii);
        cur_file_name = cdf_file_names{ii};
        [lia,locb]  = ismember(cur_file_name,file_str);
        
        % 若cdf文件名在SHA1SUM文件中
        if lia == 1
            flags(locb) =   FLAGS_FILEEXIST;% 存在这个文件
            % 计算SHA1值并对比
            temp_str    =   File_SHA1([work_dir, cur_file_name]);
            if(strcmp(temp_str,sha1_str{locb}))
                flags(locb) = FLAGS_SHA1MATCH;
            end
        end
    end
    
    % 找出各种状态,并输出信息
    temp0 = find(flags == FLAGS_NOFILE)     ;
    temp1 = find(flags == FLAGS_FILEEXIST)  ;
    temp2 = find(flags == FLAGS_SHA1MATCH)  ;
    
    fprintf('SHA1SUM文件中总计有效文件应有 %d 个,其中\n',file_num);
    fprintf('0.未下载文件 %d 个',length(temp0));
    if temp0 ~= 0
        fprintf('分别是\n');
        for ii = 1:length(temp0)
            fprintf('%s\n',file_str{temp0(ii)});
        end
    end
    fprintf('1.有文件但SHA1验证失败 %d 个,',length(temp1));
    if temp1 ~= 0
        fprintf('分别是\n');
        for ii = 1:length(temp1)
            fprintf('%s\n',file_str{temp1(ii)});
        end
    end

    fprintf('2.下载且校验成功%d个\n',length(temp2));

end


