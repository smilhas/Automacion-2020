%% Definicion de trayectoria de RR
N = 2; % cantidad de links
L1 = 1;
L2 = 1;

DH = struct('d', cell(1,N), 'a', cell(1,N), 'alpha', cell(1,N), 'theta', cell(1,N),...
    'type', cell(1,N)); %genera estructura base
DH(1).alpha = 0;    DH(1).a = 0;    DH(1).d = 0;    DH(1).type = 'R';
DH(2).alpha = 0;    DH(2).a = L1;   DH(2).d = 0;    DH(2).type = 'R';

for  iLink = 1:N
        links{iLink} = Link('d', DH(iLink).d, 'a', DH(iLink).a, 'alpha', ...
            DH(iLink).alpha, 'modified'); % Vector de estructuras Link
end

Tool = transl([L2, 0, 0]); % Offset de la herramienta

messi = SerialLink([links{:}], 'tool', Tool, 'name', 'messi');
q0=[0 0]; %eligo un angulo inicial

T1=transl(1,-1,0);
T2=transl(1,1,0);

q1=messi.ikine(T1,'q0', [pi/2,pi/2], 'mask', [1, 1, 0, 0, 0, 0]);                    %Posicion joint inicial
q2=messi.ikine(T2,'q0', [pi/2,pi/2], 'mask', [1, 1, 0, 0, 0, 0]);                    %Posicion joint final
t=[0:0.05:2]';                          %Tiempo de trayectoria propuesto

% TRAYECTORIAS EN ESPACIO DE ARTICULACION
%Aplica trayectoria con polinomio de grado 5, con velocidad inicial y final igual a 0
[q,qd,qdd]=jtraj(q1,q2,t);

%Graficos de Trayectoria en espacio de Joint
messi.plot(q);