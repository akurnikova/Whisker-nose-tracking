% set priority to realtime to maximize speed
%set_priority(-1, 6, 6)

%% CONFIGURE SYSTEM

% setup camera and ao - do at startup
[vidparams aoparams] = linescan_set_parameters();
VID = linescan_setup_camera();
AO = linescan_setup_ao();
% focus camera - do from gui
linescan_focus_camera(VID);
% select roi - do from gui
[roi fullimage] = linescan_set_roi(VID,vidparams.width,vidparams.height);
set(VID,'ROIPosition', roi);
% get background illumination - do from gui
meanbg = linescan_get_bg_intensity(VID,vidparams);
% select illumination limits
[collimits] = linescan_set_collimits(VID);
% save static variables - do from gui
starttime = clock;
fps = dvr_get_framerate(VID);
saved_variables = {'fullimage';'roi';'starttime';'collimits';'meanbg';'fps';'vidparams';'aoparams'};
uisave(saved_variables,'linescan_preview_variables_run.mat');


%% RUN - do from gui
[dt looptime] = linescan_run_preview(VID,AO,vidparams,aoparams,meanbg,collimits);

delete(VID)
delete(AO)
clear VID AO

