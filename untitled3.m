clc;
clear;

% Define grid parameters
N = 256;  % dimensions of the grid
x = linspace(-N/2, N/2, N);
y = linspace(-N/2, N/2, N);
[X, Y] = meshgrid(x, y);

% Create a 2D Gaussian distribution centered at (0,0)
sigma = N/8;  % standard deviation of the Gaussian
signal = exp(-(X.^2 + Y.^2) / (2 * sigma^2)) + 0.1*rand(N);

% Fourier transform of the signal
F_signal = fft2(signal);

% Power spectrum of the signal
power_spectrum = abs(F_signal).^2;

% Inverse Fourier transform of the power spectrum
autocorrelation = ifft2(power_spectrum);

% Use fftshift to center the result
autocorrelation = fftshift(real(autocorrelation));



figure;
subplot(2, 2, 1);
imagesc(x, y, signal);
axis square;
title('Original 2D Gaussian Signal');
xlabel('x');
ylabel('y');
colorbar;

subplot(2, 2, 2);
imagesc(x, y, log(1+power_spectrum));  % log scale for better visibility
axis square;
title('Power Spectrum');
xlabel('Frequency X');
ylabel('Frequency Y');
colorbar;

subplot(2, 2, 3);
imagesc(x, y, autocorrelation);
axis square;
title('Autocorrelation Function');
xlabel('Lag X');
ylabel('Lag Y');
colorbar;
