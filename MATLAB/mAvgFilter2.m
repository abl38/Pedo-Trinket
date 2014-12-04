function data = mAvgFilter2(dataInput, window)
    
    tempData = ones(length(dataInput),1);
    
    for i = 1:length(dataInput)
        if i <= window
            tempData(i) = sum(dataInput(1:i))/i;
        elseif i > window
            tempData(i) = sum((dataInput((i-window):i))./window);
        end
    end
    
    data = tempData;

end

