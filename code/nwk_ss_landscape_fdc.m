function [ dis_opt,dif_opt, fdc, trend] = nwk_ss_landscape_fdc( maxb,data,max_nfe,t0SA,method )
%% the main function of fdc
%
%% initial stage//diversification_generator
data = input_block(data);
i_fdc=0;
dimension = size(data.Specimen, 2);
num_block = max(data.Specimen(3,:));
popsize=max(20,(dimension*0.05));
ini_solution=ones(popsize,dimension);
ini_fitness=zeros(1,popsize);
refset=zeros(maxb,dimension);

seed_solution=1:num_block;
% it is required to test which permuatation have better performance
num_RAERsolution=popsize;
ini_order = intial_order_RAER(seed_solution,num_RAERsolution);

for i_raer=1:num_RAERsolution
    [ini_fitness(i_raer),ini_solution(i_raer,:)] = RAER(data, ini_order(i_raer,:));
end

%  ini_fitness

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
trend(1) = ref_fitness(1);
nfe=1; 
ac=0;
probability = ones(4,1)./4;
Pro_record_ls = [nfe; 0; probability];
Pro_record = Pro_record_ls;

i_fdc = i_fdc+1;
solution_fdc{i_fdc,:} =  refset(1,:);
cost_fdc(i_fdc) = trend(1);

%% iterated section
while nfe < max_nfe
    %% select the subset of refset(referense set)
    starting_point=refset(1,:);
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
    
    Dim = size(new_solution,2);
    for new_sol_index = 1:popsize
            iteration = 0;
        while iteration < Dim
        %% improve the new trail solution in iterated local search
         nrand_walk = popsize; % for FDC
        if method == 5
            [new_cost(new_sol_index), new_solution(new_sol_index,:), ls_trend, ls_nfe, Pro_record_ls, ~, ~] = ite_lsmeta_ac(t0SA,new_cost(new_sol_index),new_solution(new_sol_index,:),data,trend(end),Pro_record_ls(3:end, end), nrand_walk);
            Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
            Pro_record = [Pro_record, Pro_record_ls];
        elseif method <= 4 && method >= 1
            [new_cost(new_sol_index), new_solution(new_sol_index,:), ls_trend, ls_nfe, ~] = ite_lssa_ac(t0SA,new_cost(new_sol_index),new_solution(new_sol_index,:),data,trend(end),nrand_walk,method);
        end
        trend = [trend,ls_trend];
        t0SA = 0.9*t0SA;
        nfe = ls_nfe + nfe;
        iteration = iteration + ls_nfe;
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
            dis_recorder(maxb) = r_distance(refset(1,:), new_solution(new_sol_index,:));
        end
        end
        i_fdc = i_fdc+1;
        solution_fdc{i_fdc} = new_solution(new_sol_index,:);
        cost_fdc(i_fdc) = new_cost(new_sol_index);
    end
end
final_best_value = ref_fitness(1);
final_best_solution = refset(1,:);

%% calculate fdc
dis_opt = zeros(size(cost_fdc)); 
dif_opt = zeros(size(cost_fdc));
for ijk = 1:i_fdc
    dis_opt(ijk) = r_distance(solution_fdc{ijk}, final_best_solution);
    dif_opt(ijk) = cost_fdc(ijk) - final_best_value;
end
fdc = corr(dis_opt',dif_opt');


