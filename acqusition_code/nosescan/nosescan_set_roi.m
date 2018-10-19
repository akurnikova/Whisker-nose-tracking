function [roi d] = nosescan_set_roi(vid,width,height)


    % set ROI to everything
    set(vid,'ROIPosition', [ 0 0 get(vid,'VideoResolution') ] );
   
    % show a snapshot
    set(vid,'FramesPerTrigger',1)
    start(vid)
    pause(0.25);
    d = peekdata(vid,1);
    stop(vid)
    
    figure(1);
    imagesc(d), colormap(gray),figure(gcf),title('Choose a bounding box')
    
    % do the rubberband thing
    k = waitforbuttonpress;
    initialpoint = get(gca,'CurrentPoint') ;   % button down detected
    initialrect = [(initialpoint(1,1)-round(width/2)) (initialpoint(1,2)-round(height/2)) width height];
    
    h = imrect(gca,initialrect);
    api = iptgetapi(h);
    k = waitforbuttonpress; % move box
    disp('click again to finalize location')
    k = waitforbuttonpress; % click again to begin recording
    finalrect = api.getPosition();
    
    point1(1,1) = finalrect(1); point1(1,2) = finalrect(2);
    point2(1,1) = finalrect(1)+width; point2(1,2) = finalrect(2)+height;
    
    point1 = point1(1,1:2);              % extract x and y
    point2 = point2(1,1:2);
    p1 = min(point1,point2);             % calculate locations
    offset = abs(point1-point2);         % and dimensions
    x = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
    y = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
    hold on
    axis manual
    plot(x,y,'r','linewidth',5)          % draw box around selected region
    hold off
    
    %save ROI
    roi = [p1(1) p1(2) offset(1) offset(2)]
