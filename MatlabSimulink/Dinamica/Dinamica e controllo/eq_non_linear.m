%% Scrip per la scrittura della dinamica del sistema non lineare
% lo script segue il filo logico della relazione 

syms th1 th2 th3 th1p th2p th3p th1pp th2pp th3pp J11 J12 J13 J22 J23 J33 x y z xp yp zp 
syms ms xpp ypp zpp t l Jm w11p w12p w21p w22p F11 F12 F21 F22 F11p F12p F21p F22p k g
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
K_g_p = simplify(J_g*w_b_p + W_b*J_g*w_b); % derivata del momento angolare, terna solidale
%% Forze thrust
% utili solo nel caso si voglia modellare la dinamica dei motori 
w11 = F11*k;
w12 = F12*k;
w21 = F21*k;
w22 = F22*k;

%% Prima cardinale
F_tot = Rsb*[0;0;F11+F12+F21+F22]-[0;0;ms*g];
I = ms*[xpp;ypp;zpp];

%% Momenti
Mx = (F11+F21-F12-F22)*t;
My = (F22+F21-F11-F12)*l;
Mz = (-F11p+F12p+F21p-F22p)*k*Jm; % da Fij = k wij

%% Forma di stato 
sol = solve(F_tot(1)==I(1),F_tot(2)==I(2),F_tot(3)==I(3),Mx==K_g_p(1),My==K_g_p(2),Mz==K_g_p(3),xpp,ypp,zpp,th1pp,th2pp,th3pp);

%% Verifica della posizione di equilibrio 
X_sym = [th1,th2,th3,th1p,th2p,th3p,xpp,ypp,zpp,F11,F12,F21,F22,F11p,F12p,F21p,F22p];
eq1 = subs(sol.xpp,X_sym,[0,0,0,0,0,0,0,0,0,ms/4*g,ms/4*g,ms/4*g,ms/4*g,0,0,0,0]);
eq2 = subs(sol.ypp,X_sym,[0,0,0,0,0,0,0,0,0,ms/4*g,ms/4*g,ms/4*g,ms/4*g,0,0,0,0]);
eq3 = subs(sol.zpp,X_sym,[0,0,0,0,0,0,0,0,0,ms/4*g,ms/4*g,ms/4*g,ms/4*g,0,0,0,0]);
eq4 = subs(sol.th1pp,X_sym,[0,0,0,0,0,0,0,0,0,ms/4*g,ms/4*g,ms/4*g,ms/4*g,0,0,0,0]);
eq5 = subs(sol.th2pp,X_sym,[0,0,0,0,0,0,0,0,0,ms/4*g,ms/4*g,ms/4*g,ms/4*g,0,0,0,0]);
eq6 = subs(sol.th3pp,X_sym,[0,0,0,0,0,0,0,0,0,ms/4*g,ms/4*g,ms/4*g,ms/4*g,0,0,0,0]);
if eq1==0&eq2==0&eq3==0&eq4==0&eq5==0&eq6==0
    disp('equilibrio verificato')
else
    disp('La configurazione non è di equilibrio')
end

