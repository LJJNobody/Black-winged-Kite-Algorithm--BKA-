function crowding_distance = calculate_crowding_distance(fitness)
    % 输入: fitness - 适配度数组, 维度为 n*dim
    % 输出: crowding_distance - 拥挤度数组, 维度为 n*1

    [n, dim] = size(fitness); % 获取种群个体数量 n 和目标函数个数 dim
    crowding_distance = zeros(n, 1); % 初始化拥挤度数组

    for m = 1:dim % 遍历每个目标函数
        % 获取当前目标函数的最大值和最小值
        f_max = max(fitness(:, m));
        f_min = min(fitness(:, m));
        % 对当前目标函数值进行排序
        [sorted_fitness, sorted_indices] = sort(fitness(:, m));
        
        % 将边界个体的拥挤度设为无穷大
        crowding_distance(sorted_indices(1)) = Inf;
        crowding_distance(sorted_indices(end)) = Inf;

        % 计算中间个体的拥挤度
        for i = 2:n-1
            % 计算拥挤度
            if f_max ~= f_min
                crowding_distance(sorted_indices(i)) = crowding_distance(sorted_indices(i)) + ...
                    (sorted_fitness(i+1) - sorted_fitness(i-1)) / (f_max - f_min);
            end
        end
    end
end