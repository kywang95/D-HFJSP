function [ final_best_value, final_best_solution,cost, solution] = nwk_ss_LON( maxb,data,t0SA,method )
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
%            nfe                 , the total number of evaluation
%            cput and totalt     , the value on the elapsed time
%            trend               ,the converage line
%
%% initial stage//diversification_generator
data = input_block(data);
dimension = size(data.Specimen, 2);
num_block = max(data.Specimen(3,:));
popsize=max(20,(dimension*0.05));
ini_solution=ones(popsize,dimension);
ini_fitness=zeros(1,popsize);
refset=zeros(maxb,dimension);
cost = [];
solution = [];

%% REAR/NEH based diversification generator
seed_solution=1:num_block;
% it is required to test which permuatation have better performance
num_RAERsolution=popsize;
ini_order = intial_order_RAER(seed_solution,num_RAERsolution);

for i_raer=1:num_RAERsolution
    [ini_fitness(i_raer),ini_solution(i_raer,:)] = RAER(data, ini_order(i_raer,:));
end

%% initial stage//built the initial reference set
[a,b] = sort(ini_fitness);
ref_fitness = a(1:maxb);
for i=1:maxb
    refset(i,:) = ini_solution(b(i),:);
end
for i=1:maxb
    dis_recorder(i) = r_distance(refset(1,:),refset(i,:));
end
[dis_s2t, distant_index] = max(dis_recorder);

%% initialization of output results
nfe = 0;
%% slecte the subset of refset(referense set)
starting_point=refset(1,:);
terminal_point=refset(distant_index,:);
slct_subset{1}.solution(1,:) = starting_point;
slct_subset{1}.fitness(1) = ref_fitness(1);
slct_subset{1}.solution(2,:) = terminal_point;
slct_subset{1}.fitness(2) = ref_fitness(distant_index);
%% combination based on the path relinking scheme
[new_solution, new_cost, ~] = combination_method(data,ref_fitness(1),slct_subset,1);
trend = new_cost;
%% improve the new trail solution in iterated local search
[new_cost, new_solution,ls_trend,ls_nfe] = ite_ls_operator(t0SA, new_cost,new_solution, data,trend(end), method);
trend = [trend,ls_trend];
solution = [solution; new_solution];
cost = [cost; new_cost];
while nfe < 1000 % 10000
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
