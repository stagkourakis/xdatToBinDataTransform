function timerange = getAllegoXDatTimeRange(datasourceName)
    meta = readMeta(datasourceName);
    timerange = meta.status.t_range;
end