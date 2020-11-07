% Obtiene el tamanio de la pantalla
scrsz = get(groot,'ScreenSize');

% Grafica la posicion cartesiana real en comparacion con la deseada
figure('Position',[1 scrsz(4)*0.05 scrsz(3)/2 scrsz(4)/2*0.9]);
hold on;
plot(Xee.Time',Xee.Data(:,1)','Color',[0,0,0.75]);
plot(Xee.Time',Xee.Data(:,2)','Color',[0,0.75,0]);
plot(Xee.Time',Xee.Data(:,3)','Color',[0.75,0,0]);
pos0.name = 'Xd y Xee';
pos0.DataInfo.Units = 'm';
plot(pos0);
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

% Grafica la fuerza real en comparacion con la deseada
figure('Position',[scrsz(3)/2 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2*0.9]);
hold on;
plot(Fee);
Fee.name = 'Fd y Fee';
Fee.DataInfo.Units = 'N';
Fd = 10/sqrt(2)*[1 1 0];
plot(Fee.Time', Fd(1)*ones(1,length(Fee.Time)), 'Color', [0 0 0.75]);
plot(Fee.Time', Fd(2)*ones(1,length(Fee.Time)), 'Color', [0 0.75 0]);
plot(Fee.Time', Fd(3)*ones(1,length(Fee.Time)), 'Color', [0.75 0 0]);
title('Comparacion fuerza con fuerza deseada');
legend('Fx_{m}','Fy_{m}','Fz_{m}','Fx_{d}','Fy_{d}','Fz_{d}');
grid on;
hold off;

% Grafico que muestra plano XY
figure;
robotTP.links.plot(downsample(theta.Data,5),'fps',1/(5*Tm),'noloop','top','trail','-');

% Grafico que muestra en vista perspectiva
figure;
robotTP.links.plot(downsample(theta.Data,5),'fps',1/(5*Tm),'noloop','trail','-','floorlevel',-0.5);