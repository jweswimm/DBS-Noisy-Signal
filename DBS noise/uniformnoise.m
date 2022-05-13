function dbs=uniformnoise(f,tmax,dt)
%Creates DBS train of frequency f, of length tmax (msec), 
%with time step dt (msec)

%set timescale
t=0:dt:tmax;

%set amplitude of pulse
amp=300;

%How many "waves" of dbs?
num_pulses=f*(tmax/1000); %msec -> sec
%disp(num_pulses);

%create a pulse vector pulse(t) where each element represents a current at 
%time t, incremented by dt
pink_pulse=zeros(1,size(t,2));
white_pulse=zeros(1,size(t,2));


%We want num_waves many current pulses, so size(t)/num_pulses should give 
%increment of t values that should have pulse
pulse_increment=round(size(t,2)/num_pulses);

%set the current every pulse_increment to amp
% pink_pulse(pulse_increment:pulse_increment:end)=amp;
% white_pulse(pulse_increment:pulse_increment:end)=amp;

PinkNoise=dsp.ColoredNoise(1,size(t,2),1);
WhiteNoise=dsp.ColoredNoise(0,size(t,2),1);
pnoise=PinkNoise();
wnoise=WhiteNoise();

pulsewidth=0.3;
width_counter=0.3/dt; %how many timesteps are required for width of pulse



%every pulse_increment make a pulse with some noise
for i = 1:num_pulses
    for j=0:width_counter %this loop just gives a square wave
        pink_pulse(pulse_increment*i+j)=amp;
        white_pulse(pulse_increment*i+j)=amp+10;
    end
end

for i=1:size(t,2)
    pink_pulse(i)=pink_pulse(i)+10*pnoise(i);
    white_pulse(i)=white_pulse(i)+10*wnoise(i);
end


%set output dbs to pulse
%plot(t,dbs);
pink_pulse=pink_pulse(1:size(t,2)); %resize pulse to get rid of extra values
white_pulse=white_pulse(1:size(t,2)); %resize pulse to get rid of extra values

dbs=pink_pulse;



% subplot(1,2,1);
% plot(t,dbs);
% title('Pink')
% 
% subplot(1,2,2);
% plot(t,white_pulse);
% title('White')

 plot(dbs);


%Original create dbs
% t=0:dt:tmax; ID=zeros(1,length(t));
% iD=300;
% pulse=iD*ones(1,0.3/dt);
% 
% i=1;
% while i<length(t)
%     dbs(i:i+0.3/dt-1)=pulse;
%     instfreq=f;
%     isi=1000/instfreq;
%     i=i+round(isi*1/dt);
% end