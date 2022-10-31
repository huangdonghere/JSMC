function S = solveS(sumXX,sumL,XX,C,E,Y,mu,alpha,V,n)

A_syl = 2*sumXX + mu*eye(n);
B_syl = 2*alpha*sumL;
C_syl = mu*C - Y;
for v=1:V
    C_syl = C_syl + 2*XX{v}*(eye(n) - E{v});
end
S = lyap(A_syl,B_syl,-C_syl);