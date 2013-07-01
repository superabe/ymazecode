Event = TS{1,20}.Timestamp;
nrelated = 0;
for n = 1:16
    Timestamp = TS{1,n}.Timestamp;
    [p,h,trend] = EventRelated(Timestamp,Event,[-20,0],4,[-50,50],0.1,0.01 );
    if(h==1)
        nrelated = nrelated + 1;
        str = ['Ele:' num2str(TS{1,n}.Electorde) 'Unit:' num2str(TS{1,n}.Unit) 'trend:' num2str(trend)];
        disp(str);        
    end
    
end
disp(['nrelated = ' num2str(nrelated)])