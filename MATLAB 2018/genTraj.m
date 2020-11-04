%Generacion de trayectoria:
% Genera una trayectoria en ejes 
% tal que el 'tool' va de points[1] a points[2] en un tiempo 'time' y con
% la cantidad de pasos indicada en 'steps'.

function [x, xd, xdd] = genTraj(points, time, step)    
    
    time = round(time/step)*step;
    steps=zeros(size(points,1),1);
    x=zeros(2,1); %Prealocar
    x=points(1,1:2);
    for i=1:size(points,1)-1
        steps(i)=(time(i+1)-time(i))/step;
        tx_start=transl(points(i,:));
        tx_end=transl(points(i+1,:));

        traj = ctraj(tx_start,tx_end,steps(i));
        ctrajTrans=transl(traj);
        x=[x; ctrajTrans(:,1:2)];    
    end
    xd=[diff(x)/step   ; 0 0];
    xdd=[diff(xd)/step ; 0 0]; 
    
