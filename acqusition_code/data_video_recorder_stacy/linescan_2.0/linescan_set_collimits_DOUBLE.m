function [collimitsA, collimitsB] = linescan_set_collimits_DOUBLE(vid)

% show a snapshot
start(vid)
pause(0.25);
d = peekdata(vid,1);
stop(vid)
imagesc(d), colormap(gray),figure(gcf),title('Set TOP limits')
    
% set left and right points
disp('set left limit');
hl = impoint(gca,[]);
api = iptgetapi(hl);
leftpoint = api.getPosition();
disp('set right limit');
hr = impoint(gca,[]);
api = iptgetapi(hr);
rightpoint = api.getPosition();

collimitsA = [ceil(leftpoint(1)) floor(rightpoint(1))];


% show a snapshot
start(vid)
pause(0.25);
d = peekdata(vid,1);
stop(vid)
imagesc(d), colormap(gray),figure(gcf),title('Set BOTTOM limits')
    
% set left and right points
disp('set left limit');
hl = impoint(gca,[]);
api = iptgetapi(hl);
leftpoint = api.getPosition();
disp('set right limit');
hr = impoint(gca,[]);
api = iptgetapi(hr);
rightpoint = api.getPosition();

collimitsB = [ceil(leftpoint(1)) floor(rightpoint(1))];

close gcf