load('myRecording.mat');
% Record your voice for 1 seconds.
a = audiorecorder;
disp('Start speaking.')
recordblocking(a, 5);
disp('End of Recording.');

%Frequencia de amostragem
Fs = 44000;

% Play back the recording.
play(a);

% Store data in double-precision array.
atual = getaudiodata(a);

% Plot the waveform.
figure(1)
plot(atual);
title('audio');


