function [value] = CU(x) 
%--------------------------------------------------------------------------
% Matlab M-file Project: HyEQ Toolbox @  Hybrid Systems Laboratory (HSL), 
% https://hybrid.soe.ucsc.edu/software
% http://hybridsimulator.wordpress.com/
% Filename: C.m
%--------------------------------------------------------------------------
% Description: Flow set
% Return 0 if outside of C, and 1 if inside C
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
%   See also HYEQSOLVER, PLOTARC, PLOTARC3, PLOTFLOWS, PLOTHARC,
%   PLOTHARCCOLOR, PLOTHARCCOLOR3D, PLOTHYBRIDARC, PLOTJUMPS.
%   Copyright @ Hybrid Systems Laboratory (HSL),
%   Revision: 0.0.0.3 Date: 05/20/2015 3:42:00

global cTilde_0 cTilde_10 d_0 d_10 

% state
z1 = x(1);
z2 = x(2);
q = x(3);

absGradL = abs(GradientL(z1));

halfz2Squared = (1/2)*z2^2;


if (q == 0 && absGradL <= cTilde_0 && halfz2Squared <= d_0)||(q==1 && (absGradL >= cTilde_10 || halfz2Squared >= d_10 ))
    value = 1;
else
    value = 0;
end

end