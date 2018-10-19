function roi = get_roi(vid)

    % set ROI to everything
    set(vid,'ROIPosition', [ 0 0 get(vid,'VideoResolution') ] );
   
    % show a snapshot
    set(vid,'FramesPerTrigger',1)
    start(vid)
    pause(0.25);
    d = getdata(vid);
    imagesc(d), colormap(gray),figure(gcf),title('Choose a bounding box')
    
    % do the rubberband thing
    k = waitforbuttonpress;
    point1 = get(gca,'CurrentPoint');    % button down detected
    finalRect = rbbox;                   % return figure units
    point2 = get(gca,'CurrentPoint');    % button up detected
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


   