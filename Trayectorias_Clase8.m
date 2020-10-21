%%                       CAPITULO 7 - TRAYECTORIAS
close all
clear all
clc
%% Diferencias funciones de trayectorias
pasos=30;
[s,sd,sdd]=tpoly(0,2,pasos);
figure(1)
plot(1:pasos,s,1:pasos,sd,1:pasos,sdd);
grid on
title('Trayectoria Función Polinomica')
legend('X','V','A','Location','Best')
[l,ld,ldd]=lspb(0,2,pasos);
figure(2)
plot(1:pasos,l,1:pasos,ld,1:pasos,ldd);
grid on
title('Trayectoria Función LSPB')
legend('X','V','A','Location','Best')

%% Manipulador y puntos iniciales y finales
mdl_puma560;                            %Crea objeto SerialLink 'p560' del brazo robotico Puma 560 (manipulador de 6 ejes, integrado al toolbox)
T1=transl(0.4,0.2,0)*trotx(pi);         %Posicion cartesiana inicial 
T2=transl(0.7,-0.25,0)*trotx(pi/2);      %Posicion cartesiana final
%Tengo la posición cartesiana, necesito cinematica inversa para sacar las
%posiciones en espacio joint
q1=p560.ikine6s(T1);                    %Posicion joint inicial
q2=p560.ikine6s(T2);                    %Posicion joint final
t=[0:0.05:2]';                          %Tiempo de trayectoria propuesto
%% TRAYECTORIAS EN ESPACIO DE ARTICULACION
%Aplica trayectoria con polinomio de grado 5, con velocidad inicial y final igual a 0
[q,qd,qdd]=jtraj(q1,q2,t);
%Graficos de Trayectoria en espacio de Joint
figure(3)
qplot(t,q);
title('Trayectoria joints')
figure(4)
qplot(t,qd);
title('Velocidad joints')
figure(5)
qplot(t,qdd);
title('Aceleración joints')
% Movimiento de Manipulador Puma 560 para la trayectoria realizada
figure(6)
p560.plot(q);

T=p560.fkine(q);   %Trayectoria cartesiana (posicion y rotacion) en manipularo Puma 560
p=transl(T);       %Trayectoria de posicion

%Grafico trayectoria cartesiana (EE)
figure(7)
plot(t,p(:,1),t,p(:,2),t,p(:,3))
grid on
title('Trayectoria del EE en cartesianas (generada en espacio joint)')
legend('x','y','z')
%% TRAYECTORIAS EN ESPACIO CARTESIANO
Tcart=ctraj(T1,T2,length(t));
% 
% Grafico de la trayectoria cartesiana generada
figure(8)
plot(t,transl(Tcart))
title('Trayectoria cartesiana')
xlabel('Tiempo');
ylabel('Posicion');
grid on
legend('x','y','z')

qc=p560.ikine6s(Tcart);  %Resultado de la trayectoria en el espacio de joint
qcd=zeros(41,6);
qcdd=zeros(41,6);
qcd(2:41,:)=diff(qc)/0.05;
qcdd(2:41,:)=diff(qcd)/0.05;
figure(9)
qplot(t,qc);
title('Trayectoria de los joints (generada por espacio cartesiano)')