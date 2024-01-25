 function [endvalue, endsolution, reward, ls_trend, nfe, Pro_record_ls]=local_search_meta_initialization(t0SA, startvalue,startsolution,data,bestsf)
% local_search normal local search operator with simulated annealing
%  input_args:  t0SA        , the tempurature of simulated annealing
%              startvalue   , the cost function of start point
%              startsolution, the start point in search process of local_search_sa
%              data         , the process_time matrix and the number of job and machine of one given problem
% output_args: endvalue     , the terminal solution  in search process of local_search_sa
%              endsolution  , the cost function of terminal point
%              nfels        , the number of evualation

method_num = 4;
iteration = max(data.Specimen(3,:));
% c = 0.8;
nfe = 0;
ls_trend = zeros(1, iteration*method_num);
method_cost = zeros(method_num, 1);
method_solution = zeros(method_num, size(startsolution,2));
reward = zeros(method_num, 1);
probability = zeros(method_num, 1);
for method_No = 1:method_num
    gbestval = startvalue;
    temp_solution = startsolution;
    nfels = 0;
    while nfels < iteration
    switch method_No
        case 1
            solution = inverse(temp_solution,data);
        case 2
            solution = insert(temp_solution,data);
        case 3
            solution = swap(temp_solution,data);
        case 4
            solution = insert_block(temp_solution,data);
    end
    temp_cost = COST(solution,data);
    nfels = nfels + 1;
    % updata the gbest
    if temp_cost > gbestval
        if min(1,exp((gbestval-temp_cost)/t0SA)) > rand
            temp_solution = solution;
        end
    else
        gbestval = temp_cost;
        temp_solution = solution;
    end    
    bestsf = min(gbestval,bestsf);
    nfe = nfe + 1;
    ls_trend(nfe) = bestsf;
    end
    method_solution(method_No,:) = temp_solution;
    method_cost(method_No) = temp_cost;
end

reward = abs(method_cost-startvalue)/nfels;
% compute the accumulating probability of each neighborhood
% [~, tmpb] = sort(-reward);
% probability(tmpb) = c * (1-c) .^((1:method_num) - 1)
probability = reward./sum(reward);
% at this moment, nfe = iteration * method_num;
Pro_record_ls = [nfe; 0; probability];
[Evalue, I] = sort(method_cost);
endvalue = Evalue(1);
endsolution = method_solution(I(1),:);
