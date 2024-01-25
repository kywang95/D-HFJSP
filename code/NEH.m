function [cost,tran_solution] = NEH(data)
% NEH heuristic algorithm for Heterogeneous Distributed Scheduling Problem
% input : data, the property of machines and specimens
% output: cost, the makespan of proposed solution
%         all_solution, the final feasible solution

n = size(data.Specimen, 2);
SS0 = data.Specimen(1,:);
S = randperm(length(SS0));
SS = SS0(S);

p = 2;
partical_solution1 = [1,2];
temp_cost1 = COST(partical_solution1, data);
partical_solution2 = [2,1];
temp_cost2 = COST(partical_solution2,data);
if temp_cost1 < temp_cost2
    tran_solution = partical_solution1;
else
    tran_solution = partical_solution2;
end
if p == n
    cost = min(temp_cost1, temp_cost2);
elseif p > n
    error('The amount of specimens is too small for this algorithm!');
end
while p < n
    p = p + 1;
    temp_solution = tran_solution;
    temp_cost = zeros(1, p);
    for insert_position = 1:p
        tran_solution = temp_solution;
        if insert_position == p
            tran_solution(insert_position) = p;
        else
            tran_solution(insert_position) = p;
            tran_solution((insert_position+1):p) = temp_solution(insert_position:(p-1));
        end
        temp_cost(insert_position) = COST(tran_solution, data);
    end
    [cost,index] = min(temp_cost);
    tran_solution = temp_solution;
    if index == p
        tran_solution(index) = p;
    else
        tran_solution(index) = p;
        tran_solution((index+1):p) = temp_solution(index:(p-1));
    end
end
end