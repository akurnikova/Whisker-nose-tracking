function [fps,flag] = dvr_get_framerate( vid )

roi = get(vid,'ROIPosition');
width = roi(3);
height = roi(4);
exposure_time = get(getselectedsource(vid),'Shutter') * 20; % in microseconds

formula1 = (10^6) / ((height+3)*15.28);
formula3 = (10^6) / (exposure_time + 28);
fps = min( formula1, formula3 );

flag = 1;
