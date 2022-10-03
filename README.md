# Signal Processing (SP) project 1: Time-series denoising

# Credit
The dataset and proposal of the exercise is from the Udemy course [Signal Processing Problems, solved in Matlab and in Python](https://www.udemy.com/course/signal-processing/). I highly recommend this course for those learning signal processing.

# Proposal
The exercise presents the following noisy signal that I should clean.

<p align="center">
    <img width="400" src="https://github.com/MariaGoniIba/SP1-Time-series-denoising/blob/main/Original%20signal.png">
</p>

# Solution
The first thing that I observe are those large spikes. I use a median filter to get rid of those concrete points while keeping the variability of the signal.
The way I select the values which are particularly high is setting up a threshold. To do this, I plot the histogram of the signal and select manually the threshold for which values seem to be outliers.
<p align="center">
    <img width="400" src="https://github.com/MariaGoniIba/SP1-Time-series-denoising/blob/main/Histogram.png">
</p>

In this case, I choose a threshold of -5 and 5. I go through the signal with a loop and replace those values below -5 and above 5 with the median of the data points around. In this case, I select a window of k=5 points to each side. 
In the case that the spike is at the very beginning or end, when choosing a window of [i-k:i+k] you may be out of the signal. In these cases, I compute either the [i:i+k] windown in the beginning or the [i-k:i] window in the end.

```
for i=1:length(dataout)
    
    % find lower and upper bounds to avoid edge effects
    lowbnd = max(1,dataout(i)-k);
    uppbnd = min(dataout(i)+k,n);
    
    % compute median of surrounding points
    filtsig(dataout(i)) = median(origSignal(lowbnd:uppbnd));
end
```

Once filtered we still have a noisy signal. Now I apply a mean-smooth filter which sets up each data point in the filter signal to be the average of the surrounding points from the original signal. 
The number of data points that you go backwards and forwards in time is the order of the mean smoothing filter. 

<p align="center">
    <img width="600" src="https://github.com/MariaGoniIba/SP1-Time-series-denoising/blob/main/Original%20and%20filtered%20signal.png">
</p>

