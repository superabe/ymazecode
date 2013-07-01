for i = 1:28;
pretest{1,i}.Timestamp=preandtest{1,i}.Timestamp(1,preandtest{1,i}.Timestamp<3500);
pretest{1,i}.Electrode=preandtest{1,i}.Electrode;
pretest{1,i}.Unit=preandtest{1,i}.Unit;

test{1,i}.Timestamp=preandtest{1,i}.Timestamp(1,preandtest{1,i}.Timestamp>4500);
test{1,i}.Electrode=preandtest{1,i}.Electrode;
test{1,i}.Unit=preandtest{1,i}.Unit;

end

TSNo5{1}=pretest;
TSNo5{2}=test;
TSNo5{3}=posttest;



EventWin = [-10,0];
Bin = 0.1;

for nfile = 1:3
    Event = TSNo5{nfile}{1,end}.Timestamp;
    nrelated = 0;
    for n = 1:size(TSNo5{nfile},2)
        if ~(TSNo5{nfile}{1,n}.Unit == 0 || TSNo5{nfile}{1,n}.Unit==255)
            Timestamp = TSNo5{nfile}{1,n}.Timestamp;
            [p,h,trend] = EventRelated(Timestamp,Event,EventWin,1,[-200,200],Bin,0.001 );
            
                EventSpikeRaster = SpikeRaster(Timestamp,Event,EventWin,Bin);
                EevrFR = evrFR(EventSpikeRaster,Bin);
                if (h == 1) 
                    nrelated = nrelated + 1; 
                end
                str = [' Ele:' num2str(TSNo5{nfile}{1,n}.Electrode) ' Unit:' num2str(TSNo5{nfile}{1,n}.Unit), ' h:' num2str(h) ' evrFR:' num2str(EevrFR)];
                disp(str);        
            
        end
        
    end
    disp(['nrelated = ' num2str(nrelated)])

end