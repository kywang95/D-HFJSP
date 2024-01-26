function [ datacell ] = inputbm( data )
job1 = data(1); job2 = data(2);
mac = data(3:12); cap = data(13:22);
t1 = data(23 : (22+job1*8)); 
t2 = data((23 + job1*8) : (22 + (job1+job2)*8));
% t1 = data(23 : (22+job1*9)); 
% t2 = data((23 + job1*9) : (22 + (job1+job2)*9));
% tran = data(23 + (job1+job2)*9);

type = [ones(1,job1), ones(1,job2)*2];
Specimen = [1:job1, (job1+1):(job1+job2); type];
m = {[mac(1);mac(6)],[mac(2);mac(7)], ...
    [mac(3),mac(4);mac(8),mac(9)],[mac(5);mac(10)]};
c = {[cap(1);cap(6)],[cap(2);cap(7)], ...
    [cap(3),cap(4);cap(8),cap(9)],[cap(5);cap(10)]};
time = [reshape(t1, job1, 8); reshape(t2, job2, 8)];
% time = [reshape(t1, job1, 9); reshape(t2, job2, 9)];
processT = reshape(time(:, 1:8), (job1+job2), 4, 2);
datacell.m = m;
datacell.c = c; 
datacell.t = processT; 
% datacell.tran = tran; 
% datacell.DD = time(:,9); 
datacell.Specimen = Specimen;
 
%  % specimen property: code, type
% Specimen = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21:100;
%     ones(1,50) ones(1,50)*2];
% % machine property: number, capacity, processing time
% m = {[1;1],[1;1],[4,4;2,2],[1;1]}; % the quantity of machines in factory A;B
% c = {[10;15],[1;1],[19,13;4,7],[1;1]}; % the capacity of machines in factory A;B
% t = {[50;30],[1;2],[20,80;40,100],[1;1]}; % the processing time in factory A;B
% tran = 10; % transportation time between factory A and B
% DD = 100; % due date of each specimen
% S = Specimen(1,:);
% Type = Specimen(2,:);
% data.m = m; data.c = c; data.t = t; data.tran = tran; data.DD = DD; 
% data.Specimen = Specimen;
 
