clear all
close all
clc

data = csvread('Walking 36 Steps.txt');

timeData = data(:,1)/1000000;
xData = data(:,2);
yData = data(:,3);
zData = data(:,4);

% create vector
vectorData = [xData yData zData];
prevVectorData = circshift(vectorData,1);

for i=2:length(vectorData)
    currentVector = [xData(i) yData(i) zData(i)];
    prevVector = [xData(i-1) yData(i-1) zData(i-1)];
    dataAngle(i) = acos(dot(currentVector,prevVector)/dot(norm(currentVector),norm(prevVector)));
end
[b,a] = butter(3,0.15);
freqz(b,a);
dataOut = filter(b,a,dataAngle);

plot(timeData,dataOut);
