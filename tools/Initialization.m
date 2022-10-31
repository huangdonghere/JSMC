function [Z,E,XX,sumXX,sumL] = Initialization(X,L,S,V, n)

%% Initialization 
E = cell(1,V);
XX = cell(1,V);
sumXX = zeros(n,n);
sumL = zeros(n,n);
sumS = zeros(n,n);
for v = 1:V    
    E{v} = zeros(n);
    XX{v} = X{v}' * X{v};
    sumXX = sumXX + XX{v};
    sumL = sumL + L{v};
    sumS = sumS + S{v};
end
Z = 1/V * sumS;