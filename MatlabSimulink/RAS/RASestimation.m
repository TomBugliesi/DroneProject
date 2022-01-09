%% Script per la stima della RAS

addpath(genpath('C:\Users\Tommaso\università\Controlli Automatici\Nuovo\Relazione\GitRepo\MatlabSimulink\Dinamica'));
run('controlloLQR.m');
clc
close all

% Definisco i controllori PID
sys_z_PID = pid(10,6,10);
sys_R_PID = pid(1,1,0.5);
sys_Y_PID = pid(1,1,1);

% definisco la funzione di trasferimento in catena diretta 
dir_PID_z = feedback(sys_z_PID*sys_z,1); %catena diretta 
dir_PID_R = feedback(sys_R_PID*sys_R,1); %catena diretta 
dir_PID_P = feedback(sys_R_PID*sys_R,1); %catena diretta 
dir_PID_Y = feedback(sys_Y_PID*sys_Y,1); %catena diretta 

% mi riporto in forma di stato per assemblare le matrici risultanti in
% un'unica matrice 
G_PID_z = tf(dir_PID_z);
poli_PID_z = zpk(G_PID_z).p{1}
zeri_PID_z = zpk(G_PID_z).z{1};
dir_PID_z = ss(G_PID_z);
A_z_PID = dir_PID_z.a;
B_z_PID = dir_PID_z.b;
C_z_PID = dir_PID_z.c;
D_z_PID = dir_PID_z.d;

G_PID_R = tf(dir_PID_R);
poli_PID_R = zpk(G_PID_R).p{1}
zeri_PID_R = zpk(G_PID_R).z{1};
dir_PID_R = ss(G_PID_R);
A_R_PID = dir_PID_R.a;
B_R_PID = dir_PID_R.b;
C_R_PID = dir_PID_R.c;
D_R_PID = dir_PID_R.d;

G_PID_P = tf(dir_PID_P);
poli_PID_P = zpk(G_PID_P).p{1}
zeri_PID_P = zpk(G_PID_P).z{1};
dir_PID_P = ss(G_PID_P);
A_P_PID = dir_PID_P.a;
B_P_PID = dir_PID_P.b;
C_P_PID = dir_PID_P.c;
D_P_PID = dir_PID_P.d;

G_PID_Y = tf(dir_PID_Y);
poli_PID_Y = zpk(G_PID_Y).p{1}
zeri_PID_Y = zpk(G_PID_Y).z{1}
dir_PID_Y = ss(G_PID_Y);
A_Y_PID = dir_PID_Y.a;
B_Y_PID = dir_PID_Y.b;
C_Y_PID = dir_PID_Y.c;
D_Y_PID = dir_PID_Y.d;

% Verifico gli autovalori dei sottoblocchi della funzione di trasferimento
% complessiva 
disp('eig(A_z_PID)=')
eig(A_z_PID)
disp('eig(A_R_PID)=')
eig(A_R_PID)
disp('eig(A_P_PID)=')
eig(A_P_PID)
disp('eig(A_Y_PID)=')
eig(A_Y_PID)

% assemblo il istema in forma di stato e verifico la corrispondenza tra i
% risultati del PID implementato su simulink e del PID ottenuto su matlab 
A_PID = [A_z_PID,zeros(size(A_z_PID,1),size(A_R_PID,2)),zeros(size(A_z_PID,1),size(A_P_PID,2)),zeros(size(A_z_PID,1),size(A_Y_PID,2));...
    zeros(size(A_R_PID,1),size(A_z_PID,2)),A_R_PID,zeros(size(A_R_PID,1),size(A_P_PID,2)),zeros(size(A_R_PID,1),size(A_Y_PID,2));...
    zeros(size(A_P_PID,1),size(A_z_PID,2)),zeros(size(A_P_PID,1),size(A_R_PID,2)),A_R_PID,zeros(size(A_P_PID,1),size(A_Y_PID,2));...
    zeros(size(A_Y_PID,1),size(A_z_PID,2)),zeros(size(A_Y_PID,1),size(A_R_PID,2)),zeros(size(A_Y_PID,1),size(A_P_PID,2)),A_Y_PID];

B_PID = [B_z_PID,zeros(size(B_z_PID,1),size(B_R_PID,2)),zeros(size(B_z_PID,1),size(B_P_PID,2)),zeros(size(B_z_PID,1),size(B_Y_PID,2));...
    zeros(size(B_R_PID,1),size(B_z_PID,2)),B_R_PID,zeros(size(B_R_PID,1),size(B_P_PID,2)),zeros(size(B_R_PID,1),size(B_Y_PID,2));...
    zeros(size(B_P_PID,1),size(B_z_PID,2)),zeros(size(B_P_PID,1),size(B_R_PID,2)),B_R_PID,zeros(size(B_P_PID,1),size(B_Y_PID,2));...
    zeros(size(B_Y_PID,1),size(B_z_PID,2)),zeros(size(B_Y_PID,1),size(B_R_PID,2)),zeros(size(B_Y_PID,1),size(B_P_PID,2)),B_Y_PID];

