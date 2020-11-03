function [ Mx ] = modelAlpha( robot, theta )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Wrap angle
theta = wrapTo2Pi(theta);

% Define las matrices de inercia y jacobiano
M = robot.inertia(theta');
J = robot.jacob0(theta','trans');

% Define la matriz de inercia cartesiana
Mx = pinv(J')*M*pinv(J);

end

