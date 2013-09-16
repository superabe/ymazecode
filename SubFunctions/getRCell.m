function [ RCell ] = getRCell( BehCell )
%GETRCELL get RCell from Behavioral data cell
%   Detailed explanation goes here
RCell = [BehCell{1}(2) BehCell{2}(2) BehCell{3}(2)] ;

end

