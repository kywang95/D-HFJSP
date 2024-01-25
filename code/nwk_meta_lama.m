function [ final_best_value, final_best_solution,nfe,cput,totalt,trend,Pro_record] = nwk_meta_lama( maxb,data,max_nfe,t0SA )
%% the main function of scatter search algorithm
% nwk_ss_single: The function is mainly coding based on the algorithm in the paper
% "some aspects of scatter search in the folw shop problem"; The initial
% scheme and improvement method have some difference with the basic framework.
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
%% initial stage//diversification_generator
dimension = size(data.Specimen, 2);
popsize = max(20,(dimension*0.05));
data = input_block(data);
% num_block = max(data.Specimen(3,:));
ini_solution = ones(popsize, dimension);
ini_fitness = zeros(1, popsize);
refset = zeros(maxb, dimension);

% % NEH is incorporated using random.
% seed_solution = 1:num_block;
% % it is required to test which permuatation have better performance
% num_RAERsolution = popsize;
% ini_order = intial_order_RAER(seed_solution, num_RAERsolution);
% 
% for i_raer = 1:num_RAERsolution
%     [ini_fitness(i_raer), ini_solution(i_raer,:)] = RAER(data, ini_order(i_raer,:));
% end

for i_raer = 1:popsize
    ini_solution(i_raer, :) = randperm(dimension);
    ini_fitness(i_raer) = COST(ini_solution(i_raer, :), data);
end

%   ini_fitness

%% initial stage//built the initial reference set
[a,b] = sort(ini_fitness);
ref_fitness = a(1:maxb);
for i = 1:maxb
    refset(i,:) = ini_solution(b(i),:);
end
for i = 1:maxb
    dis_recorder(i) = r_distance(refset(1,:),refset(i,:));
end
[dis_s2t,distant_index] = max(dis_recorder);

%% initialization of output results
trend(1) = ref_fitness(1);
% t0=cputime;
% tic;
nfe = popsize;
Pro_record = [];

%% training stage
    %% slecte the subset of refset(referense set)
    starting_point=refset(1,:);
    terminal_point=refset(distant_index,:);
    slct_subset{1}.solution(1,:) = starting_point;
    slct_subset{1}.fitness(1) = ref_fitness(1);
    slct_subset{1}.solution(2,:) = terminal_point;
    slct_subset{1}.fitness(2) = ref_fitness(distant_index);
    
    %% combination based on the path relinking scheme
    [new_solution,new_cost,com_trend] = combination_method(data,trend(end),slct_subset,1);
    trend = [trend,com_trend];
    nfe = nfe + 1;
    
    %% improve the new trail solution in iterated local search
    [new_cost, new_solution, reward, ls_trend,ls_nfe, Pro_record_ls]=local_search_meta_initialization(t0SA, new_cost,new_solution,data,trend(end));
    trend = [trend,ls_trend];
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = ls_nfe + nfe;
    t0SA = 0.9*t0SA;
    
    %% update the refset(referense set)
    refset(distant_index,:) = [];
    ref_fitness(distant_index) = [];
    dis_recorder(distant_index) = [];
    
    if new_cost < ref_fitness(1)
        refset(2:maxb,:) = refset;
        ref_fitness(2:maxb) = ref_fitness;
        refset(1,:) = new_solution;
        ref_fitness(1) = new_cost;
        for i = 1:maxb
            dis_recorder(i) = r_distance(refset(1,:),refset(i,:));
        end
    else
        refset(maxb,:) = new_solution;
        ref_fitness(maxb) = new_cost;
        dis_recorder(maxb) = r_distance(refset(1,:),new_solution);
    end  
    [~,distant_index] = max(dis_recorder);

cput = cputime - t0;
%% iterated section
while cput < max_nfe
    
    %% slecte the subset of refset(referense set)
    terminal_point=refset(distant_index,:);
    slct_subset{1}.solution(1,:) = starting_point;
    slct_subset{1}.fitness(1) = ref_fitness(1);
    slct_subset{1}.solution(2,:) = terminal_point;
    slct_subset{1}.fitness(2) = ref_fitness(distant_index);
    
    %% combination based on the path relinking scheme
    [new_solution,new_cost,com_trend] = combination_method(data,trend(end),slct_subset,1);
%     new_cost
    trend = [trend,com_trend];
    
    popsize = size(new_solution,1);
    new_sol_index = 1;
    
    cput = cputime - t0;
    if cput > max_nfe
        break
    end
    
    %% improve the new trail solution in iterated local search
    [new_cost(new_sol_index),new_solution(new_sol_index,:),reward, ls_trend,ls_nfe, Pro_record_ls] = local_search_meta(t0SA, reward, new_cost(new_sol_index),new_solution(new_sol_index,:),data,trend(end),Pro_record_ls(3:end, end));
%     new_cost
    trend = [trend,ls_trend];
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
%     Pro_record_ls(2:end,end)
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = ls_nfe + nfe;
    t0SA = 0.9*t0SA;
    
    %% update the refset(referense set)
    refset(distant_index,:) = [];
    ref_fitness(distant_index) = [];
    dis_recorder(distant_index) = [];
    
    if new_cost(new_sol_index) < ref_fitness(1)
        refset(2:maxb,:) = refset;
        ref_fitness(2:maxb) = ref_fitness;
        refset(1,:) = new_solution(new_sol_index,:);
        ref_fitness(1) = new_cost(new_sol_index);
        for i = 1:maxb
            dis_recorder(i) = r_distance(refset(1,:),refset(i,:));
        end
    else
        refset(maxb,:) = new_solution(new_sol_index,:);
        ref_fitness(maxb) = new_cost(new_sol_index);
        dis_recorder(maxb) = r_distance(refset(1,:),new_solution(new_sol_index,:));
    end
    
    [dis_s2t,distant_index] = max(dis_recorder);
    %     if dis_s2t<maxd
    %         break
    %     end
%     if length(trend)>10000 && (trend(end-10000)==trend(end))
%         break
%     end
    cput = cputime - t0;
end

final_best_value = ref_fitness(1);
final_best_solution = refset(1,:);
cput = cputime-t0;
totalt = toc;
end
