%% Script per la pianificazione ottima

addpath(genpath('C:\Users\Tommaso\università\Controlli Automatici\Nuovo\Relazione\GitRepo\MatlabSimulink\Dinamica'));
run('eq_non_linear.m');

A = eval(A);
B = eval(B);
%X = [x,y,z,xp,yp,zp,th1,th2,th3,th1p,th2p,th3p];
%U = [H,R,P,Yp];
% A(12,:) = [];
% A(:,12) = [];
% B(9,:) = B(12,:);
% B(12,:) = [];
% C = eye(11);
% D = zeros(11,4);
C = eye(12);
D = zeros(12,4);

%% Verifico nuovamente il rango delle matrici di osservabilità e ragg.
% considero il sistema nella sua forma più generale 12x12
sys = ss(A,B,C,D);
rR = rank(ctrb(sys.a,sys.b));
rO = rank(obsv(sys.a,sys.c));

if rR==size(A,1)
    disp('Il rango di R è uguale alla dimensione dello stato ')
else
    warning('R non è rango pieno righe')
end
% if rO==size(A_num,1)
%     disp('Il rango di O è uguale alla dimensione dello stato ')
% else
%     warning('O non è rango pieno colonne')
% end

%% Discretize the system with ZOH
Ts = 0.1;
sys_d_zoh = c2d(sys,Ts,'zoh');
A_d_zoh = sys_d_zoh.a;
B_d_zoh = sys_d_zoh.b;
C_d_zoh = sys_d_zoh.c;
D_d_zoh = sys_d_zoh.d;

R_d_zoh = ctrb(A_d_zoh,B_d_zoh);
O_d_zoh = obsv(A_d_zoh,sys_d_zoh.c);
rR_d_zoh = rank(R_d_zoh);
rO_d_zoh = rank(O_d_zoh);

if rR_d_zoh==size(A,1)
    disp('Il rango di R_d_zoh è uguale a rR ')
else
    warning('R_d_zoh non è rango pieno righe')
end
% if rO_d_zoh==size(A_num,1)
%     disp('Il rango di O_d_zoh è uguale a rO ')
% else
%     warning('O_d_zoh non è rango pieno colonne')
% end

%% Discretize the system with Forward Euler
A_d_fe = Ts*A + eye(size(A,1));
B_d_fe = Ts*B; %le altre matrici sono invariate
C_d_fe = C;
D_d_fe = D;

R_d_fe = ctrb(A_d_fe,B_d_fe);
O_d_fe = obsv(A_d_fe,C_d_fe);
rR_d_fe = rank(R_d_fe);
rO_d_fe = rank(O_d_fe);

if rR_d_fe==size(A,1)
    disp('Il rango di R_d_fe è uguale a rR ')
else
    warning('R_d_zoh non è rango pieno righe')
end
% if rO_d_fe==size(A_num,1)
%     disp('Il rango di O_d_fe è uguale a rO ')
% else
%     warning('O_d_zoh non è rango pieno colonne')
% end

%% Optimal Planning

p = 50; %number of iterations higher or equal to size(A,1)
Ttot = p*Ts;
x_0 = [0;0;0;0;0;0;0;0;0;0;0;0]; %condizioni iniziali uguali all'equilibrio
x_fin = zeros(11,1);
x_fin(1) = 5;
x_fin(2) = 6;
x_fin(3) = 7;
x_fin(4) = 0;
x_fin(5) = 0;
x_fin(6) = 0;
x_fin(7) = 0;
x_fin(8) = 0;
x_fin(9) = 0;
x_fin(10) = 0;
x_fin(11) = 0;
x_fin(12) = 0;

%% Optimal Planning without constraints FE

Rp_d_fe = B_d_fe; %calcolo la matrice di raggiungibilità per fe
for i = 2:p
    Rp_d_fe = [B_d_fe, A_d_fe*Rp_d_fe];
end
u = pinv(Rp_d_fe)*(x_fin-A_d_fe^(p)*x_0); %soluzione in p passi del problema di pianificazione
u = reshape(u,4,p); %il vettore in uscita è un vettore colonna
u = transpose(u); %a seguito del reshape si effettua una trasposizione per ottenere dei vettori colonna
u = flip(u); %flip perché gli ingressi su simulink si susseguono dal tempo 0 al tempo finale

