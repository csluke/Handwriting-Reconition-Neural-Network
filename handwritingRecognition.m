%-------------------------------------------------------
% File name: handwritingRecognition.m
% Author: Christopher Sluke, Andre Le, Joel Rivera 
% Class: ELC 470 
% Professor: Dr. Anthony Deese
%
% Description: Handwriting recgonition Progrom which utilizes a neural
% network with 3 neurons to determine if a character is a 1, 0 or X
% from a pool of 30 images written by different students
%-------------------------------------------------------

clear;
close all;

%imports all the images
zero = cell(1,9);
for m = 1:length(zero)
    filename = strcat('0/Zero',int2str(m),'.png');
    zero{m} = importGrey(filename);
end

one = cell(1,10);
for m = 1:length(one)
    % the conditional statment prevents an error from 
    % occuring within the matlab rgb2gray function within the importGrey
    %  user-defined function that only happens when accessing one[6]
    if m ~= 6 
        filename = strcat('1/One',int2str(m),'.png');
        one{m} = importGrey(filename);
    end
end

ex = cell(1,11);
for m = 1:length(ex)
    filename = strcat('X/Ex',int2str(m),'.png');
    ex{m} = importGrey(filename);
end

%assigns training data
training_data0 = cat(3, zero{1}, zero{3}, zero{9});
training_data1 = cat(3, one{2}, one{7}, one{8});
training_dataX = cat(3, ex{3}, ex{7}, ex{11});

%assigns inputs data
x = cat(3, zero{2}, zero{4}, zero{5}, zero{6}, zero{7}, zero{8}, ... 
one{1}, one{3}, one{4}, one{5}, one{9}, one{10}, ...
ex{1}, ex{2}, ex{4}, ex{5}, ex{6}, ex{8}, ex{9}, ex{10});

numInputs = size(x,3); %number of inputs
iterations = 30000;  %number of iterations
numSensors = 10; %number of sensors

% Sensorblock(x1, x2, y1, y2, sensorType, sensorNum)
% x1 - x2: coordinates of pixels horizontal
% y1 - y2: coordinates of pixels veritcal
% sensorType: 1-red 2-green 3-blue
% sensorNum: 1 for first sensor, 2 for second sensor, etc.
sensor1 = Sensorblock(80, 110, 5, 60, 1, 1);
sensor2 =  Sensorblock(20, 60, 75, 115, 1, 2);
sensor3 = Sensorblock(130, 170, 75, 115, 1, 3);
sensor4 = Sensorblock(5, 130, 30, 50, 2, 1);
sensor5 = Sensorblock(60, 180, 50, 70, 2, 2);
sensor6 = Sensorblock(5, 130, 80, 100, 2, 3);
sensor7 = Sensorblock(60, 180, 100, 120, 2, 4);
sensor8 = Sensorblock(60, 130, 65, 85, 3, 1);
sensor9 = Sensorblock(40, 85, 10, 60, 3, 2);
sensor10 = Sensorblock(105, 150, 90, 140, 3, 3);

% imshowSensor(image, grid, varargin)
% image: name of image
% varargin: variable input, accepts any amount of sensors
% grid: 1 for grid, 0 for no grid

for m = 1:length(zero)
    figure('Name', strcat('zero', int2str(m)), 'NumberTitle','off');
    imshowSensor(zero{m}, 1, sensor1, sensor2, sensor3, sensor4, sensor5, ...
       sensor6, sensor7, sensor8, sensor9, sensor10);
end

for m = 1:length(one)
    if m ~= 6
        figure('Name',strcat('one', int2str(m)),'NumberTitle','off');
        imshowSensor(one{m}, 1, sensor1, sensor2, sensor3, sensor4, sensor5, ...
            sensor6, sensor7, sensor8, sensor9, sensor10);
    end
end

for m = 1:length(ex)
    figure('Name',strcat('x', int2str(m)),'NumberTitle','off');
    imshowSensor(ex{m}, 1, sensor1, sensor2, sensor3, sensor4, sensor5, ...
       sensor6, sensor7, sensor8, sensor9, sensor10);
end


inputData = zeros(numSensors, numInputs); %array of input data

w = zeros (30, iterations); %aray of weights

w0 = 1; %threshold
wGeneral = -1; %value assigned for weights that do not directly correspond with a sensor 

%initalizes all 30 weights

% important weights of first neuronn (zero)
w(1,1) = 1/3;
w(2,1) = 1/3;
w(3,1) = 1/3;
%----------------------
w(4,1) = wGeneral;
w(5,1) = wGeneral;
w(6,1) = wGeneral;
w(7,1) = wGeneral;
w(8,1) = wGeneral;
w(9,1) = wGeneral;
w(10,1) = wGeneral;
%==================
w(11,1) = wGeneral;
w(12,1) = wGeneral;
w(13,1) = wGeneral;
% important weights of sendond neuron (one)
w(14,1) = 2;
w(15,1) = 2;
w(16,1) = 2;
w(17,1) = 2;
%----------------------
w(18,1) = -2;
w(19,1) = -2;
w(20,1) = -2;
%==================
w(21,1) = wGeneral;
w(22,1) = wGeneral;
w(23,1) = wGeneral;
w(24,1) = wGeneral;
w(25,1) = wGeneral;
w(26,1) = wGeneral;
w(27,1) = wGeneral;
% important weights of thrid neuronn (x)
w(28,1) = 1/3;
w(29,1) = 1/3;
w(30,1) = 1/3;
%==========================

