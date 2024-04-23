J  = 1;
numSpinsPerDim = 200;
probSpinUp = 0.5;
spin = sign(probSpinUp - rand(numSpinsPerDim, numSpinsPerDim));
kT = 0;

dt = 0.00001;

for i=1:1000000
    kT = kT + dt;
    spin = metropolis(spin, kT, J);
    imagesc(spin);
    title(sprintf('Temprature %f', kT));
    axis equal off;
    drawnow;
end