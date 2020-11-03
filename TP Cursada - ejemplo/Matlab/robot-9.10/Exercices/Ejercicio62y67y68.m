clear all;clc;

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

caso='Ejemplo 6.7';
% caso='Problema 6.2';
% caso='Problema 6.8';

switch caso
    case 'Ejemplo 6.7' % EJEMPLO 6.7 libro PAG 179 
        disp('Ejemplo 6.7 Craig');
        syms l1 m1 l2 m2 Ixx1 Ixx2 Iyy1 Iyy2 Izz1 Izz2 real %r1 r2 real 
        r1=l1;
        r2=l2;
        I1=zeros(3);
        I2=zeros(3);
        syms q1 q2 dotq1 dotq2 ddotq1 ddotq2 g real 
        dotd1=0; % NO ES PRIMÁTICO!
        ddotd1=0;
        dotd2=0; % NO ES PRIMÁTICO!
        ddotd2=0;
        P1 = [0;0;0];
        P2 = [l1;0;0];
        L1 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0,'m',m1,'I',I1,'r',[l1;0;0],'modified');
        L2 = Link('revolute', 'd', 0, 'a', l1, 'alpha', 0,'m',m2,'I',I2,'r',[l2;0;0],'modified');
        ee = Link('revolute', 'd', 0, 'a', l2, 'alpha', 0,'m',0,'modified');
    %   gravity=[0;0;g] % NOAFECTADO POR GRAVEDAD
        gravity=[0;g;0] % AFECTADO POR GRAVEDAD    
        rob= SerialLink([L1 L2 ee],'name','RobExample6.7');
        rob.gravity=gravity;
    case 'Problema 6.2'% PROBLEMA 6.2 libro PAG 179 
        disp('Problema 6.2 Craig');
        syms l1 m1 l2 m2 Ixx1 Ixx2 Iyy1 Iyy2 Izz1 Izz2 r1 r2 real 
        I1=mdiag(Ixx1,Iyy1,Izz1);
        I2=mdiag(Ixx2,Iyy2,Izz2);
        syms q1 q2 dotq1 dotq2 ddotq1 ddotq2 g real
        dotd1=0; % NO ES PRIMÁTICO!
        ddotd1=0;
        dotd2=0; % NO ES PRIMÁTICO!
        ddotd2=0;
        P1 = [0;0;0]; % TERNAS 0 Y 1 COINCIDEN !
        P2 = [l1;0;0];
        L1 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0,'m',m1,'I',I1,'r',[r1;0;0],'modified');
        L2 = Link('revolute', 'd', 0, 'a', l1, 'alpha', 0,'m',m2,'I',I2,'r',[r2;0;0],'modified');
        ee = Link('revolute', 'd', 0, 'a', l2, 'alpha', 0,'m',0,'modified');
    %   gravity=[0;0;g] % NOAFECTADO POR GRAVEDAD
        gravity=[0;g;0] % AFECTADO POR GRAVEDAD    
        rob= SerialLink([L1 L2 ee],'gravity',gravity,'name','RobProblem6.2');
        rob.gravity=gravity;
    case 'Problema 6.8'% PROBLEMA 6.8
        disp('Problema 6.8 Craig');
        syms l1 m1 l2 m2 Ixx1 Ixx2 Iyy1 Iyy2 Izz1 Izz2 elev real
        r1=0; 
        r2=0;
        I1=mdiag(Ixx1,Iyy1,Izz1);
        I2=mdiag(Ixx2,Iyy2,Izz2);
        syms q1 dotq1 ddotq1 d2 dotd2 ddotd2 g real
        dotd1=0; % NO ES PRIMÁTICO!
        ddotd1=0;
        dotq2=0; % ES PRIMÁTICO!
        ddotq2=0;
        P1 = [0;0;elev]; % ESTÁ ELEVADO RESPECTO DE LA MESA!
        P2 = [0;0;d2];   % PRISMÁTICO
        L1 = Link('revolute','d', elev, 'a', 0, 'alpha', 0,'m',m1,'I',I1,'r',[r1;0;0],'modified');
        L2 = Link('prismatic','a', 0, 'alpha', -pi/2,'theta',0,'m',m2,'r',[r2;0;0],'modified');
        ee = Link('revolute','d', 0, 'a', 0, 'alpha', pi/2,'m',0,'modified');
        gravity=[0;0;g] % NOAFECTADO POR GRAVEDAD
%       gravity=[0;g;0] % AFECTADO POR GRAVEDAD    
        rob= SerialLink([L1 L2 ee],'name','P 6.8');
        rob.gravity=gravity;     
end

pause

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

V0=[0;0;0]; % LA BASE ESTÁ QUIETA
dotV0=rob.gravity;
Omega0=[0;0;0];
dotOmega0=[0;0;0];

Pc1=[r1;0;0]; % Ubicación del centro de masa link1 en terna 1.
Omega1=R10*Omega0+[0;0;dotq1];
dotOmega1=R10*dotOmega0+cross(R10*Omega0,[0;0;dotq1]) + [0;0;ddotq1];
V1=R10*(V0+cross(Omega0,P1)) + [0;0;dotd1];
dotV1=R10*(dotV0+cross(dotOmega0,P1)+cross(Omega0,cross(Omega0,P1)))+2*cross(Omega1,[0;0;dotd1])+[0;0;ddotd1];
Vc1=V1+cross(Omega1,Pc1);
dotVc1=cross(dotOmega1,Pc1)+cross(Omega1,cross(Omega1,Pc1))+dotV1;
F1=m1*dotVc1;
N1=I1*dotOmega1+cross(Omega1,I1*Omega1);

Pc2=[r2;0;0]; % Ubicación del centro de masa link2 en terna 2.
Omega2=R21*Omega1+[0;0;dotq2];
dotOmega2=R21*dotOmega1+cross(R21*Omega1,[0;0;dotq2]) + [0;0;ddotq2];
V2=R21*(V1+cross(Omega1,P2)) + [0;0;dotd2];
dotV2=R21*(dotV1+cross(dotOmega1,P2)+cross(Omega1,cross(Omega1,P2)))+2*cross(Omega2,[0;0;dotd2])+[0;0;ddotd2];
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



%%% ATENCIÓN EL SCRIPT ESTÁ MUY MANOSEADO:
%% ESTA PARTE ES SOLO PARA EL 6.7

l1=.4;
m1=2;
l2=.2;
m2=1;
g=9.81;

L1 = Link('revolute', 'd', 0, 'a', 0, 'alpha', 0,'m',m1,'I',I1,'r',[l1;0;0],'modified');
L2 = Link('revolute', 'd', 0, 'a', l1, 'alpha', 0,'m',m2,'I',I2,'r',[l2;0;0],'modified');
ee = Link('revolute', 'd', 0, 'a', l2, 'alpha', 0,'m',0,'modified');
%gravity=[0;0;g] % NOAFECTADO POR GRAVEDAD

gravity=[0;g;0] % AFECTADO POR GRAVEDAD    
rob67= SerialLink([L1 L2],'name','RobExample6.7');
rob67.gravity=gravity;
rob67graph= SerialLink([L1 L2 ee],'name','RobExample6.7');
rob67graph.gravity=gravity;


Kp=4;
Ki=.2;
Kd=2;

Ti = transl(.6,0,0);
Tf = transl(0,.6,0);
tfinal=10;
Ts=0.02;
tc = ctraj(Ti, Tf, tfinal/Ts+1);
ttc=reshape(tc,[4 4*(tfinal/Ts+1)]);