% Simulink Sim
timing = Ts*(0:(size(u,1)-1)).';
uSim = [timing,u];
y_lim = lsim(sys,u,timing, x_0,'zoh'); %Simulate time response of dynamic systems to arbitrary inputs.
ySim = [timing,y_lim];

%% Optimal Planning with posture holding FE

up = pinv(B_d_fe)*( (eye(size(A_d_fe,1))-A_d_fe)*x_fin); %final value of the input
Rp_d_fe_hold = Rp_d_fe;
Rp_d_fe_hold(:,1:4) = []; % occorre ridimensionare la matrice di raggiungibilità
u_hold = pinv(Rp_d_fe_hold)*(x_fin-A_d_fe^(p)*x_0-B_d_fe*up);  % calcolo i valori precedenti degli ingressi noto l'ultimo
u = [up;u_hold];
u = reshape(u,4,p); %il vettore in uscita è un vettore colonna
u = transpose(u); %a seguito del reshape si effettua una trasposizione per ottenere dei vettori colonna
u = flip(u); %flip perché gli ingressi su simulink si susseguono dal tempo 0 al tempo finale

% Simulink Sim
timing = Ts*(0:(size(u,1)-1)).';
uSim = [timing,u];
y_lim = lsim(sys,u,timing, x_0,'zoh'); %Simulate time response of dynamic systems to arbitrary inputs.
ySim = [timing,y_lim];

%% Optimal planning with posture holding and input bound
% per lower e upper bound si considera che la forza di spinta massima è 40N
% e quella minima pari a 0 e il sistema fisico sia in equilibrio grazie ad
% una forza verticale pari a 6N/4 per motore, dunque il lower bound è -6 e l'upper 34/4 per motore.
% Questi bound sono riferiti alle forze F11,F12,F21,F22, che sono associati
% agli ingressi H,R,P,Y attraverso le funzioni F11_HPRY,F12_HPRY,F21_HPRY,F22_HPRY
F_lb = -1.5;
F_ub = 8.5;
% F_lb = -4; %sequenza di ingressi più limitante per osservare la
% saturazione
% F_ub = 0.5;


% increase number of steps until the control is bounded
max_it = 1000;
p = 20; %starting step value

Rp_d_fe = B_d_fe; %calcolo la matrice di raggiungibilità al passo p
for i = 2:p
    Rp_d_fe = [B_d_fe, A_d_fe*Rp_d_fe];
end
% calcolo il valore finale degli ingressi per avere posture holding
up = pinv(B_d_fe)*( (eye(size(A_d_fe,1))-A_d_fe)*x_fin);
for i=1:max_it
    % calcolo il valore degli ingressi fino passo p-1
    Rp_d_fe_hold = Rp_d_fe;
    Rp_d_fe_hold(:,1:4) = []; % occorre ridimensionare la matrice di raggiungibilità
    u_hold = pinv(Rp_d_fe_hold)*(x_fin-A_d_fe^(p)*x_0-B_d_fe*up);
    % considero tutta la sequenza di tutti gli ingressi
    u = [up;u_hold];
    u = reshape(u,4,p); %il vettore in uscita è un vettore colonna, creo 4 sottovettori
    u = transpose(u); %a seguito del reshape si effettua una trasposizione per ottenere dei vettori colonna
    u = flip(u);
    u_Y = [u(:,1),u(:,2),u(:,3),cumtrapz(u(:,4))*Ts]; %l'input adesso è Yp, integro il segnale per avere Y
    %calcolo le forze sui singoli motori
    F11 = zeros(1,size(u,1));
    F12 = zeros(1,size(u,1));
    F21 = zeros(1,size(u,1));
    F22 = zeros(1,size(u,1));
    F = zeros(1,4);
    for j = 1:size(u,1)
        u_temp = u_Y(j,:);
        F11(j) = double(subs(F11_HPRY,[H,R,P,Y],u_temp));
        F12(j) = double(subs(F12_HPRY,[H,R,P,Y],u_temp));
        F21(j) = double(subs(F21_HPRY,[H,R,P,Y],u_temp));
        F22(j) = double(subs(F22_HPRY,[H,R,P,Y],u_temp));
        F = [F,[F11(j),F12(j),F21(j),F22(j)]]; %creo un unico vettore di tutte le forze
    end
    %definisco la condizione di uscita dal ciclo
    if F_lb<=min(F)&&F_ub>=max(F)
        break
    else
        p=p+1
        Rp_d_fe = [B_d_fe, A_d_fe*Rp_d_fe];
    end
    
