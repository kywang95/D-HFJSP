function [permutation] = swap(old_perm,data)
%% swap operator
% swap two elements 'position_i' and 'position_i+1'in the old permutation
% input : old_perm, the old permutation
%         position_i, index of swap-position
% output: the modified permutation
dimension = size(data.Specimen, 2);
temp_solution=data.Specimen(2,old_perm);
permutation = old_perm;

position_i=ceil(rand*dimension);
position_j=ceil(rand*dimension);
while position_i==position_j || temp_solution(position_i)==temp_solution(position_j)
    position_j=fix(dimension*rand)+1;
end

permutation(position_i) = old_perm(position_j);
permutation(position_j) = old_perm(position_i);
end