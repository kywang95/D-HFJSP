function [final_best_value, final_best_solution, nfe, cput, totalt, tr, Pro_record] = nwk_pso_meta(t0SA, data,P,PLS,max_nfe)
%% the main function of partical swarm optimization algorithm
% nwk_pso: The function is mainly coding based on the PSO designed by Bo
% Liu, in 2015
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

dimension = size(data.Specimen, 2);

%parameter: P=[20 4 2 2];
popsize= P(1);
mv     = P(2);
ac1    = P(3);
ac2    = P(4);
VR = [zeros(dimension,1), ones(dimension,1)*4];

t0=cputime;
tic;

%% initial stage//diversification_generator
data = input_block(data);
% num_block = max(data.Specimen(3,:));
ini_solution = ones(popsize, dimension);
ini_fitness = zeros(1, popsize);
refset = zeros(popsize, dimension);

for i_raer = 1:popsize
    ini_solution(i_raer, :) = randperm(dimension);
    ini_fitness(i_raer) = COST(ini_solution(i_raer, :), data);
end

%  ini_fitness

%% initial stage//built the initial reference set
[a, b] = sort(ini_fitness);
ref_fitness = a(1:popsize);
for i = 1:popsize
    refset(i,:) = ini_solution(b(i),:);
end

%% initialization of output results
tr(1:popsize) = ref_fitness(1);
nfe = popsize;
Pro_record = [];

pos = zeros(popsize, dimension);
vel = zeros(popsize, dimension);

