function [] = testPRISM03prism()

% Colin Ophus - 2021 Feb
% 03 - testing of pure PRISM simulations

% input .mat file for potentials, output of final results
test_file_name = 'stack.mat';
output_file_base = 'stack';


% import potentials
load(test_file_name);

% interp factor testing
emdSTEM.partitionNumberRings = [];
%emdSTEM.interpolationFactor = [1 1]; 
% emdSTEM.interpolationFactor = [1 1]*2; 
 emdSTEM.interpolationFactor = [1 1]*8;
 %emdSTEM.interpolationFactor = [1 1]*1; 

% Probe positions
dxy = emdSTEM.cellDim(1:2) / 150;
xR = [0.01 0.99]*emdSTEM.cellDim(1); %change this 0.1 to 0.9 to avoid edge effects
yR = [0.01 0.99]*emdSTEM.cellDim(2); 
emdSTEM.xp = (xR(1)+dxy/2):dxy:(xR(2)-dxy/2);
emdSTEM.yp = (yR(1)+dxy/2):dxy:(yR(2)-dxy/2);

% Other inputs
emdSTEM.E0 = 200e3;     
emdSTEM.cS = 0; %0.3e7;     
emdSTEM.probeSemiangleArray = 28/ 1000; %default is 20
%emdSTEM.probeDefocusDF = 75 + 268.7-173.6; ESTEM
emdSTEM.probeDefocusDF = 75; 
emdSTEM.partitionSigmoidal = false; 
emdSTEM.flagOutput3D = true; 
emdSTEM.flagOutput4D = false; 
emdSTEM.drBins3D = 1 / 1000; 
emdSTEM.flagProbePositionsNearestPixel = true;


% Run PRISM simulation
emdSTEM = PRISM02_Smatrix(emdSTEM);
emdSTEM = PRISM03_probes(emdSTEM);

% Output struct
emd = emdOutput(emdSTEM);

% save file
filename = [output_file_base '_interp' ...
    '_' num2str(emdSTEM.interpolationFactor(1)) ...
    '_' num2str(emdSTEM.interpolationFactor(2)) ...
    '.mat'];
save(filename,'emd','-v7.3');


end