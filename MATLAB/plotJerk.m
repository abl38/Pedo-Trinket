function [sumJerk xJerk yJerk zJerk] = plotJerk(dataString)
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
    xJerk = backDiff(xData,avgWindow);
    yJerk = backDiff(yData,avgWindow);
    zJerk = backDiff(zData,avgWindow);
    sumJerk = mAvgFilter2(sqrt(xJerk.^2 + yJerk.^2 + zJerk.^2),avgWindow);
    figure
    %plot([sumJerk xJerk yJerk zJerk])
    %legend('sumJerk','xJerk','yJerk','zJerk')
    plot(sumJerk)
    title(dataString)
end