Win = [-3,3];
subplot(3,1,1);
plotRaster(Timestamp,Event,Win);
subplot(3,1,2);
plotHistogram( Timestamp,Event,Win,0.2,[],'r');

SpikeRaster = getSpikeRaster(Timestamp,Event,Win,0.1);
[ Mean,SEM ] = MeannSEM(SpikeRaster,4);
Mean = Mean./0.1;
subplot(3,1,3);
plot([-2.9:0.1:3],Mean);