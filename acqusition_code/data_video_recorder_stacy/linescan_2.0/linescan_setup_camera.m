function VID = linescan_setup_camera();
% set video and triggering parameters

% parameters
% selectable parameters
video_exposure = 0.25;

% VIDEO INPUT
% static parameters
video_adaptor = 'dcam'
video_device_num = 2;
video_format = 'F7_Y8_656x491'

VID = videoinput(video_adaptor,video_device_num,video_format);
set(getselectedsource(VID),'Shutter',50*video_exposure); % set to milliseconds*50 %498
set(getselectedsource(VID),'Gain',255) %28
set(getselectedsource(VID), 'Brightness',800) %717
set(getselectedsource(VID),'NormalizedBytesPerPacket',1023) %1024?
%set(getselectedsource(VID),'NormalizedBytesPerPacket',256)

% trigger to run continuously
triggerconfig(VID, 'Manual');
set(VID,'FramesPerTrigger',Inf)
