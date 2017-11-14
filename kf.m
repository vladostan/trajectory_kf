function x_est = kf(z, A, C, Q, R)

% z - measurement signal
% A - state transition
% C - observation
% Q - covariance of process noise
% R - covariance of observation noise
% x_est - estimate signal

P = ones(size(A));
I = eye(size(A));

x_est = zeros(size(C, 2), size(z, 2));
x_est(:,1) =  C\z(:,1);

for i = 2:size(z, 2)
    
    % Predict
    x_est(:,i) = A * x_est(:,i-1);
    P = A * P * A' + Q;
    
    % Update
    G = P*C'/(C*P*C'+R);
    P = (I-G*C)*P;
    x_est(:,i) = x_est(:,i) + G*(z(:,i) - C*x_est(:,i));
    
end
