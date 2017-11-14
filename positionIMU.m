clc; close all; 

%Robot captured data from sensors each 0.05th second, duration was 18 seconds.
time = linspace(0,18-0.05,360)';

%Clear z component of accelerometer, x and y components of gyroscope since
%the work is in 2D space
acc(:,3) = 0;
gyro(:,1) = 0;
gyro(:,2) = 0;
data = [time acc(:,1) acc(:,2) acc(:,3) gyro(:,1) gyro(:,2) gyro(:,3)];

% Initial conditions
phi_imu = 0; theta_imu = 0; psi_imu = 0; %Euler angle rotations
u_imu = 0; v_imu = 0; w_imu = 0; %New coordinate system coordinates
x_imu = 0; y_imu = 0; z_imu = 0; %Displacement in 3D space

initial = [phi_imu theta_imu psi_imu; u_imu v_imu w_imu; x_imu y_imu z_imu];

% Get output translations and rotations from IMU data (accelerometer and gyroscope)
% Taken from here:
% https://www.mathworks.com/matlabcentral/fileexchange/25730-inertial-measurement-unit-position-calculator
% and slightly adjusted to needs
output = find_position(data,initial);

x_imu = squeeze(output(3,1,:));
y_imu = squeeze(output(3,2,:));
z_imu = squeeze(output(3,3,:));
u_imu = squeeze(output(2,1,:));
v_imu = squeeze(output(2,2,:));
w_imu = squeeze(output(2,3,:));
phi_imu = squeeze(output(1,1,:));
theta_imu = squeeze(output(1,2,:));
psi_imu = squeeze(output(1,3,:));

phi_imu = (180/pi)*phi_imu;
theta_imu = (180/pi)*theta_imu;
psi_imu = (180/pi)*psi_imu;

clear data initial output time