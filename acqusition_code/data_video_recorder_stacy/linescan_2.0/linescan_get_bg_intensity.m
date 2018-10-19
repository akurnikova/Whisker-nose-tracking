function meanbg = linescan_get_bg_intensity(VID,vidparams);

numframes = vidparams.bgframes;

triggerconfig(VID, 'Manual');
set(VID,'FramesPerTrigger',Inf)
start(VID);
pause(0.1);
snapshot = peekdata(VID,1); % take lines
linebg = zeros(numframes,size(snapshot,2));
for i=1:numframes
    snapshot = peekdata(VID,1); % take lines
    linebg(i,:) = mean(snapshot); % average over lines
end
stop(VID)
meanbg = mean(linebg);
