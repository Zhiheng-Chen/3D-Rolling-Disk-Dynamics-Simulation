function [F_f_x_prime,F_f_y_prime,F_N] = F_C_inertialToPrecessing(Z,F_C_X,F_C_Y,F_N)
%rotation matrix
psi = Z(4);
R_psi = [cos(psi)   -sin(psi)   0
         sin(psi)   cos(psi)    0
         0          0           1];

%mapping
F_C_XYZ = [F_C_X F_C_Y F_N]';
F_C_xyz_prime = R_psi'*F_C_XYZ;
F_f_x_prime = F_C_xyz_prime(1);
F_f_y_prime = F_C_xyz_prime(2);
F_N = F_C_xyz_prime(3);