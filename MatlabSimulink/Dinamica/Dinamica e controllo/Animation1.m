% clear 
% close all


figure
plot3([-1,1],[1,-1],[-1,1],'k','LineWidth',4)
hold on
plot3([-1,1],[-1,1],[-1,1],'k','LineWidth',4)
hold on 
plot3(-1,-1,-1,'ro',1,1,1,'ro',-1,1,-1,'ro',1,-1,1,'ro','MarkerSize',20)
hold on 
quiver3(0,0,0,1,0,0,'b','LineWidth',3) 

axis ([-10 10 -10 10 -2 2])
 
grid