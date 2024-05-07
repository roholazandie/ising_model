clc;
clear;

Tmax = 4;
T = 0:0.01:Tmax;

T_c = 2.26;
N = 100;

correlation_lengths = 1./abs(T-T_c);
finite_correlation_lengths = 1./(abs(T-T_c)+1/N);

plot(T, correlation_lengths, T, finite_correlation_lengths)