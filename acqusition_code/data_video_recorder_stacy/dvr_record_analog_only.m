function [data,tdata] = dvr_record_analog_only(outputdir,filename,channels,Fs,T,analog_device_num,range); 
%  synchronize air puffing and recording physiological data
% inputs: channels - 0 indexed vector of channels to record
%           Fs - sampling frequency for recording channels (in Hertz)
%           T - time to collect data (in seconds)
% outputs: data - n x channels matrix of collected data
%           n = Fs*T (total number of samples)
%           channels = number of channels to record from

% Jeff Moore - 1/27/09

% record arbitrary number of simultaneous analog inputs

%% Experiment parameters
dur = T*1000; % duration, in milliseconds

%% Analog Input Setup

AI = analoginput('nidaq',analog_device_num);
for ichan = 1:length(channels)
    addchannel(AI,channels(ichan));
    % set range
    ActualIRange = setverify(AI.Channel(ichan),'InputRange',[-range(ichan) range(ichan)]);
    ActualSRange = setverify(AI.Channel(ichan),'SensorRange',[-range(ichan) range(ichan)]);
    ActualURange = setverify(AI.Channel(ichan),'UnitsRange',[-range(ichan) range(ichan)]);
    allranges = [ActualIRange, ActualSRange, ActualURange];
    if ~(mean(abs(allranges))==range(ichan)) % check if all ranges are set correctly
        error('Range must be set to +/- 10,5,0.5 or 0.05');
    end
    % done setting range
end;
AI.SampleRate = Fs;
%AI.TriggerRepeat = inf;
% set single ended
set(AI,'InputType','SingleEnded');
get(AI);
set(AI);
for chn = 1:length(AI.Channel);
    get(AI.Channel([chn]));
    set(AI.Channel([chn]));
end

%% start experiment

[tdata,data] = dvr_acquire_analog_only(AI,dur);

%% cleanup
delete(AI); clear AI;
% save
curdir = pwd;
cd(outputdir);
save( [filename '.mat'], 'tdata', 'data');
cd(curdir);




