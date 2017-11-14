clc; close all;

%% Preconfigure
mylego = legoev3('usb');

mL = motor(mylego,'B')
mR = motor(mylego,'C')

speed = 50;
%% Starting movement by trajectory
resetRotation(mL)
resetRotation(mR)
rotationL = [];
rotationR = [];
%Trajectory:
%Forward 3s
mL.Speed = speed
mR.Speed = speed
start(mL)
start(mR)
for i = 1:60
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.05)
end
stop(mL)
stop(mR)
pause(0.5);

%Rotate 135 CW
mR.Speed = -speed
start(mL)
start(mR)
for i = 1:10
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.4*2/10)
end
stop(mL)
stop(mR)
pause(0.5);

%Forward 5s
mR.Speed = speed
start(mL)
start(mR)
for i = 1:100
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.05)
end
stop(mL)
stop(mR)
pause(0.5);

%Rotate 135 CCW
mL.Speed = -speed
start(mL)
start(mR)
for i = 1:10
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.4*2/10)
end
stop(mL)
stop(mR)
pause(0.5);

%Forward 3s
mL.Speed = speed
start(mL)
start(mR)
for i = 1:60
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.05)
end
stop(mL)
stop(mR)
pause(0.5);

%Rotate 135 CCW
mL.Speed = -speed
start(mL)
start(mR)
for i = 1:10
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.4*2/10)
end
stop(mL)
stop(mR)
pause(0.5);

%Forward 5s
mL.Speed = speed
start(mL)
start(mR)
for i = 1:100
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.05)
end
stop(mL)
stop(mR)
pause(0.5);

%Rotate 135 CW
mR.Speed = -speed
start(mL)

start(mR)
for i = 1:10
    rotationL = [rotationL readRotation(mL)];
    rotationR = [rotationR readRotation(mR)];
    pause(0.4*2/10)
end
stop(mL)
stop(mR)
%% Save odometry to file
% save('odometry2','rotationL', 'rotationR');