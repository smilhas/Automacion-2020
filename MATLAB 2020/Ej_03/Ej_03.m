%%                       TP 01 - Ej 01
close all
clc
%% Creacion del brazo RR

%Perturbacion
pert = 0.1;

messi = RobotInit(pert);

%% CALCULO DE TRAYECTORIAS
% Transformadas homogeneas inicial/final
T1=transl(1.001,1,0);
T2=transl(0.1,1.9,0);

% Cálculo de posicion inicial/final en espacio joint
%q0=[0 -pi/2]; %Elijo un angulo inicial
q0 = [0.0000    1.5698];
%q0= [-20.53*pi/180  pi/4+abs(-20.53*pi/180)];
%T1 = messi.fkine(q0);

q1=messi.ikine(T1,'q0', q0, 'mask', [1, 1, 0, 0, 0, 0]);    %Posicion joint inicial
q2=messi.ikine(T2,'q0', q0, 'mask', [1, 1, 0, 0, 0, 0]);    %Posicion joint final

% Definición del tiempo
step = 0.05;
Tmax = 2;
t=(0:step:Tmax)';   %Tiempo de trayectoria propuesto

% Trayectorias en espacio joint
[q,qd,qdd]=jtraj(q0,q2,t);
PlotTraj(t,q,'Trayectoria en espacio joint',['Tiempo', 'Angulo'], ['tita_1','tita_2'], 1);

% Calculo trayectoria en caratesianas a partir del espacio joint
T = messi.fkine(q);
x_j=transl(T);
% posición en cartesianas
x_j = x_j(:,[1,2]);
% velocidad en cartesianas
xd_j = [diff(x_j)/step; 0 0];
% aceleración en cartesianas
xdd_j = [diff(xd_j)/step; 0 0];
PlotTraj(t,x_j,'Trayectoria del EE en cartesianas (generada en espacio joint)',['Tiempo', 'Posicion'], ['x','y'], 3);

% Sino mas facil calculo la trayectoria en cartesianas directamente
Tcart=ctraj(T1,T2,length(t));
x_c=transl(Tcart);
x_c = x_c(:,[1,2]);
xd_c = [diff(x_c)/step; 0 0];
xdd_c = [diff(xd_c)/step; 0 0];
PlotTraj(t,x_c,'Trayectoria cartesiana',['Tiempo', 'Posicion'], ['x','y'], 4);

Xt = timeseries (x_j,t);
Xdt = timeseries (xd_j,t);
Xddt = timeseries (xdd_j,t);

% Xt = timeseries (x_c,t);
% Xdt = timeseries (xd_c,t);
% Xddt = timeseries (xdd_c,t);

%% Definiciones de función

function PlotTraj(t,x,plotTitle,labels,legends,index)
    figure(index)
    plot(t,x)
    title(plotTitle)
%     xlabel(labels(1));
%     ylabel(labels(2));
    grid on
%     legend(legends(1),legends(2))
end