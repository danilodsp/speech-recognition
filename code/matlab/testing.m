% trying to remove the zeros

z=1;
[lin,c] = size(myRecording);

for aux=1:lin
  if myRecording(aux)~= 0
      tes(z)= myRecording(aux);
      z=z+1;
  end
end
figure(2)
plot(tes);

model_without_zero = melcepst(tes);
