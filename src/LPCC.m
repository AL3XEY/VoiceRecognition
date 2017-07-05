close all;
clear all;
clc;

pkg load signal;
%pkg load ltfat;

[signal,fe]= audioread('sample.wav') ;
% soundsc(signal/max(signal),fe) ;
 
N=length(signal);
te = 1/fe;
t = (0 : N-1) * te;
f = ((0 : N - 1)/N ) * fe;
Nms = N*te;

figure;
plot(t,signal);
title('Original signal');
xlabel('t');
ylabel('s(t)');

%%%%% LPCC %%%%%

PowerSpectrum = abs(fft(signal,1024)).^2;
AutoCorrelation = ifft(PowerSpectrum,1024);
Cepstrum = ifft(log(PowerSpectrum),1024);
figure;
plot(PowerSpectrum);
figure;
plot(AutoCorrelation);
figure;
plot(Cepstrum);

[lp,g] = lpc(signal,10);
ARPowerSpectrum = g ./ abs(fft(lp,1024)).^2;
Cepstrum =  ifft(log(ARPowerSpectrum),1024);