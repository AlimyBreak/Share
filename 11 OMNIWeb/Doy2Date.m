% Doy2Date: 把一年中的某一天(从1月1日起)换算成日期
% [month_of_doy, day_of_doy] = Doy2Date(year, doy)
% 输入
% year         : doy对应的年份
% doy          : 一年中的第几天(从1月1日起)
% 输出
% month_of_doy : doy对应的月
% day_of_doy   : doy对应的日

% 算法思想：先判断闰年和平年,闰年2月29天,平年2月28天.
%          每月天数依次累加,直到大于等于doy,即为doy所在月
%          doy减去当前月份之前完整月份的天数就是当前月中的第几天.

% author : TSC
% time   : 2016-12-17
% email  : 292936085#qq.com(将#替换为@)

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

% 先判断闰年和平年
% 非整百年数除以4，无余为闰年,整百年数除以400，无余为闰
if (0 ~= mod(year, 100) && 0 == mod(year, 4)) || 0 == mod(year, 400) 
    month2 = 29;
else
    month2 = 28;
end

% 合并所有月份
month_merge = [];
for imonth = 1 : 12
    month_merge = [month_merge, eval(strcat('month', num2str(imonth)))];
end

for imonth = 1 : 12
    if doy < 1
        disp('doy的正确范围应该为1到365/366（平年365，闰年366）');
        month_of_doy = NaN;
        day_of_doy   = NaN;
        break;
    end
    % 每月天数依次累加,直到大于等于doy,i即为doy所在月
    if sum(month_merge(1:imonth)) >= doy             
        month_of_doy = imonth;
        days_before  = sum(month_merge(1:imonth-1));
        % doy减去当前月份之前完整月份的天数就是当前月中的第几天.
        day_of_doy   = doy - days_before;            
        break;
    elseif 12 == imonth
        disp('doy的正确范围应该为1到365/366（平年365，闰年366）');
        month_of_doy = NaN;
        day_of_doy   = NaN;
        break;
    end
end

