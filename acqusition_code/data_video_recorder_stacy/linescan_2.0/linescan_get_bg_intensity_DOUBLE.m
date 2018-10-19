function [meanbgA meanbgB] = linescan_get_bg_intensity_DOUBLE(VID,vidparams)

numframes = vidparams.bgframes;
lines2avg = vidparams.numlines;

uiwait(msgbox('Set TOP','Background'))

triggerconfig(VID, 'Manual');
set(VID,'FramesPerTrigger',Inf)
start(VID);
pause(0.1);
snapshot = peekdata(VID,1); % take lines
linebg = zeros(numframes,size(snapshot,2));
for i=1:numframes
    snapshot = peekdata(VID,1); % take lines
    linebgA(i,:) = mean(snapshot(1:lines2avg,:)); % average over lines
end
stop(VID)
meanbgA = mean(linebgA);

uiwait(msgbox('Set BOTTOM','Background'))

triggerconfig(VID, 'Manual');
set(VID,'FramesPerTrigger',Inf)
start(VID);
pause(0.1);
snapshot = peekdata(VID,1); % take lines
linebg = zeros(numframes,size(snapshot,2));
for i=1:numframes
    snapshot = peekdata(VID,1); % take lines
    linebgB(i,:) = mean(snapshot((end-lines2avg):end,:)); % average over lines
end
stop(VID)
meanbgB = mean(linebgB);