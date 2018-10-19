function [roi d height] = linescan_set_roi_DOUBLE(vid,width)

figure(1)
    % set ROI to everything
    set(vid,'ROIPosition', [ 0 0 get(vid,'VideoResolution') ] );
   
    % show a snapshot
    start(vid)
    pause(0.5);
    d = peekdata(vid,1);
    stop(vid)
    imagesc(d), colormap(gray),figure(gcf),title('Choose a bounding box')
    
    % do the rubberband thing
    disp('Click top line');
    k = waitforbuttonpress;
    initialpointA = get(gca,'CurrentPoint') ;   % button down detected top
    disp('Click bottom line');
    k = waitforbuttonpress;
    initialpointB = get(gca,'CurrentPoint') ; % button down detected bottom
    height = initialpointB(1,2)-initialpointA(1,2);
    initialrect = [1 initialpointA(1,2) width height];
    
    h = imrect(gca,initialrect);
    api = iptgetapi(h);
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


   