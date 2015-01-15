function numPeaks = countPeaks(data, threshold)
peakArray = (data > threshold) + (data < -threshold);
count = 0;
currentIndex = 1;
for i = 1:(length(peakArray)-1)
    if (peakArray(i+1) ~= peakArray(i)) && (peakArray(i+1) ~= 0) && (i-currentIndex > 10)  
        count = count + 1;
        currentIndex = i;
    end
end
numPeaks = floor(count/2); 
end