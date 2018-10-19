function AO = linescan_setup_ao();
% setup analog output for linescan run
AO = analogoutput('nidaq','Dev1');
ch = addchannel(AO,[0 1]);