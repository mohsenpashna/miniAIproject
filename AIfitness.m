function [fitness]=AIfitness(Inp,CrrFx,Rn)

% Chrm = dec2bin(Num * 51.15,10);
if nargin <3
    CrrFx = 51.15;Rn=-10;
end
x = ((bin2dec(Inp))/CrrFx+Rn);
fitness = AIftfunc(x);