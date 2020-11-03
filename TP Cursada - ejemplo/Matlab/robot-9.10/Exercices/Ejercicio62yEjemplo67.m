clear all;clc;

syms q1 q2 dotq1 dotq2 ddotq1 ddotq2 g real 
syms l1 m1 l2 m2 Ixx1 Ixx2 Iyy1 Iyy2 Izz1 Izz2 r1 r2 real 
I1=mdiag(Ixx1,Iyy1,Izz1);
I2=mdiag(Ixx2,Iyy2,Izz2);

% DATOS FISICOS PARA SIMULACIÓN
% l1=.4;
% m1=1;
% l2=.4;
% m2=1;
% w1=.1;
% w2=.1;
% Ixx1=0;
% Ixx2=0;
% Iyy1=0;
% Iyy2=0;
% Izz1=m1*(l1^2+w1^2)/12;
% Izz2=m2*(l2^2+w2^2)/12;

%% ATENCIÓN: SCRIPT EN DESARROLLO: ACA SE DEBE COMENTAR SEGUN QUE PROBLEMA
% QUIEREN RESOLVER

problema=6.7;
% problema=6.2;

if problema==6.7, % EJEMPLO 6.7 libro PAG 179
    disp('Ejemplo 6.7 Craig');
    I1=zeros(3);
    I2=zeros(3);
    r1=l1;
    r2=l2;
    dotD1=0; % NO ES PRIMÁTICO!
    ddotD1=0;
    L1 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0,'m',m1,'I',I1,'r',[r1;0;0],'modified');
    L2 = Link('revolute', 'd', 0, 'a', l1, 'alpha', 0,'m',m2,'I',I2,'r',[r2;0;0],'modified');
    ee = Link('revolute', 'd', 0, 'a', l2, 'alpha', 0,'m',0,'modified');
%   gravity=[0;0;g] % NOAFECTADO POR GRAVEDAD
    gravity=[0;g;0] % AFECTADO POR GRAVEDAD    
    rob= SerialLink([L1 L2 ee],'name','RobExample6.7');
    rob.gravity=gravity;
elseif problema==6.2, % PROBLEMA 6.2 libro PAG 179
    disp('Problema 6.2 Craig');
    dotD1=0; % NO ES PRIMÁTICO!
    ddotD1=0;
    L1 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0,'m',m1,'I',I1,'r',[r1;0;0],'modified');
    L2 = Link('revolute', 'd', 0, 'a', l1, 'alpha', 0,'m',m2,'I',I2,'r',[r2;0;0],'modified');
    ee = Link('revolute', 'd', 0, 'a', l2, 'alpha', 0,'m',0,'modified');
%   gravity=[0;0;g] % NOAFECTADO POR GRAVEDAD
    gravity=[0;g;0] % AFECTADO POR GRAVEDAD    
    rob= SerialLink([L1 L2 ee],'gravity',gravity,'name','RobProblem6.2');
    rob.gravity=gravity;
end

%% DE AQUI HACIA ABAJO SERA CONVERTIDO EN FUNCION LUEGO
% PARA CALCULAR M,VC y G SIMBOLICO

I1=rob.links(1).I;
I2=rob.links(2).I;
m1=rob.links(1).m;
m2=rob.links(2).m;

T01 = rob.A(1,q1);
R01 = t2r(T01);
T12 = rob.A(2,[q1 q2]);
R12 = T12(1:3,1:3);
R10 = R01';
R21 = R12';
P1 = [0;0;0];
P2 = [l1;0;0];

V0=[0;0;0]; % LA BASE ESTÁ QUIETA
dotV0=rob.gravity;
Omega0=[0;0;0];
dotOmega0=[0;0;0];

