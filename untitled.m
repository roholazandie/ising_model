clc;
clear;

% Define true parameters
A = 5;  % Amplitude
b = 1;  % Decay rate

% Generate synthetic data
x = linspace(0, 20, 100);  % Create an array of x values from 0 to 20
y_true = A * exp(-b * x);  % True exponential decay
noise = 0.5 * randn(size(y_true));  % Generate random noise
y_noisy = y_true + noise;  % Add noise to the true data

% Fit the noisy data
[fit_params, gof] = fit(x', y_noisy', 'exp1');  % Fit to a single-term exponential

% Display the fitted parameters
disp(fit_params);

% Calculate the time constant from the fit
tau_calculated = -1/fit_params.b;

% Display the calculated time constant and the true time constant
fprintf('Calculated Time Constant: %f\n', tau_calculated);
fprintf('True Time Constant: %f\n', -1/-b);

% Optionally, plot the results
figure;
plot(fit_params, x, y_noisy);
title('Exponential Fit to Noisy Data');
legend('Data', 'Exponential Fit');
xlabel('X');
ylabel('Y');
