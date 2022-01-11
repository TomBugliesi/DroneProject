%% Stabilità

addpath(genpath('C:\Users\Tommaso\università\Controlli Automatici\Nuovo\Relazione\GitRepo\MatlabSimulink\Dinamica'));
run('eq_non_linear.m');
clc
close all

disp('Gli autovalori di A sono')
eig(A)

disp('th_3pp è nulla per los tato contenuto in U intersecato W')
subs(f6_eq,[x,y,z,xp,yp,zp,th1,th2,th3,th1p,th2p,th3],[0,0,0,0,0,0,0,0,0.5,0,0,0.5])