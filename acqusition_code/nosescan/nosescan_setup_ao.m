function AO = nosescan_setup_ao();
% setup analog output for linescan run
AO = analogoutput('nidaq','Dev2');
ch = addchannel(AO,[0 1]);