function [ final_best_value, final_best_solution,nfe,cput,totalt,trend] =nwk_sa( maxb,data,max_nfe,maxd,t0SA,method )
%% the main function of simulated annealing - ablation study
%input_args :maxb          , the maximum number of the primal reference set;
%            data          , the machine property cell and the job property vector
% data.m = m; data.c = c; data.t = t;  S = Specimen(1,:); Type = Specimen(2,:);
% data.Specimen = Specimen;
%            max_nfe       , the maximum iteration in the process of search
%            maxd          , the terminal condition on the maximum distance

%output_args:final_best_value    , the best cost function valueof proposed solutions
%            final_best_solution , the best solutions in the context of tested problem
%            nfe                 , the total number of evaluation
%            cput and totalt     , the value on the elapsed time
%            trend               ,the converage line
%
t0=cputime;
tic;
%% initial stage
data = input_block(data);
dimension = size(data.Specimen, 2);

ini_solution = randperm(dimension);
ini_fitness = COST(ini_solution, data);

%% initialization of output results
trend(1) = ini_fitness;
nfe = 1;
new_solution = ini_solution;
new_cost = ini_fitness;

cput = cputime - t0;
%% iterated section
while cput < max_nfe
    %% improve the new trail solution in iterated local search
    [new_cost,new_solution,ls_trend,ls_nfe] = local_search_sa(t0SA,new_cost,new_solution,data,trend(end),method);
    %     new_cost
    trend = [trend,ls_trend];
    
    t0SA = 0.9*t0SA;
    nfe = ls_nfe + nfe;
    cput = cputime - t0;
    
%     if length(trend)>5000 && (trend(end-5000)==trend(end))
%         break
%     end
end

final_best_value = new_cost;
final_best_solution = new_solution;
cput = cputime-t0;
totalt = toc;
end
