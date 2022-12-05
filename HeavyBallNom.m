 %--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: HeavyBall.m
%--------------------------------------------------------------------------
% Project: Testing out parameters lambda and gamma for fast, oscillatory
% convergence globally and slow, smooth convergence locally.
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

clear all

set(0,'defaultTextInterpreter','tex');

% global variables
global gamma_0 gamma_1 lambda_0 lambda_1 c_0 c_10 V0 delta alpha cTilde_0 cTilde_10 d_0 d_10 M sigma randomsInterp randomsIndex rho
%%%%%%%%%%%%%%%%%%%%%
% setting the globals
%%%%%%%%%%%%%%%%%%%%%
setMinima();

lambda_0 = 40;
lambda_1 = 1/5;

gamma_0 = 2/3;
gamma_1 = 1/2;

M = 1;

delta = 0.5;

c_0 = 9000;  
c_10 = 443.13409399;  % 499.38409399

% eps_0 has to be bigger than eps_10
eps_0 = 20;
eps_10 = 15;

% These are the same, since L = x^2
alpha = 1/2; % 1

cTilde_0 = eps_0*alpha
cTilde_10 = eps_10*alpha
d_0 = c_0 - gamma_0*((cTilde_0^2)/alpha)
d_10 = c_10 - gamma_1*((cTilde_10^2)/alpha)

%%%%%%%%%%%%%%%%%%%%%
% setting the locals
%%%%%%%%%%%%%%%%%%%%%

% initial conditions
z1_0 = 50;
z2_0 = 0;
q_0 = 1;

% Assign initial conditions to vector
x0 = [z1_0;z2_0;q_0];

% simulation horizon
TSPAN=[0 2000];
JSPAN = [0 20];

% rule for jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

options = odeset('RelTol',1e-6,'MaxStep',.01);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulate the nominal system with same c_10 as noisy solutions %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Running simulation of nominal system...')

[tNom,jNom,xNom] = HyEQsolver(@fU,@gU,@CU,@DU,...
    x0,TSPAN,JSPAN,rule,options);
    
    
% Finding time of convergence and L values for the hybrid closed-loop system
lNom = zeros(1,length(tNom));
[deltaVecNom lNom lDeltaNom] = timeToConv(xNom,tNom);