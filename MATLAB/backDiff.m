function data = backDiff(dataInput, filtWindow)
% Create temp data
temp = zeros(1,length(dataInput));

for i = 2:length(dataInput)
    % find backward difference  
    temp(i) = dataInput(i)-dataInput(i-1);
end
%filter data
data = mAvgFilter2(temp, filtWindow);
end
