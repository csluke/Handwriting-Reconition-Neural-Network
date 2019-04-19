function [result] = Sensor(image, x1, x2, y1, y2, threshold)
% Determines if there is a given sensor by 
% comparing the values of each pixel. If there
% are more pixels than the threshold value that
% have an RGB value of less than 200, then there is 
% a line, and 1 is returned

xLength = x2 - x1;
yLength = y2 - y1;

greyValue = 0;

pixelcount = 0; 
result = 0;

i = x1;
j = y1;
while i < x2
    while j < y2
        greyValue = impixel(image,i,j);
        
        if greyValue < 160
            pixelcount = pixelcount + 1;
        end
        
        j = j+1;
    end 
    j = y1;
    i = i +1;
    
    if pixelcount >= threshold
        break
    end
end


if pixelcount >= threshold
    result = 1;
end
% checks to return 0 incase x and y values 
% are worng because of user error

if xLength <= 0
    result = 5;
    
else if yLength <= 0
    result = 5;
    
end

end

