% Driver Code

%% clear commands
clear all
close all
clc

%% kinematic engagement

time = 500; %seconds
Ts = 0.1;

% x(1)    :: hP
% x(2)    :: dP
% x(3)    :: gammaP
% x(4)    :: hE
% x(5)    :: dE
% x(6)    :: gammaE
% x(7)    :: R
% x(8)    :: beta

beta_0 = 0; 

R_0 = sqrt((30000 - 0)^2 + (10000 - 10000)^2);

x0_kin = [10000, 0, 0, 10000, 30000, pi, R_0, beta_0]; 

x = zeros(8,time/Ts);

for ii = 1:time/Ts
    if ii == 1
        [~,xx]      = ode45(@(t,x)kinsim(t,x), [ii ii+1]*Ts , x0_kin);
    else
        [~,xx]      = ode45(@(t,x)kinsim(t,x), [ii ii+1]*Ts , x(:,ii-1) );
    end
    x(:,ii) = xx(end,:);
    
    
    
    %%% Intersample Fuzing %%%%%%%%
    [detonate , missDistance ] = fuzeKin( xx );
    if detonate
        missDistance
        break
    end
    %%% Intersample Fuzing %%%%%%%%
%     if (ii*Ts)>500
%         missDistance
%         break
% 
%     end


end

figure(1)
p1 = plot( x(2,1:ii)/1000 , x(1,1:ii)/1000  , 'b' );
hold on
plot( x(2,1)/1000  , x(1,1)/1000  , 'bx' )
plot( x(2,ii)/1000  , x(1,ii)/1000  , 'bo' )
p2 = plot( x(5,1:ii)/1000  , x(4,1:ii)/1000  , 'r' );
plot( x(5,1)/1000  , x(4,1)/1000  , 'rx' )
plot( x(5,ii)/1000  , x(4,ii)/1000  , 'ro' )
hold off
ylimits = ylim;
xlimits = xlim;
axis equal
ylim([0 ylimits(2)])
xlim([0 xlimits(2)])
legend([p1,p2],{'Pursuer','Evader'},'interpreter','latex','Location','best')
ylabel('$h$ (km)','interpreter','latex')
xlabel('$d$ (km)','interpreter','latex')


%% dynamic engagement

% x(1)    :: VP
% x(2)    :: gammaP
% x(3)    :: hP
% x(4)    :: dP
% x(5)    :: VE
% x(6)    :: gammaE
% x(7)    :: hE
% x(8)    :: dE


x0_dyn = [450, 0, 10000, 0, 450, pi, 10000, 30000]; 



x2 = zeros(8,time/Ts);
for ii = 1:time/Ts
    if ii == 1
        [~,xx]      = ode45(@(t,x)dynsim(t,x), [ii ii+1]*Ts , x0_dyn );
    else
        [~,xx]      = ode45(@(t,x)dynsim(t,x), [ii ii+1]*Ts , x2(:,ii-1) );
    end
    x2(:,ii) = xx(end,:);
    
    

    %%% Intersample Fuzing %%%%%%%%
    [detonate , missDistance ] = fuze( xx );
    if detonate
        missDistance
        break
    end
    %%% Intersample Fuzing %%%%%%%%

%     if (ii*Ts)>500
%         missDistance
%         break
% 
%     end
    
    
end



figure(2)
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

figure(3)
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

