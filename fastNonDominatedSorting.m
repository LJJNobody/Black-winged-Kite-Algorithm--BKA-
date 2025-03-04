function [ranks, fronts] = fastNonDominatedSorting(objValues)
    % 参数说明：
    % objValues - M×N矩阵，M为种群数量，N为目标函数数量
    % 返回值：
    % ranks     - 每个解的等级（前沿序号）
    % fronts    - 包含各前沿解索引的细胞数组
    
    [M, ~] = size(objValues);
    S = cell(M, 1);      % 被解i支配的解集合
    N = zeros(M, 1);     % 支配解i的解数量
    ranks = zeros(M, 1); % 解的等级
    
    % 初始化前沿集合
    fronts = cell(M, 1);
    fronts{1} = [];
    
    % 初始化阶段
    for i = 1:M
        for q = i+1:M
            % 判断支配关系
            if Dominates(objValues(i,:),objValues(q,:))
                S{i} = [S{i}, q];  % i支配q，将q加入S(i)
                N(q)=N(q)+1;
            elseif Dominates(objValues(q,:),objValues(i,:))
                % 检查是否被q支配
                N(i) = N(i) + 1;
                S{q}=[S{q},i];
            end
        end
        if N(i) == 0
            ranks(i) = 1;
            fronts{1} = [fronts{1}, i];
        end
    end
    
    % 主循环阶段
    k = 1;
    while ~isempty(fronts{k})
        Q = [];
        for i = fronts{k}
            for q = S{i}
                N(q) = N(q) - 1;
                if N(q) == 0
                    ranks(q) = k + 1;
                    Q = [Q, q];
                end
            end
        end
        k = k + 1;
        fronts{k} = Q;
    end
    % 清理空的前沿
    fronts = fronts(1:k-1);
end