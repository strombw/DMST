
% Inputs
geom.H = 0.3; % turbine height
geom.R = 0.1; % turbine radius
geom.c = 0.04; % turbine chord
geom.N = 2; % Number of blades
geom.alpha_p = 6*pi/180; % Preset pitch angle

oper.omega = 12; % turbine rotation rate, m/s
oper.U_inf = 1; % freestream vel coming into tube
oper.mu = 8.9*10^(-4); % Dynamic viscosity
oper.rho = 1000; % fluid density

tube.a_init = 0; % initial guess for a. Base on neighboring streamtubes?
tube.theta = pi/4; % center of arc of streamtube
tube.dtheta = pi/16; % Sweep of streamtube arc
tube.Ftol = 0.001;

polarFunc = @dummyPolar; % Input foil polar function that gives Cl, Cd, absed on alpha, Re

[torque, thrust, a, alpha_n] = getInductionFactor(geom,oper,tube,polarFunc);