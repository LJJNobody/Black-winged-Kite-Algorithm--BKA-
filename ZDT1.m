% ZDT1目标函数
function [f1, f2] = ZDT1(x)
    f1 = x(:,1);
    g = 1 + 9*sum(x(:,2:end),2)/(size(x,2)-1);
    f2 = g.*(1 - sqrt(f1./g));
end