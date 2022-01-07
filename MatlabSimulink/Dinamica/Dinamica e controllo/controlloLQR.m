%% Script per la definzione dei controllori in catena diretta e di retroazione con logica LQR
run('controllo.m');
clc %mostrare nella command window solo gli elementi del presente script

%%  Soluzione LQR z,zp
Q_z = [100,0;0,1]*eye(2)*C_z'*C_z
R_z = 1;

[K_lqr_z,S_lqr_z,p_lqr_z] = lqr(sys_z,Q_z,R_z)

% Calcolo della matrice L a partire dalla soluzione LQR

q_lqr_z = 5*p_lqr_z;

K_lqr_z = place(A_z,B_z,p_lqr_z);
L_lqr_z = place(A_z',C_z',q_lqr_z)';

reg_dir_lqr_z = ss(A_z-B_z*K_lqr_z-L_lqr_z*C_z,L_lqr_z,K_lqr_z,0);
reg_fb_lqr_z = ss(A_z-B_z*K_lqr_z-L_lqr_z*C_z,-L_lqr_z,-K_lqr_z,0);
G0_fb_lqr_z = dcgain(reg_fb_lqr_z); 

%%  Soluzione LQR R e P
Q_R = C_R'*C_R
R_R = 1;

[K_lqr_R,S_lq0r_R,p_lqr_R] = lqr(A_R,B_R,Q_R,R_R)

% Calcolo della matrice L a partire dalla soluzione LQR

q_lqr_R = 5*p_lqr_R;

K_lqr_R = place(A_R,B_R,p_lqr_R);
L_lqr_R = place(A_R',C_R',q_lqr_R)';

reg_dir_lqr_R = ss(A_R-B_R*K_lqr_R-L_lqr_R*C_R,L_lqr_R,K_lqr_R,0);
reg_fb_lqr_R = ss(A_R-B_R*K_lqr_R-L_lqr_R*C_R,-L_lqr_R,-K_lqr_R,0);
G0_fb_lqr_R = dcgain(reg_fb_lqr_R); 

%%  Soluzione LQR Y
Q_Y = 1*C_Y'*C_Y
R_Y = 1;

[K_lqr_Y,S_lq0r_Y,p_lqr_Y] = lqr(A_Y,B_Y,Q_Y,R_Y)

% Calcolo della matrice L a partire dalla soluzione LQR

q_lqr_Y = 5*p_lqr_Y;

K_lqr_Y = place(A_Y,B_Y,p_lqr_Y);
L_lqr_Y = place(A_Y',C_Y',q_lqr_Y)';

reg_dir_lqr_Y = ss(A_Y-B_Y*K_lqr_Y-L_lqr_Y*C_Y,L_lqr_Y,K_lqr_Y,0);
reg_fb_lqr_Y = ss(A_Y-B_Y*K_lqr_Y-L_lqr_Y*C_Y,-L_lqr_Y,-K_lqr_Y,0);
G0_fb_lqr_Y = dcgain(reg_fb_lqr_Y); 

%% Check poli e zeri lqr z,zp
dir_lqr_z = feedback(sys_z*reg_dir_lqr_z,1); %catena diretta 
Gd_lqr_z = tf(dir_lqr_z)
poli_d_lqr_z = zpk(Gd_lqr_z).p{1}
zeri_d_lqr_z = zpk(Gd_lqr_z).z{1}

fb_lqr_z = feedback(sys_z, reg_fb_lqr_z); %catena di retroazione
Gf_lqr_z = tf(fb_lqr_z)
poli_f_lqr_z = zpk(Gf_lqr_z).p{1}
zeri_f_lqr_z = zpk(Gf_lqr_z).z{1}

%% Check poli e zeri lqr R e P
dir_lqr_R = feedback(sys_R*reg_dir_lqr_R,1); %catena diretta 
Gd_lqr_R = tf(dir_lqr_R)
poli_d_lqr_R = zpk(Gd_lqr_R).p{1}
zeri_d_lqr_R = zpk(Gd_lqr_R).z{1}

fb_lqr_R = feedback(sys_R, reg_fb_lqr_R); %catena di retroazione
Gf_lqr_R = tf(fb_lqr_R)
poli_f_lqr_R = zpk(Gf_lqr_R).p{1}
zeri_f_lqr_R = zpk(Gf_lqr_R).z{1}

%% Check poli e zeri lqr R e P
dir_lqr_Y = feedback(sys_Y*reg_dir_lqr_Y,1); %catena diretta 
Gd_lqr_Y = tf(dir_lqr_Y)
poli_d_lqr_Y = zpk(Gd_lqr_Y).p{1}
zeri_d_lqr_Y = zpk(Gd_lqr_Y).z{1}

fb_lqr_Y = feedback(sys_Y, reg_fb_lqr_Y); %catena di retroazione
Gf_lqr_Y = tf(fb_lqr_Y)
poli_f_lqr_Y = zpk(Gf_lqr_Y).p{1}
zeri_f_lqr_Y = zpk(Gf_lqr_Y).z{1}