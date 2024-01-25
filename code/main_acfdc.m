clear all
close all

% ---------------Settings of path of benchmark and results--------
pathofbenchmark='../benchmark/';

%% lanscape analysis
benchmark ={
    'I_20_80_5.txt'; 'I_50_50_5.txt'; 'I_80_20_5.txt'; ...
    'I_40_160_5.txt'; 'I_100_100_5.txt'; 'I_160_40_5.txt'; ...
    'I_60_240_5.txt'; 'I_150_150_5.txt'; 'I_240_60_5.txt'; ...
    'I_80_320_5.txt'; 'I_200_200_5.txt'; 'I_320_80_5.txt'; ...
    'I_100_400_5.txt'; 'I_250_250_5.txt'; 'I_400_100_5.txt'; ...
    };
alldata = cell(1,length(benchmark));

for case_i = 1:length(benchmark)
    fprintf('%s \n',benchmark{case_i});
    alldata{1,case_i}=load([pathofbenchmark benchmark{case_i}]);
    data = inputbm(alldata{1,case_i});
    maxb = 12;
    max_distance = 5;
    data1 = data;
    data2 = data;
    t0SA = 3;
    s_final_best_solution = {};
    
    % iteration times for landscape analysis
    max_iter_num = 20000;
    max_run_num = 10;
    %                 %% AC and FDC
    for test_case_i = 1:max_run_num
        test_case_i
        % ac
        for i_method = 1:5
            [ s1_ac{test_case_i, i_method}, s1_cost_ac{test_case_i, i_method}, s1_method_No_ac(test_case_i, i_method), s1_trend{test_case_i, i_method}] ...
                = nwk_ss_landscape_ac( maxb,data1,max_iter_num,t0SA,i_method );
        end
        %% save results of ac 
        path_result='../FLA/ac/';
        pathdata=[path_result '/'];
        filename = ['data_AC_', benchmark{case_i}(3:end-4) '_' num2str(test_case_i)];
        save([pathdata filename],'s1_cost_ac','s1_ac','s1_method_No_ac','s1_trend');
        
        % fdc
        for i_method = 1:5
            [ s1_dis_opt{test_case_i, i_method},s1_dif_opt{test_case_i, i_method}, s1_fdc(test_case_i, i_method), ...
                s1_trend{test_case_i, i_method}] ...
                = nwk_ss_landscape_fdc( maxb,data1,max_iter_num,t0SA,i_method );
        end
       %% save results of fdc
        path_result='../FLA/fdc/';
        pathdata=[path_result '/'];
        filename = ['data_FDC_', benchmark{case_i}(3:end-4) '_' num2str(test_case_i)];
        save([pathdata filename],'s1_dis_opt','s1_dif_opt','s1_fdc','s1_trend');
    end
end
