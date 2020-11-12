function ksortMat = getAsKilosort2Matrix(datasource, timerange)
%ksortMat = getAsKilosort2Matrix(datasourceName, timerange)
    arguments
        datasource string
        timerange (1, 2) = [-1, -1]
    end
    % sigStruct = getAllegoXDatAllSigs(datasourceName, timerange);
    sigStruct = getAllegoXDatAllSigs(datasource, timerange);

    ksortMat = int16(sigStruct.signals / 0.195); %convert from volts to 16 bit range
end
