function signalStruct = getAllegoXDatAuxSigs(datasourceName, timerange) 
    arguments
        datasourceName string
        timerange (1, 2) = [-1, -1]
    end

    signalStruct = getAllegoXDatAllSigs(datasourceName, timerange);
    shape = size(signalStruct.signals);
    auxBegin = shape(1) - 5;
    auxEnd = auxBegin + 1;
    signalStruct.signals = signalStruct.signals(auxBegin:auxEnd, :);
end