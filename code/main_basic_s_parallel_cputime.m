% clear all
close all
% ---------------Settings of path of benchmark and results--------
pathofbenchmark='../benchmark/';

% pool = parpool(1);
for dirc_idx=0:16
    %% optimization
    switch dirc_idx
        %%        statistical analysis
        case 0
            benchmark={
                'I_1_1_1.txt';'I_1_1_2.txt'; ...
                'I_1_1_3.txt';'I_1_1_4.txt'; ...
                'I_1_1_5.txt'; ...
                'I_2_2_1.txt';'I_2_2_2.txt'; ...
                'I_2_2_3.txt';'I_2_2_4.txt'; ...
                'I_2_2_5.txt'; ...
                'I_3_3_1.txt';'I_3_3_2.txt'; ...
                'I_3_3_3.txt';'I_3_3_4.txt'; ...
                'I_3_3_5.txt'; ...
                'I_4_4_1.txt';'I_4_4_2.txt'; ...
                'I_4_4_3.txt';'I_4_4_4.txt'; ...
                'I_4_4_5.txt'; ...
                };
        case 1
            benchmark={
                'I_20_80_1.txt';'I_20_80_2.txt'; ...
                'I_20_80_3.txt';'I_20_80_4.txt'; ...
                'I_20_80_5.txt';'I_20_80_6.txt'; ...
                'I_20_80_7.txt';'I_20_80_8.txt'; ...
                'I_20_80_9.txt';'I_20_80_10.txt'; ...
                'I_50_50_1.txt';'I_50_50_2.txt'; ...
                'I_50_50_3.txt';'I_50_50_4.txt'; ...
                'I_50_50_5.txt';'I_50_50_6.txt'; ...
                'I_50_50_7.txt';'I_50_50_8.txt'; ...
                'I_50_50_9.txt';'I_50_50_10.txt'; ...
                'I_80_20_1.txt';'I_80_20_2.txt'; ...
                'I_80_20_3.txt';'I_80_20_4.txt'; ...
                'I_80_20_5.txt';'I_80_20_6.txt'; ...
                'I_80_20_7.txt';'I_80_20_8.txt'; ...
                'I_80_20_9.txt';'I_80_20_10.txt'; ...
                };
        case 2
            benchmark={
                'I_40_160_1.txt';'I_40_160_2.txt'; ...
                'I_40_160_3.txt';'I_40_160_4.txt'; ...
                'I_40_160_5.txt';'I_40_160_6.txt'; ...
                'I_40_160_7.txt';'I_40_160_8.txt'; ...
                'I_40_160_9.txt';'I_40_160_10.txt'; ...
                };
        case 3
            benchmark={
                'I_100_100_1.txt';'I_100_100_2.txt'; ...
                'I_100_100_3.txt';'I_100_100_4.txt'; ...
                'I_100_100_5.txt';'I_100_100_6.txt'; ...
                'I_100_100_7.txt';'I_100_100_8.txt'; ...
                'I_100_100_9.txt';'I_100_100_10.txt'; ...
                };
        case 4
            benchmark={
                'I_160_40_1.txt';'I_160_40_2.txt'; ...
                'I_160_40_3.txt';'I_160_40_4.txt'; ...
                'I_160_40_5.txt';'I_160_40_6.txt'; ...
                'I_160_40_7.txt';'I_160_40_8.txt'; ...
                'I_160_40_9.txt';'I_160_40_10.txt'; ...
                };
        case 5
            benchmark={
                'I_60_240_1.txt';'I_60_240_2.txt'; ...
                'I_60_240_3.txt';'I_60_240_4.txt'; ...
                'I_60_240_5.txt';'I_60_240_6.txt'; ...
                'I_60_240_7.txt';'I_60_240_8.txt'; ...
                'I_60_240_9.txt';'I_60_240_10.txt'; ...
                };
        case 6
            benchmark={
                'I_150_150_1.txt';'I_150_150_2.txt'; ...
                'I_150_150_3.txt';'I_150_150_4.txt'; ...
                'I_150_150_5.txt';'I_150_150_6.txt'; ...
                'I_150_150_7.txt';'I_150_150_8.txt'; ...
                'I_150_150_9.txt';'I_150_150_10.txt';...
                };
        case 7
            benchmark={
                'I_240_60_1.txt';'I_240_60_2.txt'; ...
                'I_240_60_3.txt';'I_240_60_4.txt'; ...
                'I_240_60_5.txt';'I_240_60_6.txt'; ...
                'I_240_60_7.txt';'I_240_60_8.txt'; ...
                'I_240_60_9.txt';'I_240_60_10.txt'; ...
                };
        case 8
            benchmark={
                'I_80_320_1.txt';'I_80_320_2.txt'; ...
                'I_80_320_3.txt';'I_80_320_4.txt'; ...
                'I_80_320_5.txt';'I_80_320_6.txt'; ...
                'I_80_320_7.txt';'I_80_320_8.txt'; ...
                'I_80_320_9.txt';'I_80_320_10.txt'; ...
                };
        case 9
            benchmark={
                'I_200_200_1.txt';'I_200_200_2.txt'; ...
                'I_200_200_3.txt';'I_200_200_4.txt'; ...
                'I_200_200_5.txt';'I_200_200_6.txt'; ...
                'I_200_200_7.txt';'I_200_200_8.txt'; ...
                'I_200_200_9.txt';'I_200_200_10.txt'; ...
                };
        case 10
            benchmark={
                'I_320_80_1.txt';'I_320_80_2.txt'; ...
                'I_320_80_3.txt';'I_320_80_4.txt'; ...
                'I_320_80_5.txt';'I_320_80_6.txt'; ...
                'I_320_80_7.txt';'I_320_80_8.txt'; ...
                'I_320_80_9.txt';'I_320_80_10.txt'; ...
                };
        case 11
            benchmark={
                'I_100_400_1.txt';'I_100_400_2.txt'; ...
                'I_100_400_3.txt';'I_100_400_4.txt'; ...
                'I_100_400_5.txt'; ...
                };
        case 12
            benchmark={
                'I_100_400_6.txt';'I_100_400_7.txt'; ...
                'I_100_400_8.txt';'I_100_400_9.txt'; ...
                'I_100_400_10.txt'; ...
                };
        case 13
            benchmark={
                'I_250_250_1.txt';'I_250_250_2.txt'; ...
                'I_250_250_3.txt';'I_250_250_4.txt'; ...
                'I_250_250_5.txt';...
                
                };
        case 14
            benchmark={
                'I_250_250_6.txt';'I_250_250_7.txt'; ...
                'I_250_250_8.txt';'I_250_250_9.txt'; ...
                'I_250_250_10.txt'; ...
                };
        case 15
            benchmark={
                'I_400_100_1.txt';'I_400_100_2.txt'; ...
                'I_400_100_3.txt';'I_400_100_4.txt'; ...
                'I_400_100_5.txt'; ...
                
                };
        case 16
            benchmark={
                'I_400_100_6.txt';'I_400_100_7.txt'; ...
                'I_400_100_8.txt';'I_400_100_9.txt'; ...
                'I_400_100_10.txt'; ...
                };
    end
    alldata = cell(1,length(benchmark));
    
    for case_i = 1:length(benchmark)
        fprintf('%s \n',benchmark{case_i});
        alldata{1,case_i}=load([pathofbenchmark benchmark{case_i}]);
        data = inputbm(alldata{1,case_i});
        maxb = 12;
        max_distance = 5;
        data1 = data;
        t0SA = 3;
        method_num = 4;
        queueLength = 500; utilityUB = 40;
        s_final_best_solution = {};
        
        % iteration times for optimization
        % max_iter_num = 10000;
        max_iter_num = size(data.Specimen, 2)*0.1;
        max_run_num = 30;
        
        
                %% optimization with GA
                'GA'
                for i_method = 1:method_num
                    switch i_method
                        case 1
                            method_name ='inverse';
                        case 2
                            method_name ='insert';
                        case 3
                            method_name ='swap';
                        case 4
                            method_name ='insert_block';
                    end
                    path_result=['../statistical_analysis/ga/' method_name '/'];
                    path_result1=sprintf('simu_%d',dirc_idx);
                    pathdata=[path_result path_result1 '/'];
                    if exist(pathdata, 'file') == 0
                        fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                        mkdir(pathdata);
                    end
                    %             for test_case_i = 1:max_run_num
                    parfor test_case_i = 1:max_run_num
                        fprintf('test %d ',test_case_i);
                        filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                        result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true);
                        P = [20, 10, 0.9, 0.9];
                        [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend] ...
                            = nwk_ga(t0SA, data1, P, max_iter_num, i_method);
                        % save results
                        result.s1_final_best_value = s1_final_best_value;
                        result.s1_final_best_solution =s1_final_best_solution;
                        result.s1_nfe = s1_nfe;
                        result.s1_cput = s1_cput;
                        result.s1_totalt = s1_totalt;
                        result.s1_trend = s1_trend;
                        % fprintf('%d ', result.s1_final_best_value);
                    end
        
                    %             figure
                    %             plot(result.s1_trend);
                    fprintf('\n');
                end
        
        
                %% optimization with PSO
                'PSO'
                for i_method = 1:method_num
                    switch i_method
                        case 1
                            method_name ='inverse';
                        case 2
                            method_name ='insert';
                        case 3
                            method_name ='swap';
                        case 4
                            method_name ='insert_block';
                    end
                    path_result=['../statistical_analysis/pso/' method_name '/'];
                    path_result1=sprintf('simu_%d',dirc_idx);
                    pathdata=[path_result path_result1 '/'];
                    if exist(pathdata, 'file') == 0
                        fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                        mkdir(pathdata);
                    end
                    %             for test_case_i = 1:max_run_num
                    parfor test_case_i = 1:max_run_num
                        fprintf('test %d ',test_case_i);
                        filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                        result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true);
                        P=[20 4 2 2];
                        PLS=0.1;
                        [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend] ...
                            = nwk_pso(t0SA, data1, P, PLS, max_iter_num, i_method);
                        % save results
                        result.s1_final_best_value = s1_final_best_value;
                        result.s1_final_best_solution =s1_final_best_solution;
                        result.s1_nfe = s1_nfe;
                        result.s1_cput = s1_cput;
                        result.s1_totalt = s1_totalt;
                        result.s1_trend = s1_trend;
                        % fprintf('%d ', result.s1_final_best_value);
                    end
        
                    %             figure
                    %             plot(result.s1_trend);
                    fprintf('\n');
                end
        
        
                %% optimization with SS-SA
                'SS-SA'
                for i_method = 1:method_num
                    switch i_method
                        case 1
                            method_name ='inverse';
                        case 2
                            method_name ='insert';
                        case 3
                            method_name ='swap';
                        case 4
                            method_name ='insert_block';
                    end
                    path_result=['../statistical_analysis/scatter_search/' method_name '/'];
                    path_result1=sprintf('simu_%d',dirc_idx);
                    pathdata=[path_result path_result1 '/'];
                    if exist(pathdata, 'file') == 0
                        fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                        mkdir(pathdata);
                    end
                    parfor test_case_i = 1:max_run_num
                        fprintf('test %d ',test_case_i);
                        filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                        result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                        [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend] ...
                            =  nwk_ss( maxb,data1,max_iter_num,max_distance,t0SA,i_method );
                        % save results
                        result.s1_final_best_value = s1_final_best_value;
                        result.s1_final_best_solution =s1_final_best_solution;
                        result.s1_nfe = s1_nfe;
                        result.s1_cput = s1_cput;
                        result.s1_totalt = s1_totalt;
                        result.s1_trend = s1_trend;
        %                 fprintf('%d ', result.s1_final_best_value);
                    end
                    fprintf('\n');
                end
        
        
                %% optimization with SA
                'SA'
                for i_method = 1:method_num
                    switch i_method
                        case 1
                            method_name ='inverse';
                        case 2
                            method_name ='insert';
                        case 3
                            method_name ='swap';
                        case 4
                            method_name ='insert_block';
                    end
                    path_result=['../statistical_analysis/simulated_annealing/' method_name '/'];
                    path_result1=sprintf('simu_%d',dirc_idx);
                    pathdata=[path_result path_result1 '/'];
                    if exist(pathdata, 'file') == 0
                        fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                        mkdir(pathdata);
                    end
                    parfor test_case_i = 1:max_run_num
                        fprintf('test %d ',test_case_i);
                        filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                        result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                        [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend] ...
                            =  nwk_sa( maxb,data1,max_iter_num,max_distance,t0SA,i_method );
                        % save results
                        result.s1_final_best_value = s1_final_best_value;
                        result.s1_final_best_solution =s1_final_best_solution;
                        result.s1_nfe = s1_nfe;
                        result.s1_cput = s1_cput;
                        result.s1_totalt = s1_totalt;
                        result.s1_trend = s1_trend;
                        % fprintf('%d ', result.s1_final_best_value);
                    end
                    fprintf('\n');
                end
        
        
                %% optimization with fixed_temperature_algorithm
                'fta'
                for i_method = 1:method_num
                    switch i_method
                        case 1
                            method_name ='inverse';
                        case 2
                            method_name ='insert';
                        case 3
                            method_name ='swap';
                        case 4
                            method_name ='insert_block';
                    end
                    path_result=['../statistical_analysis/fixed_temperature_algorithm/' method_name '/'];
                    path_result1=sprintf('simu_%d',dirc_idx);
                    pathdata=[path_result path_result1 '/'];
                    if exist(pathdata, 'file') == 0
                        fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                        mkdir(pathdata);
                    end
                    parfor test_case_i = 1:max_run_num
                        fprintf('test %d ',test_case_i);
                        filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                        result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                        [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend] ...
                            =  nwk_fta( maxb,data1,max_iter_num,max_distance,t0SA,i_method );
                        % save results
                        result.s1_final_best_value = s1_final_best_value;
                        result.s1_final_best_solution =s1_final_best_solution;
                        result.s1_nfe = s1_nfe;
                        result.s1_cput = s1_cput;
                        result.s1_totalt = s1_totalt;
                        result.s1_trend = s1_trend;
                        % fprintf('%d ', result.s1_final_best_value);
                    end
                    fprintf('\n');
                end
        
        
                %% optimization with SA+meta
                'SA+meta_Lamarckian'
                path_result='../statistical_analysis/sa_meta/';
                path_result1=sprintf('simu_%d',dirc_idx);
                pathdata=[path_result path_result1 '/'];
                if exist(pathdata, 'file') == 0
                    fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                    mkdir(pathdata);
                end
                parfor test_case_i = 1:max_run_num
                    fprintf('test %d ',test_case_i);
                    filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                    result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                    [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend, s1_Pro_record] ...
                        =  nwk_sa_meta(data1,max_iter_num,t0SA);
                    % save results
                    result.s1_final_best_value = s1_final_best_value;
                    result.s1_final_best_solution =s1_final_best_solution;
                    result.s1_nfe = s1_nfe;
                    result.s1_cput = s1_cput;
                    result.s1_totalt = s1_totalt;
                    result.s1_trend = s1_trend;
                end
                fprintf('\n');
        
        
                %% optimization with fixed_temperature_algorithm+meta
                'fta+meta_Lamarckian'
                path_result='../statistical_analysis/fta_meta/';
                path_result1=sprintf('simu_%d',dirc_idx);
                pathdata=[path_result path_result1 '/'];
                if exist(pathdata, 'file') == 0
                    fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                    mkdir(pathdata);
                end
                parfor test_case_i = 1:max_run_num
                    fprintf('test %d ',test_case_i);
                    filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                    result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                    [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend,s1_Pro_record] ...
                        =  nwk_fta_meta(data1,max_iter_num,t0SA);
                    % save results
                    result.s1_final_best_value = s1_final_best_value;
                    result.s1_final_best_solution =s1_final_best_solution;
                    result.s1_nfe = s1_nfe;
                    result.s1_cput = s1_cput;
                    result.s1_totalt = s1_totalt;
                    result.s1_trend = s1_trend;
                end
                fprintf('\n');
        
                %% optimization with ga+meta
                'ga+meta_Lamarckian'
                path_result='../statistical_analysis/ga_meta/';
                path_result1=sprintf('simu_%d',dirc_idx);
                pathdata=[path_result path_result1 '/'];
                if exist(pathdata, 'file') == 0
                    fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                    mkdir(pathdata);
                end
                parfor test_case_i = 1:max_run_num
                    fprintf('test %d ',test_case_i);
                    filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                    result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                    P = [20, 10, 0.9, 0.9];
                    [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend, s1_Pro_record] ...
                        =  nwk_ga_meta(t0SA, data1, P, max_iter_num);
                    % save results
                    result.s1_final_best_value = s1_final_best_value;
                    result.s1_final_best_solution =s1_final_best_solution;
                    result.s1_nfe = s1_nfe;
                    result.s1_cput = s1_cput;
                    result.s1_totalt = s1_totalt;
                    result.s1_trend = s1_trend;
                end
                fprintf('\n');
        
                %% optimization with pso+meta
                'pso+meta_Lamarckian'
                path_result='../statistical_analysis/pso_meta/';
                path_result1=sprintf('simu_%d',dirc_idx);
                pathdata=[path_result path_result1 '/'];
                if exist(pathdata, 'file') == 0
                    fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                    mkdir(pathdata);
                end
                parfor test_case_i = 1:max_run_num
                    fprintf('test %d ',test_case_i);
                    filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                    result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                    P=[20 4 2 2];
                    PLS=0.1;
                    [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend,s1_Pro_record] ...
                        =  nwk_pso_meta(t0SA, data1,P,PLS,max_iter_num);
                    % save results
                    result.s1_final_best_value = s1_final_best_value;
                    result.s1_final_best_solution =s1_final_best_solution;
                    result.s1_nfe = s1_nfe;
                    result.s1_cput = s1_cput;
                    result.s1_totalt = s1_totalt;
                    result.s1_trend = s1_trend;
                end
                fprintf('\n');
        
        
                %% optimization with meta-lamarckian
                'meta-lamarckian'
                path_result='../statistical_analysis/meta_lamarckian/';
                path_result1=sprintf('simu_%d',dirc_idx);
                pathdata=[path_result path_result1 '/'];
                if exist(pathdata, 'file') == 0
                    fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
                    mkdir(pathdata);
                end
                parfor test_case_i = 1:max_run_num
                    fprintf('test %d ',test_case_i);
                    filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
                    result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
                    [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_totalt, s1_trend,s1_Pro_record] ...
                        =  nwk_meta_lama( maxb,data1,max_iter_num,t0SA );
                    result.s1_final_best_value = s1_final_best_value;
                    result.s1_final_best_solution =s1_final_best_solution;
                    result.s1_nfe = s1_nfe;
                    result.s1_cput = s1_cput;
                    result.s1_totalt = s1_totalt;
                    result.s1_trend = s1_trend;
                    % fprintf('%d ', result.s1_final_best_value);
                end
                fprintf('\n');                
        
        
        %% optimization with SR-AM - HyperHeuristics
        'SR-AM'
        path_result='../statistical_analysis/SR-AM/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_SR_AM(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');                 
        
        
       %% optimization with SR-GDEL - HyperHeuristics
        'SR-GDEL'
        path_result='../statistical_analysis/SR-GDEL/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_SR_GDEL(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');           
        
        
       %% optimization with SR-IO - HyperHeuristics
        'SR-IO'
        path_result='../statistical_analysis/SR-IO/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_SR_IO(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');       
        
        
       %% optimization with SR-LACC - HyperHeuristics
        'SR-LACC'
        path_result='../statistical_analysis/SR-LACC/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_SR_LACC(data1,max_iter_num,method_num,queueLength);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with SR-SA - HyperHeuristics
        'SR-SA'
        path_result='../statistical_analysis/SR-SA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_SR_SA(data1,max_iter_num,method_num,t0SA);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with SR-NA - HyperHeuristics
        'SR-NA'
        path_result='../statistical_analysis/SR-NA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_SR_NA(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
       %% optimization with BS-AM - HyperHeuristics
        'BS-AM'
        path_result='../statistical_analysis/BS-AM/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_BS_AM(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');                 
        
        
       %% optimization with BS-GDEL - HyperHeuristics
        'BS-GDEL'
        path_result='../statistical_analysis/BS-GDEL/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_BS_GDEL(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');           
        
        
       %% optimization with BS-IO - HyperHeuristics
        'BS-IO'
        path_result='../statistical_analysis/BS-IO/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_BS_IO(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');       
        
        
       %% optimization with BS-LACC - HyperHeuristics
        'BS-LACC'
        path_result='../statistical_analysis/BS-LACC/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_BS_LACC(data1,max_iter_num,method_num,queueLength);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with BS-SA - HyperHeuristics
        'BS-SA'
        path_result='../statistical_analysis/BS-SA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_BS_SA(data1,max_iter_num,method_num,t0SA);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with BS-NA - HyperHeuristics
        'BS-NA'
        path_result='../statistical_analysis/BS-NA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_BS_NA(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
       %% optimization with RPD-AM - HyperHeuristics
        'RPD-AM'
        path_result='../statistical_analysis/RPD-AM/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RPD_AM(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');                 
        
        
       %% optimization with RPD-GDEL - HyperHeuristics
        'RPD-GDEL'
        path_result='../statistical_analysis/RPD-GDEL/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RPD_GDEL(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');           
        
        
       %% optimization with RPD-IO - HyperHeuristics
        'RPD-IO'
        path_result='../statistical_analysis/RPD-IO/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RPD_IO(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');       
        
        
       %% optimization with RPD-LACC - HyperHeuristics
        'RPD-LACC'
        path_result='../statistical_analysis/RPD-LACC/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RPD_LACC(data1,max_iter_num,method_num,queueLength);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with RPD-SA - HyperHeuristics
        'RPD-SA'
        path_result='../statistical_analysis/RPD-SA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RPD_SA(data1,max_iter_num,method_num,t0SA);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with RPD-NA - HyperHeuristics
        'RPD-NA'
        path_result='../statistical_analysis/RPD-NA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RPD_NA(data1,max_iter_num,method_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with RL-AM - HyperHeuristics
        'RL-AM'
        path_result='../statistical_analysis/RL-AM/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RL_AM(data1,max_iter_num,method_num,utilityUB);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');                 
        
        
       %% optimization with RL-GDEL - HyperHeuristics
        'RL-GDEL'
        path_result='../statistical_analysis/RL-GDEL/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RL_GDEL(data1,max_iter_num,method_num,utilityUB);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');           
        
        
       %% optimization with RL-IO - HyperHeuristics
        'RL-IO'
        path_result='../statistical_analysis/RL-IO/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RL_IO(data1,max_iter_num,method_num,utilityUB);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');       
        
        
       %% optimization with RL-LACC - HyperHeuristics
        'RL-LACC'
        path_result='../statistical_analysis/RL-LACC/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RL_LACC(data1,max_iter_num,method_num,queueLength,utilityUB);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with RL-SA - HyperHeuristics
        'RL-SA'
        path_result='../statistical_analysis/RL-SA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RL_SA(data1,max_iter_num,method_num,t0SA,utilityUB);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');
        
        
       %% optimization with RL-NA - HyperHeuristics
        'RL-NA'
        path_result='../statistical_analysis/RL-NA/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_nfe, s1_cput, s1_trend, s1_Pro_record] ...
                =  nwk_HH_RL_NA(data1,max_iter_num,method_num,utilityUB);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_nfe = s1_nfe;
            result.s1_cput = s1_cput;
            result.s1_trend = s1_trend;
        end
        fprintf('\n');

                
        %% optimization with NEH - ablation study
        'NEH'
        path_result='../statistical_analysis/NEH/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_cput, s1_totalt] ...
                =  nwk_heuristic_NEH_cput(data1,max_iter_num);
            
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_cput = s1_cput;
            result.s1_totalt = s1_totalt;
        end
        fprintf('\n');
        
        
        %% optimization with NEH-B - ablation study
        'NEH-B'
        path_result='../statistical_analysis/NEH-B/';
        path_result1=sprintf('simu_%d',dirc_idx);
        pathdata=[path_result path_result1 '/'];
        if exist(pathdata, 'file') == 0
            fprintf(['Creating the folder\n' pathdata, '\n please check.\n']);
            mkdir(pathdata);
        end
        parfor test_case_i = 1:max_run_num
            fprintf('test %d ',test_case_i);
            filename = sprintf('data_%d_iter_%d', case_i, test_case_i);
            result = matfile(sprintf([pathdata filename], test_case_i), 'writable', true)
            [s1_final_best_value, s1_final_best_solution, s1_cput, s1_totalt] ...
                =  nwk_heuristic_NEHB_cput( maxb,data1,max_iter_num );
            result.s1_final_best_value = s1_final_best_value;
            result.s1_final_best_solution =s1_final_best_solution;
            result.s1_cput = s1_cput;
            result.s1_totalt = s1_totalt;
        end
        
        fprintf('\n');
        
    end
end
delete(pool);
