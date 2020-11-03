% Defino robot RR segun la consigna
robotTP = robotRR;

% Lo perturba y lo asigna como planta (o no)
robotPlanta = robotTP.links;
% robotPlanta = robotTP.links.perturb(0.8);

% Defino el tiempo de muestreo del sistema y tiempo final de simulacion
Tm = 1e-3;
Tf = 1;

% Defino una posicion inicial del robot
q0 = [0;pi/2];

% Defino las ganancias del sistema criticamente amortiguado
Kpf = (2*pi*20)^2*eye(3); % Defino una frecuencia de 1Hz
Kvf = 2*sqrt(Kpf)*eye(3);

% Por consigna considero rigidez de pared igual a 1000
Ke = 1000;