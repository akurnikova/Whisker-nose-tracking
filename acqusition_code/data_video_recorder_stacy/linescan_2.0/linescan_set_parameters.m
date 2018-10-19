function [vidparams aoparams] = linescan_set_parameters();
% SET PARAMETERS

% VIDEO PARAMETERS
vidparams.threshold = [];
vidparams.width = 655;
vidparams.height = 5;
vidparams.displaynframes = 100;
vidparams.bgframes = 1000;
% ANALOG OUTPUT PARAMETERS
aoparams.aorange = [-5 5];
aoparams.aovals = linspace(aoparams.aorange(1),aoparams.aorange(2),vidparams.width);
aoparams.aoswing = aoparams.aorange(2)-aoparams.aorange(1);
aoparams.aooffset = aoparams.aorange(1);
