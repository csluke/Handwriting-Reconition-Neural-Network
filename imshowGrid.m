function [  ] = imshowGrid(inputImage, grid)
% Plots image with a grid overlay
% If grid is 1, the gridlines are shown, otherwise only the axis
% labels are shown. Each box of the grid represents a 10x10 block of pixels

imshow(inputImage);
hold on
axis on
M = size(inputImage,1);
N = size(inputImage,2);
for k = 0:5:M
    x = [1 N];
    y = [k k];
    plot(x,y,'Color','w','LineStyle','-');
    if grid == 1
        plot(x,y,'Color',[0.5 0.5 0.5],'LineStyle','-');
    end
end

for k = 0:5:N
    x = [k k];
    y = [1 M];
    plot(x,y,'Color','w','LineStyle','-');
    if grid == 1
        plot(x,y,'Color',[0.5 0.5 0.5],'LineStyle','-');
    end
end

hold off
end

