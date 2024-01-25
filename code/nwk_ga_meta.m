function [final_best_value, final_best_solution, nfe, cput, totalt, tr, Pro_record] = nwk_ga_meta(t0SA, data, P, max_nfe)
%% the main function of genetic algorithm
% nwk_ga: The function is mainly coding based on the GA designed by Wu
% Muh-Cherng COR, 2017, GA for DFJSP
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

% parameter: P = [20, 10, 0.9, 0.9];
popsize = P(1);
generation = P(2);
pm = P(3); % probability of mutation
pc = P(4); % probability of crossover

t0=cputime;
tic;

%% initial stage//diversification_generator
data = input_block(data);
dimension = size(data.Specimen, 2);
ini_solution = ones(popsize, dimension);
ini_fitness = zeros(1, popsize);
refset = zeros(popsize, dimension);

for i_raer = 1:popsize
    ini_solution(i_raer, :) = randperm(dimension);
    ini_fitness(i_raer) = COST(ini_solution(i_raer, :), data);
end

%% initial stage//built the initial reference set
[a, b] = sort(ini_fitness);
ref_fitness = a(1:popsize);
for i = 1:popsize
    refset(i,:) = ini_solution(b(i),:);
end

%% initialization of output results
tr(1:popsize) = ref_fitness(1);
nfe = popsize;
% initialize the gbest
gbest = refset(1, :);
gbestval = ref_fitness(1);
Pro_record = [];

%% training stage
B = Roulette(1./ref_fitness, 2);
while B(1) == B(2)
    B(2) = Roulette(1./ref_fitness, 1);
end
if rand < pc && (dimension > 2)
    newref = crossover(refset(B(1), :), refset(B(2), :));
    
    %evaluation
    for j_pos = 1:2
        newval = COST(newref(j_pos, :), data);
        
        if newval < ref_fitness(B(j_pos))
            refset(B(j_pos), :) = newref(j_pos, :);
            ref_fitness(B(j_pos)) = newval;
        end
        if newval < gbestval
            gbestval = newval;
            gbest = newref(j_pos, :);
        end
        
        nfe = nfe + 1;
        tr(nfe) = gbestval;
    end
end
%===================================================
%using SA local search mechanism
j_pos = datasample(1:2, 1);
startvalue = gbestval;
[newval, newref(j_pos,:), reward, ls_trend, nfesa, Pro_record_ls] = local_search_meta_initialization(t0SA, startvalue, refset(B(j_pos), :), data, gbestval);
Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
Pro_record = [Pro_record, Pro_record_ls];
nfe = nfe + nfesa;
%decrease the temperature
t0SA = 0.9*t0SA;
%end of SA
tr = [tr, ls_trend];

%---------------------------------------------------
%update pbest and gbest if possible
if ref_fitness(B(j_pos)) > newval
    ref_fitness(B(j_pos)) = newval;
    refset(B(j_pos), :)= newref(j_pos, :);
end

%find gbest
[iterbestval, idx1] = min(ref_fitness);
if gbestval > iterbestval
    gbestval = iterbestval;
    gbest = refset(idx1,:);
end

%find gbest
[iterbestval, idx1] = min(ref_fitness);
if gbestval > iterbestval
    gbestval = iterbestval;
    gbest = refset(idx1,:);
end

cput = cputime - t0;
% start GA iterative procedures
%% iterated section
while cput < max_nfe
    B = Roulette(1./ref_fitness, 2);
    while B(1) == B(2)
        B(2) = Roulette(1./ref_fitness, 1);
    end
    if rand < pc && (dimension > 2)
        newref = crossover(refset(B(1), :), refset(B(2), :));
        
        %evaluation
        for j_pos = 1:2
            newval = COST(newref(j_pos, :), data);
            
            if newval < ref_fitness(B(j_pos))
                refset(B(j_pos), :) = newref(j_pos, :);
                ref_fitness(B(j_pos)) = newval;
            end
            if newval < gbestval
                gbestval = newval;
                gbest = newref(j_pos, :);
            end
            
            nfe = nfe + 1;
            tr(nfe) = gbestval;
        end
    end
    
    cput = cputime - t0;
    if cput > max_nfe
        break
    end
    %===================================================
    %using SA local search mechanism
    if rand < pm
        %             for j_pos = 1:2
        j_pos = datasample(1:2, 1);
        startvalue = gbestval;
        [newval, newref(j_pos,:), reward, ls_trend, nfesa, Pro_record_ls] = local_search_meta(t0SA, reward, startvalue, refset(B(j_pos), :), data, gbestval, Pro_record_ls(3:end, end));
        Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
        Pro_record = [Pro_record, Pro_record_ls];
        nfe = nfe + nfesa;
        %decrease the temperature
        t0SA = 0.9*t0SA;
        %end of SA
        tr = [tr, ls_trend];
        
        %---------------------------------------------------
        %update pbest and gbest if possible
        if ref_fitness(B(j_pos)) > newval
            ref_fitness(B(j_pos)) = newval;
            refset(B(j_pos), :)= newref(j_pos, :);
        end
        
        %find gbest
        [iterbestval, idx1] = min(ref_fitness);
        if gbestval > iterbestval
            gbestval = iterbestval;
            gbest = refset(idx1,:);
        end
    end
    
    %find gbest
    [iterbestval, idx1] = min(ref_fitness);
    if gbestval > iterbestval
        gbestval = iterbestval;
        gbest = refset(idx1,:);
    end
    cput = cputime - t0;
end  % end epoch loop
final_best_value = gbestval;
final_best_solution = gbest;
cput = cputime - t0;
totalt = toc;

