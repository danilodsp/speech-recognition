 function [frq,bnd] = erb2frq(erb)

 persistent u h k c d
 if ~numel(u)
     u=[6.23e-6 93.39e-3 28.52];
     p=sort(roots(u));           % p=[-14678.5 -311.9]
     d=1e-6*(6.23*(p(2)-p(1)));  % d=0.0895
     c=p(1);                     % c=-14678.5
     k = p(1) - p(1)^2/p(2);     % k=676170.4
     h=p(1)/p(2);                % h=47.06538
 end
 frq = sign(erb).*(k./max(h-exp(d*abs(erb)),0)+c);
 bnd=polyval(u,abs(frq));
 if ~nargout
     plot(erb,frq,'-x');
     xlabel(['Frequency (' xticksi 'Erb-rate)']);
     ylabel(['Frequency (' yticksi 'Hz)']);
 end