function sys = symtosys(A,B,C,D)
% Create a sys epresenting the continuous-time state-space model from the
% matrix A,B,C,D defined as sym
[ms, t, l, Jm, k, J11, J12, J13, J22, J23, J33, g] = params_drone;
A = eval(A);
B = eval(B);
C = eval(C);
D = eval(D);

sys = ss(A,B,C,D);
end

