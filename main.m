clear;
clc;
close all;

%% parameters
%system parameters
m = 0.0036;  %mass of the coin, in kg
h = 0.00165;    %thickness of the coin, in m
R = 0.01025; %radius of the coin, in m
g = 9.81;   %gravitaional acceleration, in m/s^2
mu_roll = 0;    %100000000000;    %coefficient of rolling friction
params = [m,h,R,g,mu_roll];

%simulation parameters
Deltat = 2.008;    %time interval to simulate, in s
alpha = 5000;   %coefficient for constraint stablization; increase for better accuracy but slower speed
N_plot = 35;    %plot fineness
N_animation = 200;  %slow-motion interpolation

%% initial conditions
X0 = 0;
Y0 = 0;
Z0 = 0.1;
psi0 = 0;
theta0 = 60/180*pi;
phi0 = 0;
X_dot_0 = 0;
Y_dot_0 = 0.1;
Z_dot_0 = 0.5;
psi_dot_0 = 0*2*pi;
theta_dot_0 = 50*2*pi;
phi_dot_0 = -5*2*pi;


IC = [X0 Y0 Z0 psi0 theta0 phi0 X_dot_0 Y_dot_0 Z_dot_0 psi_dot_0 theta_dot_0 phi_dot_0]';

%% initialize data logging
data_t = zeros(0,0);
data_Z = zeros(0,12);
global F_C_X F_C_Y F_N;
F_C_X = 0;
F_C_Y = 0;
F_N = 0;

%% solve equations of motion
%falling
options = odeset("events",@(t,Z) event_impact(t,Z,params));
[t,Z] = ode45(@(t,Z) eom_falling(t,Z,params),[0,Deltat],IC,options);
[data_t,data_Z] = logData(data_t,data_Z,t,Z);

%impact mapping
[Z_plus,~] = impactMapping(data_Z(end,:)',params);
[data_t,data_Z] = logData(data_t,data_Z,data_t(end),Z_plus');

%rolling
[t,Z] = ode45(@(t,Z) eom_rolling(t,Z,params,alpha),[data_t(end),Deltat],data_Z(end,:)');
[data_t,data_Z] = logData(data_t,data_Z,t(2:end),Z(2:end,:));

%% animate
animateCoin(data_t,data_Z,params,Deltat,N_plot,N_animation);