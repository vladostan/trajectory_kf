clc; close all;

% Odometry localization (Dead reckoning)
r = 0.028; % Radius of wheels in m
d = 0.149; % Axial distance between wheels in m

dphi_r = diff(odometry(:,2)); %Number of rotations per time measurement
dphi_l = diff(odometry(:,1)); %Number of rotations per time measurement
ds = r/2*(dphi_r + dphi_l);
dtheta = r/d*(dphi_r - dphi_l);

x_od = zeros(size(odometry,1),1);
y_od = zeros(size(odometry,1),1);
theta = zeros(size(odometry,1),1);

for i = 2:size(odometry,1)
    x_od(i) = x_od(i-1) + ds(i-1)*sind(theta(i-1));
    y_od(i) = y_od(i-1) + ds(i-1)*cosd(theta(i-1));
    theta(i) = theta(i-1) + dtheta(i-1);
end

x_od = gnegate(x_od);
% scatter(x_od, y_od);

clear d dphi_l dphi_r ds dtheta i r theta