function [sumAcc xAcc yAcc zAcc] = plotAcceleration(dataString)
    data = csvread(dataString);
    time = data(:,1)/1000000;
    xData = data(:,2);
    yData = data(:,3);
    zData = data(:,4);
    xData = xData - mean(xData);
    yData = yData - mean(yData);
    zData = zData - mean(zData);
    sumData = xData + yData + zData;
    avgWindow = 8;
    %Plot FILTERED Acceleration Data
    figure 
    xAcc = mAvgFilter2(xData,avgWindow);
    yAcc = mAvgFilter2(yData,avgWindow);
    zAcc = mAvgFilter2(zData,avgWindow);
    % Sum of Filtered x,y,z Acceleration Data
    sumAcc = mAvgFilter2(xData + yData + zData, avgWindow);
    plot([sumAcc xAcc yAcc zAcc])
    legend('sumAcc','xAcc','yAcc','zAcc')
    title(dataString)
end