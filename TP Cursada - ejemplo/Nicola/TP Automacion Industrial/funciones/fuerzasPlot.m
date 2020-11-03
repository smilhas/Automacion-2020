% Obtiene el tamanio de la pantalla
scrsz = get(groot,'ScreenSize');

% Grafica la posicion cartesiana
figure('Position',[1 scrsz(4)*0.05 scrsz(3)/2 scrsz(4)/2*0.9]);
Xee.name = 'Xee';
Xee.DataInfo.Units = 'm';
plot(Xee);
title('Trayectoria');
legend('x_{ee}','y_{ee}','z_{ee}');
grid on;

% Grafica los angulos de joints
figure('Position',[scrsz(3)/2 scrsz(4)*0.05 scrsz(3)/2 scrsz(4)/2*0.9]);
theta.name = 'Joints';
theta.DataInfo.Units = 'rad';
plot(theta);
title('Joints');
legend('\theta_{1}','\theta_{2}');
grid on;

% Grafica la fuerza real en comparacion con la deseada
figure('Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2*0.9]);
hold on;
plot(Fm);
Fm.name = 'Fd y Fm';
Fm.DataInfo.Units = 'N';
Fd = 10/sqrt(2)*[1 1 0];
plot(Fm.Time', Fd(1)*ones(1,length(Fm.Time)), 'Color', [0 0 0.75]);
plot(Fm.Time', Fd(2)*ones(1,length(Fm.Time)), 'Color', [0 0.75 0]);
plot(Fm.Time', Fd(3)*ones(1,length(Fm.Time)), 'Color', [0.75 0 0]);
title('Comparacion fuerza con fuerza deseada');
legend('Fx_{m}','Fy_{m}','Fz_{m}','Fx_{d}','Fy_{d}','Fz_{d}');
grid on;
hold off;

% Grafico que muestra plano XY
figure;
robotTP.links.plot(downsample(theta.Data,10),'fps',1/Tm,'noloop','top','trail','-');

% Grafico que muestra en vista perspectiva
figure;
robotTP.links.plot(downsample(theta.Data,10),'fps',1/Tm,'noloop','trail','-','floorlevel',-0.5);