function [ Vx ] = modelBeta( robot, u )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Saca de la entrada la posicion y velocidad de los links
theta = u(1:robot.n);
thetaD = u(robot.n+1:robot.n*2);

% Wrap angle
theta = wrapTo2Pi(theta);

% Define la matriz de coriolis y fuerzas centrifugas
V = robot.coriolis(theta',thetaD')*thetaD;
% Define las matrices de inercia y jacobiano
M = robot.inertia(theta');
J = robot.jacob0(theta','trans');
Jdot = robot.jacob_dot(theta,thetaD);
Jdot = Jdot(1:3);

% Define la misma matriz pero con respecto a las variables cartesianas
Vx = pinv(J')*(V-M*pinv(J)*Jdot);

end

