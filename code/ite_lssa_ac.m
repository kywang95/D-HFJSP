function [endvalue, endsolution, ls_trend, nfesa, cost_ac]=ite_lssa_ac(t0SA,startvalue,startsolution,data,bestsf,nrand_walk,method)
% local_search normal local search operator with simulated annealing
%  input_args:  t0SA        , the tempurature of simulated annealing
%              startvalue   , the cost function of start point
%              startsolution, the start point in search process of local_search_sa
%              data         , the process_time matrix and the number of job and machine of one given problem
% output_args: endvalue     , the terminal solution  in search process of local_search_sa
%              endsolution  , the cost function of terminal point
%              nfesa        , the number of evualation

N = size(data.Specimen, 2);
dim = length(data.Specimen);
gbestval = startvalue;
temp_solution = startsolution;
nfesa = 0;
solution_ac = zeros(nrand_walk,N); 
cost_ac = zeros(nrand_walk,1);
i_walk = 1;

iteration = max(data.Specimen(3,:));
% while nfesa < iteration*(iteration-1)
while nfesa < dim
    for i_walk = 1:nrand_walk
    switch method
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
        nfesa = nfesa+1;        
        % updata the gbest
        if temp_cost > gbestval
            if min(1,exp((gbestval-temp_cost)/t0SA)) > rand
                temp_solution = solution;
            end
        else
            gbestval = temp_cost;
            temp_solution = solution;
        end
        
        bestsf = min(gbestval, bestsf);
        ls_trend(nfesa) = bestsf;
        
        cost_ac(i_walk) = temp_cost;
    end
end 
endsolution = temp_solution;
endvalue = gbestval;