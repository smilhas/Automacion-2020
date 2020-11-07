function [ pos,vel,acc ] = trajGenerator( robot,Q0,Pf,t_final,t_m)
%TRAJGENERATOR Genera trayectoria a recorrer por el robot RR
%   Trayectoria para llegar de la posicion inicial a la deseada del
%   end-effector

H = robot.fkine(Q0);
Pi = H(1:3,4)'; % Posicion inicial
Ri = eye(3);    % Orientacion posicion inicial
Rf = eye(3);    % Orientacion posicion final

Ti = [Ri Pi'; [0 0 0 1]];   % Matriz inicial
Tf = [Rf Pf'; [0 0 0 1]];   % Matriz final

% N: Numero de puntos de la trayectoria
N = ceil(t_final/t_m);
traj = ctraj(Ti, Tf, N);    % Genero trayectoria

% Sintetiza la pos, vel y acc
x = traj(1:3,4,:);
xD = diff(x,1,3)/t_m;
xD = cat(3,xD,zeros(3,1));
xDD = diff(xD,1,3)/t_m;
xDD = cat(3,xDD, zeros(3,1));

% Tm: Tiempo de muestreo
t = 0:t_m:(N*t_m)-t_m;

pos = timeseries(x,t);
vel = timeseries(xD,t);
acc = timeseries(xDD,t);

% %Compruebo
% trajx = squeeze(traj(1, 4, :));
% trajy = squeeze(traj(2, 4, :));
% trajz = squeeze(traj(3, 4, :));
% plot3(trajx, trajy, trajz);
% grid on;
% 
% % Para graficar cada trayectoria particular
% figure;
% plot(trajx);
% figure;
% plot(trajy);
% figure;
% plot(trajz);

end

