function pf = generateParetoFront(problem, num_points)
% 生成理论Pareto前沿
% num_points: 采样点数量（默认100）

if nargin < 2, num_points = 100; end

switch lower(problem)
    case {'zdt1', 'zdt2', 'zdt3', 'zdt4', 'zdt6'}
        f1 = linspace(0, 1, num_points)';
        if strcmpi(problem, 'zdt1')
            h = 1 - sqrt(f1);
        elseif strcmpi(problem, 'zdt2')
            h = 1 - f1.^2;
        elseif strcmpi(problem, 'zdt3')
            h = 1 - sqrt(f1) - f1.*sin(10*pi*f1);
        elseif strcmpi(problem, 'zdt4')
            h = 1 - sqrt(f1);
        elseif strcmpi(problem, 'zdt6')
            h = 1 - f1.^2;
        end
        pf = [f1, h];
        
    otherwise
        error('未实现该问题的Pareto前沿');
end
end