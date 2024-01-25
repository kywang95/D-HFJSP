function [ final_best_value, final_best_solution,nfe,cput,trend,Pro_record] = nwk_HH_RL_power_SA( data,max_nfe,MaxLLH,t0SA )
%% the main function of HyperHeuristics which start from random initialization
%input_args :maxb          , the maximum number of the primal reference set;
%            data          , the machine property cell and the job property vector
% data.m = m; data.c = c; data.t = t;  S = Specimen(1,:); Type = Specimen(2,:);
% data.tran = tran; data.DD = DD; data.Specimen = Specimen;
%            max_nfe       , the maximum iteration in the process of search
%            maxd          , the terminal condition on the maximum distance

%output_args:final_best_value    , the best cost function valueof proposed solutions
%            final_best_solution , the best solutions in the context of tested problem
%            nfe                 , the total number of evaluation
%            cput and totalt     , the value on the elapsed time
%            trend               ,the converage line
%
t0=cputime;
%% initial stage
data = input_block(data);
dimension = size(data.Specimen, 2);

ini_solution = randperm(dimension);
ini_fitness = COST(ini_solution,data);

gbestval = ini_fitness;
gbestsolution = ini_solution;
solution = ini_solution;

%% initialization of output results
trend(1) = ini_fitness;
nfe = 1;
Pro_record = [];

cput = cputime - t0;
%% iterated section
utility = ones(MaxLLH, 1);
while cput < max_nfe
    %% improve the new trail solution in iterated local search
    bestsf = trend(end);
    Pro_record_ls = [];
    method_No = randsample(find(utility == max(utility)), 1);

    nfels = 0;
%     iteration = max(data.Specimen(3,:));
    while nfels < 1 % min( iteration*(iteration-1), 2500)
         switch method_No
            case 1
                temp_solution = inverse(solution,data);
            case 2
                temp_solution = insert(solution,data);
            case 3
                temp_solution = swap(solution,data);
            case 4
                temp_solution = insert_block(solution,data);
        end
        temp_cost = COST(temp_solution,data);
        nfels = nfels + 1;
        
        % Move Acceptance - Simulated Annealing
        % updata the gbest
        if temp_cost < gbestval
            gbestval = temp_cost;
            solution = temp_solution; 
            if utility(method_No) > 1
                utility(method_No) = utility(method_No)*utility(method_No);
            else
                utility(method_No) = 2;
            end
        else
            if min(1,exp((gbestval-temp_cost)/t0SA)) > rand
                solution = temp_solution;
            end
            utility(method_No) = sqrt(utility(method_No));
        end
        bestsf = min(gbestval,bestsf);
        ls_trend(nfels) = bestsf;
    end
    
    record = [nfels; method_No; utility];
    Pro_record_ls = [Pro_record_ls, record];
    ls_nfe = nfels;
    
    % update the temperature
    t0SA = 0.9*t0SA;
    
    trend = [trend,ls_trend];
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = ls_nfe + nfe;
    cput = cputime - t0;
end
final_best_value = gbestval;
final_best_solution = gbestsolution;
cput = cputime-t0;
end
