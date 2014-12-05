clear all
close all
clc

data = csvread('Demo Data Walking.txt');
time = data(:,1)/1000000;
xData = data(:,2);
yData = data(:,3);
zData = data(:,4);

avgDT = (time(end) - time(1)) / length(time)

xData = xData - mean(xData);
yData = yData - mean(yData);
zData = zData - mean(zData);

xVelMean = cumtrapz(xData)./avgDT;
yVelMean = cumtrapz(yData)./avgDT;
zVelMean = cumtrapz(zData)./avgDT;

xPosMean = cumtrapz(xVelMean)./avgDT;
yPosMean = cumtrapz(yVelMean)./avgDT;
zPosMean = cumtrapz(zVelMean)./avgDT;

avgWindow = 8;

figure
plot([xData yData zData])


xAcc = mAvgFilter2(xData,avgWindow);
yAcc = mAvgFilter2(yData,avgWindow);
zAcc = mAvgFilter2(zData,avgWindow);

xVelFilt = cumtrapz(xAcc)./avgDT;
yVelFilt = cumtrapz(yAcc)./avgDT;
zVelFilt = cumtrapz(zAcc)./avgDT;
xPosFilt = cumtrapz(xVelFilt)./avgDT;
yPosFilt = cumtrapz(yVelFilt)./avgDT;
zPosFilt = cumtrapz(zVelFilt)./avgDT;

xJerk = backDiff(xAcc,5);
yJerk = backDiff(yAcc,5);
zJerk = backDiff(zAcc,5);

xJounce = backDiff(xJerk,5);
yJounce = backDiff(yJerk,5);
zJounce = backDiff(zJerk,5);

figure
plot([xAcc yAcc zAcc])
title(['Window Size = ', num2str(avgWindow)])
legend('xAcc','yAcc','zAcc')

figure
plot([zData zAcc])
title(['Raw Data vs Moving Average Filter; window = ', num2str(avgWindow)])

figure
plot([xVelFilt yVelFilt zVelFilt])
title('Velocity')
legend('x','y','z')
figure
plot([xPosFilt yPosFilt zPosFilt])
title('Position')
legend('x','y','z')
figure 
plot([xAcc xJerk xJounce])
title('x Acc, Jerk, Jounce')
legend('a','da','d2a')