C_PID = [C_z_PID,zeros(size(C_z_PID,1),size(C_R_PID,2)),zeros(size(C_z_PID,1),size(C_P_PID,2)),zeros(size(C_z_PID,1),size(C_Y_PID,2));...
    zeros(size(C_R_PID,1),size(C_z_PID,2)),C_R_PID,zeros(size(C_R_PID,1),size(C_P_PID,2)),zeros(size(C_R_PID,1),size(C_Y_PID,2));...
    zeros(size(C_P_PID,1),size(C_z_PID,2)),zeros(size(C_P_PID,1),size(C_R_PID,2)),C_R_PID,zeros(size(C_P_PID,1),size(C_Y_PID,2));...
    zeros(size(C_Y_PID,1),size(C_z_PID,2)),zeros(size(C_Y_PID,1),size(C_R_PID,2)),zeros(size(C_Y_PID,1),size(C_P_PID,2)),C_Y_PID];

D_PID = [D_z_PID,zeros(size(D_z_PID,1),size(D_R_PID,2)),zeros(size(D_z_PID,1),size(D_P_PID,2)),zeros(size(D_z_PID,1),size(D_Y_PID,2));...
    zeros(size(D_R_PID,1),size(D_z_PID,2)),D_R_PID,zeros(size(D_R_PID,1),size(D_P_PID,2)),zeros(size(D_R_PID,1),size(D_Y_PID,2));...
    zeros(size(D_P_PID,1),size(D_z_PID,2)),zeros(size(D_P_PID,1),size(D_R_PID,2)),D_R_PID,zeros(size(D_P_PID,1),size(D_Y_PID,2));...
    zeros(size(D_Y_PID,1),size(D_z_PID,2)),zeros(size(D_Y_PID,1),size(D_R_PID,2)),zeros(size(D_Y_PID,1),size(D_P_PID,2)),D_Y_PID];

% Procedo con un approccio equivalente ma evidenziando gli stati del
% controllore e del sistema. Non utilizzo il PID ma Lqr in retroazione

%forma di stato dei controllori in catena diretta
sys_z_lqr = reg_fb_lqr_z;
sys_R_lqr = reg_fb_lqr_R;
sys_Y_lqr = reg_fb_lqr_Y;

%forma di stato dei sottoblocchi del sistema
sys_z
sys_R
sys_Y

% calcolo la matrice in forma estesa 
clear A B C A_c B_c C_c D_c 
syms A B C A_c B_c C_c D_c 
A_s = [A-B*D_c*C, B*C_c;...
    -B_c*C, A_c];

A_s_z = [ sys_z.a-sys_z.b*sys_z_lqr.d*sys_z.c,sys_z.b*sys_z_lqr.c ;...
    -sys_z_lqr.b*sys_z.c,sys_z_lqr.a ];
A_s_R = [ sys_R.a-sys_R.b*sys_R_lqr.d*sys_R.c,sys_R.b*sys_R_lqr.c ;...
    -sys_R_lqr.b*sys_R.c,sys_R_lqr.a ];
A_s_P = [ sys_R.a-sys_R.b*sys_R_lqr.d*sys_R.c,sys_R.b*sys_R_lqr.c ;...
    -sys_R_lqr.b*sys_R.c,sys_R_lqr.a ];
A_s_Y = [ sys_Y.a-sys_Y.b*sys_Y_lqr.d*sys_Y.c,sys_Y.b*sys_Y_lqr.c ;...
    -sys_Y_lqr.b*sys_Y.c,sys_Y_lqr.a ];
A_s_hat = [A_s_z,zeros(size(A_s_z,1),size(A_s_R,2)),zeros(size(A_s_z,1),size(A_s_P,2)),zeros(size(A_s_z,1),size(A_s_Y,2));...
    zeros(size(A_s_R,1),size(A_s_z,2)),A_s_R,zeros(size(A_s_R,1),size(A_s_P,2)),zeros(size(A_s_R,1),size(A_s_Y,2));...
    zeros(size(A_s_P,1),size(A_s_z,2)),zeros(size(A_s_P,1),size(A_s_R,2)),A_s_R,zeros(size(A_s_P,1),size(A_s_Y,2));...
    zeros(size(A_s_Y,1),size(A_s_z,2)),zeros(size(A_s_Y,1),size(A_s_R,2)),zeros(size(A_s_Y,1),size(A_s_P,2)),A_s_Y];

%scrivo il nuovo stato
    % X = z,zp,x1z,x2z,th1,th1p,x1th1,x2th1,th2,th2p,x1th2,x2th2,th3,x1th3
    % U = [H,R,P,Y
    
%% Run ras estimation
% Dati
Rmin = 500;
Rmax = 1250;
N_iter_R = 1250;
N_iter_Q = 60;
DR = 250;

ras_estimate(A_s_hat,Rmin,Rmax,DR,@x_d_fun_ras,N_iter_R,N_iter_Q)




