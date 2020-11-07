% Defino robot RR segun la consigna
robotTP = robotRR;

% Lo perturba y lo asigna como planta (o no)
robotPlanta = robotTP.links;
% robotPlanta = robotTP.links.perturb(0.8);

% Defino el tiempo de muestreo del sistema
Tm = 5e-3;

% Defino las ganancias del sistema criticamente amortiguado
Kp = (2*pi*5)^2*eye(3); % Defino una frecuencia de 5Hz
Kv = 2*sqrt(Kp)*eye(3);

% Defino las ganancias del sistema criticamente amortiguado
Kpf = (2*pi*20)^2*eye(3); % Defino una frecuencia de 1Hz
Kvf = 2*sqrt(Kpf)*eye(3);

% Defino transformacion homogenea de la base a la pared en (1,1)
cX0 = [1;1;0]*1/sqrt(2);
cY0 = [-1;1;0]*1/sqrt(2);
cZ0 = [0;0;1];
cP0 = [0;-sqrt(2);0];
R0c = [cX0,cY0,cZ0];
T0c = [R0c,cP0;[0,0,0,1]];
clear cX0 cY0 cZ0 cP0

% Defino la trayectoria
Tf = 5;
q0 = [0;pi/2];
t_m = 0.04; % tiempo de muestreo de la trayectoria
[pos,vel,acc] = trajGenerator(robotTP.links,q0,[1.9,0.1,0],Tf,t_m);

% Paso la trayectoria a la terna de la pared
pos0 = pos; % Guardo la trayectoria en base para graficar luego
[posC,velC,accC] = trajTransformacion(pos.Data,vel.Data,acc.Data,T0c,R0c);
N = ceil(Tf/t_m);
t = 0:t_m:(N*t_m)-t_m;
pos = timeseries(posC,t);
vel = timeseries(velC,t);
acc = timeseries(accC,t);

% Por consigna considero rigidez de pared igual a 1000
Ke = 1000;

% Defino la matrices de control hibrido
Spos = [[1,0,0];zeros(2,3)];
Sfue = [zeros(1,3);[0,1,0];zeros(1,3)];