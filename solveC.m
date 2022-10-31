function C = solveC(S, Y, mu, lambda)
temp = S + Y/mu;
[Uc,Sigmac,Vc] = svd(temp,'econ');
sigma = diag(Sigmac);
svp = length(find(sigma > (lambda/mu)));
if svp >1
    sigma =sigma(1:svp,1)-(lambda/mu);
else
    svp =1;
    sigma = 0;
end
C = Uc(:,1:svp)*diag(sigma)*Vc(:,1:svp)';
