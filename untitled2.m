clc;
clear;

% Define the signal parameters
N = 256;  % number of points in the signal
x = linspace(0, 10, N);
frequency = 1;  % frequency of the sinusoid
signal = sin(2 * pi * frequency * x);


% Fourier transform of the signal
F_signal = fft(signal);

% Power spectrum of the signal
power_spectrum = abs(F_signal).^2;

% Inverse Fourier transform of the power spectrum
autocorrelation = ifft(power_spectrum);

% Use fftshift to center the zero lag of the autocorrelation
autocorrelation = fftshift(autocorrelation);


figure;
subplot(3, 1, 1);
plot(x, signal);
title('Original Signal');
xlabel('x');
ylabel('Amplitude');

subplot(3, 1, 2);
plot(x, power_spectrum);
title('Power Spectrum');
xlabel('Frequency');
ylabel('Power');

subplot(3, 1, 3);
plot(x - max(x)/2, real(autocorrelation));  % adjust x to center the plot around zero
title('Autocorrelation Function');
xlabel('Lag');
ylabel('Autocorrelation');