Pc1=[r1;0;0]; % Ubicación del centro de masa link1 en terna 1.
Omega1=R10*Omega0+[0;0;dotq1];
dotOmega1=R10*dotOmega0+cross(R10*Omega0,[0;0;dotq1]) + [0;0;ddotq1];
V1=R10*(V0+cross(Omega0,P1)) + [0;0;dotD1];
dotV1=R10*(dotV0+cross(dotOmega0,P1)+cross(Omega0,cross(Omega0,P1)))+2*cross(Omega1,[0;0;dotD1])+[0;0;ddotD1];
Vc1=V1+cross(Omega1,Pc1);
dotVc1=cross(dotOmega1,Pc1)+cross(Omega1,cross(Omega1,Pc1))+dotV1;
F1=m1*dotVc1;
N1=I1*dotOmega1+cross(Omega1,I1*Omega1);

Pc2=[r2;0;0]; % Ubicación del centro de masa link2 en terna 2.
Omega2=R21*Omega1+[0;0;dotq2];
dotOmega2=R21*dotOmega1+cross(R21*Omega1,[0;0;dotq2]) + [0;0;ddotq2];
dotD2=0; % NO ES PRIMÁTICO!
ddotD2=0;
V2=R21*(V1+cross(Omega1,P2)) + [0;0;dotD2];
dotV2=R21*(dotV1+cross(dotOmega1,P2)+cross(Omega1,cross(Omega1,P2)))+2*cross(Omega2,[0;0;dotD2])+[0;0;ddotD2];
Vc2=V2+cross(Omega2,Pc2);
dotVc2=cross(dotOmega2,Pc2)+cross(Omega2,cross(Omega2,Pc2))+dotV2;
F2=m2*dotVc2;
N2=I2*dotOmega2+cross(Omega2,I2*Omega2);

f3=[0;0;0];
f2=F2;
f1=R12*f2+F1;
n3=[0;0;0];
n2=N2+cross(Pc2,F2);
n1=R12*n2 + N1 + cross(Pc1,F1) + cross(P2,R12*f2);

tau1=n1(3);
tau2=n2(3);

% Aqui se generan los m_{ij}, notar que se "despeja" cada uno, haciendo "0"
% lo que sea preciso.

m11=simplify(subs(tau1,{'ddotq2','dotq1','dotq2','g'},{'0','0','0','0'})/ddotq1);
m12=simplify(subs(tau1,{'ddotq1','dotq1','dotq2','g'},{'0','0','0','0'})/ddotq2);
m21=simplify(subs(tau2,{'ddotq2','dotq1','dotq2','g'},{'0','0','0','0'})/ddotq1);
m22=simplify(subs(tau2,{'ddotq1','dotq1','dotq2','g'},{'0','0','0','0'})/ddotq2);
m11=subs(m11,{'cos(q1)','sin(q1)','cos(q2)','sin(q2)'},{'c1','s1','c2','s2'});
m12=subs(m12,{'cos(q1)','sin(q1)','cos(q2)','sin(q2)'},{'c1','s1','c2','s2'});
m21=subs(m21,{'cos(q1)','sin(q1)','cos(q2)','sin(q2)'},{'c1','s1','c2','s2'});
m22=subs(m22,{'cos(q1)','sin(q1)','cos(q2)','sin(q2)'},{'c1','s1','c2','s2'});

M=[m11 m12;m21 m22];

% NOTACIÓN: lo llamamos VC y es el termino de Coriolis y Centrifuga.
VC1=simplify(subs(tau1,{'ddotq1','ddotq2','g','sin(q2)'},{'0','0','0','s2'}));
VC2=simplify(subs(tau2,{'ddotq1','ddotq2','g','sin(q2)'},{'0','0','0','s2'}));
VC=[VC1;VC2];

G1=simplify(subs(tau1,{'ddotq1','ddotq2','dotq1','dotq2'},{'0','0','0','0'}));
G2=simplify(subs(tau2,{'ddotq1','ddotq2','dotq1','dotq2'},{'0','0','0','0'}));
G=[G1;G2];
