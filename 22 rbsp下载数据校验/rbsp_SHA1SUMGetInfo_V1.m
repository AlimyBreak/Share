%{
    rbsp_SHA1SUMGetInfo_V1: YQW/2021.10.07
    输入:
    filefullpath: 'SHA1SUM' 文件全路径
    输出:
    file_num    ：   文件个数
    file_str    :    文件名
    sha_str     :    提供的sha1校验信息(字母已经小写化)
%}

function [file_num,file_str,sha_str] = rbsp_SHA1SUMGetInfo_V1(filefullpath)

    file_num    =   0    ;
    file_str    =   []   ;
    sha_str     =   []   ;
    fidin       =   fopen(filefullpath,'r');
    
    data_temp   =   []  ;
    count       =   0   ;
    while ~feof(fidin)
        tline   =   fgetl(fidin);
        if(tline(1) ~= '#')
            count = count + 1;
            data_temp{count}= tline;
        end
    end
    fclose(fidin);
    for ii = 1:count
       str_temp = strsplit(data_temp{ii},' ');
       file_str{ii} = str_temp{2};
       sha_str{ii}  = lower(str_temp{1});
    end
    file_num = count;    
end

