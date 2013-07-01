
EventWin = [-20,0];
Bin = 0.1;

for nfile = 1:3
    Event = TSNo1{nfile}{1,end}.Timestamp;
    nrelated = 0;
    for n = 1:size(TSNo1{nfile},2)
        if ~(TSNo1{nfile}{1,n}.Unit == 0 || TSNo1{nfile}{1,n}.Unit==255)
            Timestamp = TSNo1{nfile}{1,n}.Timestamp;
            [p,h,trend] = EventRelated(Timestamp,Event,EventWin,4,[-20,-10],Bin,0.001 );
            
                EventSpikeRaster = SpikeRaster(Timestamp,Event,EventWin,Bin);
                EevrFR = evrFR(EventSpikeRaster,Bin);
                WiderSE = SpikeRaster(Timestamp,Event,[-20,0],Bin);
                WinderFR = evrFR(WiderSE,Bin);
                if (h == 1) 
                    nrelated = nrelated + 1; 
                end
                str = [' Ele:' num2str(TSNo1{nfile}{1,n}.Electorde) ' Unit:' num2str(TSNo1{nfile}{1,n}.Unit), ' h:' num2str(h) ' evrEFR:' num2str(EevrFR) ' EvrWinderFR' num2str(WinderFR)];
                disp(str);        
            
        end
        
    end
    disp(['nrelated = ' num2str(nrelated)])

end