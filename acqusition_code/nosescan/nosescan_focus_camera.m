function linescan_focus_camera(VID,vidparams);
% runs and displays camera images continuously for focusing
global STOP;

figure(1);
% set roi to everything
set(VID,'ROIPosition', [ 0 0 get(VID,'VideoResolution') ] );
%take picture
start(VID)
pause(.1)
while 1
    if STOP;break;end
    snapshot = peekdata(VID,1); % take lines
    imagesc(snapshot);colormap(gray);
    drawnow;
end
stop(VID)
delete(gca);

STOP=0; % reset STOP




