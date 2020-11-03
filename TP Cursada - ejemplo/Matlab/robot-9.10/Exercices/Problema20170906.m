clear all;clc
disp('Problema 20170906');

size=6;
stepsize=.1;
rango=[0:stepsize:1]';
workspace=[-size size -size size -size size];
L1 = Link('revolute','alpha', 0,'a', 0, 'd', 0,'modified');
L2 = Link('prismatic', 'alpha', 0,'a', 3,'theta',0,'modified');
L3 = Link('revolute','alpha',-pi/2,'a',0,'d', 0,'modified');
ee = Link('revolute','d', 0,'a',2, 'alpha',0,'modified');
rob= SerialLink([L1],'name','P20170906');
plot(rob,[ rango*(pi/2)],'workspace',workspace)
pause
clf
rob1= SerialLink([L1 L2],'name','P20170906');
plot(rob1,[rango*(pi/2) (1+rango)],'workspace',workspace)
pause
clf
rob2= SerialLink([L1 L2 L3],'name','P20170906');
plot(rob2,[rango*0 (1+rango) rango*(-pi/2)],'workspace',workspace)
pause
clf
rob3= SerialLink([L1 L2 L3 ee],'name','P20170906');
plot(rob3,[rango*(pi/2) (2+rango*1)  (rango*(-pi/2))  rango*0],'workspace',workspace)


