function [tdata,data,fps,numframesrequested,tvid,viddelay] = dvr_acquire_all_log(ai,vid,dur,fps)

% ready camera
% check frame rate
[maxfps,flag] = dvr_get_framerate( vid );
if fps>maxfps
    warning('desired frame rate exceeds maximum; acquiring at maximum rate');
    fps = maxfps;
end
fps

numframesrequested = round(dur*fps/1000)
set(vid,'FramesPerTrigger', numframesrequested);
set(vid,'TriggerFrameDelay',0);
% read ai
set(ai,'SamplesPerTrigger', round(get(ai,'SampleRate')*(dur+3500)/1000));
    
% acquire data
start(ai)
disp('start acquiring analog');
start(vid)

pause(1+(dur/1000));
wait(ai,1+(dur/1000));

[data,tdata] = getdata(ai);
% get data
if isequal(vid.LoggingMode,'disk&memory');
    [frames,tvid] = getdata(vid);
    clear frames;
else
    tvid = NaN;
end
viddelay = vid.InitialTriggerTime - ai.InitialTriggerTime;




    