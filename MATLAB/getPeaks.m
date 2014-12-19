function peakArray = getPeaks(accData, window)
jerk = backDiff(accData, 1);

tempArray = [];
for i = 2:length(jerk)
    if (jerk(i) < 0 && jerk(i-1) > 0) || (jerk(i) > 0 && jerk(i-1) < 0) 
        tempArray(i-1) = accData(i-1);
    else
        tempArray(i-1) = 0;
    end
    
end
tempArray(end+1) = 0;
peakArray = tempArray;

end