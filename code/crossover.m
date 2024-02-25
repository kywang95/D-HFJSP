function [newref] = crossover(refA, refB)
dimension = size(refA, 2);
knot1 = datasample(1:(dimension-1), 1);
knot2 = datasample(1:(dimension-1), 1);
while knot2 == knot1
    knot2 = datasample(1:(dimension-1), 1);
end
if knot2 < knot1
    temp = knot1;
    knot1 = knot2;
    knot2 = temp;
end
A1 = refA(1:knot1);
% A2 = refA((knot1+1):knot2);
A3 = refA((knot2+1):end);
B1 = refB(1:knot1);
% B2 = refB((knot1+1):knot2);
B3 = refB((knot2+1):end);
X = refA;
Y = refB;
for iA = 1:length(A1)
    Y(find(Y == A1(iA), 1)) = [];
end
for iA = length(A3):-1:1
    Y(find(Y == A3(iA), 1, 'last')) = [];
end
for iB = 1:length(B1)
    X(find(X == B1(iB), 1)) = [];
end
for iB = length(B3):-1:1
    X(find(X == B3(iB), 1, 'last')) = [];
end
newref = [B1, X, B3; A1, Y, A3];
end