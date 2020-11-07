%Empezar simulacion
clc;
%clear all;
%close all;

%% Defino Constantes:
kv=200;         % Max 400
kp=(kv^2)/4;    % Para evitar respuesta subamortiguada.

Kv = [kv,kv];
Kp = [kp,kp];

pert = 0.8;         % Perturbacion
stop_time = 1.3;    % Tiempo de parada
step_sim = 1e-3;        % Paso

wally = robo_init(pert);    % Creo el robot.
%wally_noise = robo_init(pert);

%% Calculos de trajectoria

start_pos = [-pi/2, pi/2];

p1 = [1 -1 0];      % Punto inicial.
p2 = [1 1 0];       % Punto final.

Tmax = 1.1;         % Tiempo maximo de simulacion.
step_t = 1e-2;      % Tiempo de step de simulacion.

t = 0:step_t:(Tmax-step_t);   % Genero el vector de tiempos.
[X,Xd, Xdd] = mtraj(@lspb, p1, p2, Tmax/step_t); % Genero la trayectoria.

Xt   = timeseries (  X(:,1:2) ,t);
Xdt  = timeseries ( Xd(:,1:2) ,t);
Xddt = timeseries (Xdd(:,1:2) ,t);
%% Realizo la simulacion:

% Run Sim:
%sim('ControlDePos');


%% Dibujo salidas:

% a) Grafico de cordenadas joint en funcion del tiempo.
figure;
plot(q1_out, 'r'); hold on;
plot(q2_out, 'k'); hold on;
% plot(qe_out, 'm'); hold on;
title('Coordenadas Joint');
xlabel('tiempo [seg]');
ylabel('angulo [rad]');

% b) Grafico de posicion deseada Vs real del EE en el tiempo.
figure;
subplot(1,2,1);
plot( Xt.time, Xt.Data(:,1), 'r'); hold on;
plot( x_out, 'b'); hold on;
title('Posicion Deseada Vs. Real [X]');
xlabel('tiempo [seg]');
ylabel('X [m]');
subplot(1,2,2);
plot( Xt.time, Xt.Data(:,2), 'r'); hold on;
plot( y_out, 'b'); hold on;
title('Posicion Deseada Vs. Real [Y]');
xlabel('tiempo [seg]');
ylabel('Y [m]');

% c) Grafico de posicion deseada Vs real del EE en el plano XY.
figure
plot( Xt.Data(:,1), Xt.Data(:,2) , 'r'); hold on;
plot( x_out.Data  ,    y_out.Data, 'b'); hold on;
title('Posicion Deseada Vs. Real [m]');
xlabel('X [m]');
ylabel('Y [m]');






