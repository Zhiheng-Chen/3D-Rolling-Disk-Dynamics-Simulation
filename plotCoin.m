function plotCoin(Z,params,N_plot)
%parameters
h = params(2);
R = params(3);

%state variables
X_G = Z(1);
Y_G = Z(2);
Z_G = Z(3);
psi = Z(4);
theta = Z(5);
phi = Z(6);

%homogeneous transformation matrix
R_psi = [cos(psi)   -sin(psi)   0
         sin(psi)   cos(psi)    0
         0          0           1];
R_theta = [cos(theta)       0       sin(theta)
           0                1       0
           -sin(theta)      0       cos(theta)];
R_phi = [cos(phi)   -sin(phi)   0
         sin(phi)   cos(phi)    0
         0          0           1];
R_BF = R_psi*R_theta*R_phi;
r_G = [X_G Y_G Z_G]';
HTM = [R_BF         r_G
       zeros(1,3)   1];

%plot
%-plot top
[pts_X_top,pts_Y_top] = calc_pts_circle([0 0]',R,N_plot);
pts_Z_top = h/2.*ones(1,N_plot);
for ii = 1:N_plot
    r_pt = HTM*[pts_X_top(ii) pts_Y_top(ii) pts_Z_top(ii) 1]';
    r_pt = r_pt(1:3);
    pts_X_top(ii) = r_pt(1);
    pts_Y_top(ii) = r_pt(2);
    pts_Z_top(ii) = r_pt(3);
end
plot3(pts_X_top,pts_Y_top,pts_Z_top,"color",[1,1,1]);
grid on;
hold on;
fill3(pts_X_top,pts_Y_top,pts_Z_top,[1,1,1]);

%-plot bottom
[pts_X_bottom,pts_Y_bottom] = calc_pts_circle([0 0]',R,N_plot);
pts_Z_bottom = -h/2.*ones(1,N_plot);
for ii = 1:N_plot
    r_pt = HTM*[pts_X_bottom(ii) pts_Y_bottom(ii) pts_Z_bottom(ii) 1]';
    r_pt = r_pt(1:3);
    pts_X_bottom(ii) = r_pt(1);
    pts_Y_bottom(ii) = r_pt(2);
    pts_Z_bottom(ii) = r_pt(3);
end
plot3(pts_X_bottom,pts_Y_bottom,pts_Z_bottom,"color",[1,1,1]);
fill3(pts_X_bottom,pts_Y_bottom,pts_Z_bottom,[1,1,1]);

%-plot body
for ii = 1:N_plot-1
    pts_X_body = [pts_X_top(ii),pts_X_top(ii+1),pts_X_bottom(ii+1),pts_X_bottom(ii)];
    pts_Y_body = [pts_Y_top(ii),pts_Y_top(ii+1),pts_Y_bottom(ii+1),pts_Y_bottom(ii)];
    pts_Z_body = [pts_Z_top(ii),pts_Z_top(ii+1),pts_Z_bottom(ii+1),pts_Z_bottom(ii)];
    fill3(pts_X_body,pts_Y_body,pts_Z_body,[1,1,1]);
end

% %-show spin
% r_topCenter = [X_G Y_G Z_G]'+R_BF*[0 0 h]';
% pts_X = [pts_X_top(1),r_topCenter(1)];
% pts_Y = [pts_Y_top(1),r_topCenter(2)];
% pts_Z = [pts_Z_top(1),r_topCenter(3)];
% plot3(pts_X,pts_Y,pts_Z,"color",[0,0,0]);

hold off;

function [pts_x,pts_y] = calc_pts_circle(r_center,R,N_pts)
pts_circle = linspace(0,2*pi,N_pts);
pts_x = r_center(1)+R.*cos(pts_circle);
pts_y = r_center(2)+R.*sin(pts_circle);
end

end