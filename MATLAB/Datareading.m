clear all
close all
clc
%Reading in CSV data
data = csvread('Walking 36 Steps.txt');
% Data is in format [time, xData, yData, zData] 
% Time is in microseconds
time = data(:,1)/1000000;
xData = data(:,2);
yData = data(:,3);
zData = data(:,4);

%Find the average time in between ticks
avgDT = (time(end) - time(1)) / length(time)
Freq = 1/avgDT

%Center RAW x,y,z ACCELERATION data at 0
xData = xData - mean(xData);
yData = yData - mean(yData);
zData = zData - mean(zData);

% Find sum of RAW x,y,z ACEELERATION data
sumData = xData + yData + zData;

% Preliminary orientation of x,y,z data (not necessary right now)
xyData = xData + yData;
xzData = xData + zData;
yzData = yData + zData;


% Window for moving average filter (Higher value = More Smoothing, More Delay)
avgWindow = 8;

% Plot RAW Acceleration Data
figure
plot([xData yData zData])

%Plot FILTERED Acceleration Data
figure 
xAcc = mAvgFilter2(xData,avgWindow);
yAcc = mAvgFilter2(yData,avgWindow);
zAcc = mAvgFilter2(zData,avgWindow);

% Sum of Filtered x,y,z Acceleration Data
sumAcc = xAcc + yAcc + zAcc;

% Preliminary Filtered orientation x,y,z data (not necessary right now)
xyAcc = mAvgFilter2(xyData,avgWindow);
xzAcc = mAvgFilter2(xzData,avgWindow);
yzAcc = mAvgFilter2(yzData,avgWindow);

% Plot Filtered Sum, x,y,z Acceleration Data
plot([sumAcc xAcc yAcc zAcc])
legend('sumAcc','xAcc','yAcc','zAcc')

% Take derivative of Acceleration (Jerk
% Derivative = backDiff(Data, filterWindow)
xJerk = backDiff(xAcc,avgWindow);
yJerk = backDiff(yAcc,avgWindow);
zJerk = backDiff(zAcc,avgWindow);
sumJerk = xJerk + yJerk + zJerk;

xyJerk = mAvgFilter2(xJerk + yJerk, avgWindow);
xzJerk = mAvgFilter2(xJerk + zJerk,avgWindow);
yzJerk = mAvgFilter2(yJerk + zJerk,avgWindow);

% Second Derivative of Acceleration (Jounce/Snap) UNUSED
xJounce = backDiff(xJerk,5);
yJounce = backDiff(yJerk,5);
zJounce = backDiff(zJerk,5);

% Plot Jerk Data (IMPORTANT DATA)
figure 
plot([sumJerk xJerk yJerk zJerk])
title('xJerk & yJerk; zJerk')
legend('sum','x','y','z')

% Plot 2D sums for orientated data (UNUSED)
figure
plot([xyJerk xzJerk yzJerk])
legend( 'xyJerk', 'xzJerk', 'yzJerk')


% Find Peaks using Jerk Threshold 
close all
minIndex = 100;
maxIndex = 800;

figure
threshJerk = 100;
jerkAboveT = (sumJerk > threshJerk)*threshJerk;
jerkBelowT = (sumJerk < -threshJerk)*-threshJerk;
plot([sumJerk(minIndex:maxIndex) jerkAboveT(minIndex:maxIndex) jerkBelowT(minIndex:maxIndex)])
title('sumJerk')

%Find Peaks using Acceleration Threshold
figure
threshAcc = 250;
accAboveT = (sumAcc > threshAcc)*threshAcc;
accBelowT = (sumAcc < -threshAcc)*-threshAcc;
plot([sumAcc(minIndex:maxIndex) accAboveT(minIndex:maxIndex) accBelowT(minIndex:maxIndex)])
title('sumAcc')

overlapI = and(accAboveT, jerkAboveT);
overlap = and(accAboveT, jerkAboveT);

