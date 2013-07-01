function [LETS,RETS] = getLRtime(ETS,Response)
% get event timestamp for L and R

IndexLeft = strcmp(Response,'L');
LETS = ETS(IndexLeft);

IndexRight = strcmp(Response,'R');
RETS = ETS(IndexRight);

end