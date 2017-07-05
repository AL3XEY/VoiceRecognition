close all;
clear all;
clc;

pkg load signal;
pkg load ltfat;

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

%%%%% Step 1 %%%%%

sampleSizems = 0.025; %in seconds
%sampleSize = sampleSizems/te
%newSize = round(N/sampleSize)
newSize = sampleSizems*fe
sampleSize = fe/newSize
newSignal = cell(1,newSize);
newSignalDFT = cell(1,newSize);
for i = 1:newSize
    newSignal{i} = signal((i-1)*sampleSize+1:i*sampleSize);
    %%%%% Step 2 %%%%%
    newSignalDFT{i} = dft(newSignal{i});
    %melScale{i} = 1127.*log(1+newSignalDFT./700);
    per{i} = periodogram(newSignalDFT{i});
end
%TODO sampleSize is not an integer number

%%%%% Step 3 %%%%%

lowerFreq = 300;
higherFreq = fe/2;
lowerMel = 1127.*log(1+lowerFreq./700);
higherMel = 1127.*log(1+higherFreq./700);
nFilters = 26;
space = (higherFreq-lowerFreq)/26;
spaceMels = (higherMel-lowerMel)/26;
listMels = [lowerMel:spaceMels:higherMel];
listFreq = [lowerFreq:space:higherFreq];
listFreq2 = 700.*(exp(listMels./1125)-1);

listMels - 1125.*log(1+listFreq./700);%
listFreq - listFreq2;%

ff = floor((nFilters+1).*listFreq2./space); %TODO right space ?
%ff = floor((nFilters+1).*listFreq2./fe) %TODO right ?


for i=2:nFilters-1% TODO 1:nFilters
    %filterBank{i} = zeros(1,fe);
    filterBank{i} = zeros(1,max(ff));
    k = [ff(i-1):ff(i)];
    filterBank{i}(k) = (k-ff(i-1))./(ff(i)-ff(i-1));
    k = [ff(i):ff(i+1)];
    filterBank{i}(k) = (ff(i+1)-k)./(ff(i+1)-ff(i));
    figure;
    %plot([1:fe],filterBank{i});
    plot([1:max(ff)],filterBank{i});
end

figure;
%plot([1:fe],filterBank{i});
plot([1:max(ff)],filterBank{2},[1:max(ff)],filterBank{3},[1:max(ff)],filterBank{4},[1:max(ff)],filterBank{5},[1:max(ff)],filterBank{6},[1:max(ff)],filterBank{7},[1:max(ff)],filterBank{8},[1:max(ff)],filterBank{9},[1:max(ff)],filterBank{10},[1:max(ff)],filterBank{11},[1:max(ff)],filterBank{12},[1:max(ff)],filterBank{13},[1:max(ff)],filterBank{14},[1:max(ff)],filterBank{15},[1:max(ff)],filterBank{16},[1:max(ff)],filterBank{17},[1:max(ff)],filterBank{18},[1:max(ff)],filterBank{19},[1:max(ff)],filterBank{20},[1:max(ff)],filterBank{21},[1:max(ff)],filterBank{22},[1:max(ff)],filterBank{23},[1:max(ff)],filterBank{24},[1:max(ff)],filterBank{25});

%
%figure;
%plot(listMels,listFreq);

%%%%% Step 4 %%%%%


%%%%% Step 5 %%%%%


%%%%% Step 6 %%%%%


%%%%% Step 7 %%%%%


