%Match all sensors data dimensions of time

%Calculate factors
acc_f = size(acc,1)/size(odometry,1);
gyro_f = size(gyro,1)/size(odometry,1);

temp_acc = zeros(size(odometry,1),3);
temp_gyro = zeros(size(odometry,1),3);

j = 1;
for i = 1:size(odometry,1)
    temp_acc(j,:) = acc(round(i*acc_f),:);
    temp_gyro(j,:) = gyro(round(i*gyro_f),:);
    j = j + 1;
end

acc = temp_acc;
gyro = temp_gyro;

clear i j gyro_f acc_f temp_acc temp_gyro