%processees each images with 10 sensors 
%and assigns them to the inpudData array
for i=1:numInputs
    inputData(1, i) = Sensor(x(:,:,i), 80, 110, 5, 60, 2);
    inputData(2, i) = Sensor(x(:,:,i), 20, 60, 75, 115, 2);
    inputData(3, i) = Sensor(x(:,:,i), 130, 170, 75, 115, 2);
    inputData(4, i) = Sensor(x(:,:,i), 5, 130, 30, 50, 2);
    inputData(5, i) = Sensor(x(:,:,i), 60, 180, 50, 70, 2);
    inputData(6, i) = Sensor(x(:,:,i), 5, 130, 80, 100, 2);
    inputData(7, i) = Sensor(x(:,:,i), 60, 180, 100, 120, 2);
    inputData(8, i) = Sensor(x(:,:,i), 60, 130, 65, 85, 2);
    inputData(9, i) = Sensor(x(:,:,i), 40, 85, 10, 60, 2);
    inputData(10, i) = Sensor(x(:,:,i), 105, 150, 90, 140,2);   
    print = sprintf('Aquired input data %d',i);
    disp(print)
end

%output for each neuron 
n0 = zeros(iterations, numInputs);
n1 = zeros(iterations, numInputs);
nx = zeros(iterations, numInputs);

idealOutput = zeros(3, numInputs);

for k=1:6
    idealOutput(1, k) = 1;
end

for k = 7:12
    idealOutput(2, k) = 1;
end

for k = 13:20
    idealOutput(3, k) = 1;
end
error = 0;
t = 1;
while t < iterations % t = iteration 
    % k = current input
    for k=1:numInputs
        ind = t+k-1; %current index
        
        %activation functions
        n0(t,k) = (inputData(1, k)*w(1,ind)) + (inputData(2, k)*w(2,ind)) + (inputData(3, k) * w(3,ind)) + (inputData(4, k) * w(4,ind)) + (inputData(5, k) * w(5,ind)) + (inputData(6, k) * w(6,ind)) + (inputData(7, k) * w(7,ind)) + (inputData(8, k) * w(8,ind)) + (inputData(9, k) * w(9,ind)) + (inputData(10, k) * w(10,ind)) - w0;
        n1(t,k) = (inputData(1, k)*w(11,ind)) + (inputData(2, k)*w(12,ind)) + (inputData(3, k)*w(13,ind)) + (inputData(4, k)*w(14,ind)) + (inputData(5, k)*w(15,ind)) + (inputData(6, k) * w(16,ind)) + (inputData(7, k) * w(17,ind)) + (inputData(8, k) * w(18,ind)) + (inputData(9, k) * w(19,ind)) + (inputData(10, k) * w(20,ind)) - w0;
        nx(t,k) = (inputData(1, k)*w(21,ind)) + (inputData(2, k)*w(22,ind)) + (inputData(3, k)*w(23,ind)) + (inputData(4, k)*w(24,ind)) + (inputData(5, k)*w(25,ind)) + (inputData(6, k) * w(26,ind)) + (inputData(7, k) * w(27,ind)) + (inputData(8, k) * w(28,ind)) + (inputData(9, k) * w(29,ind)) + (inputData(10, k) * w(30,ind)) - w0;
        
        %prints iteration nuber and current input
        print = sprintf('iteration: %d   input : %d ',t,k);
        disp(print)
       
        %The following conditional statments apply 
        % the unit step function
        if n0(t,k) > w0
            n0(t,k) = 1;
        else
            n0(t,k) = 0;
        end
        
        if n1(t,k) > w0
            n1(t,k) = 1;
        else
            n1(t,k) = 0;
        end
        
        if nx(t,k) > w0
            nx(t,k) = 1;
        else
            nx(t,k) = 0;
        end

        
        const = 0.01 * rand;
        %update expression for weights corresponting to n0
        for r=1:10
            w(r,ind+1) = const * (idealOutput(1,k) - n0(t,k)) * inputData(r,k) + w(r,ind);          
        end
    
        %update expression for weights corresponting to n1
        for r=11:20
            w(r,ind+1) = const * (idealOutput(2,k) - n1(t,k)) * inputData(r-10,k) + w(r,ind);
        end
        
        %update expression for weights corresponting to nx
        for r=21:30
            w(r,ind+1) =  const * (idealOutput(3,k) - nx(t,k)) * inputData(r-20,k) + w(r,ind); 
        end
        
    end
    t = t + numInputs; 
end

w(:,iterations) %prints final weights
finalOutput = zeros(3, numInputs);
finalOutput(1,:) = n0(t - numInputs,:);
finalOutput(2,:) = n1(t - numInputs,:);
finalOutput(3,:) = nx(t - numInputs,:);

idealOutput %prints ideal output
finalOutput %prints final calculated output

%calculates how many input values are accurate
numEqual = 0;
num = 0;
for a=1:numInputs
   
   for b=1:3
        if finalOutput(b,a) == idealOutput(b,a)
            num = num + 1;
        end
   end
   
   if num == 3
       numEqual = numEqual + 1;
   end
   num = 0;
end
figure
%plots weights
plot(w(1,:))
hold on
for c=2:30
    plot(w(c,:))
end
hold off

numEqual %prints how manay input values are correct
accuracy = numEqual/numInputs %prints accuracy

