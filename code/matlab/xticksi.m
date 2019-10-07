 function s=xticksi(ah)
 if ~nargin
     ah=gca;
 end
 if nargout
 s=xyzticksi(1,ah);
 else
     xyzticksi(1,ah);
 end