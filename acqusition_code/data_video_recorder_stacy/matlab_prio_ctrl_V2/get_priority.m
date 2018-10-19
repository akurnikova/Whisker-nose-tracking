% GET_PRIORITY Gets the current process priority class and thread priority
%
%    [priority_class thread_priority] = GET_PRIORITY() outputs the 
%    priority class and thread priority according to the tables below.
%
%    Process Priority Classes:
% 
%    Constant Name                 Hex WinValue      Return Value
%    IDLE_PRIORITY_CLASS           0x00000040             1
%    BELOW_NORMAL_PRIORITY_CLASS   0x00004000             2
%    NORMAL_PRIORITY_CLASS         0x00000020             3
%    ABOVE_NORMAL_PRIORITY_CLASS   0x00008000             4
%    HIGH_PRIORITY_CLASS           0x00000080             5
%    REALTIME_PRIORITY_CLASS       0x00000100             6
% 
%    Thread Priotity:
%
%    Constant Name                  WinValue         Return Value
%    THREAD_PRIORITY_IDLE             -15                 1
%    THREAD_PRIORITY_LOWEST            -2                 2
%    THREAD_PRIORITY_BELOW_NORMAL      -1                 3
%    THREAD_PRIORITY_NORMAL             0                 4
%    THREAD_PRIORITY_ABOVE_NORMAL       1                 5
%    THREAD_PRIORITY_HIGHEST            2                 6
%    THREAD_PRIORITY_TIME_CRITICAL     15                 7
%
% By Roger Aarenstrup, 2006
%
% For comments or suggestions, please use: 
% roger.aarenstrup@mathworks.com
function [priority_class, thread_priority] = get_priority()

[pri_class pri_thread] = get_prio;

switch pri_class
    case 32768 % 0x00008000 ABOVE_NORMAL_PRIORITY_CLASS
        priority_class = 4; 
    case 16384 % 0x00004000 BELOW_NORMAL_PRIORITY_CLASS
        priority_class = 2;
    case 128   % 0x00000080 HIGH_PRIORITY_CLASS
        priority_class = 5;
    case 64    % 0x00000040 IDLE_PRIORITY_CLASS
        priority_class = 1;
    case 32    % 0x00000020 NORMAL_PRIORITY_CLASS
        priority_class = 3;
    case 256   % 0x00000100 REALTIME_PRIORITY_CLASS
        priority_class = 6;
    otherwise
       error('Error reading process priority class.');
end
   
switch pri_thread
    case -15 % THREAD_PRIORITY_IDLE 
        thread_priority = 1;
    case -2  % THREAD_PRIORITY_LOWEST
        thread_priority = 2;
    case -1  % THREAD_PRIORITY_BELOW_NORMAL
        thread_priority = 3;
    case 0   % THREAD_PRIORITY_NORMAL
        thread_priority = 4;
    case 1   % THREAD_PRIORITY_ABOVE_NORMAL
        thread_priority = 5;
    case 2   % THREAD_PRIORITY_HIGHEST
        thread_priority = 6;
    case 15  % THREAD_PRIORITY_TIME_CRITICAL
        thread_priority = 7;
    otherwise
        error('Error reading Thread priority.');
end
