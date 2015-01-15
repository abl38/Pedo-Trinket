function data = mAvgFilter2(dataInput, window)
    %Create temporary data with length(dataInput) elements
    tempData = ones(length(dataInput),1);
    % Iterate through dataInput
    for i = 1:length(dataInput)
        %When not enough elements for complete window
        if i <= window
            %tempData = average of first i elements when window is greate
            tempData(i) = mean(dataInput(1:i));
        elseif i > window
            %average of elements from (i-window) to i 
            tempData(i) = mean((dataInput((i-window):i)));
        end
    end
    
    data = tempData;

end

