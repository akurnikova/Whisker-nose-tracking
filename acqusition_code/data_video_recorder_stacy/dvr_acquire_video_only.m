function dvr_acquire_video_only(vid,dur,numloops)

% ready camera
[fps,flag] = dvr_get_framerate( vid );
numframes = round(dur*fps/1000);
set(vid,'FramesPerTrigger', numframes);
set(vid,'TriggerFrameDelay',0);
    
for iloop = 1:numloops
    % acquire data
    start(vid)
    wait(vid)    
    % get data
    [ims]  = getdata(vid);
    vims = single(squeeze(ims));
    % process data
    sum(sum(var(vims,0,3)))
end


    