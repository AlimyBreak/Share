%{

    rbsp_cdfFileCheckSha1_V2: YQW/2021.10.10
    
    ����:
        work_dir    : cdf�ļ���SHA1SUM�ļ����ڵ��ļ���
        sha1file    : 'SHA1SUM' ���� 'SHA1SUM.txt'
		outputfile  : 'YYYY.txt'
    ���:
        ��.

    rbsp_cdfFileCheckSha1_V1: YQW/2021.10.07
    
    ����:
        work_dir    : cdf�ļ���SHA1SUM�ļ����ڵ��ļ���
        sha1file    : 'SHA1SUM' ���� 'SHA1SUM.txt'
    ���:
        ��.
%}


function [] = rbsp_cdfFileCheckSha1_V2(work_dir,sha1file,outputfile);

    %work_dir = 'D:\DATA\rbsp\emfisis\HFR\waveform\a\2015\';
    %sha1file = 'SHA1SUM';
    
    if work_dir(end) ~= '\';
        work_dir = [work_dir,'\'];
    end


    % ��ȡУ���ļ��е���Ϣ
    [file_num,file_str,sha1_str]  = rbsp_SHA1SUMGetInfo_V2([work_dir,sha1file]);

    % ��ȡcdf�ļ�����Ϣ,׼����У��
    temp            =   dir([work_dir,'*.cdf']);
    cdf_file_names  =   {temp.name};
    FLAGS_NOFILE    =   0;
    FLAGS_FILEEXIST =   1;
    FLAGS_SHA1MATCH =   2;
    flags           =   FLAGS_NOFILE*ones(1,length(file_str));

    % cdf�ļ���һ��У��(���к�ʱ)
    for ii = 1:length(cdf_file_names)
        fprintf('����cdf�ļ�%d��,����У���%d��\n',length(cdf_file_names),ii);
        cur_file_name = cdf_file_names{ii};
        [lia,locb]  = ismember(cur_file_name,file_str);
        
        % ��cdf�ļ�����SHA1SUM�ļ���
        if lia == 1
            flags(locb) =   FLAGS_FILEEXIST;% ��������ļ�
            % ����SHA1ֵ���Ա�
            temp_str    =   File_SHA1([work_dir, cur_file_name]);
            if(strcmp(temp_str,sha1_str{locb}))
                flags(locb) = FLAGS_SHA1MATCH;
            end
        end
    end
    
    % �ҳ�����״̬,�������Ϣ
    temp0 = find(flags == FLAGS_NOFILE)     ;
    temp1 = find(flags == FLAGS_FILEEXIST)  ;
    temp2 = find(flags == FLAGS_SHA1MATCH)  ;

    fid = fopen(outputfile,'w')
    
    fprintf(fid,'SHA1SUM�ļ����ܼ���Ч�ļ�Ӧ�� %d ��,����\n',file_num);
    fprintf(fid,'0.δ�����ļ� %d ��\n',length(temp0));
    if temp0 ~= 0
        fprintf(fid,'�ֱ���\n');
        for ii = 1:length(temp0)
            fprintf(fid,'%s\n',file_str{temp0(ii)});
        end
    end
    fprintf(fid,'1.���ļ���SHA1��֤ʧ�� %d ��  \n',length(temp1));
    if temp1 ~= 0
        fprintf(fid,'�ֱ���\n');
        for ii = 1:length(temp1)
            fprintf(fid,'%s\n',file_str{temp1(ii)});
        end
    end

    fprintf(fid,'2.������У��ɹ�%d��\n',length(temp2));
    fclose(fid);
	
end
