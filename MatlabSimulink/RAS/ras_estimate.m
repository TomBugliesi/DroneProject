function ras_estimate(A,input1,input2,Rmin,Rmax,DR,x_d_fun_ras,N_iter_R,N_iter_Q)
% Funzione per la stima della ras. In ingresso si ha
% la matrice del sistema linearizzato A (o del sistema esteso stabilizzato)
figure
title('RAS estimate')
hold on
v = ones(1,14);
v(5) = 20;
v(9) = 20;
V = diag(v);
for jj = 1:N_iter_Q
    H = (rand(size(A))-0.5);
    Q = 2*V*H'*H*V; %genero una matrice definita positiva per prodotto di una matrice e della sua trasporta (a moltiplicare un fattore di scala)
    [~,p] = chol(Q); %per vedere che Q sia pd
    P = lyap(A',Q); % trovo Q a partire da P e A... V(x) = x'Px, V_d(x) = -x'Qx
    buffer = zeros(size(A,1),N_iter_R); %matrice contenente lo stato sulla curva di livello  considerata per ogni iterazione
    
    for R = Rmin:DR:Rmax%parametro per stabilire una curva di livello su V(x)
        for ii=1:N_iter_R
            %trovo il valore dello stato sulla curva di livello
            x = rand(size(A,1),1)-0.5; % genera un vettore colonna random tra -0.5 e 0.5 di due componenti
            z = sqrt(R)*inv(sqrtm(P))*x/norm(x); % dato un versore x/norm(x) da V(x)= x'Px=y'sqrt(P)sqrt(P)y=R, con z=abs(y)*x/nomr(x), ricavo y dato che abs(y)=sqrt(R)*inv(sqrtm(P))
            buffer(:,ii) = z;
            V_d = -z'*Q*z + 2*z'*P*(x_d_fun_ras(z,input1,input2))';
            
            if V_d > 0
                %buffer = zeros(size(A,1),N_iter_R)+nan;
                buffer = NaN*ones(size(buffer));
                R = Rmax;
                ii = N_iter_R;
                break
            else
            end
        end
        
        subplot(1,3,1)
        plot(buffer(1,:),180/pi*buffer(5,:),'h')
        title('z vs \theta_1');
        xlabel('\theta_1 [deg]');
        ylabel('z [m]');
        hold on
        subplot(1,3,2)
        plot(buffer(1,:),180/pi*buffer(9,:),'h')
        title('z vs \theta_2');
        xlabel('\theta_2 [deg]');
        ylabel('z [m]');
        hold on
        subplot(1,3,3)
        plot(180/pi*buffer(5,:),180/pi*buffer(9,:),'h')
        title('\theta_1 vs \theta_2');
        xlabel('\theta_1 [deg]');
        ylabel('\theta_2 [deg]');
        hold on
        clear buffer
        R = R
        x_d_fun_ras(z,input1,input2)
    end
    disp('jj is');
    %     drawnow
    jj = jj
    drawnow
end
end