%%% Maria Goni
%%% Time series denoising

clear; clc; close all

load('denoising_codeChallenge.mat')

figure(1)
plot(origSignal)
title('Original signal')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Median filter to remove spike noise %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Set a threshold of values which will be considered particulary large
figure(2)
histogram(origSignal)
zoom on

% visual-picked threshold
thresh = 4;

% find data values above and below the threshold
dataout = find(abs(origSignal) > thresh);

% initialize filtered signal
filtsig = origSignal;

% loop through thresh points and set to median of k
k = 20; % actual window is k*2+1
n = length(origSignal);
for i=1:length(dataout)
    
    % find lower and upper bounds to avoid edge effects
    lowbnd = max(1,dataout(i)-k);
    uppbnd = min(dataout(i)+k,n);
    
    % compute median of surrounding points
    filtsig(dataout(i)) = median(origSignal(lowbnd:uppbnd));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Running-mean filter %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

filtsig2 = filtsig;

% implement the running mean filter
k = 200; % filter window is actually k*2+1
n = length(filtsig);
for i=1:n

    % find lower and upper bounds to avoid edge effects
    lowbnd = max(1,i-k);
    uppbnd = min(i+k,n);

    % each point is the average of k surrounding points
    filtsig2(i) = mean(filtsig(lowbnd:uppbnd));
end

figure(3)
subplot(3,1,1)
plot(origSignal)
title('Original signal')
subplot(3,1,2)
plot(filtsig)
title('Median filter')
subplot(3,1,3)
plot(filtsig2)
title('Running-mean filter')

