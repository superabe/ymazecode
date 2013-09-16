function [ MeanDelta,SEMDelta,p,h ] = DeltaFR(SR1pre,SR1post,SR2pre,SR2post,alpha )
%DELTAFR Delta Firing Rate, examine if there is significant difference 
%                           between the increment of A1 and A2  
%  SR1pre: SpikRaster1 pre
%  SR1post: SpikRaster1 post
%  SR2pre: SpikRaster2 pre
%  SR2post: SpikRaster2 post

if(nagrin <3)
    alpha=0.05;
end

if ~(size(SR1pre,1) == size(SR1post,1) && size(SR2pre,1) == size(SR2post,1))
    warndlg('trials of Array pre and post must be equal')
    return
end
deltaA1 = sum(SR1pre,2)./size(SR1pre,2) - sum(SR1post,2)./size(SR1post,2) ;
deltaA2 = sum(SR2pre,2)./size(SR2pre,2) - sum(SR2post,2)./size(SR2post,2) ;

MeanDelta(1,1) = mean(deltaA1,1);
MeanDelta(1,2) = mean(deltaA2,1);
SEMDelta(1,1) = std(deltaA1)/sqrt(size(deltaA1,1));
SEMDelta(1,2) = std(deltaA2)/sqrt(size(deltaA2,1));

[p,h] = ranksum(deltaA1,deltaA2,'alpha',alpha);
end

