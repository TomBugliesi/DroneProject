%% Scrip per la scrittura della dinamica del sistema non lineare

syms th1 th2 th3 th1p th2p th3p th1pp th2pp th3pp J11 J12 J13 J22 J23 J33
syms ms xpp ypp zpp t l Jm w11p w12p w21p w22p F11 F12 F21 F22 F11p F12p F21p F22p k
%% Velocità angolari
R23 = [cos(th3),-sin(th3),0;...
    sin(th3),cos(th3),0;...
    0,0,1];
R12 = [cos(th2),0,sin(th2);...
    0,1,0;...
    -sin(th2),0,cos(th2)];
R01 = [1,0,0;...
    0,cos(th1),-sin(th1);...
    0,sin(th1),cos(th1)];

Rsb = R01*R12*R23; %composiizone in assi correnti di rotazioni
Rbs = transpose(Rsb); 

Rsb_th1 = diff(Rsb,th1);
Rsb_th2 = diff(Rsb,th2);
Rsb_th3 = diff(Rsb,th3);

column1 = [1;0;0]; %Rotazione rispetto a x
column2 = R01*[0;1;0];
column3 = R01*R12*[0;0;1]; %relazione tra la velocità angolare e le derivate degli angoli RPY

w_s = [column1,column2,column3]*[th1p;th2p;th3p];
W_s=hat(w_s);

W_b = simplify(Rbs*W_s*Rsb);
w_b = hat_inv(W_b);

%% Derivata del momento angolare

% J_g = [J11,J12,J13;...
%     J12,J22,J23;...
%     J13,J23,J33];
J_g = [J11,0,0;...
    0,J22,0;...
    0,0,J33];
w_b_p = diff(w_b,th1)*th1p+diff(w_b,th2)*th2p+diff(w_b,th3)*th3p+...
    diff(w_b,th1p)*th1pp+diff(w_b,th2p)*th2pp+diff(w_b,th3p)*th3pp; %variazione del momento angolare associata a \dot(w_b}
K_g_p = simplify(J_g*w_b_p+W_b*J_g*w_b); % derivata del momento angolare, terna solidale
%% Forze thrust
% utili solo nel caso si voglia modellare la dinamica dei motori 
w11 = F11*k;
w12 = F12*k;
w21 = F21*k;
w22 = F22*k;

%% Prima cardinale
F_tot = Rsb*[0;0;F11+F12+F21+F22]-[0;0;ms*9.81];
I = ms*[xpp;ypp;zpp];

%% Momenti
Mx = (F11+F21-F12-F22)*t;
My = (F22+F21-F11-F12)*l;
Mz = (-F11p+F12p+F21p-F22p)*k*Jm; % da Fij = k wij

%% Forma di stato 
sol = solve(F_tot(1)==I(1),F_tot(2)==I(2),F_tot(3)==I(3),Mx==K_g_p(1),My==K_g_p(2),Mz==K_g_p(3),xpp,ypp,zpp,th1pp,th2pp,th3pp);

%% Funzioni utili
% definiscono la matrice antisimmetrica per la scrittura del prodotto
% vettoriale e il vettore associato alla forma antisimmetrica
function W = hat(w)
w1 = w(1);
w2 = w(2);
w3 = w(3);

W = [0,-w3,w2;...
    w3,0,-w1;...
    -w2,w1,0];
end
function w = hat_inv(W)
w1 = -W(2,3);
w3 = -W(1,2);
w2 = W(1,3);

w = [w1; w2; w3];
end



