function nosescan_run(VID,AO,vidparams,aoparams,collimits)

global STOP;

try
    
start(VID);
pause(0.5);


framecount = 0;

snapshot = peekdata(VID,1); % take lines
thresh_M =  0.9*max(max(snapshot));
[XM,YM] = find(snapshot>thresh_M);
detectX = median(XM);
detectY = median(YM);
    
figure(100); hold on; checktrackplot = gca;
imagesc(uint8(snapshot),'Parent',checktrackplot); axis equal
colormap(bone);
plot(checktrackplot,detectY,detectX,'b*','XDataSource','detectY','YDataSource','detectX')
axis([0 800 0 800]);
%% nose stuff
%mask_MIR = (pixgrid.*BWroi.BWroi_MIR);
% pause(0.5);

while 1

    framecount = framecount+1;    
    snapshot = peekdata(VID,1); % take lines
        
    thresh_M =  0.9*max(max(snapshot));
    [XM,YM] = find(snapshot>thresh_M);
    
    detectX = median(XM);
    detectY = median(YM);
    
    if isnan(detectX);
        scaledoutputX = 10;
    else
        scaledoutputX = (detectX/vidparams.width)*aoparams.aoswing+aoparams.aooffset;
    end
    if isnan(detectY);
        scaledoutputY = 10;
    else
        scaledoutputY = (detectY/vidparams.width)*aoparams.aoswing+aoparams.aooffset;
    end
    putsample(AO,[scaledoutputX scaledoutputY])

    if mod(framecount,vidparams.displaynframes)==0
        framecount = 0;
       % dispimage = snapshot;
        

        refreshdata(checktrackplot,'caller');
        drawnow;
        if STOP;break;end
    end
    
end
stop(VID)
STOP=0; % reset STOP

catch
    stop(VID)
    STOP=0; % reset STOP
end