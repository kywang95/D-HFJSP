function [ final_best_value, final_best_solution, cput, totalt] = nwk_heuristic_NEHB_cput(maxb,data,max_nfe)
%% the main function of NEH-B - ablation study
%input_args :maxb          , the maximum number of the primal reference set;
%            data          , the machine property cell and the job property vector
% data.m = m; data.c = c; data.t = t;  S = Specimen(1,:); Type = Specimen(2,:);
% data.Specimen = Specimen;

%output_args:final_best_value    , the best cost function valueof proposed solutions
%            final_best_solution , the best solutions in the context of tested problem
%            nfe                 , the total number of evaluation
%            cput and totalt     , the value on the elapsed time
%            trend               ,the converage line
%
t0=cputime;
tic;

maxb = 100000;

%% initial stage//diversification_generator
data = input_block(data);
dimension = size(data.Specimen, 2);
num_block = max(data.Specimen(3,:));
popsize = maxb; % max(20,(dimension*0.05));
ini_solution = []; % ones(popsize,dimension);
ini_fitness = []; % zeros(1,popsize);
% refset = zeros(maxb,dimension);

seed_solution = 1:num_block;
% it is required to test which permuatation have better performance
num_RAERsolution = popsize;
ini_order = intial_order_RAER(seed_solution, num_RAERsolution);

for i_raer = 1:num_RAERsolution
    
    solution = ini_order(i_raer,:);
    n = length(solution);
    SS0 = data.Specimen(1,:);
    BS0 = data.Specimen(3,:);
    S = randperm(length(SS0));
    SS = SS0(S);
    BS = BS0(S);
    
    p = 2;
    partical_solution1 = [1,2];
    all_solution1 = [SS(BS==solution(1)),SS(BS==solution(2))];
    temp_cost1 = COST(all_solution1, data);
    partical_solution2 = [2,1];
    all_solution2 = [SS(BS==solution(2)),SS(BS==solution(1))];
    temp_cost2 = COST(all_solution2,data);
    if temp_cost1 < temp_cost2
        tran_solution = partical_solution1;
        all_solution = all_solution1;
    else
        tran_solution = partical_solution2;
        all_solution = all_solution2;
    end
    if p == n
        cost = min(temp_cost1, temp_cost2);
    elseif p > n
        error('The amount of specimens is too small for this algorithm!');
    end
    while p < n
        cput = cputime - t0;
        if cput > max_nfe
            tran_solution = [tran_solution, randperm(n-p)+p];
            all_solution = [];
            for i=1:length(tran_solution)
                all_solution = [all_solution SS(BS==(solution(tran_solution(i))))];
            end
            cost = COST(all_solution, data);
            ini_fitness = [ini_fitness, cost];
            ini_solution = [ini_solution; all_solution];
            break
        end
        p = p + 1;
        temp_solution = tran_solution;
        temp_all_solution = all_solution;
        temp_cost = zeros(1, p);
        for insert_position = 1:p
            tran_solution = temp_solution;
            if insert_position == p
                tran_solution(insert_position) = p;
            else
                tran_solution(insert_position) = p;
                tran_solution((insert_position+1):p) = temp_solution(insert_position:(p-1));
            end
            temp_all_solution = [];
            for i=1:length(tran_solution)
                temp_all_solution = [temp_all_solution SS(BS==(solution(tran_solution(i))))];
            end
            temp_cost(insert_position) = COST(temp_all_solution, data);
        end
        [cost,index] = min(temp_cost);
        tran_solution = temp_solution;
        if index == p
            tran_solution(index) = p;
            all_solution = [];
            for i=1:length(tran_solution)
                all_solution = [all_solution SS(BS==(solution(tran_solution(i))))];
            end
        else
            tran_solution(index) = p;
            tran_solution((index+1):p) = temp_solution(index:(p-1));
            all_solution = [];
            for i=1:length(tran_solution)
                all_solution = [all_solution SS(BS==(solution(tran_solution(i))))];
            end
        end
    end
    % end
    % ini_fitness(i_raer) = cost;
    % ini_solution(i_raer,:) = all_solution;
    ini_fitness = [ini_fitness, cost];
    ini_solution = [ini_solution; all_solution];
    
    cput = cputime - t0;
    if cput > max_nfe
        break
    end
end

%  ini_fitness

%% initial stage//built the initial reference set
[a,b] = sort(ini_fitness);
ref_fitness = a; % (1:maxb)
refset = [];
for i = 1:length(a)
%     refset(i,:) = ini_solution(b(i),:);
    refset = [refset; ini_solution(b(i),:)];
end

%% output results

final_best_value = ref_fitness(1);
final_best_solution = refset(1,:);
cput = cputime-t0;
totalt = toc;
end

