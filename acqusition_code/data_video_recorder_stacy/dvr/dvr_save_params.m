function dvr_save_params(outputdir,filename,Fs,savecoords,range);

recordtime = datestr(clock);
manipcoords.x = NaN;
manipcoords.y = NaN;
manipcoords.z = NaN;

if savecoords == 1
    [x y z] = sccommand_readvalues();
    manipcoords.x = x;
    manipcoords.y = y;
    manipcoords.z = z;
end

daqrange = [-range range];

curdir = pwd;
cd(outputdir);
save( [filename,'.mat'], 'recordtime', 'Fs', 'manipcoords','daqrange');
cd(curdir);