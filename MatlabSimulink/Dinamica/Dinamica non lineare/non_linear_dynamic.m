function Xp = non_linear_dynamic(X)
x = X(1);
y = X(2);
z = X(3);
xp = X(4);
yp = X(5);
zp = X(6);
th1 = X(7);
th2 = X(8);
th3 = X(9);
th1p = X(10);
th2p = X(11);
th3p = X(12);

%% Ingressi 

F11 = X(13);
F12 = X(14);
F21 = X(15);
F22 = X(16);
F11p = X(17);
F12p = X(18);
F21p = X(19);
F22p = X(20);
%% Parametri

[ms, t, l, Jm, k, J11, J12, J13, J22, J23, J33] = params_drone;

%% Derivata dello stato

Xp(1) = xp;
Xp(2) = yp;
Xp(3) = zp;
Xp(4) = (sin(th2)*(F11 + F12 + F21 + F22))/ms;
Xp(5) = -(cos(th2)*sin(th1)*(F11 + F12 + F21 + F22))/ms;
Xp(6) = (100*F11*cos(th1)*cos(th2) - 981*ms + 100*F12*cos(th1)*cos(th2) + 100*F21*cos(th1)*cos(th2) + 100*F22*cos(th1)*cos(th2))/(100*ms);
Xp(7) = th1p;
Xp(8) = th2p;
Xp(9) = th3p;
Xp(10) = (J22^2*th2p*th3p*cos(th3)^2 + J11^2*th2p*th3p*sin(th3)^2 + F11*J22*t*cos(th3) - F12*J22*t*cos(th3) + F21*J22*t*cos(th3) - F22*J22*t*cos(th3) + F11*J11*l*sin(th3) + F12*J11*l*sin(th3) - F21*J11*l*sin(th3) - F22*J11*l*sin(th3) + J22^2*th1p*th2p*cos(th3)^2*sin(th2) - J11*J22*th2p*th3p*cos(th3)^2 - J22*J33*th2p*th3p*cos(th3)^2 + J11^2*th1p*th2p*sin(th2)*sin(th3)^2 - J11*J22*th2p*th3p*sin(th3)^2 - J11*J33*th2p*th3p*sin(th3)^2 + J11*J22*th1p*th2p*sin(th2)*sin(th3)^2 - J11*J33*th1p*th2p*sin(th2)*sin(th3)^2 + J11^2*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J22^2*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J11^2*th1p*th3p*cos(th2)*cos(th3)*sin(th3) - J22^2*th1p*th3p*cos(th2)*cos(th3)*sin(th3) + J11*J22*th1p*th2p*cos(th3)^2*sin(th2) - J22*J33*th1p*th2p*cos(th3)^2*sin(th2) - J11*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J22*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J11*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th3) + J22*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th3))/(J11*J22*cos(th2)*(cos(th3)^2 + sin(th3)^2));
Xp(11) = (F21*J11*l*cos(th3) - F12*J11*l*cos(th3) - F11*J11*l*cos(th3) + F22*J11*l*cos(th3) + F11*J22*t*sin(th3) - F12*J22*t*sin(th3) + F21*J22*t*sin(th3) - F22*J22*t*sin(th3) - J11^2*th1p*th3p*cos(th2)*cos(th3)^2 - J22^2*th1p*th3p*cos(th2)*sin(th3)^2 - J11^2*th2p*th3p*cos(th3)*sin(th3) + J22^2*th2p*th3p*cos(th3)*sin(th3) - J11^2*th1p^2*cos(th2)*cos(th3)^2*sin(th2) - J22^2*th1p^2*cos(th2)*sin(th2)*sin(th3)^2 - J11^2*th1p*th2p*cos(th3)*sin(th2)*sin(th3) + J22^2*th1p*th2p*cos(th3)*sin(th2)*sin(th3) + J11*J33*th2p*th3p*cos(th3)*sin(th3) - J22*J33*th2p*th3p*cos(th3)*sin(th3) + J11*J33*th1p^2*cos(th2)*cos(th3)^2*sin(th2) + J22*J33*th1p^2*cos(th2)*sin(th2)*sin(th3)^2 + J11*J22*th1p*th3p*cos(th2)*cos(th3)^2 + J11*J33*th1p*th3p*cos(th2)*cos(th3)^2 + J11*J22*th1p*th3p*cos(th2)*sin(th3)^2 + J22*J33*th1p*th3p*cos(th2)*sin(th3)^2 + J11*J33*th1p*th2p*cos(th3)*sin(th2)*sin(th3) - J22*J33*th1p*th2p*cos(th3)*sin(th2)*sin(th3))/(J11*J22*(cos(th3)^2 + sin(th3)^2));
Xp(12) = -(J11*J22^2*th2p^2*cos(th2)*cos(th3)*sin(th3)^3 + J11*J22^2*th2p^2*cos(th2)*cos(th3)^3*sin(th3) - J11^2*J22*th2p^2*cos(th2)*cos(th3)*sin(th3)^3 - J11^2*J22*th2p^2*cos(th2)*cos(th3)^3*sin(th3) - J22*J33^2*th2p*th3p*cos(th3)^2*sin(th2) + J22^2*J33*th2p*th3p*cos(th3)^2*sin(th2) - J11*J33^2*th2p*th3p*sin(th2)*sin(th3)^2 + J11^2*J33*th2p*th3p*sin(th2)*sin(th3)^2 + F11*J22*J33*t*cos(th3)*sin(th2) - F12*J22*J33*t*cos(th3)*sin(th2) + F21*J22*J33*t*cos(th3)*sin(th2) - F22*J22*J33*t*cos(th3)*sin(th2) + F11*J11*J33*l*sin(th2)*sin(th3) + F12*J11*J33*l*sin(th2)*sin(th3) - F21*J11*J33*l*sin(th2)*sin(th3) - F22*J11*J33*l*sin(th2)*sin(th3) - J11*J22^2*th1p^2*cos(th2)^3*cos(th3)*sin(th3)^3 - J11*J22^2*th1p^2*cos(th2)^3*cos(th3)^3*sin(th3) + J11^2*J22*th1p^2*cos(th2)^3*cos(th3)*sin(th3)^3 + J11^2*J22*th1p^2*cos(th2)^3*cos(th3)^3*sin(th3) + J11*J22^2*th1p*th2p*cos(th2)^2*cos(th3)^4 - J11^2*J22*th1p*th2p*cos(th2)^2*cos(th3)^4 - J11*J22^2*th1p*th2p*cos(th2)^2*sin(th3)^4 + J11^2*J22*th1p*th2p*cos(th2)^2*sin(th3)^4 - J22*J33^2*th1p*th2p*cos(th3)^2*sin(th2)^2 + J22^2*J33*th1p*th2p*cos(th3)^2*sin(th2)^2 - J11*J33^2*th1p*th2p*sin(th2)^2*sin(th3)^2 + J11^2*J33*th1p*th2p*sin(th2)^2*sin(th3)^2 - J11*J33^2*th1p^2*cos(th2)*cos(th3)*sin(th2)^2*sin(th3) + J11^2*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)^2*sin(th3) + J22*J33^2*th1p^2*cos(th2)*cos(th3)*sin(th2)^2*sin(th3) - J22^2*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)^2*sin(th3) + F11p*J11*J22*Jm*k*cos(th2)*sin(th3)^2 - F12p*J11*J22*Jm*k*cos(th2)*sin(th3)^2 - F21p*J11*J22*Jm*k*cos(th2)*sin(th3)^2 + F22p*J11*J22*Jm*k*cos(th2)*sin(th3)^2 - J11*J22*J33*th2p*th3p*cos(th3)^2*sin(th2) - J11*J22*J33*th2p*th3p*sin(th2)*sin(th3)^2 + J11*J22*J33*th1p*th2p*cos(th2)^2*cos(th3)^2 + J11*J22*J33*th1p*th2p*cos(th2)^2*sin(th3)^2 + J11*J22*J33*th1p*th2p*cos(th3)^2*sin(th2)^2 + J11*J22*J33*th1p*th2p*sin(th2)^2*sin(th3)^2 + F11p*J11*J22*Jm*k*cos(th2)*cos(th3)^2 - F12p*J11*J22*Jm*k*cos(th2)*cos(th3)^2 - F21p*J11*J22*Jm*k*cos(th2)*cos(th3)^2 + F22p*J11*J22*Jm*k*cos(th2)*cos(th3)^2 - J11*J33^2*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J11^2*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J22*J33^2*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J22^2*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3))/(J11*J22*J33*cos(th2)*(cos(th3)^2 + sin(th3)^2));

end