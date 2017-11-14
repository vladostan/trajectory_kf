%Read odometry data
load('data/odometry1')

odometry = double([rotationL' rotationR']);

%Read accelerometer data
fileID = fopen('data/accelerometer1.csv','r');
formatSpec = '%d,%f,%f,%f,%s';
A = fscanf(fileID,formatSpec);

acc = zeros(length(A)/27,3);
j = 1;
for i = 1:27:length(A)
    acc(j,1) = A(i+1,1);
    acc(j,2) = A(i+2,1);
    acc(j,3) = A(i+3,1);
    j = j + 1;
end

%Read gyroscope data
fileID = fopen('data/gyroscope1.csv','r');
A = fscanf(fileID,formatSpec);

gyro = zeros(length(A)/27,3);
j = 1;
for i = 1:27:length(A)
    gyro(j,1) = A(i+1,1);
    gyro(j,2) = A(i+2,1);
    gyro(j,3) = A(i+3,1);
    j = j + 1;
end

fclose('all');
clear A fileID formatSpec i j rotationL rotationR