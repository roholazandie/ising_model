import numpy as np
from tqdm import tqdm
import matplotlib.pyplot as plt


def metropolis(spin, kT, J):
    """
    The Metropolis algorithm.
    Parameters:
        spin : np.array
            A matrix of +/-1's representing the spin configuration.
        kT : float
            The product of Boltzmann constant k and temperature T.
        J : float
            The coupling coefficient.
    Returns:
        np.array
            The updated spin configuration.
    """
    numIters = spin.size
    for _ in range(numIters):
        # Pick a random spin
        row, col = np.random.randint(spin.shape[0]), np.random.randint(spin.shape[1])

        # Find its nearest neighbors with periodic boundary conditions
        above = (row - 1) % spin.shape[0]
        below = (row + 1) % spin.shape[0]
        left = (col - 1) % spin.shape[1]
        right = (col + 1) % spin.shape[1]

        neighbors = spin[above, col] + spin[below, col] + spin[row, left] + spin[row, right]

        # Calculate energy change if this spin is flipped
        dE = 2 * J * spin[row, col] * neighbors

        # Boltzmann probability of flipping
        prob = np.exp(-dE / kT)

        # Spin flip condition
        if dE <= 0 or np.random.rand() <= prob:
            spin[row, col] = -spin[row, col]

    return spin


# Constants
J = 1
numSpinsPerDim = 100
probSpinUp = 0.5
spin = np.sign(probSpinUp - np.random.rand(numSpinsPerDim, numSpinsPerDim))
kT = 0
dt = 0.001
N = 100  # Update the plot every N iterations

k = 1
T_c = 2 * J / (k * np.log(1 + np.sqrt(2)))  # 2.269

# Simulation loop
plt.figure()
temperatures = []

kT = T_c
for i in range(100000):
    spin = metropolis(spin, kT, J)
    if i % N == 0:  # Every N iterations, update the plot
        plt.clf()  # Clear the figure to update the plot
        plt.imshow(spin, cmap='gray', interpolation='nearest')
        plt.title(f'Temperature {kT:.5f}')
        plt.axis('equal')
        plt.axis('off')
        plt.draw()
        plt.pause(0.001)  # Pause to update the display



for i in range(1, 1000001):
    kT += dt
    temperatures.append(kT)
    spin = metropolis(spin, kT, J)
    if i % N == 0:  # Every N iterations, update the plot
        plt.clf()  # Clear the figure to update the plot
        plt.imshow(spin, cmap='gray', interpolation='nearest')
        plt.title(f'Temperature {kT:.5f}')
        plt.axis('equal')
        plt.axis('off')
        plt.draw()
        plt.pause(0.001)  # Pause to update the display

    if kT > 3:
        break

plt.show()

# Plot correlation length vs temperature
correlation_lengths = 1. / (np.abs([t - T_c for t in temperatures]) + 1 / N)

plt.plot(temperatures, correlation_lengths)
plt.xlabel('Temperature')
plt.ylabel('Correlation Length')
plt.title('Correlation Length vs Temperature')
plt.show()

