function ims = dvr_record_video_only(T,video_device_num,video_adaptor,video_format,numloops); 
%  synchronize air puffing, video,  and recording physiological data
% inputs: channels - 0 indexed vector of channels to record
%           Fs - sampling frequency for recording channels (in Hertz)
%           T - time to collect data (in seconds)
% outputs: data - n x channels matrix of collected data
%           n = Fs*T (total number of samples)
%           channels = number of channels to record from

% Jeff Moore - 8/12/08
% modified - video only 4/21/09,

% record arbitrary number of simultaneous analog inputs

%% Fixed Parameters - behavior room computer
%analog_device_num = 'Dev1'; %NI PCI-6024e card
%video_device_num = 1;
%video_adaptor = 'dcam';
%video_format = 'F7_Y8_656x491';

%% Experiment parameters

dur = T*1000; % duration, in milliseconds
video_exposure = .1; % ms

%% Video Setup

VID = videoinput(video_adaptor,video_exposure,video_format);
set(getselectedsource(VID),'Shutter',50*video_exposure); % set to milliseconds*50
set(getselectedsource(VID),'Gain',255)
set(getselectedsource(VID), 'Brightness',800)
set(getselectedsource(VID),'NormalizedBytesPerPacket',1024)
% set ROI to everything
set(VID,'ROIPosition', [ 0 0 get(VID,'VideoResolution') ] );
fps = dvr_get_framerate(VID);

%% start experiment
dvr_acquire_video_only(VID,dur,numloops);

%% cleanup
delete(VID); clear VID;





