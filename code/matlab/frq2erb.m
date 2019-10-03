 function [erb,bnd] = frq2erb(frq)

 persistent u a h k c
 if ~numel(u)
     u=[6.23e-6 93.39e-3 28.52];
     p=sort(roots(u));               % p=[-14678.5 -311.9]
     a=1e6/(6.23*(p(2)-p(1)));       % a=11.17
     c=p(1);                         % c=-14678.5
    k = p(1) - p(1)^2/p(2);         % k=676170.42
     h=p(1)/p(2);                    % h=47.065
 end
 g=abs(frq);
 % erb=11.17268*sign(frq).*log(1+46.06538*g./(g+14678.49));
 erb=a*sign(frq).*log(h-k./(g-c));
 bnd=polyval(u,g);
 if ~nargout
     plot(frq,erb,'-x');
     xlabel(['Frequency (' xticksi 'Hz)']);
     ylabel(['Frequency (' yticksi 'Erb-rate)']);
 end