function signalStruct = getAllegoXDatDoutSigs(datasourceName, timerange) 
    arguments
        datasourceName string
        timerange (1, 2) = [-1, -1]
    end

    signalStruct = getAllegoXDatAllSigs(datasourceName, timerange);
    shape = size(signalStruct.signals);
    doutBegin = shape(1) - 1;
    doutEnd = shape(1);
    signalStruct.signals = signalStruct.signals(doutBegin:doutEnd, :);
end