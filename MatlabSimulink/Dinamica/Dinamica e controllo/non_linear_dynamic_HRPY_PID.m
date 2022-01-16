function Xp = non_linear_dynamic_HRPY_PID(X)
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
% Parametri PID
kz_p = 150;
kz_d = 14;
kz_i = 8;
kR_p = 1;
kR_d = 1;
kR_i = 0.5;
kth3_p = 1;
kth3_d = 1;
kth3_i = 0.5;

H = kz_p*(X(13))+kz_d*(X(14))+kz_i*(X(15));
R = kR_p*(X(16))+kR_d*(X(17))+kR_i*(X(18));
P = kR_p*(X(19))+kR_d*(X(20))+kR_i*(X(21));
Yp = kth3_p*(X(22))+kth3_d*(X(23))+kth3_i*(X(24));
%% Parametri

[ms, t, l, Jm, k, J11, J12, J13, J22, J23, J33, g] = params_drone;

%% Derivata dello stato

Xp(1) = xp;
Xp(2) = yp;
Xp(3) = zp;
Xp(4) = (sin(th2)*(H + g*ms))/ms;
Xp(5) = -(cos(th2)*sin(th1)*(H + g*ms))/ms;
Xp(6) = (H*cos(th1)*cos(th2) - g*ms + g*ms*cos(th1)*cos(th2))/ms;
Xp(7) = th1p;
Xp(8) = th2p;
Xp(9) = th3p;
Xp(10) = (J11^2*th2p*th3p - J11^2*th2p*th3p*cos(th3)^2 + J22^2*th2p*th3p*cos(th3)^2 + J22*R*t*cos(th3) - J11*P*l*sin(th3) + J11^2*th1p*th2p*sin(th2) - J11*J22*th2p*th3p - J11*J33*th2p*th3p - J11^2*th1p*th2p*cos(th3)^2*sin(th2) + J22^2*th1p*th2p*cos(th3)^2*sin(th2) + J11*J33*th2p*th3p*cos(th3)^2 - J22*J33*th2p*th3p*cos(th3)^2 + J11*J22*th1p*th2p*sin(th2) - J11*J33*th1p*th2p*sin(th2) + J11^2*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J22^2*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J11^2*th1p*th3p*cos(th2)*cos(th3)*sin(th3) - J22^2*th1p*th3p*cos(th2)*cos(th3)*sin(th3) + J11*J33*th1p*th2p*cos(th3)^2*sin(th2) - J22*J33*th1p*th2p*cos(th3)^2*sin(th2) - J11*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J22*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J11*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th3) + J22*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th3))/(J11*J22*cos(th2));
Xp(11) = (J22*J33*th1p^2*sin(2*th2) - J22^2*th1p^2*sin(2*th2) - J11^2*th2p*th3p*sin(2*th3) + J22^2*th2p*th3p*sin(2*th3) + 2*J11*P*l*cos(th3) + 2*J22*R*t*sin(th3) - 2*J22^2*th1p*th3p*cos(th2) - 2*J11^2*th1p*th3p*cos(th2)*cos(th3)^2 + 2*J22^2*th1p*th3p*cos(th2)*cos(th3)^2 + J11*J33*th2p*th3p*sin(2*th3) - J22*J33*th2p*th3p*sin(2*th3) + 2*J11*J22*th1p*th3p*cos(th2) + 2*J22*J33*th1p*th3p*cos(th2) - 2*J11^2*th1p^2*cos(th2)*cos(th3)^2*sin(th2) + 2*J22^2*th1p^2*cos(th2)*cos(th3)^2*sin(th2) - 2*J11^2*th1p*th2p*cos(th3)*sin(th2)*sin(th3) + 2*J22^2*th1p*th2p*cos(th3)*sin(th2)*sin(th3) + 2*J11*J33*th1p^2*cos(th2)*cos(th3)^2*sin(th2) - 2*J22*J33*th1p^2*cos(th2)*cos(th3)^2*sin(th2) + 2*J11*J33*th1p*th3p*cos(th2)*cos(th3)^2 - 2*J22*J33*th1p*th3p*cos(th2)*cos(th3)^2 + 2*J11*J33*th1p*th2p*cos(th3)*sin(th2)*sin(th3) - 2*J22*J33*th1p*th2p*cos(th3)*sin(th2)*sin(th3))/(2*J11*J22);
Xp(12) = (J11*J33^2*th1p*th2p - J11^2*J33*th1p*th2p + J11*J33^2*th2p*th3p*sin(th2) - J11^2*J33*th2p*th3p*sin(th2) - J11*J22*J33*th1p*th2p + J11*J22^2*th1p*th2p*cos(th2)^2 - J11^2*J22*th1p*th2p*cos(th2)^2 - J11*J33^2*th1p*th2p*cos(th2)^2 + J11^2*J33*th1p*th2p*cos(th2)^2 - J11*J33^2*th1p*th2p*cos(th3)^2 + J11^2*J33*th1p*th2p*cos(th3)^2 + J22*J33^2*th1p*th2p*cos(th3)^2 - J22^2*J33*th1p*th2p*cos(th3)^2 + J11*J22*J33*th2p*th3p*sin(th2) + J11*J22^2*th1p^2*cos(th2)^3*cos(th3)*sin(th3) - J11^2*J22*th1p^2*cos(th2)^3*cos(th3)*sin(th3) - J11*J33^2*th1p^2*cos(th2)^3*cos(th3)*sin(th3) + J11^2*J33*th1p^2*cos(th2)^3*cos(th3)*sin(th3) + J22*J33^2*th1p^2*cos(th2)^3*cos(th3)*sin(th3) - J22^2*J33*th1p^2*cos(th2)^3*cos(th3)*sin(th3) - J11*J33^2*th2p*th3p*cos(th3)^2*sin(th2) + J11^2*J33*th2p*th3p*cos(th3)^2*sin(th2) + J22*J33^2*th2p*th3p*cos(th3)^2*sin(th2) - J22^2*J33*th2p*th3p*cos(th3)^2*sin(th2) - J22*J33*R*t*cos(th3)*sin(th2) + J11*J33*P*l*sin(th2)*sin(th3) - 2*J11*J22^2*th1p*th2p*cos(th2)^2*cos(th3)^2 + 2*J11^2*J22*th1p*th2p*cos(th2)^2*cos(th3)^2 + J11*J33^2*th1p*th2p*cos(th2)^2*cos(th3)^2 - J11^2*J33*th1p*th2p*cos(th2)^2*cos(th3)^2 - J22*J33^2*th1p*th2p*cos(th2)^2*cos(th3)^2 + J22^2*J33*th1p*th2p*cos(th2)^2*cos(th3)^2 - J11*J22^2*th2p^2*cos(th2)*cos(th3)*sin(th3) + J11^2*J22*th2p^2*cos(th2)*cos(th3)*sin(th3) + J11*J33^2*th1p^2*cos(th2)*cos(th3)*sin(th3) - J11^2*J33*th1p^2*cos(th2)*cos(th3)*sin(th3) - J22*J33^2*th1p^2*cos(th2)*cos(th3)*sin(th3) + J22^2*J33*th1p^2*cos(th2)*cos(th3)*sin(th3) + J11*J22*Jm*Yp*k*cos(th2) + J11*J33^2*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J11^2*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J22*J33^2*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J22^2*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th2)*sin(th3))/(J11*J22*J33*cos(th2));

end