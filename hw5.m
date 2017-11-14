% Vladislav Ostankovich
% HomeWork #5 System Identification and Simulation

clc; close all; clear;

% move; %Code responsible for moving lego robot and obtaining odometry
readData; %Read sensors data from files and store them
timeMatch; %Time-warp all sensors to match each other
positionOdometry; %Get position vectors from odometry sensors measurements
positionIMU; %Get roto-translation measurements from IMU data (accelerometer + gyroscope)

%% Kalman Filter
% Odometry example
x_od_est = kf(x_od', 1, 1, 0.005, 0.05^2);
y_od_est = kf(y_od', 1, 1, 0.005, 0.05^2);

figure,
title('Odometry example')
hold on
plot(x_od, y_od, 'b')
plot(x_od_est, y_od_est, 'g')
legend('odometry', 'kalman')
hold off

% IMU example
x_imu_est = kf(x_imu', 1, 1, 0.005, 0.05^2);
y_imu_est = kf(y_imu', 1, 1, 0.005, 0.05^2);

figure,
title ('IMU example')
hold on
plot(x_imu, y_imu, 'b')
plot(x_imu_est, y_imu_est, 'g')
legend('IMU', 'kalman')

hold off

% Sensor fusion
x_est = kf([x_od(2:360)'; x_imu'], 1, [1; 1], 0.005, [0.05^2 0; 0 0.05^2]);
y_est = kf([y_od(2:360)'; y_imu'], 1, [1; 1], 0.005, [0.05^2 0; 0 0.05^2]);

figure,
title ('Sensor fusion')
hold on
plot(x_od(2:360), y_od(2:360), 'b')
plot(x_imu, y_imu, 'r')
plot(x_est, y_est, 'g')
legend('odometry', 'IMU', 'kalman')
hold off

%% Extended Kalman Filter
%% Uncented Kalman Filter
%% Particle Filter
% Odometry example
x_od_est = pf(x_od, 1000, 'mean', 'systematic', 0.5);
y_od_est = pf(y_od, 1000, 'mean', 'systematic', 0.5);

figure,
title('Odometry example')
hold on
plot(x_od, y_od, 'b', 'LineWidth', 5)
plot(x_od_est(:,2), y_od_est(:,2), 'go')
legend('odometry', 'particle filter')
hold off

% IMU example
x_imu_est = pf(x_imu, 1000, 'mean', 'systematic', 0.5);
y_imu_est = pf(y_imu, 1000, 'mean', 'systematic', 0.5);

figure,
title('IMU example')
hold on
plot(x_imu, y_imu, 'b', 'LineWidth', 5)
plot(x_imu_est(:,2), y_imu_est(:,2), 'go')
legend('IMU', 'particle filter')
hold off

% Sensor fusion
x_est = pf([x_od(2:360); x_imu], 1000, 'mean', 'systematic', 0.5);
y_est = pf([y_od(2:360); y_imu], 1000, 'mean', 'systematic', 0.5);

figure,
title ('Sensor fusion')
hold on
plot(x_od, y_od, 'b', 'LineWidth', 5)
plot(x_imu, y_imu, 'r', 'LineWidth', 5)
plot(x_est(:,2), y_est(:,2), 'go')
legend('odometry', 'IMU', 'particle filter')
hold off