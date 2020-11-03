classdef robotRR
    %ROBOTRR define un robot de 2 links rotacionales RR segun
    %especificaciones
    
    properties
        % Length of links
        L = [1,1];
        
        % Mass
        m = [1,1];
        
        % Center of mass
        r = cell(1,2);
        
        % Inertia
        I = {0*eye(3),0*eye(3)};
        
        % Friction
        b = [1,1];

        % Robot
        links;
                
    end
    
    methods
        
        % Constructor
        function self = robotRR(~)
            
            % Defines center of mass and a-parameter
            self.r = {[self.L(1),0,0],[self.L(2),0,0]};
            a = [0,self.L(1)];
                        
            % Defines Joints
            N = 2;
            linksCell = cell(1,N);
            for i=1:N
                linksCell{i} = Link('revolute','modified','d', 0, 'a', a(i), 'alpha', 0,...
                'm', self.m(i), 'r', self.r{i}, 'I', self.I{i}, 'B', 1); 
            end
            
            % Defines Robot
            self.links = SerialLink([linksCell{:}],'tool',transl(self.L(1),0,0),'name','RR Arm');
        end
    end
    
end

