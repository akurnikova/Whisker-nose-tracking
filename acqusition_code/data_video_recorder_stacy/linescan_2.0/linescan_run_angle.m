function linescan_run_angle(VID,AO,vidparams,aoparams,meanbg,collimits)

if isempty(vidparams.threshold)
    disp('Must set THRESHOLD before running')
    return;
end

if isempty(meanbg)
    meanbg = 255*ones(1,vidparams.width);
    warning('Background not set - defaulting to WHITE');
end

global STOP;

start(VID);
pause(0.1);
scaledoutput = 10;
evenframe = 0;
framecount = 0;
snapshot = peekdata(VID,1); % take lines
linelimit = 255*ones(size(snapshot)); % set lines to white
xdetect = [];
ydetect = [];
figure(100);xlim([0 vidparams.width]);ylim([0 vidparams.height]); hlineplot = gca; % plot once
plot(hlineplot,xdetect,ydetect,'YDataSource','ydetect','XDataSource','xdetect');xlim([0 vidparams.width]);ylim([0 vidparams.height]);

while 1
    framecount = framecount+1;
    evenframe=evenframe+1;
    evenframe=mod(evenframe,2);
    snapshot = peekdata(VID,1); % take lines
    [slope int xdetect ydetect] = linescan_calculate_angle(snapshot,vidparams.threshold,linelimit,vidparams.height,collimits,meanbg);
    if isempty(slope);
        scaledoutput = 10;
    else
        scaledoutput = atan(slope);
    end
    putsample(AO,[scaledoutput evenframe])
    if mod(framecount,vidparams.displaynframes)==0
        framecount = 0;
        scaledoutput
        refreshdata(hlineplot,'caller');
        drawnow;
        if STOP;break;end
    end
end
stop(VID)
STOP=0; % reset STOP