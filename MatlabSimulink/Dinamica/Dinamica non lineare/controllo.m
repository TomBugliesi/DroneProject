%% Script per la definzione dei controllori in catena diretta e di retroazione
run('eq_non_linear.m');
clc %mostrare nella command window solo gli elementi del presente script

sys_num = ss(A_num,B_num,C_num,D_num); 
A_num
B_num
C_num

%% Controllo sotosistema z,zp 
s= tf('s');
sys_tf_num = tf(sys_num);

G_z = sys_tf_num(1,1);

poli = zpk(G_z).p{1};
zeri = zpk(G_z).z{1};

p = [-3,-4];
q = 5*p;

sys_z = ss(G_z);
K_z = place(sys_z.a,sys_z.b,p);
L_z = place(sys_z.a',sys_z.c',q)';
A_z = sys_z.a;
B_z = sys_z.b;
C_z = sys_z.c;

reg_dir_z = ss(A_z-B_z*K_z-L_z*C_z,L_z,K_z,0);
reg_fb_z = ss(A_z-B_z*K_z-L_z*C_z,-L_z,-K_z,0);
G0_fb_z = dcgain(reg_fb_z); %computes the steady-state (D.C. or low frequency) gain of the dynamic system SYS.

%% Controllo sotosistema Roll (e Pitch)
G_R = sys_tf_num(2,2);

poli = zpk(G_R).p{1};
zeri = zpk(G_R).z{1};

p = [-3,-4];
q = 5*p;

sys_R = ss(G_R);
K_R = place(sys_R.a,sys_R.b,p);
L_R = place(sys_R.a',sys_R.c',q)';
A_R = sys_R.a;
B_R = sys_R.b;
C_R = sys_R.c;

reg_dir_R = ss(A_R-B_R*K_R-L_R*C_R,L_R,K_R,0);
reg_fb_R = ss(A_R-B_R*K_R-L_R*C_R,-L_R,-K_R,0);
G0_fb_R = dcgain(reg_fb_R); %computes the steady-state (D.C. or low frequency) gain of the dynamic system SYS.

%% Controllo sotosistema Yaw
G_Y = sys_tf_num(4,4);

poli = zpk(G_Y).p{1};
zeri = zpk(G_Y).z{1};

p = [-3];
q = 5*p;

sys_Y = ss(G_Y);
K_Y = place(sys_Y.a,sys_Y.b,p);
L_Y = place(sys_Y.a',sys_Y.c',q)';
A_Y = sys_Y.a;
B_Y = sys_Y.b;
C_Y = sys_Y.c;

reg_dir_Y = ss(A_Y-B_Y*K_Y-L_Y*C_Y,L_Y,K_Y,0);
reg_fb_Y = ss(A_Y-B_Y*K_Y-L_Y*C_Y,-L_Y,-K_Y,0);
G0_fb_Y = dcgain(reg_fb_Y); %computes the steady-state (D.C. or low frequency) gain of the dynamic system SYS.

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