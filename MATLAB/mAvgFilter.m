function data = mAvgFilter(dataInput, window)
    b = (1/window)*ones(1,window);
    data = filter(b,1,dataInput);
end