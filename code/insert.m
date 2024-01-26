function [permutation] = insert(old_perm,data)
%% insert operator position 'i' into position 'j'
% input: position index ,position_i and position_j
% output: modified permuatation based invert operator

dimension = size(data.Specimen, 2);
temp_solution=data.Specimen(2,old_perm);
permutation = old_perm;

position_i=ceil(rand*dimension);
position_j=ceil(rand*dimension);
while position_i==position_j || temp_solution(position_i)==temp_solution(position_j)
    position_j=fix(dimension*rand)+1;
end

d(1) = position_i;
d(2) = position_j;

if d(1) < d(2)
    temp = permutation(d(1));
    for i = 1:(d(2)-d(1))
        permutation(d(1)+i-1) = old_perm(d(1)+i);
    end
    permutation(d(2)) = temp;
else
    temp = permutation(d(1));
    for i= 1:(d(1)-d(2))
        permutation(d(2)+i) = old_perm(d(2)+i-1);
    end
    permutation(d(2)) = temp;
end

end
