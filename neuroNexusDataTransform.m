%%  This scripts aims to transform the data acquired by NeuroNexus proprietary software Allego to binary format
%   which is compatible with the spike sorting pipeline KiloSort

%   (C) Stefanos Stagkourakis, 2020
%   California Institute of Technology

%%  Set the directory path, where your data is located for where to find your data
close all; clear all; clc;
NNDir = 'C:\directory';
addpath(genpath(NNDir))

myProbCh = 32;     % Indicate how many channels your silicon probe carries (example is set at n=32)
fs       = 20000;  % Define your sampling rate

%%  Define key variables

datasource = 'sbpro_1__uid0925-13-41-01';                           %   File name
reader = allegoXDatFileReader();                                    %   Load the data

timeRange = reader.getAllegoXDatTimeRange(datasource);
timeRange  = [timeRange(1)  floor(timeRange(2))];                   %   Define time range of your recording
% destinationFile = NNDir;

%   Create signal structure
signalStruct = reader.getAllegoXDatAllSigs(datasource, timeRange);
signalStruct = getAllegoXDatPriSigs(datasource, timeRange);
signalStruct = getAllegoXDatAuxSigs(datasource, timeRange);
signalStruct = getAllegoXDatDinSigs(datasource, timeRange);
signalStruct = getAllegoXDatDoutSigs(datasource, timeRange);

%% Prepare data Matrix for KiloSort
ksortMat = getAsKilosort2Matrix(datasource, timeRange);             %   Load your data matrix

%  Consider trimming any peripheral signals in the step below
ksortMatNeuralSig = ksortMat(1:myProbCh,:);
whos ksortMatNeuralSig 

% This dataset is 32 channels by 20000 time samples.
fid = fopen(fullfile(NNDir, '\ksortMatNeuralSig.bin'), 'w'); 
fwrite(fid, ksortMatNeuralSig, 'int16');
fclose(fid);

%%  You can now spike sort your data with kilosort.
%   Note that you need a channel map specific for your probe.


%%  End
