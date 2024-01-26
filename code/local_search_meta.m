function [endvalue, endsolution,reward, ls_trend, nfels, Pro_record_ls]=local_search_meta(t0SA, reward, startvalue,startsolution,data,bestsf, probability)
% local_search normal local search operator with simulated annealing
%  input_args:  t0SA        , the tempurature of simulated annealing
%              startvalue   , the cost function of start point
%              startsolution, the start point in search process of local_search_sa
%              data         , the process_time matrix and the number of job and machine of one given problem
% output_args: endvalue     , the terminal solution  in search process of local_search_sa
%              endsolution  , the cost function of terminal point
%              nfels        , the number of evualation

Pro_record_ls = [];
method_num = length(reward);
% c = 0.8;

method_No = Roulette( probability, 1 );
% select the neighborhood with the highest probablity
% for i = 1: method_num
%     aprobLS(i) = sum(probability(1:i));
% end
% randnumLS = rand;
% j = 1;
% while randnumLS > aprobLS(j)
%     j = j + 1;
%     if j > method_num
%         j = method_num;
%         break
%     end
% end
% method_No = j;

tempreward = zeros(method_num, 1);

[gbestval,temp_solution,ls_trend, nfels] = local_search_sa(t0SA,startvalue,startsolution,data,bestsf,method_No);

%  probability(method_No) = probability(method_No) *£¨bestsf/gbestval) * (startvalue-gbestval)/(iteration*(iteration-1))£©
% probability(method_No) = probability(method_No) * ( nfe * (startbest-bestsf)/startbest + 1 );
%     probability(method_No) = probability(method_No) * ( (bestsf/gbestval) * (startvalue-gbestval)/startvalue + 1 );
tempreward(method_No) = abs(gbestval - startvalue)/nfels;
reward = reward + tempreward;
% compute the accumulating probability of each neighborhood
% [~, tmpb] = sort(-reward);
% probability(tmpb) = c * (1-c) .^((1:method_num) - 1);
probability = reward./sum(reward);

record = [nfels; method_No; probability];
Pro_record_ls = [Pro_record_ls, record];
endsolution = temp_solution;
endvalue = gbestval;

