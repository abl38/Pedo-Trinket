function data = stdDev(dataInput , window)

    tempData = ones(length(dataInput),1);
    
    for i = 1:length(dataInput)
        if i <= window
            tempData(i) = std(dataInput(1:i));
        elseif i > window
            tempData(i) = std((dataInput((i-window):i)));
        end
    end
    
    data = tempData;

end

