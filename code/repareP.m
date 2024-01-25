function [PP]=repareP(J,JJ,P)
[~,IdxJ] = sort(J);
[~,IdxJJ] = sort(JJ);
PP(IdxJJ) = P(IdxJ);
end