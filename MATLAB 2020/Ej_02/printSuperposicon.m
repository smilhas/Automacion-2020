clear all;
close all;
%%
sinP=readtable('sinPerturbacion.csv');
conP=readtable('conPerturbacion.csv');
%% Plot x superpuesto
f1=figure();
plot(sinP.Var1,sinP.Var2,'LineWidth',3);
hold on;
plot(conP.Var1,conP.Var2,'LineWidth',3);
title('Grafico x');
legend('Sin Perturbacion','Con Perturbacion');
grid on;
xlabel('T[s]');
ylabel('Metros');
hold off;
saveas(f1,'ej2X.png');
%% Plot y
f2=figure();
plot(sinP.Var1,sinP.Var3,'LineWidth',3);
hold on;
plot(conP.Var1,conP.Var3,'LineWidth',3);
title('Grafico y');
legend('Sin Perturbacion','Con Perturbacion');
grid on;
xlabel('T[s]');
ylabel('Metros');
hold off;
saveas(f2,'ej2Y.png');
%% Plot q1
f3=figure();
plot(sinP.Var1,sinP.Var4,'LineWidth',3);
hold on;
plot(conP.Var1,conP.Var4,'LineWidth',3);
title('Grafico q1');
legend('Sin Perturbacion','Con Perturbacion');
grid on;
xlabel('T[s]');
ylabel('Radianes');
hold off;
saveas(f3,'ej2q1.png');
%% Plot q2
f4=figure();
plot(sinP.Var1,sinP.Var5,'LineWidth',3);
hold on;
plot(conP.Var1,conP.Var5,'LineWidth',3);
title('Grafico q2');
legend('Sin Perturbacion','Con Perturbacion');
grid on;
xlabel('T[s]');
ylabel('Radianes');
hold off;
saveas(f4,'ej2q2.png');
%% Plot Fuerza
f5=figure();
plot(sinP.Var1,sinP.Var6,'LineWidth',3);
hold on;
plot(conP.Var1,conP.Var6,'LineWidth',3);
title('Grafico Fuerza');
legend('Sin Perturbacion','Con Perturbacion');
grid on;
xlabel('T[s]');
ylabel('Newton');
hold off;
saveas(f5,'ej2F.png');