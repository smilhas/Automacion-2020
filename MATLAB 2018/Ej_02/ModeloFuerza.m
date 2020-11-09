function [y,dd] = ModeloFuerza(pendiente,ordenada,kenv,x)
d=abs(pendiente*x(1)-x(2)+ordenada)/sqrt((pendiente^2) +1);
yprima=x(1)*pendiente+ordenada;
if(yprima>x(2))
    d=0;
end
if((x(1)<0)||(x(2)<0))
    d=0;
end
temp=d*kenv;%*sqrt(2)/2;
dd=d;
y = temp;


