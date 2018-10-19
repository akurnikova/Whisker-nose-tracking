function [roi] = dvr_record_analog_video_cont(outputdir,filename,channels,Fs,T,...
    analog_device_num,video_device_num,video_adaptor,video_format,axeshandle,exposure_channel_index,roi,width,height,range,LogMode, trialdelay); 
%  synchronize AIr puffing, video,  and recording physiological data
% inputs: channels - 0 indexed vector of channels to record
%           Fs - sampling frequency for recording channels (in Hertz)
%           T - time to collect data (in seconds)
% outputs: data - n x channels matrix of collected data
%           n = Fs*T (total number of samples)
%           channels = number of channels to record from

% Jeff Moore - 8/12/08
% Stacy Kurnikova - 4/21/14
global STOP; 

STOP = 0;

dur = T*1000; % duration, in milliseconds
video_exposure = 0.25; %

%% Analog Input Setup
% % 
% % AI = analoginput('nidaq',analog_device_num);
% % for ichan = 1:length(channels)
% %     addchannel(AI,channels(ichan));
% %     % set range
% %     ActualIRange = setverify(AI.Channel(ichan),'InputRange',[-range(ichan) range(ichan)]);
% %     ActualSRange = setverify(AI.Channel(ichan),'SensorRange',[-range(ichan) range(ichan)]);
% %     ActualURange = setverify(AI.Channel(ichan),'UnitsRange',[-range(ichan) range(ichan)]);
% %     allranges = [ActualIRange, ActualSRange, ActualURange];
% %     if ~(mean(abs(allranges))==range(ichan)) % check if all ranges are set correctly
% %         error('Range must be set to +/- 10,5,0.5 or 0.05');
% %     end
% %     % done setting range
% % end;
% % AI.SampleRate = Fs; % set sample rate

%AI.TriggerRepeat = inf;
% set single ended
%set(AI,'InputType','SingleEnded');
%get(AI);
%set(AI);
% for chn = 1:length(AI.Channel);
%     get(AI.Channel([chn]));
%     set(AI.Channel([chn]));
% end

%% Video Setup

VID = videoinput('dcam',1,'F7_Y8_656x491');
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

VID.LoggingMode = LogMode; %'disk&memory','disk';
    

%% start experiment

[maxfps,flag] = dvr_get_framerate( VID );
if fps>maxfps
    warning('desired frame rate exceeds maximum; acquiring at maximum rate');
    fps = maxfps;
end

numframesrequested = round(dur*fps/1000)
set(VID,'FramesPerTrigger', numframesrequested);
set(VID,'TriggerFrameDelay',0);
% read AI
set(AI,'SamplesPerTrigger', round(get(AI,'SampleRate')*(dur+3500)/1000));
    

while 1
    disp('REC')
    % code to log data while acquiring
    videofile = ['TEST',datestr(now,'yymmdd-HHMMSS'),'_video.avi'];
    aviobj = avifile(videofile, 'compression','none','fps',fps);
    aviobj.Colormap = gray(256);
    VID.DiskLogger = aviobj;

    start(VID)

    [frames,tvid] = getdata(VID);
    
    while(numframesreturned<numframesrequested) % wAIt for all frames to be returned
        numframesreturned = VID.DiskLoggerFrameCount;
        pause(0.5);
    end

    %% cleanup
    aviobj = close(VID.DiskLogger);
    stop(VID);
    
    disp('pausing')
end




