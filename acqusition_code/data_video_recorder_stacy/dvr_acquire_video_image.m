function dvr_acquire_video_image(axeshandle,vid)

% ready camera
set(vid,'FramesPerTrigger',1)
start(vid)
pause(0.25);
d = getdata(vid);
axes(axeshandle);
imagesc(d), colormap(gray)


    