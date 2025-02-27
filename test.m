clear
clc
close all

pop_size=1000;
gen_size=30;
% 生成理论Pareto前沿
pf=generateParetoFront("zdt1",pop_size);

% 运行算法并绘制结果
pop = rand(pop_size,gen_size); % 随机生成种群（决策变量）
[f1, f2] = ZDT("zdt1",pop);
[ranks, fronts] = fastNonDominatedSorting([f1, f2]);

scatter(pf(:,1), pf(:,2), 'k.'); hold on;
scatter(f1(ranks==1), f2(ranks==1), 'ro');
xlabel("f1"),ylabel("f2");
legend('True PF', 'Algorithm F1');