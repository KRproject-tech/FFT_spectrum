clc
clear all
close all hidden

%% delete
delete( '*.asv')


%% time series

time_m = linspace( 0, 10, 1e+6);
y_data = @( time)( 6*sin( 2*pi*1.25*time) + 5*sin( 2*pi*100*time) + 3*cos( 2*pi*1000*time) );


data = [ time_m.' y_data( time_m).'];

%% FFT spectrum

[ dom_freq, dom_amp] = FFT_data( data, 1e+7, 1);

%% plot

hold( gca, 'on')
plot( dom_freq, dom_amp, 'ro')