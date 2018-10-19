function linescan_run_DOUBLE_STACY(VID,AO,vidparams,aoparams,meanbgA,meanbgB,collimits)

lines2avg = vidparams.numlines;

if isempty(vidparams.threshold)
    disp('Must set THRESHOLD before running')
    return;
end

if isempty(meanbgA)
    meanbgA = 255*ones(1,vidparams.width);
    meanbgB = 255*ones(1,vidparams.width);
    warning('Background not set - defaulting to WHITE');
end

global STOP;

start(VID);
pause(0.5);

evenframe = 0;
framecount = 0;
snapshot = peekdata(VID,1); % take lines
linelimitA = 255*ones(1,size(snapshot,2)); % set lines to white
linelimitB = 255*ones(1,size(snapshot,2)); % set lines to white
linelimitplotA = linelimitA;
linelimitplotB = linelimitB;
figure(99);xlim([-5 10]);ylim([0 256]); hlineplotA = gca; % plot once
plot(hlineplotA,aoparams.aovals,linelimitplotA,'YDataSource','linelimitplotA');xlim([-5 10]);ylim([0 256]);
figure(100);xlim([-5 10]);ylim([0 256]); hlineplotB = gca; % plot once
plot(hlineplotB,aoparams.aovals,linelimitplotB,'YDataSource','linelimitplotB');xlim([-5 10]);ylim([0 256]);

pause(0.5);

while 1
    tic
    framecount = framecount+1;
    evenframe=evenframe+1;
    evenframe=mod(evenframe,2);
    

    snapshot = peekdata(VID,1); % take lines
    
    
    linevalA = mean(snapshot(1,:,:)); % average over lines, top
    linevalB = mean(snapshot(end-lines2avg:end,:)); % average over lines, top
    
    line_nobgA = 255+linevalA-meanbgA;
    line_nobgB = 255+linevalB-meanbgB;
    
    linelimitA(collimits(1):collimits(2)) = line_nobgA(collimits(1):collimits(2));
    linelimitB(collimits(1):collimits(2)) = line_nobgB(collimits(1):collimits(2));
    
    detectA = mean(find(linelimitA<vidparams.threshold));
    detectB = mean(find(linelimitB<vidparams.threshold));
    
    if isnan(detectA);
        scaledoutputA = 10;
    else
        scaledoutputA = (detectA/vidparams.width)*aoparams.aoswing+aoparams.aooffset;
    end
    if isnan(detectB);
        scaledoutputB = 10;
    else
        scaledoutputB = (detectB/vidparams.width)*aoparams.aoswing+aoparams.aooffset;
    end
    putsample(AO,[scaledoutputA scaledoutputB])

    
    if mod(framecount,vidparams.displaynframes)==0
        framecount = 0;
        linelimitplotA = linelimitA;
        linelimitplotB = linelimitB;
        if isnan(detectA);linelimitplotA(vidparams.width)=0;else;linelimitplotA(ceil(detectA))=0;end
        if isnan(detectB);linelimitplotB(vidparams.width)=0;else;linelimitplotB(ceil(detectB))=0;end
        refreshdata(hlineplotA,'caller');
        refreshdata(hlineplotB,'caller');
        drawnow;
        if STOP;break;end
    end
    toc
end
stop(VID)
STOP=0; % reset STOP