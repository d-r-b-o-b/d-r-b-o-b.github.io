clear

figure(1); clf; hold on;
x = 0:0.1:10;
s = 1;
y = exp(-(x - 3.812).^2/2/s^2) / sqrt(2*pi*s);
plot(x, y, 'linewidth', 3)
xlabel('noise parameter, \sigma')
ylabel('probability density')
set(gca, 'fontsize', 30, 'ytick', [])
saveFigurePng(gcf, 'pDist')