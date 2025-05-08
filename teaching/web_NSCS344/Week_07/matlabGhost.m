clear

defImage = pow2(get(0,'DefaultImageCData'),47);
imgCell = repmat({zeros(size(defImage))},8,7);
for shift = 0:52
    imgCell{shift+1} = bitshift(defImage,shift);
end;
allImages = cell2mat(imgCell.');
imshow(allImages,[min(allImages(:)) max(allImages(:))]);
%%
filename = '~/Desktop/ghost.gif'
figure(1); clf
for i = 1:52
    i
    imagesc(imgCell{i})
    %title(num2str(i))
    %pause(1)
    drawnow 
    % Capture the plot as an image
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    % Write to the GIF File
    if i == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
end
%%
