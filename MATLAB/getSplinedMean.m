function splinedMean = getSplinedMean(dataInput, window)
   
    lowerSlope = 0; lc = 2;
    upperSlope = 0; uc = 2;
    lastPeak = 0;
    lastTrough = 0;
    peakArray = getPeaks(dataInput, window);
    upper = zeros(1,length(peakArray));
    lower = zeros(1,length(peakArray));
    deriv = backDiff(dataInput, 1);

    tempArray = [];
for i = 2:length(deriv)
    if (deriv(i) < 0 && deriv(i-1) > 0) || (deriv(i) > 0 && deriv(i-1) < 0) 
        if (deriv(i) < 0 && deriv(i-1) > 0) 
        lowerPeaks(i-1) = dataInput(i-1);
        
        elseif (deriv(i) > 0 && deriv(i-1) < 0) 
        upperPeaks(i-1) = dataInput(i-1);
        end
    else
    upperPeaks(i-1) = 0;
    lowerPeaks(i-1) = 0;
    end
    
    
    
end

tempArray(end+1) = 0;
    
    for j = 1:length(upperPeaks)
        if (upperPeaks(j) ~= 0)
            upperIndex(uc) = j;
            uc = uc + 1;
        end
    end
    
    for j = 1:length(lowerPeaks)
        if (lowerPeaks(j) ~= 0)
            lowerIndex(lc) = j;
            lc = lc + 1;
        end
    end
    
    uc = 2;
    lc = 2;
    
    for i = 2:length(peakArray)
        if (uc < length(upperIndex)) && (lc < length(lowerIndex))
            
            if (upperPeaks(i) ~= 0)
            lastPeak = upperPeaks(i);
            lower(i) = lower(i-1) + lowerSlope;
            upper(i) = upperPeaks(i);
            uc = uc + 1;
            end
            
            if (lowerPeaks(i) ~= 0)
            lastTrough = lowerPeaks(i);
            lower(i) = peakArray(i);
            upper(i) = upper(i-1) + upperSlope;
            lc = lc + 1;
            end
            
            if (upperPeaks(i) == 0 && lowerPeaks(i) == 0)
            lowerSlope = (lowerPeaks(lowerIndex(lc)) - lastPeak) / (lowerIndex(lc) - lowerIndex(lc-1));
            upperSlope = (upperPeaks(upperIndex(uc)) - lastTrough) / (upperIndex(uc) - upperIndex(uc-1));
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
    
    splinedMean = dataInput - splineArray';
end