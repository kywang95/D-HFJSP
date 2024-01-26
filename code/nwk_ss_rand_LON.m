function  [final_best_value, final_best_solution, cost, solution] =  nwk_ss_rand_LON( data,t0SA,method )
%% the main function of scatter search algorithm
% nwk_ss_single: The function is mainly coding based on the algorithm in the paper
%"some aspects of scatter search in the folw shop problem"; The initial
%scheme and improvement method have some difference with the basic framework.
%input_args :maxb          , the maximum number of the primal reference set;
%            data          , the machine property cell and the job property vector
% data.m = m; data.c = c; data.t = t;  S = Specimen(1,:); Type = Specimen(2,:);
% data.tran = tran; data.DD = DD; data.Specimen = Specimen;
%            max_nfe       , the maximum iteration in the process of search
%            maxd          , the terminal condition on the maximum distance

%output_args:final_best_value    , the best cost function valueof proposed solutions
%            final_best_solution , the best solutions in the context of tested problem
%            cost                , the fitness value of the local optima
%            solution            , the solution of the local optima
%            trend               , the converage line
%
%% initial stage//diversification_generator
data = input_block(data);
solution = [];
cost = [];
nfe = 0;

%% initial stage//built the initial reference set
new_solution = randperm(size(data.Specimen, 2));
new_cost = COST(new_solution, data);
trend = new_cost;
solution = [solution; new_solution];
cost = [cost; new_cost];


[new_cost, new_solution,ls_trend,ls_nfe] = ite_ls_operator(t0SA, new_cost,new_solution, data,trend(end), method);
trend = [trend,ls_trend];
solution = [solution; new_solution];
cost = [cost; new_cost];

while nfe < 1000 % 10000
    %% improve the new trail solution in iterated local search
  [new_cost, new_solution,ls_trend,ls_nfe] = ite_ls_operator(t0SA, new_cost,new_solution, data,trend(end), method);
        trend = [trend,ls_trend];
    if sum(new_solution == solution(end,:)) ~= length(new_solution)
        solution = [solution; new_solution];
        cost = [cost; new_cost];
        if cost(end) == cost(end-1)
            nfe = nfe + 1;
        else 
            nfe = 0;
        end
    else
        nfe = nfe + 1;
    end
end
% plot(trend)
final_best_value = new_cost;
final_best_solution = new_solution;
