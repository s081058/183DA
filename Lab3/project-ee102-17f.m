clc;clear all;close all;
%% task 1
load Audiorecords.mat;
Fs = 8000;
s1 = trainAudiorecords(1,:);
s2 = trainAudiorecords(2,:);
filename1 = '-1.wav';
audiowrite(filename1,s1,Fs);
filename2 = '1.wav';
audiowrite(filename2,s2,Fs);

%% task 2
SVMStruct = svmtrain(trainAudiorecords,trainAudiolabels);
SVMSclassify = svmclassify(SVMStruct,testAudiorecords);
correctnum = 0;
a = testAudiolabels';
b = SVMSclassify';
for i = 1:length(a)
    if (a(i) == b(i))
        correctnum = correctnum + 1;
    end
end
correction = correctnum/length(a);
clear a b i;

%% task 3
FT1 = fft(s1);
FT2 = fft(s2);
f1 = (0:length(FT1)-1)/3;
subplot(4,1,1);
plot(f1,abs(FT1));
SFT1 = fftshift(FT1);
fshift1 = (-length(FT1)/2:length(FT1)/2-1)/3;
subplot(4,1,2);
plot(fshift1,abs(SFT1));

f2 = (0:length(FT2)-1)/3;
subplot(4,1,3);
plot(f2,abs(FT2));
SFT2 = fftshift(FT2);
fshift2 = (-length(FT2)/2:length(FT2)/2-1)/3;
subplot(4,1,4);
plot(fshift1,abs(SFT2));

%% task 4
FT = (fft(trainAudiorecords'))';
SFT = fftshift(FT,2);
PSD = (abs(SFT).^2);
SVMStructPSD = svmtrain(PSD,trainAudiolabels);

FTtest = (fft(testAudiorecords'))';
SFTtest = fftshift(FTtest,2);
PSDtest = (abs(SFTtest).^2);
SVMSclassifyPSD = svmclassify(SVMStructPSD,PSDtest);

correctnum1 = 0;
a = testAudiolabels';
b = SVMSclassifyPSD';
for i = 1:length(a)
    if (a(i) == b(i))
        correctnum1 = correctnum1 + 1;
    end
end
correction1 = correctnum1/length(a);

clear a b i;

%% task 5
[b,a] = butter(8,150/4000);
trainFilter = filter(b,a,trainAudiorecords,[],2);
figure;
plot(trainFilter(1,:));
figure;
plot(trainFilter(2,:));
STD1 = std(trainFilter,0,2);
SVMStructSTD = svmtrain(STD1,trainAudiolabels);
testFilter = filter(b,a,testAudiorecords,[],2);
STDtest = std(testFilter,0,2);
SVMSclassifySTD = svmclassify(SVMStructSTD,STDtest);
correctnum2 = 0;
clear a b;
a = testAudiolabels';
b = SVMSclassifySTD';
 for i = 1:length(a)
     if (a(i) == b(i))
         correctnum2 = correctnum2 + 1;
     end
 end
correction2 = correctnum2/length(a);
clear a b i;

%Report
