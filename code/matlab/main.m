% Complete code
load('modelo_sem.mat');
load('modelo.mat');
% Record speech signal
a = audiorecorder;
disp('Comece a falar.')
recordblocking(a, 1);
disp('Parou de gravar.');

% Sampling frequency
Fs = 44000;

% Play back the speech recorded
play(a);

% Put speech signal in a vector
gravacao_atual = getaudiodata(a);

% Plot the wave shape
figure(1)
plot(gravacao_atual);
title('audio');

% Remove zeros
z=1;
[lin,c] = size(gravacao_atual);
for aux=1:lin
  if (gravacao_atual(aux)~= 0)
      tes(z)= gravacao_atual(aux);
      z=z+1;
  end
end
figure(2)
plot(tes);


% Using MFCC
w = melcepst(tes,22050);
[l2,c2]=size(w);
% w = melcepst(gravacao_atual);


% Collect frame of same length
[l1,c1]=size(modelo_sem);
troca = zeros(l1,c1);
for i=1:l1
    for j=1:c1
        if (l1<=l2)&&(c1<=c2)
      troca(i,j)=w(i,j);  
        end
    end
end

% Pearson correlation
x=troca.*modelo_sem;
% x=w.*modelo;
[lin,col] = size(x);
y = zeros(lin,1);

for i=1:lin
    som= 0;
    for j=1:col
        som = x(i,j);
        y(i,1)= y(i,1) +som;
    end
end

med = mean(y);

m = max(y);
y = y/m;
figure(3)
plot(y);

media= (y(3)+y(4))/2

if media >= 0.85
    
disp('abre');
media

end

