function signalStruct = getAllegoXDatDinSigs(datasourceName, timerange) 
    arguments
        datasourceName string
        timerange (1, 2) = [-1, -1]
    end

    signalStruct = getAllegoXDatAllSigs(datasourceName, timerange);
    shape = size(signalStruct.signals);
    dinBegin = shape(1) - 3;
    dinEnd = dinBegin + 1;
    signalStruct.signals = signalStruct.signals(dinBegin:dinEnd, :);
end