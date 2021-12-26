function [] = testPRISM01potential()

% Colin Ophus - 2021 Feb
% 01 - This testing script generates and saves the projected potentials,
% intended to be reused for testing. 

% emd struct .mat output for testing
test_file_name = 'stack.mat';

% load the decahedral nanoparticle testing
%load('inputData01.mat')
%cellDim = [50,50,268.7]; %ESTEM
cellDim = [50,50,173.6]; %others


b=dlmread('stack.txt','%s');
atoms=b;

% Inputs:
emdSTEM.pixelSize =  50/1024;
emdSTEM.potBound = 3;
emdSTEM.potSamplingZ = 0.1; 
emdSTEM.potBandLimit = [0.75 0.95]; 
emdSTEM.numFP = 16; 
emdSTEM.sliceThickness = 1.5; 
emdSTEM.interpolationFactor = [1 1]*1; 

% Compute potentials
emdSTEM = PRISM01_potential(atoms,cellDim,emdSTEM);

% Save .mat output
save(test_file_name,'emdSTEM');

end