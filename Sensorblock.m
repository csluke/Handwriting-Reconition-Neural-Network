classdef Sensorblock
    
    properties
        x1
        x2
        y1
        y2
        xLength
        yLength
        sensorType
        sensorNum
    end
    
    methods        
        function obj = Sensorblock(x1, x2, y1, y2, sensorType, sensorNum)
        % Sensorblock(x1, x2, y1, y2, sensorType, sensorNum)
        % x1 - x2: coordinates of pixels horizontal
        % y1 - y2: coordinates of pixels veritcal
        % sensorType: 1-red 2-green 3-blue
        % sensorNum: 1 for first sensor, 2 for second sensor, etc.
            if nargin == 6
                obj.x1 = x1;
                obj.x2 = x2;
                obj.y1 = y1;
                obj.y2 = y2;
                obj.xLength = x2-x1;
                obj.yLength = y2-y1;
                obj.sensorType = sensorType;
                obj.sensorNum = sensorNum;   
            else
                error("Wrong number of input arguments");
            end
        end
        
        function result = Sensorblocktest(image, threshold, obj)
        % Determines if there is a given sensor by 
        % comparing the values of each pixel. If there
        % are more pixels than the threshold value that
        % have an RGB value of less than 200, then there is 
        % a line, and 1 is returned
            if nargin == 3
                isSensor = isa(obj,'Sensorblock');
                if isSensor == 1
                    pixelcount = 0; 
                    result = 0;

                    i = obj.x1;
                    j = obj.y1;
                    while i < obj.x2
                        while j < obj.y2
                            greyValue = impixel(image,i,j);
                            if greyValue < 200
                                pixelcount = pixelcount + 1;
                            end
                            j = j+1;
                        end 
                        j = obj.y1;
                        i = i+1;
                    end

                    if pixelcount >= threshold
                        result = 1;
                    end

                    % checks to return 0 incase x and y values 
                    % are wrong because of user error
                    if obj.xLength <= 0
                        result = 0;
                    elseif obj.yLength <= 0
                        result = 0;
                    end  
                else
                    result = -1;
                end
            else
                error("Wrong number of input arguments");
            end
        end
        
        function imshowSensor(image, grid, varargin)
        % imshowSensor(image, grid, varargin)
        % image: name of image
        % varargin: variable input, accepts any amount of sensors
        % grid: 1 for grid, 0 for no grid
            if nargin >= 3
                imshowGrid(image, grid);
                for k = 1:nargin-2
                    isSensor = isa(varargin{k},'Sensorblock');  % check for valid input
                    if isSensor == 1
                        obj = varargin{k};  %current object is a sensorblock
                        hold on
                        % creating sensor
                        % sensorType: 1-red 2-green 3-blue
                        if obj.sensorType == 1
                            rectangle('Position',[obj.x1 obj.y1 obj.xLength obj.yLength], ...
                            'EdgeColor','r', ...
                            'LineWidth', 2, ...
                            'LineStyle', '-');
                        elseif obj.sensorType == 2
                            rectangle('Position',[obj.x1 obj.y1 obj.xLength obj.yLength], ...
                                'EdgeColor','g', ...
                                'LineWidth', 2, ...
                                'LineStyle', '-.');
                        elseif obj.sensorType == 3
                            rectangle('Position',[obj.x1 obj.y1 obj.xLength obj.yLength], ...
                                'EdgeColor','b', ...
                                'LineWidth', 2, ...
                                'LineStyle', ':');
                        end
                        hold off;
                    else
                        error('One or more inputs was not a sensor');
                    end
                end
            else
               error("Wrong number of input arguments");
            end
        end
    end
end
