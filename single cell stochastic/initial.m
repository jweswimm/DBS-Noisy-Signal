clear all
close all

%% Set initial conditions

%time variables
tmax=1000; %maximum time (ms)
dt=0.01; %timestep (ms)
t=0:dt:tmax;
n=1; %number of neurons in each nucleus (TH, STN, GPe, GPi) %was 10, jww 

%initial membrane voltages for all cells
v1=0;%-62+randn(n,1)*5;
v2=-62+randn(n,1)*5;
v3=0;%-62+randn(n,1)*5;
v4=0;%-62+randn(n,1)*5;
r=randn(n,1)*2;

%Sensorimotor cortex input to talamic cells
%[Istim, timespike]=createSMC(tmax,dt,14,0.2); %commented out by JWW

%BGnetwork loads Istim.mat which has all the initial conditions
%save('Istim.mat','Istim','timespike','tmax','dt','v1','v2','v3','v4','r','n');


%% Running BGnetwork.m
%For 1000msec with 10 neurons in each nucleus, each condition will take
%roughly 60sec to run.
% 
% h=BGnetworkWhile(0,0,0); %healthy
% pd =BGnetworkWhile(1,0,0); %PD
% dbs=BGnetworkWhile(1,1,130); %PD with DBS

% 
%h=BGnetworkWhile(0,0,0); %healthy
%pd = BGnetworkWhile(1,0,0); %PD
%dbs=Copy_of_BGnetworkWhile(1,1,130); %PD with DBS
%h1 = BGnetwork(0,0,0);

%%

h = Copy_of_BGnetworkWhile(0,0,0);

