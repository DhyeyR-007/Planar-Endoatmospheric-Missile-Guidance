%% Driver Code_Case II dynamic engagement

%% Clear commands
clear all
close all
clc

time = 400; %seconds
Ts = 0.1;

%% first nZ,E condition

% x(1)    :: VP
% x(2)    :: gammaP
% x(3)    :: hP
% x(4)    :: dP
% x(5)    :: VE
% x(6)    :: gammaE
% x(7)    :: hE
% x(8)    :: dE

x0_dyn = [450, 0, 10000, 0, 450, pi, 10000, 30000]; 
g = 9.81; %m/s^2

x = zeros(8,time/Ts);
options_1 = odeset('Events', @(t,x)Abort_FirstPart(t),'RelTol',1e-6,'AbsTol',1e-6);

for ii = 1:time/Ts
    
    % Evader normal acceleration
    nzE = piecewise_FirstPart(g,(ii*Ts)); %m/s^2
    
    
    if ii == 1
        [~,xx]      = ode45(@(t,x)dynsim(t,x,nzE), [ii ii+1]*Ts , x0_dyn);
    else
        [~,xx]      = ode45(@(t,x)dynsim(t,x,nzE), [ii ii+1]*Ts , x(:,ii-1) );
    end
    x(:,ii) = xx(end,:);
    
    

    %%% Intersample Fuzing %%%%%%%%
    [detonate , missDistance ] = fuze( xx );
    if detonate
        missDistance
        break
    end
    %%% Intersample Fuzing %%%%%%%%

    

end



figure(1)
p1 = plot( x(4,1:ii)/1000  , x(3,1:ii)/1000  , 'b' );
hold on
plot( x(4,1)/1000  , x(3,1)/1000  , 'bx' )
plot( x(4,ii)/1000  , x(3,ii)/1000  , 'bo' )
p2 = plot( x(8,1:ii)/1000  , x(7,1:ii)/1000  , 'r' );
plot( x(8,1)/1000  , x(7,1)/1000  , 'rx' )
plot( x(8,ii)/1000  , x(7,ii)/1000  , 'ro' )
hold off
ylimits = ylim;
xlimits = xlim;
axis equal
xlim(xlimits)
ylim([0 ylimits(2)])
legend([p1,p2],{'Pursuer','Evader'},'interpreter','latex','Location','best')
ylabel('$h$ (km)','interpreter','latex')
xlabel('$d$ (km)','interpreter','latex')
grid on

figure(2)
plot( [1:ii]*Ts , x(1,1:ii) , 'b' )
hold on
plot( [1:ii]*Ts , x(5,1:ii) , 'r')
hold off
legend('$V_{\rm P}$','$V_{\rm E}$','interpreter','latex')
ylabel('$V$ (m/s)','interpreter','latex')
xlabel('$t$ (s)','interpreter','latex')
grid on
axis tight
ylimits = ylim;
xlimits = xlim;
ylim([0 ylimits(2)])
xlim([0 xlimits(2)])





%% second nZ,E condition


% x(1)    :: VP
% x(2)    :: gammaP
% x(3)    :: hP
% x(4)    :: dP
% x(5)    :: VE
% x(6)    :: gammaE
% x(7)    :: hE
% x(8)    :: dE

x0_dyn = [450, 0, 10000, 0, 450, pi, 10000, 30000];
g = 9.81; %m/s^2
Rtemp = [];
options_2 = odeset('Events', @(t,x)Abort_FirstPart(t),'RelTol',1e-6,'AbsTol',1e-6);
x2 = zeros(8,time/Ts);

for ii = 1:time/Ts
    
    % Evader normal acceleration
    nzE = piecewise_SecondPart(g,(ii*Ts)); %m/s^2
    
    
    if ii == 1
        [~,xx]      = ode45(@(t,x)dynsim(t,x,nzE), [ii ii+1]*Ts , x0_dyn );
    else
        [~,xx]      = ode45(@(t,x)dynsim(t,x,nzE), [ii ii+1]*Ts , x2(:,ii-1) );
    end
    x2(:,ii) = xx(end,:);
    
    

    %%% Intersample Fuzing %%%%%%%%
    [detonate , missDistance ] = fuze( xx );
    if detonate
        missDistance
        break
    end
    %%% Intersample Fuzing %%%%%%%%

  
end



figure(3)
p1 = plot( x2(4,1:ii)/1000  , x2(3,1:ii)/1000  , 'b' );
hold on
plot( x2(4,1)/1000  , x2(3,1)/1000  , 'bx' )
plot( x2(4,ii)/1000  , x2(3,ii)/1000  , 'bo' )
p2 = plot( x2(8,1:ii)/1000  , x2(7,1:ii)/1000  , 'r' );
plot( x2(8,1)/1000  , x2(7,1)/1000  , 'rx' )
plot( x2(8,ii)/1000  , x2(7,ii)/1000  , 'ro' )
hold off
ylimits = ylim;
xlimits = xlim;
axis equal
ylim([0 ylimits(2)])
xlim([0 xlimits(2)])
legend([p1,p2],{'Pursuer','Evader'},'interpreter','latex')
ylabel('$h$ (km)','interpreter','latex')
xlabel('$d$ (km)','interpreter','latex')
% xlim([17.5 18.5])
% ylim([10.7 11])
grid on

figure(4)
plot( [1:ii]*Ts , x2(1,1:ii) , 'b' )
hold on
plot( [1:ii]*Ts , x2(5,1:ii) , 'r')
hold off
legend('$V_{\rm P}$','$V_{\rm E}$','interpreter','latex')
ylabel('$V$ (m/s)','interpreter','latex')
xlabel('$t$ (s)','interpreter','latex')
grid on
axis tight
ylimits = ylim;
xlimits = xlim;
ylim([0 ylimits(2)])
xlim([0 xlimits(2)])




%% Auxiliary functions

function k = piecewise_FirstPart(g,t)
     if t < 10 && t>=0
         k = 4*g;
     elseif t<29 && t>=10
         k = -3 * g;
     elseif t < 70 && t>=29
         k = 3 * g;
     elseif t < 89 && t>=70
         k = -0.5 * g;
     elseif t>=89
         k = g;
     end
    
end

function [value, isterminal, direction] = Abort_FirstPart(t)
     
   
    value      = (t>500) ;
    isterminal = 1; 
    direction  = 0;

end


function k = piecewise_SecondPart(g,t)
     if t < 11 && t>=0
         k = 5*g;
     elseif t>=11
         k = -0.5 * g;
     end
end



