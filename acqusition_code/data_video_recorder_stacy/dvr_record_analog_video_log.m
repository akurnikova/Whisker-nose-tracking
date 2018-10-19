function [roi] = dvr_record_analog_video(outputdir,filename,channels,Fs,T,...
    analog_device_num,video_device_num,video_adaptor,video_format,axeshandle,exposure_channel_index,roi,width,height,range,LogMode); 
%  synchronize air puffing, video,  and recording physiological data
% inputs: channels - 0 indexed vector of channels to record
%           Fs - sampling frequency for recording channels (in Hertz)
%           T - time to collect data (in seconds)
% outputs: data - n x channels matrix of collected data
%           n = Fs*T (total number of samples)
%           channels = number of channels to record from

% Jeff Moore - 8/12/08

% record arbitrary number of simultaneous analog inputs

%% Fixed Parameters - behavior room computer
%analog_device_num = 'Dev1'; %NI PCI-6024e card
%video_device_num = 1;
%video_adaptor = 'dcam';
%video_format = 'F7_Y8_656x491';

%% Experiment parameters
global STOP; 

STOP = 0;

dur = T*1000; % duration, in milliseconds
%video_exposure = .25; % ms, 0.25 ms for large light
%video_exposure = 2;
video_exposure = 0.25; %

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
AI.SampleRate = Fs; % set sample rate

%AI.TriggerRepeat = inf;
% set single ended
set(AI,'InputType','SingleEnded');
get(AI);
set(AI);
for chn = 1:length(AI.Channel);
    get(AI.Channel([chn]));
    set(AI.Channel([chn]));
end

%% Video Setup

VID = videoinput(video_adaptor,video_device_num,video_format);
set(getselectedsource(VID),'Shutter',50*video_exposure); % set to milliseconds*50
set(getselectedsource(VID),'Gain',255)
set(getselectedsource(VID), 'Brightness',800)
set(getselectedsource(VID),'NormalizedBytesPerPacket',1024)
axes(axeshandle);
fullimage = NaN;
if isempty(roi)
    [roi fullimage] = dvr_set_roi_constrect(VID,width,height);
end
set(VID,'ROIPosition', roi);
fps = dvr_get_framerate(VID);
    
% code to log data while acquiring
videofile = [outputdir '\' filename '_video.avi'];
if exist(videofile, 'file') == 2
    disp('FILE NAME CONFLICT -- ADDING TIMESTAMP');
    videofile = [outputdir,'\',filename,datestr(now,'yymmdd-HHMMSS'),'_video.avi'];
end
aviobj = avifile(videofile, 'compression','none','fps',fps);
aviobj.Colormap = gray(256);
VID.LoggingMode = LogMode; %'disk&memory','disk';
VID.DiskLogger = aviobj;
% end code to setup data logging

%% start experiment

[tdata,data,fps,numframesrequested,tvid,viddelay] = dvr_acquire_all_log(AI,VID,dur,fps);
while(~(exist(videofile)==2));end; % wait for file to be created
numframesreturned = VID.DiskLoggerFrameCount;
while(numframesreturned<numframesrequested) % wait for all frames to be returned
    numframesreturned = VID.DiskLoggerFrameCount
    pause(0.5);
end
pause(0.5); % test - pause to make sure no additional frames available
numframesreturned = VID.DiskLoggerFrameCount;
%ims = uint8(ims);

%% cleanup
aviobj = close(VID.DiskLogger);
delete(AI); clear AI;
delete(VID); clear VID;

%% parse output
if isempty(exposure_channel_index)
    error('must have exposure line on');
end
vid_exposures = dvr_square2trig(data(:,exposure_channel_index));
extra_exposures = (length(vid_exposures)-numframesreturned)-2 %should always take 2 more frames before stopped by matlab
    
if numframesrequested ~= numframesreturned %number of frames should always be number of timestamps returned
    warning('frames may be dropped'); 
elseif extra_exposures~=0 % no dropped frames
    warning('frames may be dropped');
else 
    disp('got all frames');
end
numframesrequested
numframesreturned
% save
curdir = pwd;
cd(outputdir);
save( [filename '.mat'], 'tdata','tvid' ,'data','fps','numframesrequested','numframesreturned','extra_exposures','roi','fullimage','viddelay');
clear data tdata
cd(curdir);






