function [ final_best_value, final_best_solution,nfe,cput,totalt,trend,Pro_record] = nwk_fta_meta( data,max_nfe,t0SA )
%% the main function of meta-Lamarckian equiped with fixed temperature algorithm start from random initialization
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
tic;
%% initial stage
data = input_block(data);
dimension = size(data.Specimen, 2);

ini_solution = randperm(dimension);
ini_fitness = COST(ini_solution,data);

%% initialization of output results
trend(1) = ini_fitness;
nfe = 1;
new_solution = ini_solution;
new_cost = ini_fitness;
Pro_record = [];

%% training stage
    
    %% improve the new trail solution in iterated local search
    [new_cost, new_solution, reward, ls_trend,ls_nfe, Pro_record_ls]= ...
        local_search_meta_initialization(t0SA, new_cost,new_solution,data,trend(end));
    trend = [trend,ls_trend];
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = ls_nfe + nfe;
%     t0SA = 0.9*t0SA;
cput = cputime - t0;
%% iterated section
while cput < max_nfe  
    %% improve the new trail solution in iterated local search
    [new_cost,new_solution,reward, ...
        ls_trend,ls_nfe, Pro_record_ls] = local_search_meta(t0SA, ...
        reward, new_cost,new_solution, ...
        data,trend(end),Pro_record_ls(3:end, end));
%     new_cost
    trend = [trend,ls_trend];
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
%     Pro_record_ls(2:end,end)
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = ls_nfe + nfe;
%     t0SA = 0.9*t0SA;
cput = cputime - t0;
end

final_best_value = new_cost;
final_best_solution = new_solution;
cput = cputime-t0;
totalt = toc;
end
