function x_estimate = pf(x, particles, stateEstimationMethod, resamplingMethod, noise)

    pf = robotics.ParticleFilter;
    pf.StateEstimationMethod = stateEstimationMethod;
    pf.ResamplingMethod = resamplingMethod;

    initialize(pf, particles, [0 0], eye(2));

    t = linspace(0,18-0.05,size(x,1));
    x_estimate = [t; x']';

    x_predicted = zeros(length(t),2);
    x_corrected = zeros(length(t),2);

    for i = 1:length(t)
        % Predict
        [x_predicted(i,:),~] = predict(pf);
        % Observe
        x_measured(i,:) = x_estimate(i,:) + noise*(rand([1 2])-noise/2);
        % Correct
        [x_corrected(i,:),~] = correct(pf,x_measured(i,:));
    end
    
    x_estimate = x_corrected;
    
end