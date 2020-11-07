syms g q1 dq1 ddq1 q2 dq2 ddq2 ele1 ele2 real;
syms c1 s1 real;
syms Ix1 Iy1 Iz1 Ix2 Iy2 Iz2 m1 m2 real;

I1=mdiag(Ix1,Iy1,Iz1);
I2=mdiag(Ix2,Iy2,Iz2);

R10=[c1 s1 0;-s1 c1 0; 0 0 1];
%R21=[c2 s2 0;-s2 c2 0; 0 0 1];
R21=[1 0 0;0 0 -1; 0 1 0];
R32=[1 0 0;0 0 1; 0 -1 0];
R01=R10';
R12=R21';
R23=R32';

Omega00=zeros(3,1);
dOmega00=zeros(3,1);
dV00=[g;0;0];
Pc1=[0;ele1;0];
Pc2=[0;0;0];
P10=[0;0;0];
P21=[0;q2;0];
P32=[0;0;ele2];

%n=1
Omega11=[0;0;dq1];
dOmega11=[0;0;ddq1];

dV11=R10*dV00;
dVc11=cross(dOmega11,Pc1)+cross(Omega11,cross(Omega11,Pc1))+dV11;

F11=m1*dVc11;
N11=I1*dOmega11+cross(Omega11,I1*Omega11);

%n=2
Omega22=R12*Omega11;
dOmega22=R12*dOmega11;

dV22=R21*(dV11+cross(dOmega11,P21)+cross(Omega11,cross(Omega11,P21)))+2*cross(Omega22,[0;0;dq2])+[0;0;ddq2];
dVc22=dV22+cross(dOmega22,Pc2)+cross(Omega22,cross(Omega22,Pc2));

F22=m2*dVc22;
N22=I2*dOmega22+cross(Omega22,I2*Omega22);

T1=N11(3,1)
T2=F22(3,1)
