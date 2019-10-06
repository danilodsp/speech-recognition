function [f,t,w] = enframe(x,win,inc,m)

nx = length(x(:));

if nargin<2 || isempty(win)
    win=nx;
end

if nargin<4 || isempty(m)
    m='';
end

nwin = length(win);

if nwin == 1
    lw = win;
    w = ones(1,lw);
else
    lw = nwin;
    w = win(:).';
end

if (nargin < 3) || isempty(inc)
    inc = lw;
end

nli = nx-lw+inc;
nf = max(fix(nli/inc),0);   % number of full frames
na = nli-inc*nf+(nf==0)*(lw-inc);       % number of samples left over
fx = nargin>3 && (any(m=='z') || any(m=='r')) && na>0; % need an extra row
f = zeros(nf+fx,lw);
indf = inc*(0:(nf-1)).';
inds = (1:lw);

if fx
    f(1:nf,:) = x(indf(:,ones(1,lw))+inds(ones(nf,1),:));
    if any(m=='r')
        ix=1+mod(nf*inc:nf*inc+lw-1,2*nx);
        f(nf+1,:)=x(ix+(ix>nx).*(2*nx+1-2*ix));
    else
        f(nf+1,1:nx-nf*inc)=x(1+nf*inc:nx);
    end
    nf=size(f,1);
else
    f(:) = x(indf(:,ones(1,lw))+inds(ones(nf,1),:));
end

if (nwin > 1)   % if we have a non-unity window
    f = f .* w(ones(nf,1),:);
end

if nargout>1
    if any(m=='E')
        t0=sum((1:lw).*w.^2)/sum(w.^2);
    elseif any(m=='A')
       t0=sum((1:lw).*w)/sum(w);
   else
       t0=(1+lw)/2;
    end
    t=t0+inc*(0:(nf-1)).';
end