%initialization
vel(1:popsize, 1:dimension)=normalize(rand([popsize, dimension]), ...
    [-mv*ones(dimension,1),mv*ones(dimension,1)]',1);
% use the job of NEH to generate the pos, and construct the complete pos
pos(1:popsize, 1:dimension) = VR(1,1) + (VR(1,2)-VR(1,1))/dimension.*((refset-1) + rand(popsize,dimension));

%evaluate
J = zeros(popsize, dimension);
out = zeros(popsize, 1);
for j = 1:popsize
    %apply rpv to generate the job sequence
    [~, J_index] = sort(pos(j, :));
    J(j, J_index) = 1:dimension;
    out(j) = COST(J(j,:), data);
end
nfe = nfe + popsize;
% initialize the pbest and gbest
pbest = pos;
pbestval = out;
Jbest = J;
[gbestval,idx1] = min(pbestval);
gbest = pbest(idx1,:);
tr((nfe-popsize+1):nfe) = gbestval;

cput = cputime - t0;
% start PSO iterative procedures

%% training stage
    %update particle
    for j = 1:popsize
        % each epoch get new set of randum numbers
        rannum1 = rand([1,dimension]);
        rannum2 = rand([1,dimension]);
        c = ac1 + ac2;
        Km = abs(2-c-sqrt(c*c-4*c));
        K = 2/Km;
        vel(j,1:dimension) = K*vel(j,1:dimension) ...
            + K*ac1*rannum1.*(pbest(j,1:dimension) - pos(j,1:dimension)) ...
            + K*ac2*rannum2.*(gbest(1,1:dimension) - pos(j,1:dimension));
        % limit velocities here (uses masking)
        velmaskmin = -mv*ones(size(vel(j,:)));
        velmaskmax = mv*ones(size(vel(j,:)));
        
        minvelmask_throwaway = vel(j,:) <= velmaskmin;
        minvelmask_keep = vel(j,:) >  velmaskmin;
        
        newvelA = vel(j,:).*minvelmask_keep; % keeps good vals, zeros bad
        newvelB = velmaskmin.*minvelmask_throwaway; %
        vel(j,:) = newvelA + newvelB;  % takes care of vals < -maxvel
        
        maxvelmask_throwaway = vel(j,:) >= velmaskmax;
        maxvelmask_keep = vel(j,:) <  velmaskmax;
        
        newvelA = vel(j,:).*maxvelmask_keep;
        newvelB = velmaskmax.*maxvelmask_throwaway;
        vel(j,:) = newvelA + newvelB; % takes care of vals > maxvel
        
        pos(j,:) = pos(j,:) + vel(j,:);
        
        % position masking, limits positions to desired search space
        posmaskmin = VR(:,1)';
        posmaskmax = VR(:,2)';
        minposmask_throwaway = pos(j,:) <= posmaskmin;
        minposmask_keep = pos(j,:) > posmaskmin;
        newposA = pos(j,:).*minposmask_keep;
        newposB = posmaskmin.*minposmask_throwaway;
        pos(j,:) = newposA + newposB;
        maxposmask_throwaway = pos(j,:) >= posmaskmax;
        maxposmask_keep = pos(j,:) < posmaskmax;
        newposA = pos(j,:).*maxposmask_keep;
        newposB = posmaskmax.*maxposmask_throwaway;
        pos(j,:) = newposA + newposB;
    end
    % end update particle
    %==================================================
    %--------------------------------------------------
    
    J = zeros(popsize, dimension);
    out = zeros(popsize, 1);
    for j = 1:popsize
        %apply rpv to find permutation
        [~, J_index] = sort(pos(j, :));
        J(j, J_index) = 1:dimension;
        %evaluation
        out(j) = COST(J(j,:), data);
    end
     
    %---------------------------------------------------
    %update pbest and gbest if possible
    for j = 1:popsize
        if pbestval(j) > out(j)
            pbestval(j) = out(j);
            pbest(j,:) = pos(j,:);
            Jbest(j,:) = J(j,:);
        end
    end
    %find gbest
    [iterbestval, idx1] = min(pbestval);
    if gbestval > iterbestval
        gbestval = iterbestval;
        gbest = pbest(idx1,:);
    end
    nfe = nfe + popsize;
    tr((nfe-popsize+1):nfe) = min([out; gbestval]);
%     fprintf('global %d ', gbestval);
    %-----------------------------------------------------
    
    %===================================================
    %using SA local search mechanism
    startvalue = gbestval;
    %% improve the new trail solution in iterated local search
    [pval, J_temp, reward, ls_trend, nfesa, Pro_record_ls] = local_search_meta_initialization(t0SA, startvalue, Jbest(idx1,:), data, gbestval);
    npbest = repareP(Jbest(idx1,:), J_temp, pbest(idx1,:));
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = nfe + nfesa;
    %decrease the temperature
    t0SA = 0.9*t0SA;
    %end of SA
    tr = [tr, ls_trend];
    
    %---------------------------------------------------
    %update pbest and gbest if possible
    if pval < pbestval(idx1)
        pbestval(idx1) = pval;
        pbest(idx1,:) = npbest;
        Jbest(idx1,:) = J_temp;
    end
    %find gbest
    [iterbestval, idx1] = min(pbestval);
    if gbestval > iterbestval
        gbestval = iterbestval;
        gbest = pbest(idx1,:);
    end
    
    cput = cputime - t0;



%% iterated section
while cput < max_nfe % start epoch loop (iterations)
    %=============================================
    %update particle
    for j = 1:popsize
        % each epoch get new set of randum numbers
        rannum1 = rand([1,dimension]);
        rannum2 = rand([1,dimension]);
        c = ac1 + ac2;
        Km = abs(2-c-sqrt(c*c-4*c));
        K = 2/Km;
        vel(j,1:dimension) = K*vel(j,1:dimension) ...
            + K*ac1*rannum1.*(pbest(j,1:dimension) - pos(j,1:dimension)) ...
            + K*ac2*rannum2.*(gbest(1,1:dimension) - pos(j,1:dimension));
        % limit velocities here (uses masking)
        velmaskmin = -mv*ones(size(vel(j,:)));
        velmaskmax = mv*ones(size(vel(j,:)));
        
        minvelmask_throwaway = vel(j,:) <= velmaskmin;
        minvelmask_keep = vel(j,:) >  velmaskmin;
        
        newvelA = vel(j,:).*minvelmask_keep; % keeps good vals, zeros bad
        newvelB = velmaskmin.*minvelmask_throwaway; %
        vel(j,:) = newvelA + newvelB;  % takes care of vals < -maxvel
        
        maxvelmask_throwaway = vel(j,:) >= velmaskmax;
        maxvelmask_keep = vel(j,:) <  velmaskmax;
        
        newvelA = vel(j,:).*maxvelmask_keep;
        newvelB = velmaskmax.*maxvelmask_throwaway;
        vel(j,:) = newvelA + newvelB; % takes care of vals > maxvel
        
        pos(j,:) = pos(j,:) + vel(j,:);
        
        % position masking, limits positions to desired search space
        posmaskmin = VR(:,1)';
        posmaskmax = VR(:,2)';
        minposmask_throwaway = pos(j,:) <= posmaskmin;
        minposmask_keep = pos(j,:) > posmaskmin;
        newposA = pos(j,:).*minposmask_keep;
        newposB = posmaskmin.*minposmask_throwaway;
        pos(j,:) = newposA + newposB;
        maxposmask_throwaway = pos(j,:) >= posmaskmax;
        maxposmask_keep = pos(j,:) < posmaskmax;
        newposA = pos(j,:).*maxposmask_keep;
        newposB = posmaskmax.*maxposmask_throwaway;
        pos(j,:) = newposA + newposB;
    end
    % end update particle
    %==================================================
    %--------------------------------------------------
    
    J = zeros(popsize, dimension);
    out = zeros(popsize, 1);
    for j = 1:popsize
        %apply rpv to find permutation
        [~, J_index] = sort(pos(j, :));
        J(j, J_index) = 1:dimension;
        %evaluation
        out(j) = COST(J(j,:), data);
    end
     
    %---------------------------------------------------
    %update pbest and gbest if possible
    for j = 1:popsize
        if pbestval(j) > out(j)
            pbestval(j) = out(j);
            pbest(j,:) = pos(j,:);
            Jbest(j,:) = J(j,:);
        end
    end
    %find gbest
    [iterbestval, idx1] = min(pbestval);
    if gbestval > iterbestval
        gbestval = iterbestval;
        gbest = pbest(idx1,:);
    end
    nfe = nfe + popsize;
    tr((nfe-popsize+1):nfe) = min([out; gbestval]);
%     fprintf('global %d ', gbestval);
    %-----------------------------------------------------
    cput = cputime - t0;
    if cput > max_nfe
        break
    end
    
    %===================================================
    %using SA local search mechanism
    startvalue = gbestval;
    [pval, J_temp, reward, ls_trend, nfesa, Pro_record_ls] = local_search_meta(t0SA, reward, startvalue, Jbest(idx1,:), data, gbestval, Pro_record_ls(3:end, end));
    npbest = repareP(Jbest(idx1,:), J_temp, pbest(idx1,:));
    Pro_record_ls(1,:) = Pro_record_ls(1,:) + nfe;
    Pro_record = [Pro_record, Pro_record_ls];
    nfe = nfe + nfesa;
    %decrease the temperature
    t0SA = 0.9*t0SA;
    %end of SA
    tr = [tr, ls_trend];
    
    %---------------------------------------------------
    %update pbest and gbest if possible
    if pval < pbestval(idx1)
        pbestval(idx1) = pval;
        pbest(idx1,:) = npbest;
        Jbest(idx1,:) = J_temp;
    end
    %find gbest
    [iterbestval, idx1] = min(pbestval);
    if gbestval > iterbestval
        gbestval = iterbestval;
        gbest = pbest(idx1,:);
    end
    
    cput = cputime - t0;
%     fprintf('local %d ', gbestval)
    %-----------------------------------------------------
end  % end epoch loop
final_best_value = gbestval;
final_best_solution = Jbest(idx1,:);
cput = cputime - t0;
totalt = toc;
end