end

u_Y = [u(:,1),u(:,2),u(:,3),cumtrapz(u(:,4))*Ts]; %l'input adesso è Yp, integro il segnale per avere Y
%calcolo le forze sui singoli motori
F11 = zeros(1,size(u,1));
F12 = zeros(1,size(u,1));
F21 = zeros(1,size(u,1));
F22 = zeros(1,size(u,1));
F = zeros(1,4);
for j = 2:size(u,1)
    u_temp = u_Y(j,:);
    F11 = double(subs(F11_HPRY,[H,R,P,Y],u_temp));
    F12 = double(subs(F12_HPRY,[H,R,P,Y],u_temp));
    F21 = double(subs(F21_HPRY,[H,R,P,Y],u_temp));
    F22 = double(subs(F22_HPRY,[H,R,P,Y],u_temp));
    F = [F;[F11,F12,F21,F22]]; %creo un unico vettore di tutte le forze
end
u = flipud(u);

% Simulink Sim
Ttot = p*Ts;
timing = Ts*(0:size(u,1)-1).';
FSim = [timing,F];
uSim = [timing,flipud(u)];
y_lim = lsim(sys,flipud(u),timing, x_0,'zoh'); %Simulate time response of dynamic systems to arbitrary inputs.
ySim = [timing,y_lim];

%% Optimal planning with posture holding and input bound fmincon
% dato che la condizione sugli ingressi non può essere espressa come a*u<b,
% dato che tra le u abbiamo Yp, si passa direttamente a fmincon

p = 2; %steps are not fixed
F_lb = -1.5;
% F_ub = 34/4;
F_ub = 8.5;
% considero gli ingressi del problema iniziale per utilizzare semplicemente
% fmincon
B_F = zeros(12,8);
B_F(6,:) = [1,1,1,1,0,0,0,0]/ms; %F11+F12+F21+F22 = H
B_F(10,:) = [1,-1,1,-1,0,0,0,0]*t/J11; %F11-F12+F21-F22 = R
B_F(11,:) = [-1,-1,1,1,0,0,0,0]*l/J22; %-F11-F12+F21+F22 = P
B_F(12,:) = [0,0,0,0,-1,1,1,-1]*Jm*k/J33; %-F11p+F12p+F21p-F22p = Yp
D_F = zeros(12,8);

B_d_fe = Ts*B_F; %le altre matrici sono invariate
Rp_d_fe = B_d_fe; %calcolo la matrice di raggiungibilità al passo p
for i = 2:p
    Rp_d_fe = [B_d_fe, A_d_fe*Rp_d_fe]; %la raggiungibilità non è influenzata dal cambio di variabili
end

up = pinv(B_d_fe)*( (eye(size(A_d_fe,1))-A_d_fe)*x_fin);

for i = 1:max_it
    
    % Lower and upper bound has to be add as matrixes for each time instant
    lb = [repmat(F_lb, p-1,4),repmat(0, p-1,4)];
    ub = [repmat(F_ub, p-1,4),repmat(0, p-1,4)];
    
    %matrici in fmincon per avere lo stato finale desiderato e il
    %mantenimento dello stato
    Rp_d_fe_hold = Rp_d_fe;
    Rp_d_fe_hold(:,1:8) = []; % occorre ridimensionare la matrice di raggiungibilità
    Aeq = Rp_d_fe_hold;
    beq = x_fin-A_d_fe^(p)*x_0-B_d_fe*up;
    
    % Function handle to be used in the fmincon command
    fOpt_handle = @(u)(myFun_fmincon(u)); %the input doesn't contains the integrated Y signal
    
    % Initial condition for fmincon
    u0 = zeros(8*(p-1),1);
    
    % Options
    myoptions = optimset('Algorithm','sqp');
    [u,FVAL,exitflag] = fmincon(fOpt_handle, u0, [], [], Aeq, beq, lb, ub,[], myoptions);
    
    cond = A_d_fe^(p)*x_0+Rp_d_fe_hold*u-x_fin;
    if norm(cond) < 0.001
        break
    else
        p = p+5;
        Rp_d_fe = B_d_fe; %calcolo la matrice di raggiungibilità al passo p
        for j = 2:p
            Rp_d_fe = [B_d_fe, A_d_fe*Rp_d_fe]; %la raggiungibilità non è influenzata dal cambio di variabili
        end
    end
    
