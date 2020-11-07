% Obtiene el tamanio de la pantalla
scrsz = get(groot,'ScreenSize');

% Grafica la posicion cartesiana real en comparacion con la deseada
figure('Position',[1 scrsz(4)*0.05 scrsz(3)/2 scrsz(4)/2*0.9]);
hold on;
plot(Xee.Time',Xee.Data(:,1)','Color',[0,0,0.75]);
plot(Xee.Time',Xee.Data(:,2)','Color',[0,0.75,0]);
plot(Xee.Time',Xee.Data(:,3)','Color',[0.75,0,0]);
Xd.name = 'Xd y Xee';
Xd.DataInfo.Units = 'm';
plot(Xd);
title('Comparacion trayectoria con trayectoria deseada');
legend('x_{ee}','y_{ee}','z_{ee}','x_{d}','y_{d}','z_{d}');
grid on;
hold off;

% Grafica los angulos de joints
figure('Position',[scrsz(3)/2 scrsz(4)*0.05 scrsz(3)/2 scrsz(4)/2*0.9]);
theta.name = 'Joints';
theta.DataInfo.Units = 'rad';
plot(theta);
title('Joints');
legend('\theta_{1}','\theta_{2}');
grid on;

% Grafica la posicion cartesiana deseada
figure('Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2*0.9]);
Xd.name = 'Xd';
Xd.DataInfo.Units = 'm';
plot(Xd);
title('Trayectoria deseada');
legend('x_{d}','y_{d}','z_{d}');
grid on;

% Grafico que muestra plano XY
figure;
robotTP.links.plot(downsample(theta.Data,2),'fps',1/(2*Tm),'noloop','top','trail','-');
close;

% Grafico que muestra en vista perspectiva
figure;
robotTP.links.plot(downsample(theta.Data,2),'fps',1/(2*Tm),'noloop','trail','-','floorlevel',-0.5);