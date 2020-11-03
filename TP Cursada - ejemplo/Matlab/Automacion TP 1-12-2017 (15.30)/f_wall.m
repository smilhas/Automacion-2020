%Wall_Force
function f_w = f_wall(X)
x=X(1);
y=X(2);
k=1e6;

%Plano: x + y -2 = 0
dist = (x+y-2)/sqrt(2);
f_w = max(0, dist*k); %si x,y está antes del plano, F=0