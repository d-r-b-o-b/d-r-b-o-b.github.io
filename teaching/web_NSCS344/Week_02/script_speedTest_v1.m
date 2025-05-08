clear

% number of dots participants pay attention to
D = 8;

t0 = 0;

% viewing time in frames
frame_vals = [100:25:700];
T_vals = [1:5:21];%ceil((frame_vals-t0)/1000*30);

% fraction of dots moving in the preferred direction
COH = [3.2 6.4 12.8 25.6 51.2];
f_vals = (COH / 100 + 1) /2;


nDecisions = 100;
ACCURACY = nan(length(T_vals), length(f_vals));
% tic
% for i = 1:length(T_vals)
%     for j = 1:length(f_vals)
%         ACCURACY(i,j) = makeManyDecisions(D, T_vals(i), f_vals(j), nDecisions);
%     end
% end
% t1 = toc
tic
for i = 1:length(T_vals)
    for j = 1:length(f_vals)
        ACCURACY(i,j) = makeManyDecisions_slow(D, T_vals(i), f_vals(j), nDecisions);
    end
end
t2 = toc
%%