end
%commentare questa parte se risulta un errore
%elimino i primi ingressi nulli per i quali l'ottimizzatore non trova una
%soluzione
indx = u==0;
Min = min(find(indx));
Max = max(find(indx));
Min = Max-8*round((Max-Min)/8);
len = length(u(Min+1:Max));
p = p-len/8;
u(Min+1:end) = [];

u = [up;u];
u = reshape(u,8,p); %il vettore in uscita è un vettore colonna, creo 4 sottovettori
u = transpose(u); %a seguito del reshape si effettua una trasposizione per ottenere dei vettori colonna
u = flip(u);
F = u(:,1:4);
u_HRPYp =zeros(size(u,1),4);
u_HRPYp(:,1) = u(:,1)+u(:,2)+u(:,3)+u(:,4);
u_HRPYp(:,2) = u(:,1)-u(:,2)+u(:,3)-u(:,4);
u_HRPYp(:,3) = -u(:,1)-u(:,2)+u(:,3)+u(:,4);
u_HRPYp(:,4) = -u(:,5)+u(:,6)+u(:,7)-u(:,8);

%ripristino le matrici del sistema e gli ingressi
A_d_fe = Ts*A + eye(size(A,1));
B_d_fe = Ts*B;
C_d_fe = C;
D_d_fe = D;
u = u_HRPYp;
Ttot = p*Ts;

% Simulink Sim
timing = Ts*(0:size(u,1)-1).';
FSim = [timing,F];
uSim = [timing,u];
y_lim = lsim(sys,u,timing, x_0,'zoh'); %Simulate time response of dynamic systems to arbitrary inputs.
ySim = [timing,y_lim];

