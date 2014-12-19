function splineMean = getSplinedMean(dataInput, window)
   
    lowerSlope = 0; lc = 2;
    upperSlope = 0; uc = 2;
    lastPeak = 0;
    lastTrough = 0;
    peakArray = getPeaks(dataInput, window);
    upper = zeros(1,length(peakArray));
    lower = zeros(1,length(peakArray));

    
    for j = 1:length(peakArray)
        if (peakArray(j) > 0)
            upperIndex(uc) = j;
            uc = uc + 1;
        end
        if (peakArray(j) < 0)
            lowerIndex(lc) = j;
            lc = lc + 1;
        end
    end
    
    uc = 2;
    lc = 2;
    
    for i = 2:length(peakArray)
        if (uc < length(upperIndex)) && (lc < length(lowerIndex))
            if (peakArray(i) > 0)
            lastPeak = peakArray(i);
            upper(i) = peakArray(i);
            uc = uc + 1;
            end
            if (peakArray(i) < 0)
            lastTrough = peakArray(i);
            lower(i) = peakArray(i);
            lc = lc + 1;
            end
            if (peakArray(i) == 0)
            lowerSlope = (peakArray(lowerIndex(lc)) - lastPeak) / (lowerIndex(lc) - lowerIndex(lc-1));
            upperSlope = (peakArray(upperIndex(uc)) - lastTrough) / (upperIndex(uc) - upperIndex(uc-1));
            lower(i) = lower(i-1) + lowerSlope;
            upper(i) = upper(i-1) + upperSlope;
            end
        elseif uc > length(upperIndex)
            upper(i) = upper(i-1);
        elseif lc > length(lowerIndex)
            lower(i) = lower(i-1);
        end
        
    end

    for i = 1:length(upper)
        splineArray(i) = (upper(i) + lower(i))/2;
    end
    
    splineMean = splineArray;
end