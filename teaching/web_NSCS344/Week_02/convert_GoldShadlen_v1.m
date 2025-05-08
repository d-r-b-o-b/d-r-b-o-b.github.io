clear
load goldShadlen_data.mat

% save goldShadlen.mat
N = 47;

dataX = nan(5,47);
dataY = nan(5,47);
for i = 1:length(realX)
    dataX(i,1:length(realX{i})) = realX{i};
    dataY(i,1:length(realX{i})) = realY{i};
end

dataX = dataX';
dataY = dataY';

figure(1); clf;
plot(dataX, dataY)

save goldShadlen dataX dataY