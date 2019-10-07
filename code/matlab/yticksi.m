 function s=yticksi(ah)

 if ~nargin
     ah=gca;
 end
 if nargout
 s=xyzticksi(2,ah);
 else
     xyzticksi(2,ah);
 end