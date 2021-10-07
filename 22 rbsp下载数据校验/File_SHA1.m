%{
    File_SHA1: YQW/ 2021.10.07
    计算文件的SHA1值
    输入: filefullpath        文件绝对路径
    输出: h                   SHA-1字符串(默认小写输出)
    参考链接:
    https://blog.csdn.net/COCO56/article/details/106161207
    https://blog.csdn.net/Harbour_zhang/article/details/103084622
%}


function [h] = File_SHA1(filefullpath)

	fid =   fopen(filefullpath,'rb');
	x   =   java.security.MessageDigest.getInstance('SHA-1');
	while 1
	A = fread(fid,1024*1024*8,'uint8');
        if isempty(A)
            break;
        end
        x.update(A);
	end
    fclose(fid);
    h = typecast(x.digest,'uint8');
    h=dec2hex(h)';
    if(size(h,1))==1 % remote possibility: all hash bytes  128, so pad:
        h=[repmat('0',[1 size(h,2)]);h];
    end
    h=lower(h(:)'); %
end

