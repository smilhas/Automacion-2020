%% Creacion del brazo RR

N = 2; % cantidad de links

% Largos 1m
L1 = 1;
L2 = 1;

%Perturbacion
pert = 0.1;

% Masa 1kg
m = 1 +(2*rand()-1)*pert;

% Centro de masa en extremo
r=1;
rv = [r+(2*rand()-1)*pert, (2*rand()-1)*pert, 0];

% Friccion unitaria:     'B', 1
b = 1;  

% Planar, sin momento de inercia.
g=9.81;

DH = struct('d', cell(1,N), 'a', cell(1,N), 'alpha', cell(1,N), 'theta', cell(1,N),...
    'type', cell(1,N)); %genera estructura base
DH(1).alpha = 0;    DH(1).a = 0;    DH(1).d = 0;    DH(1).type = 'R';
DH(2).alpha = 0;    DH(2).a = L1;   DH(2).d = 0;    DH(2).type = 'R';

for  iLink = 1:N
        links{iLink} = Link('d', DH(iLink).d, 'a', DH(iLink).a, 'alpha', ...
            DH(iLink).alpha, 'm', m, 'r', rv, 'B', b, 'modified'); % Vector de estructuras Link
end

Tool = transl(L2, 0, 0); % Offset de la herramienta

messi = SerialLink([links{:}], 'tool', Tool, 'name', 'messi');

%% CALCULO DE TRAYECTORIAS
q0=[0 -pi/2]; %Elijo un angulo inicial

T1=transl(1,-1,0);
T2=transl(1,1,0);

q1=messi.ikine(T1,'q0', q0, 'mask', [1, 1, 0, 0, 0, 0]);                    %Posicion joint inicial
q2=messi.ikine(T2,'q0', q0, 'mask', [1, 1, 0, 0, 0, 0]);                    %Posicion joint final

% Definición del tiempo
step = 0.05;
Tmax = 2;
t=(0:step:Tmax)';                          %Tiempo de trayectoria propuesto

% Trayectorias en espacio joint
%Aplica trayectoria con polinomio de grado 5, con velocidad inicial y final igual a 0
[q,qd,qdd]=jtraj(q1,q2,t);

% Calculo trayectoria en caratesianas a partir del espacio joint
T = messi.fkine(q);
x_j=transl(T);
x_j = x_j(:,[1,2]);
figure(1)
plot(t,x_j)
grid on
title('Trayectoria del EE en cartesianas (generada en espacio joint)')
legend('x','y','z')

% Sino mas facil calculo la trayectoria en cartesianas directamente
Tcart=ctraj(T1,T2,length(t));
x_c=transl(Tcart);
x_c = x_c(:,[1,2]);
figure(2)
plot(t,x_c)
title('Trayectoria cartesiana')
xlabel('Tiempo');
ylabel('Posicion');
grid on
legend('x','y','z')

% velocidad en cartesianas
xd_j = [diff(x_j)/step; 0 0];
figure(3)
plot(t,xd_j)
title('Velocidad cartesiana')
xlabel('Tiempo');
ylabel('Velocidad');
grid on
legend('xd','yd','zd')

% aceleración en cartesianas
xdd_j = [diff(xd_j)/step; 0 0];
figure(4)
plot(t,xdd_j)
title('Aceleración cartesiana')
xlabel('Tiempo');
ylabel('Aceleración');
grid on
legend('xdd','ydd','zdd')

Xt = timeseries (x_j,t);
Xdt = timeseries (xd_j,t);
Xddt = timeseries (xdd_j,t);

%% Prueba del toolbox

messi.rne([q,qd,qdd])