function trigsamps = dvr_square2trig(signal)

% convert to binary
high = max(signal)/2;
binarysignal = (signal>high)*1.0;
dsignal = binarysignal(2:end)-binarysignal(1:end-1);
%dpuffs = [0;dpuffs];
trigsamps = find(dsignal>0.5);
