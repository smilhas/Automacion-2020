% Agrega la carpeta de funciones al path
path([pwd,'/funciones'],path);

again = 'Reproducir Again';
notSim = 'No simular';

%% Simulacion sin perturbacion
% Llama script que inicializa variables
hibrido_var;

% Llama simulacion
if Tm > 1e-1, mucho = 'poco';else mucho = 'mucho';end
msgbox(['¡No te asustes! La simulación tarda ',mucho,'. El tiempo de muestreo es de ',num2str(Tm),' segundos'],'Simulación en curso');
sim('hibrido_sim',[0 Tf+0.1]);

choice = again;
while strcmp(choice,again)
close all;
    
% Grafica todo
hibridoPlot;

choice = questdlg('Queres reproducir nuevamente o pasar a simular con perturbacion?','Terminado',...
    again,'Simular Perturbación',notSim,again);

close all;
end

%% Simulacion con perturbacion
% Crea el robot perturbado
robotPlanta = robotTP.links.perturb(0.8);
% Defino el tiempo de muestreo del sistema (lo reduzco para que no me tire errores numericos)
Tm = 5e-3;

% Llama simulacion
if ~strcmp(choice,notSim)
    if Tm > 1e-1, mucho = 'poco';else mucho = 'mucho';end
    msgbox(['¡No te asustes! La simulación tarda ',mucho,'. El tiempo de muestreo es de ',num2str(Tm),' segundos'],'Simulación en curso');
    sim('hibrido_sim',[0 Tf+0.1]);
    choice = again;
end

while strcmp(choice,again)
close all;
    
% Grafica todo
hibridoPlot;

choice = questdlg('Queres reproducir nuevamente o terminar?','Terminado',...
    again,notSim,again);

close all;
end

clear choice again notSim;