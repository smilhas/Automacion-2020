%clear all; clc;

%% Defino Constantes:
Workspace = [-5 5 -5 5 -1 1]; %workspace [xmin xmax ymin ymax ...
l1=1;
l2=1;
g=9.81;


%% Defino Plano.
p1 = [2 0 Workspace(5)];
p2 = [0 2 Workspace(5)];
p3 = [2 0 Workspace(6)];
p4 = [0 2 Workspace(6)];

points=[p1' p3' p4' p2'];
fill3(points(1,:),points(2,:),points(3,:),'r')
grid on
alpha(0.3)

%% Creo el Brazo:

% Valores iniciales de los angulos:
q1_0 = 0;
q2_0 = 0;
qe_0 = 0;

% Defino parametros del brazo.
syms q1 q2 qe %coordenadas joint rot

% Links:
L1 = Link ('revolute', 'a',  0, 'd', 0, 'alpha',    0, 'modified', 'm',1); %'m',1,'I',eye(3),'G',1) %masa, inercia, G=gear ratio (relation de movimiento a 1 de rot en el actuador)
L2 = Link ('revolute', 'a', l1, 'd', 0, 'alpha',    0, 'modified','m',1);  %'qlim', limit
L3 = Link ('revolute', 'a', l2, 'd', 0, 'alpha', pi/2, 'modified');        % EE.

% Robot:
Rob = SerialLink( [L1 L2 L3],'name','TP1' ); %'tool',Tool, 'name','TP1'

%% Verifico condiciones del Brazo:

% Informacion del Robot
Rob

% Cinematica Inversa
Rob.fkine([q1,q2,qe])

% Inicializo los valores del brazo.
q = [q1_0,q2_0,qe_0];

% Grafico el Robot:
Rob.teach (q, 'workspace', Workspace);
%Rob.plot(q)
hold on


%% Genero una trayectoria T:
P_inicial = [1,-1, 0];
P_final   = [1, 1, 0];
iterations = 20;

%T = ctraj(@tpoly, P_inicial, P_final, iterations);
[p, pd, pdd] = mtraj(@tpoly, P_inicial, P_final, iterations);

%clf;
figure;
%plot(T)

subplot(3,1,1); plot(p); xlabel('Time'); ylabel('p');
subplot(3,1,2); plot(pd); xlabel('Time'); ylabel('pd');
subplot(3,1,3); plot(pdd); xlabel('Time'); ylabel('pdd');

figure


%transl() %offset


%traylin