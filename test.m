clear
clc
close all

% 生成理论Pareto前沿
x = linspace(0,1,100)';
pf = [x, 1 - sqrt(x)];

% 运行算法并绘制结果
pop = rand(100,30); % 随机生成种群（决策变量）
[f1, f2] = ZDT1(pop);
[ranks, fronts] = fastNonDominatedSorting([f1, f2]);

scatter(pf(:,1), pf(:,2), 'k.'); hold on;
scatter(f1(ranks==1), f2(ranks==1), 'ro');
legend('True PF', 'Algorithm F1');