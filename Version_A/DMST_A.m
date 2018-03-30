% function [td,tds] = DMST_A(geom,oper,polarFunc)

geom.H = 0.3; % turbine height
geom.R = 0.1; % turbine radius
geom.c = 0.04; % turbine chord
geom.N = 2; % Number of blades
geom.alpha_p = 6*pi/180; % Preset pitch angle

oper.omega = 12; % turbine rotation rate, m/s
oper.U_inf = 1; % freestream vel coming into tube
oper.mu = 8.9*10^(-4); % Dynamic viscosity
oper.rho = 1000; % fluid density

polarFunc = @dummyPolar;





N_tubes = 10; % number of stream tubes per half rotor

tube.Ftol = 0.0001; % force tolerance fraction
tube.dtheta = pi/N_tubes; % tubes angular width
tube.a_init = 0; % initial guess for a

theta_up = tube.dtheta/2 + (0:N_tubes-1).*tube.dtheta; % centers of upstream streamtubes
theta_down = pi + theta_up;

theta = [theta_up,theta_down];

U_inf = oper.U_inf;

% calculate things for the upstream side
for i = 1:N_tubes
    tube.theta = theta_up(i);
    [torque(i), thrust(i), a(i), alpha_n(i)] = getInductionFactor(geom,oper,tube,polarFunc);
end

% calculate things for the downstream side
for i = 1:N_tubes
    tube.theta = theta_down(i);
    oper.U_inf = U_inf*(1-2*a(N_tubes-i+1)); % calculate new free stream vel based on induction of upstream tubes
    [torque(i+N_tubes), thrust(i+N_tubes), a(i+N_tubes), alpha_n(i+N_tubes)] = getInductionFactor(geom,oper,tube,polarFunc);
end