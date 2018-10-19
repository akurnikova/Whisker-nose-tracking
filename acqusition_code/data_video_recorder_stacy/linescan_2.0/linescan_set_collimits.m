function [collimits] = linescan_set_collimits(vid)

% show a snapshot
start(vid)
pause(0.25);
d = peekdata(vid,1);
stop(vid)
imagesc(d), colormap(gray),figure(gcf),title('Set limits')
    
% set left and right points
disp('set left limit');
hl = impoint(gca,[]);
api = iptgetapi(hl);
leftpoint = api.getPosition();
disp('set right limit');
hr = impoint(gca,[]);
api = iptgetapi(hr);
rightpoint = api.getPosition();

collimits = [ceil(leftpoint(1)) floor(rightpoint(1))];
    