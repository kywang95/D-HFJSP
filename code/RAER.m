function [cost,all_solution] = RAER(data, r_sequence)
% NEH heuristic algorithm for Heterogeneous Distributed Scheduling Problem
% input : data, the property of machines and specimens
%       : r_sequence, the random initial sequence
% output: cost, the makespan of proposed solution
%         all_solution, the final feasible solution

solution = r_sequence;
n = length(solution);
SS0 = data.Specimen(1,:);
BS0 = data.Specimen(3,:);
S = randperm(length(SS0));
SS = SS0(S);
BS = BS0(S);

p = 2;
partical_solution1 = [1,2];
all_solution1 = [SS(BS==solution(1)),SS(BS==solution(2))];
temp_cost1 = COST(all_solution1, data);
partical_solution2 = [2,1];
all_solution2 = [SS(BS==solution(2)),SS(BS==solution(1))];
temp_cost2 = COST(all_solution2,data);
if temp_cost1 < temp_cost2
    tran_solution = partical_solution1;
    all_solution = all_solution1;
else
    tran_solution = partical_solution2;
    all_solution = all_solution2;
end
if p == n
    cost = min(temp_cost1, temp_cost2);
elseif p > n
    error('The amount of specimens is too small for this algorithm!');
end
while p < n
    p = p + 1;
    temp_solution = tran_solution;
    temp_all_solution = all_solution;
    temp_cost = zeros(1, p);
    for insert_position = 1:p
        tran_solution = temp_solution;
        if insert_position == p
            tran_solution(insert_position) = p;
        else
            tran_solution(insert_position) = p;
            tran_solution((insert_position+1):p) = temp_solution(insert_position:(p-1));
        end
        temp_all_solution = [];
        for i=1:length(tran_solution)
        temp_all_solution = [temp_all_solution SS(BS==(solution(tran_solution(i))))];
        end
        temp_cost(insert_position) = COST(temp_all_solution, data);
    end
    [cost,index] = min(temp_cost);
    tran_solution = temp_solution;
    if index == p
        tran_solution(index) = p;
        all_solution = [];
        for i=1:length(tran_solution)
        all_solution = [all_solution SS(BS==(solution(tran_solution(i))))];
        end
    else
        tran_solution(index) = p;
        tran_solution((index+1):p) = temp_solution(index:(p-1));
        all_solution = [];
        for i=1:length(tran_solution)
        all_solution = [all_solution SS(BS==(solution(tran_solution(i))))];
        end
    end
end
end