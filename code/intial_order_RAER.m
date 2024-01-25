function [ini_order] = intial_order_RAER(seed_solution,upper_bound)
% to generate a set of diverse solutions based on the input permuatation
% input : seed_solution, the seed solution of diversification generator
%         upper_bound  , the upper bound of diversification generator
% output: ini_order    , a collection of random solutions for RAER
% heuristic

dimension = length(seed_solution);
t = ceil(dimension*0.5);
clct_solution = zeros(max(upper_bound,t),dimension);
for index_i = 1:t
    r = ceil(dimension/index_i);
    lni = dimension-(r-1)*index_i;
    temp_p = [];
    for index_j = index_i:(-1):1
        temp_pp = [];
        if lni < index_j
            bound_r = r-1;
        else
            bound_r = r;
        end
        
        for index_r = 1:bound_r
            temp_pp(index_r) = index_j + (index_r-1) * index_i;
        end
        
        temp_p = [temp_p,temp_pp];
    end
    for change_index = 1:dimension
        clct_solution(index_i,change_index) = seed_solution(temp_p(change_index));
    end
end
if upper_bound > t
    for i = 1:(upper_bound-t)
        clct_solution(t+i,:) = randperm(dimension);
    end
end

sel_num1 = floor(t/upper_bound);
if sel_num1 == 0
    ini_order = clct_solution;
elseif sel_num1 == 1
    ran_se = randperm(t,upper_bound);
    for i_ran_se = 1:upper_bound
        ini_order(i_ran_se,:) = clct_solution(ran_se(i_ran_se),:);
    end
else
    sel_num2 = randi(sel_num1);
    for i_ran_se = 1:upper_bound
        ini_order(i_ran_se,:) = clct_solution((sel_num2-sel_num1+i_ran_se*sel_num1),:);
    end
    end
end
        




        
            
        