%% Linearizzazione del sistema intorno all'equilibrio
%traslo il sistema nell'equilibrio in modo che le variabili ne siano una
%perturbazione 
f1 = subs(sol.xpp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
f2 = subs(sol.ypp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
f3 = subs(sol.zpp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
f4 = subs(sol.th1pp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
f5 = subs(sol.th2pp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
f6 = subs(sol.th3pp,[F11,F12,F21,F22],[F11+ms/4*g,F12+ms/4*g,F21+ms/4*g,F22+ms/4*g]);
 
X = [x,y,z,xp,yp,zp,th1,th2,th3,th1p,th2p,th3p];
X_eq = [0,0,0,0,0,0,0,0,0,0,0,0];
U = [F11,F12,F21,F22,F11p,F12p,F21p,F22p];
U_eq = [0,0,0,0,0,0,0,0];
f= [f1;f2;f3;f4;f5;f6];
f_linear_X = jacobian(f,X);
f_linear_U = jacobian(f,U);
f_linear = sum(subs(f_linear_X,[X, U],[X_eq,U_eq]).*X,2) + sum(subs(f_linear_U,[X, U],[X_eq,U_eq]).*U,2)

%% Cambio di variabili 
syms H P R Y Hp Pp Rp Yp
HH = F11+F12+F21+F22;
PP = -F11-F12+F21+F22;
RR = F11+F21-F12-F22;
YY = -(F11+F22-F12-F21);
sol_HPRY = solve(HH == H,PP == P, RR == R,YY == Y,F11,F12,F21,F22);
F11_HPRY = sol_HPRY.F11;
F12_HPRY = sol_HPRY.F12;
F21_HPRY = sol_HPRY.F21;
F22_HPRY = sol_HPRY.F22;
F11_HPRYp = subs(sol_HPRY.F11,[H, P, R, Y],[Hp, Pp, Rp, Yp]);
F12_HPRYp = subs(sol_HPRY.F12,[H, P, R, Y],[Hp, Pp, Rp, Yp]);
F21_HPRYp = subs(sol_HPRY.F21,[H, P, R, Y],[Hp, Pp, Rp, Yp]);
F22_HPRYp = subs(sol_HPRY.F22,[H, P, R, Y],[Hp, Pp, Rp, Yp]);
f_linear_HPRY = simplify(subs(f_linear,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]))

%% Equazioni del sistema non lineare intorno all'equilibrio e cambio di variabile
f1_eq = simplify(subs(f1,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f2_eq = simplify(subs(f2,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f3_eq = simplify(subs(f3,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f4_eq = simplify(subs(f4,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f5_eq = simplify(subs(f5,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));
f6_eq = simplify(subs(f6,[F11,F12,F21,F22,F11p,F12p,F21p,F22p],[F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY,F11_HPRYp,F12_HPRYp,F21_HPRYp,F22_HPRYp]));

%%  Transfer function e state space per il modello linearizzato 
    X = [x,y,z,xp,yp,zp,th1,th2,th3,th1p,th2p,th3p];
A = sym(zeros(12,12));
A(1,4) = 1;
A(2,5) = 1;
A(3,6) = 1;
A(7,10) = 1;
A(8,11) = 1;
A(9,12) = 1;
    A4_6 = subs(f_linear_X,[X, U],[X_eq,U_eq]);
    A4_6 = A4_6(1:3,1:end);
A(4:6,1:end) = A4_6;
    A10_12 = subs(f_linear_X,[X, U],[X_eq,U_eq]);
    A10_12 = A10_12(4:6,1:end);
A(10:12,1:end) = A10_12;

    U = [H,R,P,Y];
B = sym(zeros(12,4));
B(6,1) = 1/ms;
B(10,2) = t/J11;
B(11,3) = l/J22;
        B(12,4) = Jm*k/J33;
A
B
disp('A and B come from')
f_linear_HPRY

C = sym(zeros(4,size(A,1)));
C(1,3) = 1;
C(2,7) = 1;
C(3,8) = 1;
C(4,12) = 1;

D = sym(zeros(4,4));

% sys = symtosys(A,B,C,D);
% sys_tf = tf(sys);
% step(sys);
%% Matrice di raggiungibilità
Rr = B;
for I=2:(size(A,1)-1)
    Rr = [Rr,A*Rr];
    if rank(Rr)==size(A,1)
        break
    end
end
disp('rank(R)=')
rank(Rr)
Rr
%% Matrice di osservabilità
O = C;
for I=2:(size(A,1)-1)
   O = [O;C*A];
   if rank(O)==size(A,1)
       break
   end
end
disp('rank(O)=')
rank(O)
O

%% Matrice di osservabilità stato semplificato 
% definizione delle matrici rispetto al nuovo stato considerato 
X_num = [z,zp,th1,th1p,th2,th2p,th3p];
[ms, t, l, Jm, k, J11, J12, J13, J22, J23, J33, g] = params_drone;
A_num = eval(A);
A_num(1:2,:) = [];
A_num(:,1:2) = [];
A_num(2:3,:) = [];
A_num(:,2:3) = [];
A_num(5,:) = [];
A_num(:,5) = [];
A_num([4,5],:) = A_num([5,4],:);
A_num(:,[4,5]) = A_num(:,[5,4]);
B_num = eval(B);
B_num(1:2,:) = [];
B_num(2:3,:) = [];
B_num(5,:) = [];
B_num([4,5],:) = B_num([5,4],:);
C_num = eval(C);
C_num(:,1:2) = [];
C_num(:,2:3) = [];
C_num(:,5) = [];
C_num(:,[4,5]) = C_num(:,[5,4]);
D_num = eval(D);
%% Matrice di raggiungibilità stato semplificato
R_num = B_num;
for I=2:(size(A_num,1)-1)
    R_num = [R_num,A_num*R_num];
    if rank(R_num)==size(A_num,1)
        break
    end
end
disp('rank(R_num)=')
rank(R_num)
R_num
%% Matrice di osservabilità stato semplificato
O_num = C_num;
for I=2:(size(A_num,1)-1)
   O_num = [O_num;C_num*A_num];
   if rank(O_num)==size(A_num,1)
       break
   end
end
disp('rank(O_num)=')
rank(O_num)
O_num

sys_num = ss(A_num,B_num,C_num,D_num);
sys_tf_num = tf(sys_num);
% step(sys_num);
T = 0.002;
[A_num_d,B_num_d,C_num_d,D_num_d] = c2dt(A_num,B_num,C_num,T,0);
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



