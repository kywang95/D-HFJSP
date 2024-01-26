function [endvalue, endsolution,ls_trend, nfels, Pro_record_ls, method_No,cost_ac] = ite_lsmeta_ac(t0SA,startvalue,startsolution,data,bestsf, probability, nrand_walk)
% local_search normal local search operator with simulated annealing
%  input_args:  t0SA        , the tempurature of simulated annealing
%              startvalue   , the cost function of start point
%              startsolution, the start point in search process of local_search_sa
%              data         , the process_time matrix and the number of job and machine of one given problem
% output_args: endvalue     , the terminal solution  in search process of local_search_sa
%              endsolution  , the cost function of terminal point
%              nfels        , the number of evualation
dim = size(data.Specimen, 2);
gbestval = startvalue;
temp_solution = startsolution;
nfels = 0;
Pro_record_ls = [];
M = length(probability);
% iteration=length(data.Specimen);
iteration = max(data.Specimen(3,:));
solution_ac = zeros(nrand_walk,dim);
cost_ac = zeros(nrand_walk,1);
i_walk = 1;

% for i=1:dim*(dim-1)
method_No = Roulette( probability, 1 );
% while nfels < iteration*(iteration-1)
while nfels < dim
    for i_walk = 1:nrand_walk
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
        ls_trend(nfels) = bestsf;
        record = [nfels; method_No; probability];
        Pro_record_ls = [Pro_record_ls, record];
        cost_ac(i_walk) = temp_cost;
    end
end
if bestsf < startvalue
    %     (bestsf/gbestval) * (startvalue-gbestval)/(iteration*(iteration-1))
    probability(method_No) = probability(method_No) * ( abs(startvalue-bestsf) * nfels / startvalue + 1 );
    probability = probability./sum(probability);
end
record = [nfels; method_No; probability];
Pro_record_ls = [Pro_record_ls, record];
endsolution = temp_solution;
endvalue = bestsf;