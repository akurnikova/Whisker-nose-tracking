function dvr_focus_camera(axeshandle,video_device_num,video_adaptor,video_format); 
% runs and displays camera images continuously for focusing
global STOP;
% %% Experiment parameters
% %video_exposure = 0.25; % ms
% %video_exposure = 2;
video_exposure = 0.25; %

%% Video Setup

VID = videoinput(video_adaptor,video_device_num,video_format);
set(getselectedsource(VID),'Shutter',50*video_exposure); % set to milliseconds*50
set(getselectedsource(VID),'Gain',255)
set(getselectedsource(VID), 'Brightness',800)
set(getselectedsource(VID),'NormalizedBytesPerPacket',1023)
fps = dvr_get_framerate(VID);

triggerconfig(VID, 'Manual');
set(VID,'FramesPerTrigger',Inf)
% %% take picture
% dvr_acquire_video_image(axeshandle,VID);
axes(axeshandle);
%set(VID,'FramesPerTrigger',1)
start(VID)
pause(0.1);

while 1
    if STOP;break;end
    snapshot = peekdata(VID,1); % take lines
    imagesc(snapshot);colormap(gray);
    drawnow;
end

stop(VID)
STOP=0; % reset STOP


