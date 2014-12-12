clear all
close all
clc
%Reading in CSV data
data = csvread('Data 10 F Steps - 10 B Steps - Shaking .txt');
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
sumJerk = sqrt(xJerk.^2 + yJerk.^2 + zJerk.^2);

xyJerk = mAvgFilter2(xJerk + yJerk, avgWindow);
xzJerk = mAvgFilter2(xJerk + zJerk,avgWindow);
yzJerk = mAvgFilter2(yJerk + zJerk,avgWindow);

% Plot Jerk Data (IMPORTANT DATA)
figure 
plot([sumJerk xJerk yJerk zJerk])
title('xJerk & yJerk; zJerk')
legend('sum','x','y','z')

% Plot 2D sums for orientated data (UNUSED)
figure
plot([sumJerk xyJerk xzJerk yzJerk])
legend('sumJerk', 'xyJerk', 'xzJerk', 'yzJerk')

%% Low pass Filter
close all
L = length(time);
n = 2^nextpow2(L);
xF = fft(xData,n)/L;
yF = fft(yData,n)/L;
zF = fft(zData,n)/L;

f = Freq/2*linspace(0,1,n/2+1);
figure
plot(f, 2*abs(xF(1:n/2+1)))

xF(250:end) = 0;
xIf = mAvgFilter2(real(ifft(xF)),avgWindow);
xIf2 = mAvgFilter2(LPF(xData, 5, Freq), avgWindow);
figure
plot(xIf)
hold on
plot(xIf2)

%% Splitting Data
cellSum = splitRawAcc(sumAcc,avgWindow, 150);
stepsCount = 0;
recompJerk=[];
recompAcc = [];
length(cellSum)
for i = 1:length(cellSum)
    sumCellJerk{i} = backDiff(cellSum{i},avgWindow);
    stepsCount = stepsCount + countPeaks(sumCellJerk{i},50);
    recompAcc = cat(1,recompAcc,  cellSum{i});
    recompJerk = cat(1,recompJerk,  sumCellJerk{i});
end
stepsCount
figure 
plot(recompJerk)
figure
plot(recompAcc)

