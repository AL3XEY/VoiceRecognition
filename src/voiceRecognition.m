close all;
clear all;
clc;

pkg load signal;

%hauteur
%fréquences
%forme des ondes (décomp Fourrier? Ondelettes?)

%STFT (Short-Time Fourrier Transform)
%MFCC (Mel-Frequency Cepstral Coefficients)
%DTW (Dynamic Time Warping)
%DWT (Discrete Wavelet Transform)

[signal,fe]= audioread('../res/coucou.wav') ;
% soundsc(signal/max(signal),fe) ;

N=length(signal);

te = 1/fe;
t = (0 : N-1) * te;
f = ((0 : N - 1)/N ) * fe;

figure;
plot(t,signal);
title('Original signal');
xlabel('t');
ylabel('s(t)');

%%%%% Fourrier %%%%%

fourrierTransform = fft(signal);
figure;
plot(f,fourrierTransform);
title('Fourrier Transform');
xlabel('f');
ylabel('S(f)');

%%%%% Module %%%%%

module = abs(fourrierTransform);
figure;
plot(f,module);
title('Module of the signal');
xlabel('f');
ylabel('|H(f)|');

%%%%% Noise removal %%%%%
%TODO cut frequencies

%%%%% DWT %%%%%
%TODO
%[u v] = dwt(signal, 'sym4');
%figure;
%plot(u,v);
%title('DWT');
%%xlabel('f');
%%ylabel('STFT(s)(f)');

%%%%% STFT %%%%%
%TODO
%shortTime = stft(signal);
%figure;
%plot(shortTime);
%title('STFT');
%%xlabel('f');
%%ylabel('STFT(s)(f)');

%%%%% Spectrogram %%%%%

[ss ff tt] = specgram(signal);
step=ceil(20*fe/1000);
window=ceil(100*fe/1000);
figure;
title('Spectrogram');
specgram(signal, 2^nextpow2(window), fe, window, window-step);
