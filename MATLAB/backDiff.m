function data = backDiff(dataInput, filtWindow)
temp = zeros(1,length(dataInput));
for i = 2:length(dataInput)
    del = dataInput(i)-dataInput(i-1);
    temp(i) = del;
end
data = mAvgFilter2(temp, filtWindow);
end
