function [child1,child2] = AImelt(chrm1,chrm2)

L = length(chrm1);
M = round(L*rand(1));

switch M 
    case 0
        child1 = chrm1;
        child2 = chrm2;
    case L
        child1 = chrm2;
        child2 = chrm1;
    otherwise
        child1 = [chrm1(1:M),chrm2(M+1:end)];
        child2 = [chrm2(1:M),chrm1(M+1:end)];
   
end