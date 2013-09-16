function [ p,h,favor,R1SR,R2SR ] = ResponseRelated( SpikeRaster,Response,R1,R2,alpha)
%RESPONSERELATED Examine if a neuron is response-related 
%                (eg. Left and Right, more effort and less effort)
%   Detailed explanation goes here
%   SpikeRaster: for all trails
%   Response: the CEll shows the response in each trail of SpikeRaster
%   R1,R2: Response 1, 2 in strings
%   version 1.0.0 only supports two responses
if (nargin < 5)
    alpha = 0.05;
end

if ~(size(SpikeRaster,1) == size(Response,1))
    errordlg('Number of trails is inconsistent!');
    return;
end

R1SR = SpikeRaster(strcmp(Response,R1),:); %R1SP: SipkeRaster for Response 1
R2SR = SpikeRaster(strcmp(Response,R2),:); %R2SP: SipkeRaster for Response 2


[ p,h,trend ] = RankSumTest(R1SR,R2SR,alpha);

favor = 'N/A';
if(h == 1)
    if(trend==1)
        favor = R2;
    else
        favor = R1;
    end
end
end

