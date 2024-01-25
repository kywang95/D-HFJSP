clc
close all
% clear all

bench = 30; % depends on the number of instances in folder
method = 28;
iteration = 30;
folder = 'simu_1' % 'simu_0',...,'simu_16'

maxLm = zeros(bench,method);
minLm = zeros(bench,method);
aveLm = zeros(bench,method);
varLm = zeros(bench,method);
% avetime = zeros(bench,method);
avecput = zeros(bench,method);

for idx = 1:method
    switch idx
        case 1
            path_result1 = 'BS-AM';
        case 2
            path_result1 = 'BS-GDEL';
        case 3
            path_result1 = 'BS-IO';
        case 4
            path_result1 = 'BS-LACC';
        case 5
            path_result1 = 'BS-NA';
        case 6
            path_result1 = 'BS-SA';
        case 7
            path_result1 = 'NEH';
        case 8
            path_result1 = 'NEH-B';
        case 9
            path_result1 = 'QLearningHyperHeuristic';
        case 10
            path_result1 = 'RL-AM';
        case 11
            path_result1 = 'RL-GDEL';
        case 12
            path_result1 = 'RL-IO';
        case 13
            path_result1 = 'RL-LACC';
        case 14
            path_result1 = 'RL-NA';
        case 15
            path_result1 = 'RL-SA';
        case 16
            path_result1 = 'RPD-AM';
        case 17
            path_result1 = 'RPD-GDEL';
        case 18
            path_result1 = 'RPD-IO';
        case 19
            path_result1 = 'RPD-LACC';
        case 20
            path_result1 = 'RPD-NA';
        case 21
            path_result1 = 'RPD-SA';       
        case 22
            path_result1 = 'SR-AM';
        case 23
            path_result1 = 'SR-GDEL';
        case 24
            path_result1 = 'SR-IO';
        case 25
            path_result1 = 'SR-LACC';
        case 26
            path_result1 = 'SR-NA';
        case 27
            path_result1 = 'SR-SA';    
        case 28
            path_result1 = 'BacktrackingSearchHyperHeuristic';  
    end
    
    path_result = '../statistical_analysis/';
    pathdata = [path_result path_result1 '/' folder];
    for i = 1:bench
        best_value = [];
%         totalt = [];
        cput = [];
        for j = 1:iteration
            result = ['data_' int2str(i) '_iter_', int2str(j), '.mat'];
            data = importdata([pathdata '/' result]);
            best_value = [best_value data.s1_final_best_value];
%             totalt = [totalt data.s1_totalt];
            cput = [cput data.s1_cput];
        end
        maxLm(i,idx)=max(best_value);
        minLm(i,idx)=min(best_value);
        aveLm(i,idx)=mean(best_value);
        varLm(i,idx)=var(best_value);
%         avetime(i,idx)=mean(totalt);
        avecput(i,idx)=mean(cput);
    end
end

maxLm
minLm
aveLm
varLm
% avetime
avecput
writematrix(maxLm, ['../statistical_analysis/worst_', folder, '.csv']);
writematrix(minLm, ['../statistical_analysis/best_', folder, '.csv']);
writematrix(aveLm, ['../statistical_analysis/average_', folder, '.csv']);
writematrix(avecput, ['../statistical_analysis/avecput_', folder, '.csv']);