function E = solveE(XX, S, temp_inv, V, n)

temp1 = (eye(n) - S);
for v = 1:V
    temp2 = XX{v}*temp1;
    E{v} = temp_inv{v} * temp2;
end
        