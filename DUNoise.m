function inside = DUNoise(x) 
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: DU.m
%--------------------------------------------------------------------------
% Description: Jump set
% Return 0 if outside of D, and 1 if inside D
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 09/29/2020 1:07:00

global gamma_0 M cTilde_10 d_10 alpha c_0 rho V0 randomsIndex randomsInterp sigma

% state
z1 = x(1);
z2 = x(2);
q = x(3);

if(randomsIndex < length(randomsInterp))
    rho = sigma*randomsInterp(randomsIndex);
else
    randomsIndex = 1;
    rho = sigma*randomsInterp(randomsIndex);
end

randomsIndex = randomsIndex + 1;

absGradL = abs(GradientL(z1) + rho);

if(q == 0)
    V0 = gamma_0*(alpha/(M^2))*absGradL^2 + (1/2)*z2^2;
elseif(q == 1)
     halfz2Squared = (1/2)*z2^2;
end

if (q == 0 && V0 >= c_0)||(q == 1 && absGradL <= cTilde_10 && halfz2Squared <= d_10)  
    inside = 1;
else
    inside = 0;
end

end