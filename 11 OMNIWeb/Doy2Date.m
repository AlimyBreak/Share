% Doy2Date: ��һ���е�ĳһ��(��1��1����)���������
% [month_of_doy, day_of_doy] = Doy2Date(year, doy)
% ����
% year         : doy��Ӧ�����
% doy          : һ���еĵڼ���(��1��1����)
% ���
% month_of_doy : doy��Ӧ����
% day_of_doy   : doy��Ӧ����

% �㷨˼�룺���ж������ƽ��,����2��29��,ƽ��2��28��.
%          ÿ�����������ۼ�,ֱ�����ڵ���doy,��Ϊdoy������
%          doy��ȥ��ǰ�·�֮ǰ�����·ݵ��������ǵ�ǰ���еĵڼ���.

% author : TSC
% time   : 2016-12-17
% email  : 292936085#qq.com(��#�滻Ϊ@)

function [month_of_doy, day_of_doy] = Doy2Date(year, doy)
month1  = 31;
month3  = 31;
month5  = 31;
month7  = 31;
month8  = 31;
month10 = 31;
month12 = 31;
month4  = 30;
month6  = 30;
month9  = 30;
month11 = 30;

% ���ж������ƽ��
% ��������������4������Ϊ����,������������400������Ϊ��
if (0 ~= mod(year, 100) && 0 == mod(year, 4)) || 0 == mod(year, 400) 
    month2 = 29;
else
    month2 = 28;
end

% �ϲ������·�
month_merge = [];
for imonth = 1 : 12
    month_merge = [month_merge, eval(strcat('month', num2str(imonth)))];
end

for imonth = 1 : 12
    if doy < 1
        disp('doy����ȷ��ΧӦ��Ϊ1��365/366��ƽ��365������366��');
        month_of_doy = NaN;
        day_of_doy   = NaN;
        break;
    end
    % ÿ�����������ۼ�,ֱ�����ڵ���doy,i��Ϊdoy������
    if sum(month_merge(1:imonth)) >= doy             
        month_of_doy = imonth;
        days_before  = sum(month_merge(1:imonth-1));
        % doy��ȥ��ǰ�·�֮ǰ�����·ݵ��������ǵ�ǰ���еĵڼ���.
        day_of_doy   = doy - days_before;            
        break;
    elseif 12 == imonth
        disp('doy����ȷ��ΧӦ��Ϊ1��365/366��ƽ��365������366��');
        month_of_doy = NaN;
        day_of_doy   = NaN;
        break;
    end
end

