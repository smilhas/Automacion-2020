clear all; clc;

%mdl_puma560

syms q1 q2 qe %coordenadas joint rot o traslacion
l1=1;
l2=1;

g=9.81;

%{%}
L1 = Link ('revolute','d',0, 'a',0 ,'alpha',0,'modified', 'm',1); %'m',1,'I',eye(3),'G',1) %masa, inercia, G=gear ratio (relation de movimiento a 1 de rot en el actuador)
L2 = Link ('revolute','a',l1, 'alpha', 0, 'd',0 ,'modified','m',1); %'qlim', limit
L3 = Link ('revolute','d',0, 'a',l2,'alpha',0,'modified');%EE

rob = SerialLink( [L1 L2 L3],'name','TP1' ); %'tool',Tool, 'name','TP1'
%plot (rob)
q = [0,0,0];
W= [-2 2 -2 2 -1 1]; %workspace [xmin xmax ymin ymax ...
rob.teach (q, 'workspace',W);
%rob.plot(q)
%transl() %offset


%traylin