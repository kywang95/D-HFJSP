function [ final_best_value, final_best_solution,nfe,cput,trend,Pro_record] = nwk_HH_RPD_GDEL( data,max_nfe,MaxLLH )
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
phase = 1;
selectPhase = 0;
while cput < max_nfe
    %% improve the new trail solution in iterated local search
    bestsf = trend(end);
    Pro_record_ls = [];
    method_No = mod(selectPhase, MaxLLH) + 1;

    nfels = 0;
    iteration = max(data.Specimen(3,:));
    while nfels < min( iteration*(iteration-1), 2500)
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
        
        % Move Acceptance - Great Deluge (GDEL) Move Acceptance
        % updata the gbest
        if temp_cost > gbestval
            if temp_cost < (1 + 0.85^(phase-1)) * gbestval
                solution = temp_solution;
            end
        else
            solution = temp_solution;
            gbestval = temp_cost;
            gbestsolution = temp_solution; 
        end
        bestsf = min(gbestval,bestsf);
        ls_trend(nfels) = bestsf;
    end
    
    
    record = [nfels; method_No];
    Pro_record_ls = [Pro_record_ls, record];
    ls_nfe = nfels;
    
    % update the phase
    phase = phase + 1;
    
    trend = [trend,ls_trend];
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = ls_nfe + nfe;
    cput = cputime - t0;
    
    selectPhase = selectPhase + 1;    
end
final_best_value = gbestval;
final_best_solution = gbestsolution;
cput = cputime-t0;
end
