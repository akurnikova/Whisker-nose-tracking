function linescan_run(VID,AO,vidparams,aoparams,meanbg,collimits)

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
linelimit = 255*ones(1,size(snapshot,2)); % set lines to white
linelimitplot = linelimit;
figure(100);xlim([-5 10]);ylim([0 256]); hlineplot = gca; % plot once
plot(hlineplot,aoparams.aovals,linelimitplot,'YDataSource','linelimitplot');xlim([-5 10]);ylim([0 256]);

while 1
    framecount = framecount+1;
    evenframe=evenframe+1;
    evenframe=mod(evenframe,2);
    snapshot = peekdata(VID,1); % take lines
    lineval = mean(snapshot); % average over lines
    line_nobg = 255+lineval-meanbg;
    linelimit(collimits(1):collimits(2)) = line_nobg(collimits(1):collimits(2));
    detect = mean(find(linelimit<vidparams.threshold));
    if isnan(detect);
        scaledoutput = 10;
    else
        scaledoutput = (detect/vidparams.width)*aoparams.aoswing+aoparams.aooffset;
    end
    putsample(AO,[scaledoutput evenframe])
    if mod(framecount,vidparams.displaynframes)==0
        framecount = 0;
        linelimitplot = linelimit;
        if isnan(detect);linelimitplot(vidparams.width)=0;else;linelimitplot(ceil(detect))=0;end
        refreshdata(hlineplot,'caller');
        drawnow;
        if STOP;break;end
    end
end
stop(VID)
STOP=0; % reset STOP