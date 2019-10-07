myVoice = audiorecorder;

disp('Start speaking.');
recordblocking(myVoice, 5);
disp('End of recording. Playing back ...');

playerObj = play(myVoice);

disp('Properties of playerObj:');
get(playerObj)