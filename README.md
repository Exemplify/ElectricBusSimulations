# GUIDE TO REPOSITORY

This repository contains the code for the work done towards the Masters dissertation titled "The system modelling for "

The repository is structured as follows:

- `src/` contains the source code for the project
- `src/data/` contains the sampled daat that can be used in the project as the original data is kept private for ethical reasons
- `src/dynamcis` contains the scripts for vehicle dynamics modelling
- `src/figures` contains the original matlab figures used in the dissertation
- `src/functions` contains the functions used in the project
- `src/scripts` contains the simulation scripts used in the project
- `src/utilities` contains the utility functions used in the project

## Installation

The project is developed using MATLAB 2022b with the following toolboxes installed:

- Control System Toolbox
- Curve Fitting Toolbox
- Computer Vision Toolbox
- Image Processing Toolbox
- Image Acquisition Toolbox
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox
- Symbolic Math Toolbox
- Optimization Toolbox
- Financial Toolbox

## Usage

To use the project the app.m file is broken into different sections. Each one of these sections can be run independently and represents a different part of the project. The system is designed to be modular and the properties of the simulation are updated in the loadOptions.m file. The options are then passed to the different functions and scripts.

Other than the app.m file, important scripts located in the scipts folder include the following:

- `chargingCalculations.m` charging calculations used within the simulation and the dissertaion
- `teperatureSensitivity.m` temperature model sensitivity analysis performed for the dissertation (processor intesive and takes a while to run)
- `efficiencySensitivities.m` efficeincy model sensitivity analysis performed for the dissertation (processor intesive and takes a while to run)
- `efficiencyLoop.m` efficeincy calculations used to compare different motor configurations
