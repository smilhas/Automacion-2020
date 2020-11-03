%% Cro el Robot:
function arm = robo_init(pert)
    
    %Perturbacion
    if ~nargin
        pert=0;
    end
    
    % Links de revolucion              'd', 0
    d=0;
    
    % Largos 1m
    l1 = 1;
    l2 = 1;
    
    % Masa 1kg
    m1 = 1 +(2*rand()-1)*pert;
    m2 = 1 +(2*rand()-1)*pert;

    % Centro de masa en extremo:  'r', [1 0 0]
    r1=1;
    r2=1;

    r1v = [r1+(2*rand()-1)*pert, (2*rand()-1)*pert, 0];
    r2v = [r2+(2*rand()-1)*pert, (2*rand()-1)*pert, 0];
    
    % Friccion unitaria:     'B', 1
    b1 = 1;   
    b2 = 1;   

    % Planar, sin momento de inercia.
    g=9.81;

    % Parametros D&H Modificados 'modified':
    L1 = Link('d', 0, 'a',  0, 'm', m1, 'r', r1v, 'B', b1, 'modified');
    L2 = Link('d', 0, 'a', l1, 'm', m2, 'r', r2v, 'B', b2, 'modified');
    Tool = transl([l2 0 0]);        % Creo el ultimo link, el End Efector.

    arm = SerialLink([L1 L2], 'tool', Tool, 'name', 'Wally');

    % W= [-2 2 -2 2 -1 1]; %workspace [xmin xmax ymin ymax ...
    % q= [0,0,0];
    % arm.teach (q, 'workspace', W);