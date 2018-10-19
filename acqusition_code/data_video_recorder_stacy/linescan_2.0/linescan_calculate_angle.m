function [slope int xdetect ydetect] = linescan_calculate_angle(data,threshold,linelimit,numlines,collimits,meanbg)
% calculate angle through detected pixels

% calculate angle
line_nobg = 255+double(data)-repmat(meanbg,numlines,1);
linelimit(:,collimits(1):collimits(2)) = line_nobg(:,collimits(1):collimits(2));
for iline=1:numlines
    detect = mean(find(linelimit(iline,:)<threshold));
    if ~isnan(detect)
        y(iline) = detect;
        x(iline) = iline;
    else
        y(iline) = NaN;
        x(iline) = NaN;
    end
end
ydetect = y(find(~isnan(y)))';
xdetect = x(find(~isnan(x)))';
if length(xdetect>1)
    X = [ones(size(xdetect)) xdetect];
    a = X\ydetect;
    int = a(1);
    slope = a(2);
else
    slope = [];
    int = [];
end
    