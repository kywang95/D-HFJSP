function [solution, model_para] = HDFJSP_MIP(alldata)
%% indices
% i--specimens n, j--operations o, l--job shop lines f,
% k--machines m, d--batches n, r--batch position n

%% parameter
% job_number, operation, factory, machine_number[l], capacity[l][k], ...
% machine_job_link[i][j][l][k], process_time[i][j][l][k]
[job_number, operation, factory, machine_number, capacity, ...
    machine_job_link, process_time] = input_func(alldata);

%% decision variables
% X[l][i], Y[l][k][i][j][d], Z[l][k][r][d]
% set the variables in default format: x = sdpvar(m, n, [option])
% set the int variables: x = intvar(m, n, [option])
% set binary variables: x = binvar(m, n, [option])
batch_number = job_number;
x = binvar(factory, job_number,'full');
y = binvar(factory, max(machine_number), job_number, operation, batch_number,'full');
z = binvar(factory, max(machine_number), batch_number, batch_number,'full');

%% state variables
% T[l][k][d], B[l][k][d], C[l][k][r], E[i][j], TAT[i]
T = sdpvar(factory, max(machine_number), batch_number,'full');
% B = sdpvar(factory, max(machine_number), batch_number,'full');
C = sdpvar(factory, max(machine_number), batch_number,'full');
E = sdpvar(job_number, operation,'full');
% c = sdpvar(factory, max(machine_number));
% e = sdpvar(job_number,1);
TAT = sdpvar(job_number, 1);
% A = sdpvar(1,1);
Tau = 99999;

%% Objective
% Objective = max(E(:,operation))
Objective = mean(TAT);

%% Constraints
Constraints = [];
fprintf('loading constraints...\n');
% fprintf('Constraint 1\n');
for i = 1:job_number
    Constraints = [Constraints, (sum(x(:,i)) == 1)];
end
% fprintf('Constraint 2\n');
for l = 1:factory
    for i = 1:job_number
        for j = 1:operation
            A = 0;
            for k = 1:machine_number(l)
                for d = 1:batch_number
                    A = A + machine_job_link(i,j,l,k)*y(l,k,i,j,d);
                end
            end
            Constraints = [Constraints, A-x(l,i) == 0];
        end
    end
end
% fprintf('Constraint 3\n');
for l = 1:factory
    for i = 1:job_number
        for j = 1:operation
            A = 0;
            for k = 1:machine_number(l)
                for d = 1:batch_number
                    A = A + (1 - machine_job_link(i,j,l,k)) * y(l,k,i,j,d);
                end
            end
            Constraints = [Constraints, A == 0];
%             Constraints = [Constraints, ...
%                 sum(sum((reshape((1 - machine_job_link(i,j,l,:)),max(machine_number),1)*ones(1,batch_number)) ...
%                 .*reshape(y(l,:,i,j,:), max(machine_number), batch_number)))== 0];
        end
    end
end
% fprintf('Constraint 4\n');
for l = 1:factory
    for k = 1:machine_number(l)
        for d = 1:batch_number
            Constraints = [Constraints, ...
                sum(sum(y(l,k,:,:,d))) <= capacity(l,k)];
        end
    end
end
fprintf('Constraint 5\n');
for l = 1:factory
    for k = 1:machine_number(l)
        for r = 1:batch_number
            Constraints = [Constraints, sum(z(l,k,r,:)) <= 1];
        end
    end
end
% fprintf('Constraint 6\n');
for l = 1:factory
    for k = 1:machine_number(l)
        for d = 1:batch_number
            Constraints = [Constraints, sum(z(l,k,:,d)) == 1];
        end
    end
end
% fprintf('Constraint 7\n');
for l = 1:factory
    for k = 1:machine_number(l)
        for d = 1:batch_number
            Constraints = [Constraints, ...
                        T(l,k,d)-max(reshape(y(l,k,:,:,d).*process_time(:,:,l,k),job_number*operation,1)) == 0];
%             for i = 1:job_number
%                 for j = 1:operation
%                     Constraints = [Constraints, ...
%                         T(l,k,d)-y(l,k,i,j,d)*process_time(i,j,l,k) >= 0];
%                 end
%             end
        end
    end
