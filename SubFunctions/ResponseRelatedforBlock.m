function [ ResRelated ] = ResponseRelatedforBlock( BlockCell,Response,Event,Window,Bin,alpha )
%RESPONSERELATEDFORSESSION analysis REsponseRelated for a session
%   Detailed explanation goes here

if (nargin < 6)
    alpha = 0.05;
end

numUnit = length(BlockCell)-1; %Todo verify number of neurons

for i=1:numUnit
   
    if(BlockCell{i}.Electrode<=128)
    
        SR = getSpikeRaster(BlockCell{i}.Timestamp,Event,Window,Bin);
        [ResRelated(i).p,ResRelated(i).h,ResRelated(i).favor] = ResponseRelated( SR,Response,'R','L',alpha);   %Todo: replace 'R','L'

    end
    
end


end

