clc;
clear;

J  = 1;
N = 500;
prob_spin_up = 0.5;
spin = sign(prob_spin_up - rand(N, N));


% analytical critical temperature
k = 1;
T_c = 2*J/(k*log(1+sqrt(2)));


max_dist = floor(N/2);
dt = 0.0001;

correlation_lengths = [];
temperatures = [];

kT = 0.1;
magnetizations = [];
iters = [];

% Create folders if they do not exist
if ~exist('ising_matrices/train', 'dir')
    mkdir('ising_matrices/train');
end
if ~exist('ising_matrices/eval', 'dir')
    mkdir('ising_matrices/eval');
end


for iter=1:1000000
    kT = kT + dt;

    spin = metropolis(spin, kT, J);
    mag = magnetizationIsing(spin);

    % Randomly decide to save in train or eval
    if rand() < 0.8  % Adjust the probability as needed
        folder = 'train';
    else
        folder = 'eval';
    end
    

    correlation_length = 1./(abs(kT-T_c)+1/N);

    filename = sprintf('ising_matrices/%s/spin_%d.mat', folder, iter);
    save(filename, 'spin', 'correlation_length');

    if kT > 3.5
        break
    end

end