end
%% not a linear constraint
% 8
% for l = 1:factory
%     l
%     for k = 1:machine_number(l)
%         for d = 1:batch_number
%                         A = T(l,k,d) - y(l,k,1,1,d)*process_time(1,1,l,k);
%                         for i = 1:job_number
%                              for j = 1:operation
%                                  A = A*(T(l,k,d) - y(l,k,i,j,d)*process_time(i,j,l,k));
%                              end
%                         end
%                         Constraints = [Constraints, A == 0];
% % %             Constraints = [Constraints, ...
% % %                 prod(prod(T(l,k,d) - ...
% % %                 reshape(y(l,k,:,:,d),job_number, operation) ...
% % %                 .*process_time(:,:,l,k))) == 0];
%         end
%     end
% end
% fprintf('Constraints 9 and 10\n');
for l = 1:factory
    for k = 1:machine_number(l)
        %        for r = 2:batch_number
        %             A = 0;
        %             for d = 1:batch_number
        %                 A = A + T(l,k,d) .* z(l,k,r,d);
        %             end
        %             Constraints = [Constraints, ...
        %                 C(l,k,r)-C(l,k,r-1)-A >= 0];
        %             %             Constraints = [Constraints, ...
        %             %                 C(l,k,r)-C(l,k,r-1)- ...
        %             %                 sum(reshape(T(l,k,:),batch_number,1)...
        %             %                 .*reshape(z(l,k,r,:),batch_number, 1)) >= 0];
        %         end
        %         if r == 1
        %             A = 0;
        %             for d = 1:batch_number
        %                 A = A + T(l,k,d) .* z(l,k,r,d);
        %             end
        %             Constraints = [Constraints, ...
        %                 C(l,k,r)-c(l,k)-A >= 0];
        %         end
        
        r = 1;
        for d = 1:batch_number
            Constraints = [Constraints, ...
                C(l,k,r) - T(l,k,d) - Tau * (z(l,k,r,d)-1) >= 0];
        end
        for r = 2:batch_number
            for d = 1:batch_number
                Constraints = [Constraints, ...
                    C(l,k,r)- C(l,k,r-1) - T(l,k,d) - Tau * (z(l,k,r,d)-1) >= 0];
            end
        end
    end
end
fprintf('Constraints 11 and 12\n');
for l = 1:factory
%     fprintf('loading constraint of factory %d\n', l);
    for k = 1:machine_number(l)
        for r = 1:batch_number
            for i = 1:job_number
                %                 for j = 2:operation
                %                     %                     A = 0;
                %                     %                     for d = 1:batch_nubmer
                %                     %                         A = A + E(i,j-1)*y(l,k,i,j,d).*z(l,k,r,d)+...
                %                     %                         T(l,k,d)*z(l,k,r,d);
                %                     %                     end
                %                     %                     Constraints = [Constraints, C(l,k,r)-A >= 0]
                %                     Constraints = [Constraints, C(l,k,r)-...
                %                         sum(E(i,j-1)*reshape(y(l,k,i,j,:), batch_number,1)...
                %                         .*reshape(z(l,k,r,:),batch_number,1)+...
                %                         reshape(T(l,k,:),batch_number,1)...
                %                         .*reshape(z(l,k,r,:), batch_number,1)) >= 0];
                %                 end
                %                 if j == 1
                %                     %                     A = 0;
                %                     %                     for d = 1:batch_nubmer
                %                     %                         A = A + e(i)*y(l,k,i,j,d)*z(l,k,r,d)+...
                %                     %                         T(l,k,d)*z(l,k,r,d);
                %                     %                     end
                %                     %                     Constraints = [Constraints, C(l,k,r)-A >= 0];
                %                     Constraints = [Constraints, C(l,k,r)-...
                %                         sum(e(i)*reshape(y(l,k,i,j,:), batch_number,1)...
                %                         .*reshape(z(l,k,r,:),batch_number,1)+...
                %                         reshape(T(l,k,:),batch_number,1)...
                %                         .*reshape(z(l,k,r,:), batch_number,1)) >= 0];
                %                 end
                j = 1;
                for d = 1:batch_number
                    Constraints = [Constraints, C(l,k,r)- T(l,k,d) ...
                        - Tau*(y(l,k,i,j,d)+z(l,k,r,d)-2) ...
                         >= 0];
                end
                for j = 2:operation
                    for d = 1:batch_number
                        Constraints = [Constraints, C(l,k,r) - ...
                            E(i,j-1) - T(l,k,d) ...
                            - Tau*(y(l,k,i,j,d)+z(l,k,r,d)-2) >= 0];
                    end
                end
            end
        end
    end
