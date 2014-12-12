function data = splitRawAcc(dataInput, averageWindow, bufferLength)
jerk = backDiff(dataInput, averageWindow);
djerk = backDiff(jerk, averageWindow)
index = [];
c = 1;
for i = 2:length(djerk)
    if (djerk(i) < 0 && djerk(i-1) > 0) || (djerk(i) > 0 && djerk(i-1) < 0) 
        index(c) = i;
        c=c+1;
    elseif i == length(djerk)
        index(c) = i;
        c=c+1;
    end
    
end
temp={};
lastIndex = 1;
c=0;
for i = 1:length(index)
    if index(i) - lastIndex - bufferLength > 0 
        c=c+1;
        temp{c} = mAvgFilter2(dataInput(lastIndex:index(i)) - mean(dataInput(lastIndex:index(i))),averageWindow);
        lastIndex = index(i);
    end
    
end

data = temp;
end

    