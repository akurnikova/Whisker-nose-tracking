function linescan_run_2pts(VID,AO,vidparams,aoparams,meanbg,collimits)

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
linelimit1 = 255*ones(1,size(snapshot,2)); % set lines to white
linelimit2 = 255*ones(1,size(snapshot,2));
linelimitplot1 = linelimit1;
linelimitplot2 = linelimit2;
figure(100);xlim([-5 10]);ylim([0 256]); hlineplot = gca; % plot once
plot(hlineplot,aoparams.aovals,linelimitplot1,'b');xlim([-5 10]);ylim([0 256]);hold on;
plot(hlineplot,aoparams.aovals,linelimitplot2,'r');

while 1
    framecount = framecount+1;
    evenframe=evenframe+1;
    evenframe=mod(evenframe,2);
    snapshot = peekdata(VID,1); % take lines
    lineval1 = mean(snapshot([1:5],:)); % average over lines
    lineval2 = mean(snapshot([26:30],:));
    line_nobg1 = 255+lineval1-meanbg;
    line_nobg2 = 255+lineval2-meanbg;
    linelimit1(collimits(1):collimits(2)) = line_nobg1(collimits(1):collimits(2));
    linelimit2(collimits(1):collimits(2)) = line_nobg2(collimits(1):collimits(2));
    detect1 = mean(find(linelimit1<vidparams.threshold));
    detect2 = mean(find(linelimit2<vidparams.threshold));
    if isnan(detect1) | isnan(detect2);
        scaledoutput1 = 10;
        scaledoutput2 = 10;
    else
        scaledoutput1 = (detect1/vidparams.width)*aoparams.aoswing+aoparams.aooffset;
        scaledoutput2 = (detect2/vidparams.width)*aoparams.aoswing+aoparams.aooffset;
    end
    putsample(AO,[scaledoutput1 scaledoutput2+0.1*evenframe])
    if mod(framecount,vidparams.displaynframes)==0
        framecount = 0;
        if ishandle(hlineplot)
            linelimitplot1 = linelimit1;
            linelimitplot2 = linelimit2;
            if isnan(detect1);linelimitplot1(vidparams.width)=0;else;linelimitplot1(ceil(detect1))=0;end
            if isnan(detect2);linelimitplot2(vidparams.width)=0;else;linelimitplot2(ceil(detect2))=0;end
            cla(hlineplot);
            plot(hlineplot,aoparams.aovals,linelimitplot1,'b');xlim([-5 10]);ylim([0 256]);hold on;
            plot(hlineplot,aoparams.aovals,linelimitplot2,'r');
        end
        drawnow;
        if STOP;break;end
    end
end
stop(VID)
STOP=0; % reset STOP