end
fprintf('Constraint 13\n');
for i = 1:job_number
%     fprintf('loading constraint of specimen %d\n', i);
    for j = 1:operation
        %         %         A = 0;
        %         %         for l = 1:factory
        %         %             for k = 1:machine_number(l)
        %         %                 for r = 1:batch_number
        %         %                     for d = 1:batch_number
        %         %                         A = A + C(l,k,r)*y(l,k,i,j,d)*z(l,k,r,d);
        %         %                     end
        %         %                 end
        %         %             end
        %         %         end
        %         %         Constraints = [Constraints, E(i,j)-A >= 0]
        %         for r = 1:batch_number
        %             for d = 1:batch_number
        %                 Constraints = [Constraints, E(i,j)-...
        %                     sum(sum(...
        %                     (reshape(C(:,:,r),factory,max(machine_number))...
        %                     .*reshape(y(:,:,i,j,d),factory,max(machine_number))...
        %                     .*z(:,:,r,d)))) >= 0];
        %             end
        %         end
        for l = 1:factory
            for k = 1:machine_number(l)
                for r = 1:batch_number
                    for d = 1:batch_number
                        Constraints = [Constraints, E(i,j)-C(l,k,r) ...
                            - Tau*(y(l,k,i,j,d)+z(l,k,r,d)-2) >= 0];
                    end
                end
            end
        end
    end
end
% fprintf('Constraint 14\n');
for l = 1:factory
    for k = 1:machine_number(l)
        for r = 1:batch_number
            Constraints = [Constraints, C(l,k,r) >= 0];
        end
    end
end
% fprintf('Constraint 15\n');
for i = 1:job_number
    Constraints = [Constraints, TAT(i) - E(i,operation) >= 0];
end
fprintf('Finish loading constraints\n');

%% diagnose whether the constraints are feasible
% diagnostics = optimize(Constraints);
% if diagnostics.problem == 0
%     disp('Solver thinks it is feasible')
% elseif diagnostics.problem == 1
%     disp('Solver thinks it is infeasible')
% else
%     disp('Something else happened')
% end
% solvetime = diagnostics.solvertime
% miptime = diagnostics.yalmiptime

%% solve the model with gurobi
% 'solver' is set as gurobi solver
% 'verbose' is the redundancy of information. Larger 'verbose' means more specific information of the solving process.
% options = sdpsettings();
% options.gurobi
% options = sdpsettings('solver','gurobi','verbose',2,'showprogress', 1);
% options = sdpsettings('solver','gurobi','verbose',1, 'gurobi.TimeLimit', 300);
options = sdpsettings('solver','gurobi','verbose',0, ...
    'gurobi.TimeLimit', 300, 'savesolverinput', 1, 'savesolveroutput', 1);
model_para = solvesdp(Constraints, Objective, options);
model_para.info
% model_para.solverinput.model
% model_para.solveroutput.result

%% record the solution
solution = struct;
% value(x)
solution.vx = value(x);
solution.vy = value(y);
solution.vz = value(z);
solution.ve = value(E);
solution.vC = value(C);
solution.vT = value(TAT);
% value(Objective)
solution.fitness = value(Objective);

%% If: Model is infeasible or unbounded
% 16
% options = sdpsettings('solver','gurobi','verbose',2, 'gurobi.TimeLimit', 600, 'gurobi.Presolve', 0);
% UsedInObjective = recover(depends(Objective));
% optimize([Model, UsedInObjective >= 0] ,Objective, options)
% for i = 1:job_number
% %     for j = 1:operation
%         Constraints = [Constraints, TAT(i) >= 0];
% %     end
% end