% Defino robot RR segun la consigna
robotTP = robotRR;

% Lo perturba y lo asigna como planta (o no)
robotPlanta = robotTP.links;
% robotPlanta = robotTP.links.perturb(0.8);

% Defino el tiempo de muestreo del sistema
Tm = 5e-2;

% Defino las ganancias del sistema criticamente amortiguado
Kp = (2*pi*5)^2*eye(3); % Defino una frecuencia de 5Hz
Kv = 2*sqrt(Kp)*eye(3);

% Defino la trayectoria
Tf = 5;
q0 = [pi;1/4*pi];
[pos,vel,acc] = trajGenerator(robotTP.links,q0,[1,1,0],Tf,0.04);