%% Optimal planning with posture holding and input bound fmincon, Trajectory
% dato che la condizione sugli ingressi non può essere espressa come a*u<b,
% dato che tra le u abbiamo Yp, si passa direttamente a fmincon
for h = 1:3
    p = 60; %steps are not fixed
    F_lb = -1.5;
    F_ub = 8.5;
    x_obj = [5;4;5];
    x_fin(1) = 10;
    x_fin(2) = 8;
    x_fin(3) = 10;
    aa(1) = 0.2; %maggiore peso alla vicinanze
    aa(2) = 0.1; %peso funzione di costo Bilanciato
    aa(3) = 0.04; %maggiore pesoagli ingressi
    a = aa(h);
    % considero gli ingressi del problema iniziale per utilizzare semplicemente
    % fmincon
    B_F = zeros(12,8);
    B_F(6,:) = [1,1,1,1,0,0,0,0]/ms; %F11+F12+F21+F22 = H
    B_F(10,:) = [1,-1,1,-1,0,0,0,0]*t/J11; %F11-F12+F21-F22 = R
    B_F(11,:) = [-1,-1,1,1,0,0,0,0]*l/J22; %-F11-F12+F21+F22 = P
    B_F(12,:) = [0,0,0,0,-1,1,1,-1]*Jm*k/J33; %-F11p+F12p+F21p-F22p = Yp
    D_F = zeros(12,8);
    
    B_d_fe = Ts*B_F; %le altre matrici sono invariate
    Rp_d_fe = B_d_fe; %calcolo la matrice di raggiungibilità al passo p
    for i = 2:p
        Rp_d_fe = [B_d_fe, A_d_fe*Rp_d_fe]; %la raggiungibilità non è influenzata dal cambio di variabili
    end
    % assemblo la matrice per definire il vettore degli stati
    M = zeros(12*p,8*p);
    M(1:12,1:8) = B_d_fe;
    T = A_d_fe*B_d_fe;
    N = zeros(12*p,12);
    N(1:12,1:12) = A_d_fe;
    for i = 1:p-1
        M(1+12*i:12+12*i,1+8*i:8+8*i) = B_d_fe;
        M(1+12*i:12+12*i,1:8*i) = T;
        T = [A_d_fe^(i+1)*B_d_fe,T];
        N(1+12*i:12+12*i,1:12) = A_d_fe^(i+1);
    end
    Q = [N,M];
    % Lower and upper bound has to be add as matrixes for each time instant
    lb = [repmat(F_lb, p,4),repmat(0, p,4)];
    ub = [repmat(F_ub, p,4),repmat(0, p,4)];
    
    %matrici in fmincon per avere lo stato finale desiderato e il
    %mantenimento dello stato
    Aeq = Rp_d_fe; % u è un vettore da u_p-1 a u_0
    beq = x_fin;
    
    % Function handle to be used in the fmincon command
    fOpt_handle = @(u)(myFun_fmincon2(u,Q,x_0,x_obj,a,p)); %the input doesn't contains the integrated Y signal
    
    % Initial condition for fmincon
    u0 = zeros(8*p,1);
    
    % Options
    myoptions = optimset('Algorithm','sqp');
    [u,FVAL,exitflag] = fmincon(fOpt_handle, u0, [], [], Aeq, beq, lb, ub,[], myoptions);
    
    %commentare questa parte se risulta un errore
    %elimino i primi ingressi nulli per i quali l'ottimizzatore non trova una
    %soluzione
    indx = u==0;
    Min = min(find(indx));
    Max = max(find(indx));
    Min = Max-8*round((Max-Min)/8);
    len = length(u(Min+1:Max));
    p = p-len/8;
    u(Min+1:end) = [];
    
    u = reshape(u,8,p); %il vettore in uscita è un vettore colonna, creo 4 sottovettori
    u = transpose(u); %a seguito del reshape si effettua una trasposizione per ottenere dei vettori colonna
    u = flip(u);
    F = u(:,1:4);
    
    u_HRPYp =zeros(size(u,1),4);
    u_HRPYp(:,1) = u(:,1)+u(:,2)+u(:,3)+u(:,4);
    u_HRPYp(:,2) = u(:,1)-u(:,2)+u(:,3)-u(:,4);
    u_HRPYp(:,3) = -u(:,1)-u(:,2)+u(:,3)+u(:,4);
    u_HRPYp(:,4) = -u(:,5)+u(:,6)+u(:,7)-u(:,8);
    
    %ripristino le matrici del sistema e gli ingressi
    A_d_fe = Ts*A + eye(size(A,1));
    B_d_fe = Ts*B;
    C_d_fe = C;
    D_d_fe = D;
    u = u_HRPYp;
    Ttot = p*Ts;
    
    % Simulink Sim
    timing = Ts*(0:size(u,1)-1).';
    FSim = [timing,F];
    uSim = [timing,u];
    
    % Plot
    out = sim('DroneOptimalPlanning');
    x_out = out.state.Data(:,1);
    y_out = out.state.Data(:,2);
    z_out = out.state.Data(:,3);
    
    figure
    plot3(x_out,y_out,z_out)
    hold on
    plot3(x_obj(1),x_obj(2),x_obj(3),'o')
    plot3(x_obj(1),x_obj(2),x_obj(3),'o','MarkerSize',20)
    grid on
    pbaspect([1 1 1])
    axis equal
    xlabel('x [m]');
    ylabel('y [m]');
    zlabel('z [m]');
    % axis([0 10 0 10 0 10])
    if h==1
        title('a = 0.2')
    elseif h==2
        title('a = 0.1')
    elseif h==3
        title('a = 0.04')
    else
    end
    for jj =1:length(timing)
        p = plot3(x_out(jj),y_out(jj),z_out(jj),'bo','MarkerSize',5);
        pause(0.2)
    end
end
%% Funzioni per fmincon
function out = myFun_fmincon2(in,Q,x_0,x_obj,a,p)
% Define the input for the fmincon function to minimize the derivative of
% the input
u = in;

u = reshape(u,8,p); %il vettore in uscita è un vettore invertito rispetto a quello che mi serve
u = transpose(u);
u = flip(u);
u = transpose(u);
u = reshape(u,1,size(u,1)*size(u,2));
u = transpose(u);
u_flip = u;

% u_flip = flip(in);
v = [x_0;u_flip];
X = Q*v;
X = reshape(X,3,size(X,1)/3); %considero solo gli ingressi x y z
X_temp = zeros(3,size(X,2)/4);
for j =1:size(X_temp,2)
    X_temp(1:3,j) = X(1:3,1+4*(j-1));
end
X = X_temp;
d = ones(1,size(X,2));
for j =1:size(X,2)
    d(j) = norm(x_obj-X(:,j),2);
end
% d_min = min(abs(d));
out = (1-a)*norm(in,2)+a*norm(1./abs(d),1);
% out = (1-a)*norm(u,2)+a*1/d_min;
end

function out = myFun_fmincon(in)
% Define the input for the fmincon function to minimize the derivative of
% the input
u = in;

out = norm(u,2);
end




