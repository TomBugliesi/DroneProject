function [ms, t, l, Jm, k, J11, J12, J13, J22, J23, J33, g] = params_drone
% Parametri in ingresso al sistema del drone. SI units

ms = 0.6; %massa calcolata 0.45. fattore di correzione c = 0.6/0.45 =1.34
t = 0.25;
l = 0.25;
k = 230;
J11= 3.625e-3*1.34;
J12= 0;
J13= 0;
J22= 3.625e-3*1.34;
J23= 0;
J33= 6.25e-3*1.34;
Jm = 7.5e-5;
g = 9.81;

end