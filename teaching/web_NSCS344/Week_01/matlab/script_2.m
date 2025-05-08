clear

% number of dots participants pay attention to
D = 8;

t0 = 80;

% viewing time in frames
frame_vals = [100:25:700];
T_vals = ceil((frame_vals-t0)/1000*30);

% fraction of dots moving in the preferred direction
COH = [3.2 6.4 12.8 25.6 51.2];
f_vals = (COH / 100 + 1) /2;


nDecisions = 20000;

for i = 1:length(T_vals)
    for j = 1:length(f_vals)
        ACCURACY(i,j) = makeManyDecisions_fast(D, T_vals(i), f_vals(j), nDecisions);
    end
end

%%
AZred = [171,5,32]/256;
AZblue = [12,35,75]/256;
AZsand = [241, 158, 31]/256;

figure(1); clf; hold on;
l = plot(frame_vals, ACCURACY,'.-');
xlim([0 800])

load ../goldShadlen_data.mat

for i = 1:length(realX)
    l2(i) = plot(realX{i}, realY{i},'.')
end

col = {AZblue (AZblue+AZsand)/2 AZsand (AZsand+AZred)/2 AZred};

for i = 1:5
%     f = (i-1)/4;
%     col = c1*f + c2*(1-f);
set([l(i) l2(i)], 'color', col{i});
end
set(l2, 'markersize', 30, 'linewidth', 3)
set(l, 'linewidth', 3)

set(gca, 'tickdir', 'out', 'fontsize', 18, 'ytick', [0.5:0.1:1], 'ylim', [0.45 1.05], ...
    'xtick', [0:200:800])
xlabel('viewing time [msec]')
ylabel('accuracy')
for i = 1:5
leg{i} = ['coh = ' num2str(COH(i))]
end
legend(l(end:-1:1), leg(end:-1:1), 'location', 'eastoutside')
