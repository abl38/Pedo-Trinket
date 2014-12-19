function splineArray = getSpline(dataInput, window)
    upper = [];
    lower = [];
    lastPeak = 0;
    lastTrough = 0;
    peakArray = getPeaks(dataInput, window);
    for i = 1:length(dataInput)
        if (peakArray(i) > 0)
            lastPeak = peakArray(i);
        end
        if (peakArray(i) < 0)
            lastTrough = peakArray(i);
        end
        
end