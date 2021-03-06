function Xp = x_d_fun_ras(X,input1,input2)
% La funzione riporta la differenza tra la derivata dello stato del sistema
% non lineare e quella del linearizzato, dunque X_p_real-X_p_lin
z = X(1);
zp = X(2);
x1z = X(3);
x2z = X(4);
th1 = X(5);
th1p = X(6);
x1th1 = X(7);
x2th1 = X(8);
th2 = X(9);
th2p = X(10);
x1th2 = X(11);
x2th2 = X(12);
th3 = X(13);
x1th3 = X(14);
th3p = 0;
input1 = eval(input1);
input2 = eval(input2);
H = 0; %input2(1)
R = 0; %input2(2)
P = 0; %input2(3)
Y = 0; %input2(4);
%% Parametri
[ms, t, l, Jm, k, J11, J12, J13, J22, J23, J33, g] = params_drone;

%% X_p_real-X_p_lin
%Rispetto al nuovo stato
    % X = z,zp,x1z,x2z,th1,th1p,x1th1,x2th1,th2,th2p,x1th2,x2th2,th3,x1th3
    % U = [H,R,P,Y
    % data la scelta di controllare il sistema in Y, non è definito nello
    % stato il valore d th3p, la cui presenza non è fondamentale nel
    % sistema lineare, ma è invece chiave per il sistema non lineare. Anzi
    % di ricalcolare i controllori per soddisfare questo requisito, si
    % assume th3p = 0, del resto la linearizzazione e il controllo sono
    % validi per th3 che variano in un intorno limitato, che tuttavia sono
    % delle ipotesi di per sé non soddisfacenti nei casi reali. 

Xp(1) = 0; %zp- input1(1)
Xp(2) = (H*cos(th1)*cos(th2) - g*ms + g*ms*cos(th1)*cos(th2))/ms-H/ms; %-input1(2)
Xp(3) = 0;
Xp(4) = 0;
Xp(5) = 0; %th1p-input1(5)
Xp(6) = +(J11^2*th2p*th3p - J11^2*th2p*th3p*cos(th3)^2 + J22^2*th2p*th3p*cos(th3)^2 + J22*R*t*cos(th3) - J11*P*l*sin(th3) + J11^2*th1p*th2p*sin(th2) - J11*J22*th2p*th3p - J11*J33*th2p*th3p - J11^2*th1p*th2p*cos(th3)^2*sin(th2) + J22^2*th1p*th2p*cos(th3)^2*sin(th2) + J11*J33*th2p*th3p*cos(th3)^2 - J22*J33*th2p*th3p*cos(th3)^2 + J11*J22*th1p*th2p*sin(th2) - J11*J33*th1p*th2p*sin(th2) + J11^2*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J22^2*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J11^2*th1p*th3p*cos(th2)*cos(th3)*sin(th3) - J22^2*th1p*th3p*cos(th2)*cos(th3)*sin(th3) + J11*J33*th1p*th2p*cos(th3)^2*sin(th2) - J22*J33*th1p*th2p*cos(th3)^2*sin(th2) - J11*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) + J22*J33*th1p^2*cos(th2)*cos(th3)*sin(th2)*sin(th3) - J11*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th3) + J22*J33*th1p*th3p*cos(th2)*cos(th3)*sin(th3))/(J11*J22*cos(th2))-(R*t)/J11; %-input1(6)
Xp(7) = 0;
Xp(8) = 0;
Xp(9) = 0; %th2p-input1(9)
Xp(10) = +(J22*J33*th1p^2*sin(2*th2) - J22^2*th1p^2*sin(2*th2) - J11^2*th2p*th3p*sin(2*th3) + J22^2*th2p*th3p*sin(2*th3) + 2*J11*P*l*cos(th3) + 2*J22*R*t*sin(th3) - 2*J22^2*th1p*th3p*cos(th2) - 2*J11^2*th1p*th3p*cos(th2)*cos(th3)^2 + 2*J22^2*th1p*th3p*cos(th2)*cos(th3)^2 + J11*J33*th2p*th3p*sin(2*th3) - J22*J33*th2p*th3p*sin(2*th3) + 2*J11*J22*th1p*th3p*cos(th2) + 2*J22*J33*th1p*th3p*cos(th2) - 2*J11^2*th1p^2*cos(th2)*cos(th3)^2*sin(th2) + 2*J22^2*th1p^2*cos(th2)*cos(th3)^2*sin(th2) - 2*J11^2*th1p*th2p*cos(th3)*sin(th2)*sin(th3) + 2*J22^2*th1p*th2p*cos(th3)*sin(th2)*sin(th3) + 2*J11*J33*th1p^2*cos(th2)*cos(th3)^2*sin(th2) - 2*J22*J33*th1p^2*cos(th2)*cos(th3)^2*sin(th2) + 2*J11*J33*th1p*th3p*cos(th2)*cos(th3)^2 - 2*J22*J33*th1p*th3p*cos(th2)*cos(th3)^2 + 2*J11*J33*th1p*th2p*cos(th3)*sin(th2)*sin(th3) - 2*J22*J33*th1p*th2p*cos(th3)*sin(th2)*sin(th3))/(2*J11*J22)-(P*l)/J22; %-input1(10)
Xp(11) = 0;
Xp(12) = 0;
Xp(13) = 0; %th3p-input1(13);
Xp(14) = 0;

end
