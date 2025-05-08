clear

IM = imread('Week_01_2.png');
figure(1);
image(IM)
hold on;

REAL_cornerX = [0 700];
REAL_cornerY = [0.5 1];

for i = 1:length(REAL_cornerX)
    disp(['click on corner'])
    disp(['   X = ' num2str(REAL_cornerX(i))])
    disp(['   Y = ' num2str(REAL_cornerY(i))])
    [IM_cornerX(i), IM_cornerY(i)] = ginput(1);
    plot(IM_cornerX(i), IM_cornerY(i), 'k.', 'markersize', 30)
end


col = 'brgycm';

for i = 1:5
    IM_x{i} = [];
    IM_y{i} = [];
    flag = true;
    while flag
        disp(['data series : ' num2str(i)])
        title(['data series : ' num2str(i)])
        [x,y] = ginput(1);
        if (x < 0) & (y < 0)
            flag = false;
        else
            IM_x{i} = [IM_x{i} x];
            IM_y{i} = [IM_y{i} y];
            plot(IM_x{i}(end), IM_y{i}(end), [col(i) '.'], 'markersize', 30)
        end
        
    end
    
end

% save pointsFromPlot
%%
load pointsFromPlot
IM_x{2} = IM_x{2}(1:end-1);
IM_y{2} = IM_y{2}(1:end-1);
%%
convert = @(x, x0_im, x0_re) (x - x0_im(1))/(x0_im(2) - x0_im(1))*(x0_re(2)-x0_re(1)) + x0_re(1);

for i = 1:5
    realX{i} = convert(IM_x{i}, IM_cornerX, REAL_cornerX)
    realY{i} = convert(IM_y{i}, IM_cornerY, REAL_cornerY)
end
% save goldShadlen_data