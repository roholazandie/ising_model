from scipy.io import loadmat
import os

directory = 'ising_matrices'  # The directory containing the .mat files
data = {}  # Dictionary to store the data

for file in os.listdir(directory):
    if file.endswith('.mat'):
        filepath = os.path.join(directory, file)
        mat_contents = loadmat(filepath)
        data[file] = {
            'matrix': mat_contents['spin'],
            'correlation_length': mat_contents['correlation_length'].item()  # Use .item() to convert numpy array to float
        }