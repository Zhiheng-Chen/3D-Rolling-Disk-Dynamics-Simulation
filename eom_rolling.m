function Z_dot = eom_rolling(t,Z,params,alpha)
%state variables
q = Z(1:6);
q_dot = Z(7:12);
Z_dot = zeros(12,1);

%equations of motion
M = func_M(Z,params);
C = func_C(Z,params);
dVdq = func_dVdq(Z,params);
J_C = func_J_C(Z,params);
J_dot_C = func_J_dot_C(Z,params);
global F_C_X F_C_Y F_N
[F_f_x_prime,F_f_y_prime,F_N] = F_C_inertialToPrecessing(Z,F_C_X,F_C_Y,F_N);
forces = [F_f_x_prime,F_f_y_prime,F_N];
Q_roll = func_Q_roll(forces,Z,params);

A_rolling = [M      -J_C'
             J_C    zeros(3,3)];
LHS = A_rolling\[Q_roll-dVdq-C*q_dot;-J_dot_C*q_dot-alpha*J_C*q_dot];
q_ddot = LHS(1:6);
Z_dot(1:6) = q_dot;
Z_dot(7:12) = q_ddot;
F_C_X = LHS(7);
F_C_Y = LHS(8);
F_N = LHS(9);

disp([num2str(t),'s finished']);

% %debug
% T = q_dot'*M*q_dot;
% V = params(1)*params(4)*Z(3);
% E_mech = T+V;
% disp(['total energy = ',num2str(E_mech),' J']);
% disp(Q_roll);
end