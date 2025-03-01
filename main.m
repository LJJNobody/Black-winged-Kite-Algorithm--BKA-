% Developed in MATLAB R2022b
% Source codes 
% _____________________________________________________
clear  
clc
close all

%% 
pop_size=1000; % Number of search agents
T=500; % Maximum numbef of iterations
F_name='zdt1'; % Name of the test function
%% 
%for i=1:30
[lb,ub,dim,fobj]=Functions_details(F_name);% Load details of the selected benchmark function
[Best_Pos,Best_Fit]=BKA(pop_size,T,lb,ub,dim,fobj);

pf=generateParetoFront(F_name,pop_size);
scatter(pf(:,1), pf(:,2), 'k.'); hold on;
scatter(Best_Fit(:,1), Best_Fit(:,2), 'ro');
xlabel("f1"),ylabel("f2");
legend('True PF', 'Algorithm F1');




