function [tdata,data] = dvr_acquire_all(ai,dur)

% read ai
set(ai,'SamplesPerTrigger', round(get(ai,'SampleRate')*(dur+3500)/1000));
    
% acquire data
start(ai)
wait(ai,4+(dur/1000))
    
% get data
[data,tdata] = getdata(ai);

    