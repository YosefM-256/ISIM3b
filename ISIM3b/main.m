close all; clear all;
global DAC1 DAC0 CRes EpwrPin;

DAC1 = 0; DAC0 = 1800; CRes = 0; EpwrPin = 1;

pathsNconsts = struct(  'simulationCommand',    'XVIIx64.exe -b -ascii', ...
                        'homePath',             'U:\ISIM3b\PNP_2N3906', ...
                        'cirFileName',          'ISIM3bcir_PNP_2N3906.cir', ...
                        'rawFileName',          'ISIM3bcir_PNP_2N3906.raw', ...
                        'variablesFile',        'variables_PNP_2N3906.txt', ...
                        'LTSpicePath',          'C:\Program Files\LTC\LTspiceXVII', ...
                        'databasePath',         'database_PNP_2N3906.mat');

simulationVariables = getSimulationVariables(pathsNconsts);
% q = {};
% for i=3600:25:4075
%     setDAC1(i);
%     q{end+1} = simulate(pathsNconsts,simulationVariables);
%     i
% end
findall(0,'Name','ISIM app').delete();
global app; app = ISIMapp;

% tuneBy("Ib","DAC0",-1e-3,"inverse",pathsNconsts,simulationVariables)
% doubleTuning('Ie','beta PNP',-5e-4,10,'inverse','direct',pathsNconsts,simulationVariables);

%%
% simulate(pathsNconsts,simulationVariables)

% f = plotVsatIcNPN(10, [ [5:9]*1e-4 [1:9]*1e-3 [1:9]*1e-2 [1:4]*1e-1 ], pathsNconsts,simulationVariables);
% s = plotIcVce([.3 .8 1 2 4]*1e-3,[10 [100:100:4000]],pathsNconsts,simulationVariables);
% d = plothfeIc(5,[ [1:9].*1e-5 [1:9].*1e-4 [1:9].*1e-3],"return",pathsNconsts,simulationVariables);
% % app.addPlot(s,"Ic - Vce NPN","Ic - Vce plot");
% % app.addPlot(f,"Vsat - Ic NPN","Vsat - Ic plot");
% app.addPlot(d,"hfe - Ic NPN","hfe - Ic plot");
% g = plotIdVds([2 3 4],[100:100:4000],pathsNconsts,simulationVariables);


% h = sweepDAC0Vgs([2 3 4],[100:100:4000],pathsNconsts,simulationVariables);
% b = plotIdVgs(5,[100:100:5000],"return",pathsNconsts,simulationVariables);
% n = plotRdsonVgs(50e-3,[[100:100:3000] [3025:25:4000]],pathsNconsts,simulationVariables);
% m = sweepDAC0VgsPMOS([2],50:50:4050,pathsNconsts,simulationVariables);
% tuneBy('Vc','DAC1',5,'inverse',pathsNconsts,simulationVariables);
% q = plotIcVcePNP(-3e-3,[10 [100:100:4000]],pathsNconsts,simulationVariables);
% simulate(pathsNconsts,simulationVariables)


% q = plotIcVcePNP([-5 -10 -30 -50]*1e-4,[100:100:4000],pathsNconsts,simulationVariables);
% p = plotVsatIcPNP(10,-1*10.^[-3:0.1:-0.5],pathsNconsts,simulationVariables);
% z = plothfeIcPNP(5,[25:25:2000],"return",pathsNconsts,simulationVariables);


w = sweepDAC0VgsPMOS([2 3 4],100:100:4000,pathsNconsts,simulationVariables);
%%
% s = plotIcVcePNP(-1*[.3 .8 1 2 4]*1e-3,[10 [100:100:4000]],pathsNconsts,simulationVariables);
% f = plotVsatIcPNP(10,-1*[[1:9]*1e-3 [1:9]*1e-2 [1:3]*1e-1 ], pathsNconsts,simulationVariables);
% d = plothfeIcPNP(5,[50:50:4000],"return",pathsNconsts,simulationVariables);
saveDatabase(pathsNconsts);