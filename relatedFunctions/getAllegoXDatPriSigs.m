function signalStruct = getAllegoXDatPriSigs(datasourceName, timerange) 
    arguments
        datasourceName string
        timerange (1, 2) = [-1, -1]
    end

    signalStruct = getAllegoXDatAllSigs(datasourceName, timerange);
    shape = size(signalStruct.signals);
    signalStruct.signals = signalStruct.signals(1:shape(1) - 6, :);
end