function [Z_plus,imp] = impactMapping(Z_minus,params)
%state variables
q_minus = Z_minus(1:6);
q_dot_minus = Z_minus(7:12);

%impact mapping
M = func_M(Z_minus,params);
J_C = func_J_C(Z_minus,params);
A_impactMapping = [M    -J_C'
                   J_C  zeros(3,3)];
soln = A_impactMapping\[M*q_dot_minus;zeros(3,1)];
q_dot_plus = soln(1:6);
imp = soln(7:9);
Z_plus= [q_minus;q_dot_plus];

end