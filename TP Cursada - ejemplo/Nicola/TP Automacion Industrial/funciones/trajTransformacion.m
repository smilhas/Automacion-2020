function [posC,velC,accC] = trajTransformacion(pos,vel,acc,T0c,R0c);
%TRAJTRANSFORMACION Convierte una trayectoria con una transformacion
%homogenea

% Defino los tamanios de las matrices
posC = zeros(4,1,size(pos,3));
velC = zeros(3,1,size(vel,3));
accC = zeros(3,1,size(acc,3));

% Agrego 1's para transformar
pos = cat(1,pos,ones(1,1,size(pos,3)));

for i=1:size(pos,3)
    posC(:,:,i) = T0c*pos(:,:,i);    
end

for i=1:size(vel,3)
    velC(:,:,i) = R0c*vel(:,:,i);
end

for i=1:size(acc,3)
    accC(:,:,i) = R0c*acc(:,:,i);
end

% Saco los 1's de la transformacion
posC = posC(1:3,:,:);

end

