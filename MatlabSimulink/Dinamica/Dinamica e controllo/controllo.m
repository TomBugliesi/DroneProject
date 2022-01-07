%% Script per la definzione dei controllori in catena diretta e di retroazione
run('eq_non_linear.m');
clc %mostrare nella command window solo gli elementi del presente script

sys_num = ss(A_num,B_num,C_num,D_num); 
sys_tf_num = tf(sys_num);
% sys_num_d = ss(A_num_d,B_num_d,C_num_d,D_num_d,T);
A_num
B_num
C_num

%% Controllo sotosistema z,zp 
A_z = A_num(1:2,1:2);
B_z = B_num(1:2,1);
C_z = C_num(1,1:2);
D_z = 0;
sys_z = ss(A_z,B_z,C_z,D_z);
G_z = tf(sys_z);

poli = zpk(G_z).p{1};
zeri = zpk(G_z).z{1};

p = [-3,-4];
q = 5*p;

K_z = place(A_z,B_z,p);
L_z = place(A_z',C_z',q)';

reg_dir_z = ss(A_z-B_z*K_z-L_z*C_z,L_z,K_z,0);
reg_fb_z = ss(A_z-B_z*K_z-L_z*C_z,-L_z,-K_z,0);
G0_fb_z = dcgain(reg_fb_z); %computes the steady-state (D.C. or low frequency) gain of the dynamic system SYS.

% [A_z_d,B_z_d,C_z_d,D_z_d] = c2dt(reg_dir_z.a,reg_dir_z.b,reg_dir_z.c,T,0); % controllore nel tempo discreto
%% Controllo sotosistema Roll (e Pitch)
A_R = A_num(3:4,3:4);
B_R = B_num(3:4,2);
C_R = C_num(2,3:4);
D_R = 0;
sys_R = ss(A_R,B_R,C_R,D_R);
G_R = tf(sys_R);

poli = zpk(G_R).p{1};
zeri = zpk(G_R).z{1};

p = [-3,-4];
q = 5*p;

K_R = place(A_R,B_R,p);
L_R = place(A_R',C_R',q)';

reg_dir_R = ss(A_R-B_R*K_R-L_R*C_R,L_R,K_R,0);
reg_fb_R = ss(A_R-B_R*K_R-L_R*C_R,-L_R,-K_R,0);
G0_fb_R = dcgain(reg_fb_R); %computes the steady-state (D.C. or low frequency) gain of the dynamic system SYS.

% [A_R_d,B_R_d,C_R_d,D_R_d] = c2dt(reg_dir_R.a,reg_dir_R.b,reg_dir_R.c,T,0); % controllore nel tempo discreto
%% Controllo sotosistema Yaw
A_Y = A_num(7,7);
B_Y = B_num(7,4);
C_Y = C_num(4,7);
D_Y = 0;
sys_Y = ss(A_Y,B_Y,C_Y,D_Y);
G_Y = tf(sys_Y);

poli = zpk(G_Y).p{1};
zeri = zpk(G_Y).z{1};

p = [-3];
q = 5*p;

K_Y = place(A_Y,B_Y,p);
L_Y = place(A_Y',C_Y',q)';

reg_dir_Y = ss(A_Y-B_Y*K_Y-L_Y*C_Y,L_Y,K_Y,0);
reg_fb_Y = ss(A_Y-B_Y*K_Y-L_Y*C_Y,-L_Y,-K_Y,0);
G0_fb_Y = dcgain(reg_fb_Y); %computes the steady-state (D.C. or low frequency) gain of the dynamic system SYS.

% [A_Y_d,B_Y_d,C_Y_d,D_Y_d] = c2dt(reg_dir_Y.a,reg_dir_Y.b,reg_dir_Y.c,T,0); % controllore nel tempo discreto
%% Check poli e zeri z,zp
dir_z = feedback(sys_z*reg_dir_z,1); %catena diretta 
Gd_z = tf(dir_z)
poli_d_z = zpk(Gd_z).p{1}
zeri_d_z = zpk(Gd_z).z{1}

fb_z = feedback(sys_z, reg_fb_z); %catena di retroazione
Gf_z = tf(fb_z)
poli_f_z = zpk(Gf_z).p{1}
zeri_f_z = zpk(Gf_z).z{1}

%% Check poli e zeri R
dir_R = feedback(sys_R*reg_dir_R,1); %catena diretta 
Gd_R = tf(dir_R)
poli_d_R = zpk(Gd_R).p{1}
zeri_d_R = zpk(Gd_R).z{1}

fb_R = feedback(sys_R, reg_fb_R); %catena di retroazione
Gf_R = tf(fb_R)
poli_f_R = zpk(Gf_R).p{1}
zeri_f_R = zpk(Gf_R).z{1}

%% Check poli e zeri Y
dir_Y = feedback(sys_Y*reg_dir_Y,1); %catena diretta 
Gd_Y = tf(dir_Y)
poli_d_Y = zpk(Gd_Y).p{1}
zeri_d_Y = zpk(Gd_Y).z{1}

fb_Y = feedback(sys_Y, reg_fb_Y); %catena di retroazione
Gf_Y = tf(fb_Y)
poli_f_Y = zpk(Gf_Y).p{1}
zeri_f_Y = zpk(Gf_Y).z{1}