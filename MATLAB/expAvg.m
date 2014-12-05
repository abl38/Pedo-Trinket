function data = expAvg(dataInput, window, a)    
    % IN TESTING, CURRENTLY UNUSED
    tempData = ones(length(dataInput),1);
    smoothVec = ones(length(window),1);
    
    for x = 2:window
    smoothVec(x) = (1-a)^(x-1);
    end
    smoothVec = smoothVec .* a;
    length(smoothVec)
    
    for i = 1:length(dataInput)
        if i <= window
            tempData(i) = sum(dot(dataInput(1:i),smoothVec(1:i)));
        elseif i > window
            tempData(i) = sum(dot((dataInput((i-window+1):i)),smoothVec));
        end
        
    end
    
    data = tempData;

end





