function Z_dot = eom_falling(t,Z,params)
%state variables
q = Z(1:6);
q_dot = Z(7:12);
Z_dot = zeros(12,1);

%equations of motion
M = func_M(Z,params);
C = func_C(Z,params);
dVdq = func_dVdq(Z,params);
q_ddot = M\(-dVdq-C*q_dot);

Z_dot(1:6) = q_dot;
Z_dot(7:12) = q_ddot;

end