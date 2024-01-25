% clear all
close all

iter_N = 50; % 10000;
% ---------------Settings of path of benchmark and results--------
pathofbenchmark='../benchmark/';

%% optimization
benchmark={
    'I_20_80_5.txt'; 'I_50_50_5.txt'; 'I_80_20_5.txt'; ...
    'I_40_160_5.txt'; 'I_100_100_5.txt'; 'I_160_40_5.txt'; ...
    'I_60_240_5.txt'; 'I_150_150_5.txt'; 'I_240_60_5.txt'; ...
    'I_80_320_5.txt'; 'I_200_200_5.txt'; 'I_320_80_5.txt'; ...
    'I_100_400_5.txt'; 'I_250_250_5.txt'; 'I_400_100_5.txt'; ...
    % 'I_2_2_5.txt';'I_3_3_5.txt';'I_4_4_5.txt';
    % 'I_160_640_5.txt'; 'I_400_400_5.txt'; 'I_640_160_5.txt'; ...
    % 'I_60_240_5.txt'; ...
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
    %% LON
    % iteration times for landscape analysis
    max_run_num = 5;
    for test_i = 1:max_run_num    
        for i_method = 1:4
            for test_case_i = 1:ceil(iter_N/2)
                test_case_i
                [s1_final_best_value(test_case_i), s1_final_best_solution{test_case_i}, ...
                    s1_cost{test_case_i}, s1_solution{test_case_i}] ...
                    =  nwk_ss_LON( maxb,data1,t0SA,i_method);
            end
            s_cost = s1_cost;
            s_solution = s1_solution;
            s_final_best_value = s1_final_best_value;
            s_final_best_solution = s1_final_best_solution;
            %                     s_cost = [];
            %                     s_solution = [];
            %                     s_final_best_value = [];
            %                     s_final_best_solution = [];
            
            for test_case_i = 1:ceil(iter_N/2)
                test_case_i
                [s2_final_best_value(test_case_i), s2_final_best_solution{test_case_i}, ...
                    s2_cost{test_case_i}, s2_solution{test_case_i}] ...
                    =  nwk_ss_rand_LON( data2,t0SA,i_method );
            end
            s_cost = [s_cost, s2_cost];
            s_solution = [s_solution, s2_solution];
            s_final_best_value = [s_final_best_value, s2_final_best_value];
            s_final_best_solution = [s_final_best_solution; s2_final_best_solution];
            %% build nodes and links
            [nodes, links] = Graph3D(s_cost, s_solution);
            %% save results of LON
            s_final_best_value
            path_result='../FLA/LON/';
            pathdata=[path_result '/'];
            switch i_method
                case 1
                    M = 'inverse';
                case 2
                    M = 'insert';
                case 3
                    M = 'swap';
                case 4
                    M = 'insert_block';
            end
            data_name = benchmark{case_i};
            data_name(3:end-4)
            filename1 = ['data_' data_name(3:end-4) '_' M '_',int2str(test_i),'_nodes.csv'];
            filename2 = ['data_' data_name(3:end-4) '_' M '_',int2str(test_i),'_links.csv'];
            filename = ['data_' data_name(3:end-4) '_' M '_',int2str(test_i)];
            writetable(nodes, [pathdata filename1]);
            writetable(links, [pathdata filename2]);
            save([pathdata filename],'s_cost','s_solution');
            M
            size(links)
            size(nodes)
        end
    end
end

