function [vidparams aoparams] = nosescan_set_parameters(width,height)
% SET PARAMETERS

% VIDEO PARAMETERS
vidparams.threshold = [];
vidparams.width = width;
vidparams.height = height;

vidparams.displaynframes = 100;
vidparams.bgframes = 100;

% ANALOG OUTPUT PARAMETERS
aoparams.aorange = [-5 5];
aoparams.aovals = linspace(aoparams.aorange(1),aoparams.aorange(2),vidparams.width);
aoparams.aoswing = aoparams.aorange(2)-aoparams.aorange(1);
aoparams.aooffset = aoparams.aorange(1);