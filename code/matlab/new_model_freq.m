% Remove zeros
load 'myRecording.mat'
z=1;
[lin,c] = size(myRecording);
for aux=1:lin
  if (myRecording(aux)~= 0)
      tes(z)= myRecording(aux);
      z=z+1;
  end
end
figure(1)
plot(tes);

% Pass by MFCC
modelo_sem = melcepst(tes,22050);


