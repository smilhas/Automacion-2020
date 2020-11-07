%Empezar simulación
clc;
%clear all;
%close all;


kv=200; %max 500?
kp=(kv^2)/4; %Del libro

Kv = [kv,kv];
Kp = [kp,kp];

pert=0.8; %perturbación
stop_time=1.3; 
step_sim=1e-2; %step para sim

wally = robo_init(pert);
%wally_noise = robo_init(pert);

%% Cálculos de trajectoria
start_pos=[-pi/2 pi/2];

p1 = [1 -1 0];
pm = [1 0 0];
p2 = [1 1 0];


points = [p1; p2];
times = [0, 1.1];
step_t = 1e-2; %step de trayectoria


[X, Xd, Xdd] = genTraj(points, times, step_t);
t = 0: step_t:max(times);
Xt = timeseries (X,t);
Xdt = timeseries (Xd,t);
Xddt = timeseries (Xdd,t);

%Run Sim
sim('ControlDePos');

%PLOT DE TRAYECTORIAS
figure();
plot(Xt);
hold
plot(x_out);
plot(y_out);

%PLOT DE ERRORES
figure();







