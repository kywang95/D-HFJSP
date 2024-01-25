function [ job_number, operation, factory, machine_number, capacity, ...
machine_job_link, process_time ] = input_func( data )
job1 = data(1); job2 = data(2);
mac = data(3:12); cap = data(13:22);
t1 = data(23 : (22+job1*8)); 
t2 = data((23 + job1*8) : (22 + (job1+job2)*8));

type = [ones(1,job1), ones(1,job2)*2];
Specimen = [1:job1, (job1+1):(job1+job2); type];
m = {[mac(1);mac(6)],[mac(2);mac(7)], ...
    [mac(3),mac(4);mac(8),mac(9)],[mac(5);mac(10)]};
c = {[cap(1);cap(6)],[cap(2);cap(7)], ...
    [cap(3),cap(4);cap(8),cap(9)],[cap(5);cap(10)]};
time = [reshape(t1, job1, 8); reshape(t2, job2, 8)];
processT = reshape(time(:, 1:8), (job1+job2), 4, 2);

% parameter
% job_number, operation, factory, 
% machine_number[l], capacity[l][k], 
% machine_job_link[i][j][l][k], process_time[i][j][l][k]
job_number = size(Specimen, 2);
operation = size(processT,2);
factory = 2;
machine_number = [ sum(mac(1:5)), sum(mac(6:10))];
capacity = zeros(factory, max(machine_number));
machine_job_link = zeros(job_number, operation, factory, max(machine_number));
for l = 1 : factory
    Cap = [];
    for k = (-4+l*5):(l*5)
        Cap = [Cap, ones(1,mac(k))*cap(k)];
        for i = 1:job_number
            for j = 1:2 
                if (k==j && l==1) || (k==(j+5) && l==2)
                machine_job_link(i,j,l,((length(Cap)-mac(k)+1):length(Cap))) = 1;
                end
            end
            for j = 3
                if ( k==3 && l==1 && Specimen(2,i)==1) || ( k==8 && l==2 && Specimen(2,i)==1)
                   machine_job_link(i,j,l,((length(Cap)-mac(k)+1):length(Cap))) = 1; 
                else
                    if ( k==4 && l==1 && Specimen(2,i)==2) || ( k==9 && l==2 && Specimen(2,i)==2)
                        machine_job_link(i,j,l,((length(Cap)-mac(k)+1):length(Cap))) = 1; 
                    end
                end
            end
            for j = 4
                if ( k==5 && l==1) || ( k==10 && l==2 )
                machine_job_link(i,j,l,((length(Cap)-mac(k)+1):length(Cap))) = 1;
                end
            end
        end
    end
    capacity(l,1:length(Cap)) = Cap;
end
process_time = ones(job_number, operation, factory, max(machine_number))*99999;
for i = 1:job_number
    for j = 1:operation
        for l = 1:factory
            for k = 1:machine_number(l)
                if machine_job_link(i,j,l,k)==1
                    process_time(i,j,l,k) = processT(i,j,l);
                else 
                    process_time(i,j,l,k) = 99999;
                end
            end
        end
    end
end

%  % specimen property: code, type
% Specimen = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21:100;
%     ones(1,50) ones(1,50)*2];
% % machine property: number, capacity, processing time
% m = {[1;1],[1;1],[4,4;2,2],[1;1]}; % the quantity of machines in factory A;B
% c = {[10;15],[1;1],[19,13;4,7],[1;1]}; % the capacity of machines in factory A;B
% t = {[50;30],[1;2],[20,80;40,100],[1;1]}; % the processing time in factory A;B
% % tran = 10; % transportation time between factory A and B
% DD = 100; % due date of each specimen
% S = Specimen(1,:);
% Type = Specimen(2,:);
