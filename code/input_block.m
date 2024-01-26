function [ data ] = input_block( data )
%% block based on the capability of machines for each type of specimens
SS = data.Specimen(1,:); 
Type = data.Specimen(2,:);
SS1 = SS(Type==1); 
SS2 = SS(Type==2);
a = zeros(2,1); 
b=a; 
c=a;
for i_c = 1:2
c(i_c) = maxgcd(data.c{1}(1),data.c{1}(2));    
a(i_c) = maxgcd(c(i_c),data.c{3}(1,i_c));
b(i_c) = maxgcd(a(i_c),data.c{3}(2,i_c));
end
block = [floor(length(SS1)/b(1)); floor(length(SS2)/b(2))];
rest = [rem(length(SS1),b(1)); rem(length(SS2),b(2))];
w = repmat(1:block(1),b(1),1);
x = repmat(block(1)+1,rest(1),1);
if isempty(x)==1
y = repmat((block(1)+1):sum(block),b(2),1);
z = repmat(sum(block)+1,rest(2),1);
else
y = repmat((block(1)+2):(sum(block)+1),b(2),1);
z = repmat(sum(block)+2,rest(2),1);    
end
BS = [w(:)' x(:)' y(:)' z(:)'];
data.Specimen(3,:) = BS;
end