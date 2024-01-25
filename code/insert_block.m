function [permutation] = insert_block(old_perm,data)
%% invert operator position 'i' into position 'j'
% input: position index ,position_i and position_j
% output: modified permuatation based invert operator

dimension=max(data.Specimen(3,:));
temp_solution=data.Specimen(3,old_perm);
permutation = old_perm;

block_i=ceil(rand*dimension);
block_j=ceil(rand*dimension);
while block_i==block_j
    block_j=ceil(dimension*rand);
end
temp_permutation=old_perm(temp_solution~=block_i);
position_j=find(temp_solution==block_j);
BS=old_perm(temp_solution==block_i);
d_block = find(temp_solution==block_i);
if d_block(end) < position_j(1)
d_position = max(position_j(1)-length(BS),1);
elseif d_block(1) > position_j(1)
d_position = position_j(1);
else
   d_position = max(position_j(1)-length(d_block(d_block<position_j(1))),1);  
end
    permutation(1:(d_position-1)) = temp_permutation(1:(d_position-1));
    permutation(d_position:(d_position+length(BS)-1)) = BS;
    permutation((d_position+length(BS)):end) = temp_permutation(d_position:end);
end
