%%                       TP 01 - Ej 01
close all
clc
%% Creacion del brazo RR

%Perturbacion
pert = 0.0;

messi = RobotInit(pert);

%% CALCULO DE TRAYECTORIAS
% Transformadas homogeneas inicial/final
T1=transl(1.9,0.100015,0); % Con el mil
%T1=transl(1.9,0.115,0); % Sin el mil
T2=transl(0.1,1.9,0);

% C�lculo de posicion inicial/final en espacio joint
%q0=[0 -pi/2]; %Elijo un angulo inicial
q0 = [-0.260729892263819   0.626641653599234]; % Este empoieza con 10.6 N (con el mil)
%q0 = [-0.251492072201899   0.623889277245919]; % Este empoieza con 10.6 N (sin el mil)
%q0 = [-0.260732942908050   0.626642506273637];  % Este empieza con 7 N
%q0= [-20.53*pi/180  pi/4+abs(-20.53*pi/180)];
%T1 = messi.fkine(q0);

q1=messi.ikine(T1,'q0', q0, 'mask', [1, 1, 0, 0, 0, 0]);    %Posicion joint inicial
q2=messi.ikine(T2,'q0', q0, 'mask', [1, 1, 0, 0, 0, 0]);    %Posicion joint final

% Definici�n del tiempo
step = 0.05;
Tmax = 4;
t=(0:step:Tmax)';   %Tiempo de trayectoria propuesto

% Trayectorias en espacio joint
[q,qd,qdd]=jtraj(q0,q2,t);
PlotTraj(t,q,'Trayectoria en espacio joint',['Tiempo', 'Angulo'], ['tita_1','tita_2'], 1);

% Calculo trayectoria en caratesianas a partir del espacio joint
T = messi.fkine(q);
x_j=transl(T);
% posici�n en cartesianas
x_j = x_j(:,[1,2]);
% velocidad en cartesianas
xd_j = [diff(x_j)/step; 0 0];
% aceleraci�n en cartesianas
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

Xt = timeseries (x_c,t);
Xdt = timeseries (xd_c,t);
Xddt = timeseries (xdd_c,t);

%% Definiciones de funci�n

function PlotTraj(t,x,plotTitle,labels,legends,index)
    figure(index)
    plot(t,x)
    title(plotTitle)
%     xlabel(labels(1));
%     ylabel(labels(2));
    grid on
%     legend(legends(1),legends(2))
end