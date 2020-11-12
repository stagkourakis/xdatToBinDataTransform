function signalStruct = getAllegoXDatAllSigs(datasourceName, timerange) 
    arguments
        datasourceName string
        timerange (1, 2) = [-1, -1]
    end

    meta = readMeta(datasourceName);
    sampFreq = meta.status.samp_freq;

    timeStart = timerange(1);
    if (timeStart == -1)
        timeStart = meta.status.t_range(1);
    end

    timeEnd = timerange(2);
    if (timeEnd == -1)
        timeEnd = meta.status.t_range(2);
    end

    numSamples = timeEnd * sampFreq - timeStart * sampFreq;
    tstampOffset = timeStart * sampFreq - meta.status.timestamp_range(1);

    shape = [meta.status.shape(2), numSamples];
    skipData = tstampOffset * shape(1) * 4;
    skipTstamp = tstampOffset * 8;

    fData = strcat(datasourceName, '_data.xdat');
    fTstamps = strcat(datasourceName, '_timestamp.xdat');

    fid = fopen(fData);
    fseek(fid, skipData, 'bof');
    sigs = fread(fid, shape, '*single');
    fclose(fid);

    fid = fopen(fTstamps);
    fseek(fid, skipTstamp, 'bof');
    timeStamps = fread(fid, [1, numSamples], '*int64');
    fclose(fid);

    timeSamples = cast(timeStamps, 'double') / sampFreq;

    signalStruct.signals = sigs;
    signalStruct.timeStamps = timeStamps;
    signalStruct.timeSamples = timeSamples;
end