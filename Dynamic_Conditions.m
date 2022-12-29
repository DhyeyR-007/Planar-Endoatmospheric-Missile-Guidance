function dx  = dynsim(t,x)
% finding xdot ------> dynamics simulation engagement.
% where;
% % x(1)    :: VP
% % x(2)    :: gammaP
% % x(3)    :: hP
% % x(4)    :: dP
% % x(5)    :: VE
% % x(6)    :: gammaE
% % x(7)    :: hE
% % x(8)    :: dE

dx = zeros(8,1);
g = 9.81; %m/s^2


% Evader normal acceleration
nzE = piecewise(g,t) ; %m/s^2


SP = 2.3; %Reference area for drag calculations (pursuer)
SE = 28; %Reference area for drag calculations (evader)
mP = 130; %mass of pursuer in kg
mE = 10000; %mass of evader in kg


[TP, aP, PP, rhoP] = atmosisa(x(3)); % compute speed of sound aP and air density rhoP at altitude hP
[TE, aE, PE, rhoE] = atmosisa(x(7)); % compute speed of sound aE and air density  rhoE at altitude hE
[T0, a0, P0, rho0] = atmosisa(0);    % compute air density rho0 at sea level



MiP = [0 0.6 0.8 1 1.2 2 3 4 5]; %MP data points for pursuer Cd  
CdiP = [0.016 0.016 0.0195 0.045 0.039 0.0285 0.024 0.0215 0.020]; %Cd data points for pursuer Cd
CdP = pchip(MiP,CdiP,x(1)/aP); % CdP at atltitude hP and Mach MP


MiE = [0 0.9 1 1.2 1.6 2] ; %ME data points for evader Cd
CdiE = [0.0175 0.019 0.05 0.045 0.043 0.038] ; %Cd data points for evader Cd
CdE = pchip(MiE,CdiE,x(5)/aE); % CdE at atltitude hE and Mach ME


TE = (rhoE / rho0) * 76310; %Turbofan thrust approximation for evader in N


% Thrust profile for AIM120C5 pursuer
TP = thrustprofile(t); 


R_Numerator1 =   (x(7) - x(3)) * ( (x(5) * sin(x(6)))  -  (x(1) * sin(x(2))) ) ;
R_Numerator2 =   (x(8) - x(4)) * ( (x(5) * cos(x(6)))  -  (x(1) * cos(x(2))) ) ;
R_Denominator = sqrt( ( (x(7) - x(3))^2 ) + ( (x(8) - x(4))^2 ) );

Rdot = (R_Numerator1 + R_Numerator2) / R_Denominator ;




B_Numerator1 =   (x(8) - x(4)) * ( (x(5) * sin(x(6)))  -  (x(1) * sin(x(2))) ) ;
B_Numerator2 =   (x(7) - x(3)) * ( (x(5) * cos(x(6)))  -  (x(1) * cos(x(2))) ) ;
B_Denominator =  ( ( (x(8) - x(4))^2 ) + ( (x(7) - x(3))^2 ) );

betadot = (B_Numerator1 - B_Numerator2) / B_Denominator ;

% Pursuer normal acceleration (Gravity Corrected Proportional Guidance)
nzP =  ( -3 * abs(Rdot) * betadot ) - ( g * cos(x(2)) );

% Saturate pursuer normal acceleration at 40g
if abs(nzP)>40*g
    nzP = sign(nzP)*40*g;
end



dx(1) =  ( (TP - (0.5 * rhoP * (x(1)^2) * SP * CdP))/mP ) - ( g*sin(x(2)) ) ;
dx(2) = (-1/x(1)) * ( nzP + (g*cos(x(2))) ) ;
dx(3) = x(1) * sin(x(2));
dx(4) = x(1) * cos(x(2)) ;
dx(5) = ( (TE - (0.5 * rhoE * (x(5)^2) * SE * CdE))/mE ) - ( g*sin(x(6)) );
dx(6) = (-1/x(5)) * ( nzE + (g*cos(x(6))) ) ;
dx(7) = x(5) * sin(x(6));
dx(8) = x(5) * cos(x(6));



end


%% Auxiliary functions

function k = piecewise(g,t)
     if t < 26 && t>=0
         k = -6*g;
     elseif t >= 26
         k = -g;
     end
end


function profile = thrustprofile(t)
     profile = 0;
     if t < 10 && t>=0
         profile = 11000;
     elseif t < 30 && t>= 10
         profile = 1800;
     elseif t > 30
         profile = 0;
     end
    
end





