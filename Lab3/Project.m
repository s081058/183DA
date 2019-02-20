%% Project_task1
clear, clc, close all;
load Audiorecords.mat;
Fs = 8000;
V_female=trainAudiorecords(1,:);
V_male=trainAudiorecords(2,:);
filename_1 = '-1.wav'; % female
filename_2 = '1.wav'; % male
audiowrite(filename_1 , V_female, Fs);
audiowrite(filename_2 , V_male, Fs);

%% Project_task2

SVMStruct = svmtrain(trainAudiorecords,trainAudiolabels);
SVMSclassify = svmclassify(SVMStruct,testAudiorecords);
correctnum = 0;
x = testAudiolabels';
y = SVMSclassify';
for i = 1:length(x)
    if (x(i) == y(i))
        correctnum = correctnum + 1;
    end
end
correction = correctnum/length(x);
%% Project_task3
% To compute the discrete Fourier Transform in MATLAB, fft is the command to use.
% clear, clc, close all;load Audiorecords.mat;

V_female=trainAudiorecords(1,:);
V_male=trainAudiorecords(2,:);
fs = 8000;
f = (0:length(fft(V_female))-1)*(fs/length(fft(V_female)));
M_1 = abs(fft(V_female));
M_2 = abs(fft(V_male));
subplot(2,1,1),plot (f, M_1);% First row of trainAudiorecords.
subplot(2,1,2),plot (f, M_2);% Second of trainAudiorecords.
% The magnitude of fourier transform of the second row is smaller than the
% second row's.

clear, clc, close all;
load Audiorecords.mat;
V_female=trainAudiorecords(1,:);
V_male=trainAudiorecords(2,:);
fs = 8000;
fshift = (-length(fft(V_female))/2:length(fft(V_female))/2-1)*(fs/length(fft(V_female)));
K_1 = abs(fftshift(V_female));
K_2 = abs(fftshift(V_male));
subplot(2,1,1),plot (fshift, K_1);
subplot(2,1,2),plot (fshift, K_2);

%% Project_task4
clear, clc, close all;
load Audiorecords.mat;
K_fourier = abs(fftshift((fft(trainAudiorecords'))',2)).^2;
M_fourier = abs(fftshift((fft(testAudiorecords'))',2)).^2;
modle = svmtrain(K_fourier,trainAudiolabels);
GROUP = svmclassify(modle,M_fourier);
CP = classperf(testAudiolabels',GROUP');
CP.CorrectRate*100

%% Project_task5
clear, clc, close all;
load Audiorecords.mat;
[b,a] = butter(8,100/4000); %High pass filter, keep the frequency that is higher than 125Hz.
[c,d] = butter(8,200/4000);        %Low pass filter, keep the frequency that is lower than 150Hz.

%%%%%%%%%Train SVM classifier with filter combination%%%%%%%
HighPass_filter = filter(b,a,trainAudiorecords,[],2);
LowPass_filter = filter(c,d,HighPass_filter,[],2);
F_Transform = abs(fft(LowPass_filter,[],2));
SVMStructSTD = svmtrain(F_Transform,trainAudiolabels);
%%%%%%%%% Filtrate data with filter combination%%%%%%%%%%%%%
High_Pass_filter = filter(b,a,testAudiorecords,[],2);
Low_Pass_filter = filter(c,d,High_Pass_filter,[],2);
Mfourier = abs(fft(Low_Pass_filter,[],2));
SVMSclassifySTD = svmclassify(SVMStructSTD,Mfourier);
%%%%%%%%%%Starts to test the accuracy%%%%%%%%%%%%%%%%%%%%%%%
CP = classperf(testAudiolabels,SVMSclassifySTD);
%%CP.CorrectRate*100
% End
correctnum2 = 0;
clear a b;
a = testAudiolabels';
b = SVMSclassifySTD';
 for i = 1:length(a)
     if (a(i) == b(i))
         correctnum2 = correctnum2 + 1;
     end
 end
correction2 = correctnum2/length(a)

