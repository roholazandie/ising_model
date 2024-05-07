clc;
clear;

J  = 1;
N = 200;
prob_spin_up = 0.5;
spin = sign(prob_spin_up - rand(N, N));

kT = 0;

% analytical critical temperature
k = 1;
T_c = 2*J/(k*log(1+sqrt(2)));


max_dist = floor(N/2);
dt = 0.001;
snapshots = {};
snapshotInterval = 1;
calculateInterval = 100;

correlation_lengths = [];
temperatures = [];

kT = 0.1;
magnetizations = [];
iters = [];

for iter=1:100000
    kT = kT + dt;

    spin = metropolis(spin, kT, J);
    mag = magnetizationIsing(spin);

    % magnetizations = [magnetizations, mag];
    % iters = [iters, iter];
    

    correlation_length = 1./(abs(kT-T_c)+1/N);

    imagesc(spin);
    title(sprintf('Temprature %f', kT));
    axis equal off;
    drawnow;

    if kT > 3.5
        break
    end

end

figure;
plot(iters, magnetizations);
ylim([-1 1]); 



% for iter=1:1000000
%     kT = kT + dt;
% 
%     spin = metropolis(spin, kT, J);
% 
% 
%     snapshots{end+1} = spin;
% 
% 
%     if mod(iter, calculateInterval) == 0
%         % Preallocate array to store correlation functions
%         correlationFunctions = cell(size(snapshots));
% 
%         for idx = 1:length(snapshots)
%             ft = fft2(snapshots{idx});
%             powerSpectrum = abs(ft).^2;
%             correlationFunction = ifft2(powerSpectrum);
%             correlationFunctions{idx} = fftshift(real(correlationFunction));
%         end
% 
% 
%         radialProfiles = cell(size(correlationFunctions));
%         for idx = 1:length(correlationFunctions)
%             radialProfiles{idx} = abs(computeRadialProfile(correlationFunctions{idx}));
%         end
% 
%         % Optionally, average the profiles
%         averageRadialProfile = mean(cell2mat(radialProfiles'), 1);
% 
% 
%         % plot(averageRadialProfile);
%         % drawnow;
% 
% 
%         % Fit exponential decay to the correlation function
%         dists = 1:length(averageRadialProfile);
%         [fit_params, gof] = fit(dists.', averageRadialProfile.', 'exp1');
%         correlation_length = -1/fit_params.b;
% 
% 
%         correlation_lengths = [correlation_lengths, correlation_length];
%         temperatures = [temperatures, kT];
% 
%         % empty the snapshots
%         snapshots = {};
%     end
% 
% 
% 
% 
%     % if mod(iter, 100)
%     %     corr_func = zeros(1, max_dist);
%     %     for dist = 1:max_dist
%     %         for i = 1:N
%     %             for j = 1:N
%     %                 corr_func(dist) = corr_func(dist) + ...
%     %                     spin(i, j) * (spin(mod(i+dist-1,N)+1, j) + spin(mod(i-dist-1,N)+1, j) + ...
%     %                     spin(i, mod(j+dist-1,N)+1) + spin(i, mod(j-dist-1,N)+1));
%     %             end
%     %         end
%     %     end
%     %     corr_func = corr_func / (4*N*N);
%     %     % Exponential fit to get correlation length
%     %     dists = 1:max_dist;
%     %     fit_params = fit(dists.', corr_func.', 'exp1');
%     %     correlation_lengths = [correlation_lengths, -1/fit_params.b];
%     %     temperatures = [temperatures, kT];
%     % end
% 
% 
%     imagesc(spin);
%     title(sprintf('Temprature %f', kT));
%     axis equal off;
%     drawnow;
% 
%     if kT > 3
%         break
%     end
% end
% 
% 
% % Plot correlation length vs temperature
% figure;
% 
% finite_correlation_lengths = 1./(abs(temperatures-T_c)+1/N);
% plot(temperatures, correlation_lengths, temperatures, finite_correlation_lengths);
% xline(T_c, 'r--', 'LineWidth', 2);
% xlabel('Temperature (kbT)');
% ylabel('Correlation Length');
% title('Correlation Length vs. Temperature');
% 
% 
% 
