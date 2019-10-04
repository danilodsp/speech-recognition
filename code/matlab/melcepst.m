function [c,tc] = melcepst(s,fs,w,nc,p,n,inc,fl,fh)
   if nargin<2 fs=11025; end
   if nargin<3 w='M'; end
   if nargin<4 nc=12; end
   if nargin<5 p=floor(3*log(fs)); end
   if nargin<6 n=pow2(floor(log2(0.03*fs))); end
   if nargin<9
      fh=0.5;   
       if nargin<8
          fl=0;
           if nargin<7
             inc=floor(n/2);
           end
       end
   end
 
 if isempty(w)
    w='M';
 end
 if any(w=='R')
    [z,tc]= enframe(s,n,inc);
 elseif any (w=='N')
    [z,tc]=enframe(s,hanning(n),inc);
 else
    [z,tc]=enframe(s,hamming(n),inc);
 end
 
 f=rfft(z.');
 [m,a,b]=melbankm(p,n,fs,fl,fh,w);
 pw=f(a:b,:).*conj(f(a:b,:));
 pth=max(pw(:))*1E-20;
 if any(w=='p')
    y=log(max(m*pw,pth));
 else
    ath=sqrt(pth);
    y=log(max(m*abs(f(a:b,:)),ath));
 end
 c=rdct(y).';
 nf=size(c,1);
 nc=nc+1;
 if p>nc
    c(:,nc+1:end)=[];
 elseif p<nc
    c=[c zeros(nf,nc-p)];
 end
 if ~any(w=='0')
    c(:,1)=[];
    nc=nc-1;
 end
 if any(w=='E')
    c=[log(max(sum(pw),pth)).' c];
    nc=nc+1;
 end
 
 % calculate derivative
 
 if any(w=='D')
   vf=(4:-1:-4)/60;
   af=(1:-1:-1)/2;
   ww=ones(5,1);
   cx=[c(ww,:); c; c(nf*ww,:)];
   vx=reshape(filter(vf,1,cx(:)),nf+10,nc);
   vx(1:8,:)=[];
   ax=reshape(filter(af,1,vx(:)),nf+2,nc);
   ax(1:2,:)=[];
   vx([1 nf+2],:)=[];
   if any(w=='d')
      c=[c vx ax];
     else
      c=[c ax];
   end
 elseif any(w=='d')
   vf=(4:-1:-4)/60;
   ww=ones(4,1);
   cx=[c(ww,:); c; c(nf*ww,:)];
   vx=reshape(filter(vf,1,cx(:)),nf+8,nc);
   vx(1:8,:)=[];
   c=[c vx];
end
 
 if nargout<1
  [nf,nc]=size(c);
 %    t=((0:nf-1)*inc+(n-1)/2)/fs;
  ci=(1:nc)-any(w=='0')-any(w=='E');
  imh = imagesc(tc/fs,ci,c.');
  axis('xy');
  xlabel('Time (s)');
  ylabel('Mel-cepstrum coefficient');
  map = (0:63)'/63;
  colormap([map map map]);
  colorbar;
 
 end

 
