%% Script per la valutazione del costo per controllori LQR
run('controllo.m');
clc
k=1;
spacing = 4;
for j=1:spacing:3*spacing %3 plots spacing from 1 to 2*spacing
k_Q_z=20;
k_R_z=j*2;
k_Q_R=1;
k_R_R=j*3;
k_Q_Y=1;
k_R_Y=j/2;

%calcolo i parametri dell'Lqr per il controllo
[reg_dir_lqr_z, reg_fb_lqr_z, G0_fb_lqr_z, reg_dir_lqr_R,...
    reg_fb_lqr_R, G0_fb_lqr_R, reg_dir_lqr_Y, reg_fb_lqr_Y, G0_fb_lqr_Y]...
    = lqr_params(k_Q_z,k_R_z,k_Q_R,k_R_R,k_Q_Y,k_R_Y);

simout = sim('Controllori.slx',6);
% Salvo le uscite della simulazione simulink per eseguire i plot
u_dir_lin = simout.u_dir_lin.Data;
u_ret_lin = simout.u_ret_lin1.Data;
x_dir_lin = simout.x_dir_lin.Data;
x_ret_lin = simout.x_ret_lin1.Data;
z = simout.z_scope.data;

time = simout.tout;
ts = time(2)-time(1);
% Rivaluto gli indici di costo contenuti negli integrali
Q_z = k_Q_z;
R_z = k_R_z;
Q_R = k_Q_R;
R_R = k_R_R;
Q_Y = k_Q_Y;
R_Y = k_R_Y;
% Calcolo gli argomenti degli integrali 
X_dir = sum([Q_z,Q_R,Q_R,Q_Y].*x_dir_lin.*x_dir_lin,2);
X_ret = sum([Q_z,Q_R,Q_R,Q_Y].*x_ret_lin.*x_ret_lin,2);
U_dir = sum([R_z,R_R,R_R,R_Y].*u_dir_lin.*u_dir_lin,2);
U_ret = sum([R_z,R_R,R_R,R_Y].*u_ret_lin.*u_ret_lin,2);

X_dir_tot(k) = sum(sum([Q_z,Q_R,Q_R,Q_Y].*x_dir_lin.*x_dir_lin,2));
X_ret_tot(k) = sum(sum([Q_z,Q_R,Q_R,Q_Y].*x_ret_lin.*x_ret_lin,2));
U_dir_tot(k) = sum(sum([R_z,R_R,R_R,R_Y].*u_dir_lin.*u_dir_lin,2));
U_ret_tot(k) = sum(sum([R_z,R_R,R_R,R_Y].*u_ret_lin.*u_ret_lin,2));

J_dir(k) = X_dir_tot(k)+U_dir_tot(k);
J_ret(k) = X_ret_tot(k)+U_ret_tot(k);

subplot(2,3,k)
plot(time,cumtrapz(X_dir+U_dir)*ts,'k','LineWidth',1.5)
set(gca,'FontSize',9);
hold on 
plot(time,cumtrapz(X_dir)*ts,'m','LineWidth',1.5)
set(gca,'FontSize',9);
hold on 
plot(time,cumtrapz(U_dir)*ts,'g','LineWidth',1.5)
set(gca,'FontSize',9);
legend('X+U','X','U','FontSize',5)
ylabel('J_{Lqr}');
subplot(2,3,3+k)
plot(time*[1,1,1],z,'LineWidth',2)
set(gca,'FontSize',9);
legend('Ret','Dir','PID','FontSize',5)
ylabel('[m]');
xlabel('[s]');

k=k+1
end