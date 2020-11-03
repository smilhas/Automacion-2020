% Agrega las carpetas de funciones y datos al path
path([pwd,'/funciones'],path);
path([pwd,'/datos'],path);

again = 'Reproducir Again';
notSim = 'No simular';

%% Simulacion sin perturbacion
% Llama script que inicializa variables
cartesiano_var;

% Llama simulacion
load('cartesianoNoPert');

choice = again;
while strcmp(choice,again)
close all;
    
% Grafica todo
cartesianoPlot;

choice = questdlg('Queres reproducir nuevamente o pasar a simular con perturbacion?','Terminado',...
    again,'Simular Perturbación',notSim,again);

close all;
end

%% Simulacion con perturbacion
% Crea el robot perturbado
robotPlanta = robotTP.links.perturb(0.8);
% Defino el tiempo de muestreo del sistema (lo reduzco para que no me tire errores numericos)
Tm = 1e-2;

% Llama simulacion
if ~strcmp(choice,notSim)
    load('cartesianoPert');
    choice = again;
end

while strcmp(choice,again)
close all;
    
% Grafica todo
cartesianoPlot;

choice = questdlg('Queres reproducir nuevamente o terminar?','Terminado',...
    again,notSim,again);

close all;
end

clear choice again notSim;