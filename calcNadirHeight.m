function Z_nadir = calcNadirHeight(Z,params)
%rotation matrices
X_G = Z(1);
Y_G = Z(2);
Z_G = Z(3);
psi = Z(4);
theta = Z(5);
R_psi = [cos(psi)   -sin(psi)   0
         sin(psi)   cos(psi)    0
         0          0           1];
R_theta = [cos(theta)       0       sin(theta)
           0                1       0
           -sin(theta)      0       cos(theta)];
R_PN = R_psi*R_theta;   %rotation matrix for precessing and nutating frame

%nadir height
h = params(2); %coin thickness
R = params(3);  %coin radius
r_G = [X_G Y_G Z_G]';   %COM position expressed in inertial frame
r_C1_G_PN = [R*sign(theta) 0 h/2]'; %possible nadir position relative to COM, expressed in precessing and nutating frame
r_C2_G_PN = [R*sign(theta) 0 -h/2]';    %possible nadir position relative to COM, expressed in precessing and nutating frame
r_C1_G = R_PN*r_C1_G_PN;  %possible nadir position relative to COM, expressed in inertial frame
r_C2_G = R_PN*r_C2_G_PN;  %possible nadir position relative to COM, expressed in inertial frame
r_C1 = r_G+r_C1_G;    %possible nadir position expressed in inertial frame
r_C2 = r_G+r_C2_G;    %possible nadir position expressed in inertial frame
Z_C1 = r_C1(3); %possible nadir height
Z_C2 = r_C2(3); %possible nadir height
Z_nadir = min([Z_C1,Z_C2]);   %actual nadir height

end