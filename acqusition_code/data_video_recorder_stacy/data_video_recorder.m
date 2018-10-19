function varargout = data_video_recorder(varargin)
set_priority(-1, 6, 7)
global STOP; STOP = 0;
% DATA_RECORDER M-file for data_video_recorder.fig
%      data_video_recorder, by itself, creates a new data_video_recorder or raises the existing
%      singleton*.
%
%      H = data_video_recorder returns the handle to a new data_video_recorder or the handle to
%      the existing singleton*.
%
%      data_video_recorder('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in data_video_recorder.M with the given input arguments.
%
%      data_video_recorder('Property','Value',...) creates a new data_video_recorder or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before data_video_recorder_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to data_video_recorder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help data_video_recorder

% Last Modified by GUIDE v2.5 17-Dec-2014 15:10:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @data_video_recorder_OpeningFcn, ...
                   'gui_OutputFcn',  @data_video_recorder_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before data_video_recorder is made visible.
function data_video_recorder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to data_video_recorder (see VARARGIN)

% Choose default command line output for data_video_recorder
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes data_video_recorder wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Outputs from this function are returned to the command line.
function varargout = data_video_recorder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%% ---------------- SET UP FILES PANEL ----------------------------------%
% output directory
function edit1_Callback(hObject, eventdata, handles)
if isfield(handles,'outputdir')
    set(hObject,'String',handles.outputdir);
else
    set(hObject,'String','F:\stacy');
end

function edit1_CreateFcn(hObject, eventdata, handles)
set(hObject,'String','G:\SK66');
handles.outputdir = get(hObject,'String');
guidata(hObject,handles);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% filename
function edit2_Callback(hObject, eventdata, handles)
handles.filename = get(hObject,'String');
guidata(hObject,handles);
function edit2_CreateFcn(hObject, eventdata, handles)
handles.filename = get(hObject,'String');
guidata(hObject,handles);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% browse output directory
function pushbutton1_Callback(hObject, eventdata, handles)
handles.outputdir = uigetdir;
guidata(hObject,handles);
edit1_Callback(handles.edit1, eventdata, handles)

% number of trials to record
function number_trials_Callback(hObject, eventdata, handles)
handles.numtrials = str2num(get(hObject,'String'));
guidata(hObject,handles);
function number_trials_CreateFcn(hObject, eventdata, handles)
handles.numtrials = str2num(get(hObject,'String'));
guidata(hObject,handles);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function delay_trials_Callback(hObject, eventdata, handles)
handles.trialdelay = str2num(get(hObject,'String'));
guidata(hObject,handles);

function delay_trials_CreateFcn(hObject, eventdata, handles)
handles.trialdelay = str2num(get(hObject,'String'));
guidata(hObject,handles);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% ----------------------------SELECT CHANNELS------------------------------%

function radiobutton1_Callback(hObject, eventdata, handles)
handles.ch(1) = get(hObject,'Value');
guidata(hObject,handles);

function radiobutton2_Callback(hObject, eventdata, handles)
handles.ch(2) = get(hObject,'Value');
guidata(hObject,handles);


function radiobutton3_Callback(hObject, eventdata, handles)
handles.ch(3) = get(hObject,'Value');
guidata(hObject,handles);


function radiobutton4_Callback(hObject, eventdata, handles)
handles.ch(4) = get(hObject,'Value');
guidata(hObject,handles);

function radiobutton5_Callback(hObject, eventdata, handles)
handles.ch(5) = get(hObject,'Value');
guidata(hObject,handles);

function radiobutton6_Callback(hObject, eventdata, handles)
handles.ch(6) = get(hObject,'Value');
guidata(hObject,handles);


function radiobutton7_Callback(hObject, eventdata, handles)
handles.ch(7) = get(hObject,'Value');
guidata(hObject,handles);

function radiobutton8_Callback(hObject, eventdata, handles)
handles.ch(8) = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
handles.ch(1) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function radiobutton2_CreateFcn(hObject, eventdata, handles)
ch = handles.ch;
handles.ch(2) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function radiobutton3_CreateFcn(hObject, eventdata, handles)
handles.ch(3) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function radiobutton4_CreateFcn(hObject, eventdata, handles)
handles.ch(4) = get(hObject,'Value');
guidata(hObject,handles);

function radiobutton5_CreateFcn(hObject, eventdata, handles)
ch = handles.ch;
handles.ch(5) = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function radiobutton6_CreateFcn(hObject, eventdata, handles)
handles.ch(6) = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function radiobutton7_CreateFcn(hObject, eventdata, handles)
handles.ch(7) = get(hObject,'Value');
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function radiobutton8_CreateFcn(hObject, eventdata, handles)
handles.ch(8) = get(hObject,'Value');
guidata(hObject,handles);



%------------------------------------------------------------------------%

%% ----------------------- GET RECORDING PARAMETERS -----------------------%
% get frequency
function edit3_Callback(hObject, eventdata, handles)
handles.Fs = str2double(get(hObject,'String'));
guidata(hObject,handles); 
function edit3_CreateFcn(hObject, eventdata, handles)
handles.Fs = str2double(get(hObject,'String'));
guidata(hObject,handles); 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% total time
function edit4_Callback(hObject, eventdata, handles)
handles.T = str2double(get(hObject,'String'));
guidata(hObject,handles); 
function edit4_CreateFcn(hObject, eventdata, handles)
handles.T = str2double(get(hObject,'String'));
guidata(hObject,handles); 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% voltage range
function edit17_Callback(hObject, eventdata, handles)
handles.range = str2num(get(hObject,'String'));
guidata(hObject,handles); 
function edit17_CreateFcn(hObject, eventdata, handles)
handles.range = str2num(get(hObject,'String'));
guidata(hObject,handles); 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%------------------------------------------------------------------------%

%% -----------------------------RECORD-------------------------------------%
% --- Executes on button press in record_toggle.
function record_toggle_Callback(hObject, eventdata, handles)

global STOP;
togglevalue = get(hObject,'Value');
if togglevalue == 0
    STOP = 1;
    disp('stop executed');
else

disp(handles.ch);
disp(handles.includevideo);
disp(handles.vid_height);
disp(handles.vid_width);
disp(handles.savecoords);


trig_dataq = get(handles.trig_dataq,'Value');

%%%%%%
% set up dio if trig_dataq
if trig_dataq == 1;
    dio = digitalio('nidaq',handles.analogdevice);
    lines = addline(dio,0,'in');
end

% set channels
channels = [];
for ichan = 1:8
    if handles.ch(ichan)~=0
        channels = [channels ichan-1];
    end
end
Fs = handles.Fs;
% get exposure channel index
exposure_channel_index = find(channels == handles.expchannel,1);
%%%%
% record
roi = []; % start with empty roi, then pass in outlined roi for all subsequent trials
for itrial = 1:handles.numtrials
        if trig_dataq == 0
            disp('READY: click to start trial; press return to abort');
            k = waitforbuttonpress;
        elseif trig_dataq == 1
            if itrial==1
                disp('record roi in trial 1')
                k = 0;
            else
                disp('READY: waiting for trigger');
                trig_detected = getvalue(dio);
                while(~any(trig_detected));
                    % hang
                    trig_detected = getvalue(dio);
                end
                k = 0;
            end
        end
    if k == 1 % break if keyboard entry detected, continue if mouse entry detected
        disp('stop detected')
        break;
    end
        if handles.includevideo == 1
            %save image data as .mat style (old)
            %roi = dvr_record_analog_video(handles.outputdir,[handles.filename,'_',num2str(itrial)],channels,handles.Fs,handles.T,...
            %    handles.analogdevice, handles.videodevicenum, handles.videoadaptor, handles.videoformat,...
            %    handles.axes1,exposure_channel_index,roi,handles.vid_width,handles.vid_height);
            % log avi file continuously
            disp(handles.LogMode)

            if handles.numtrials == inf
                roi = dvr_record_analog_video_log_cont(handles.outputdir,[handles.filename,'_',num2str(itrial)],channels,handles.Fs,handles.T,...
                handles.analogdevice, handles.videodevicenum, handles.videoadaptor, handles.videoformat,...
                handles.axes1,exposure_channel_index,roi,handles.vid_width,handles.vid_height,handles.range,handles.LogMode,handles.trialdelay);
            else
                roi = dvr_record_analog_video_log(handles.outputdir,[handles.filename,'_',num2str(itrial)],channels,handles.Fs,handles.T,...
                handles.analogdevice, handles.videodevicenum, handles.videoadaptor, handles.videoformat,...
                handles.axes1,exposure_channel_index,roi,handles.vid_width,handles.vid_height,handles.range,handles.LogMode);
            pause(handles.trialdelay);
            end

        else
            dvr_record_analog_only(handles.outputdir,[handles.filename,'_',num2str(itrial)],channels,handles.Fs,handles.T,...
                handles.analogdevice,handles.range);
            pause(handles.trialdelay);
        end
    %
    dvr_save_params(handles.outputdir,[handles.filename,'_',num2str(itrial),'_params'],Fs,handles.savecoords,handles.range);
    STOP == 1;
    disp('trial complete');
end
end

function plot_pushbutton_Callback(hObject, eventdata, handles) % plot
curdir = pwd;
cd(handles.outputdir);
filetoplot = uigetfile('*.mat','Select file to plot');
load(filetoplot);
cd(curdir);
time = [0:size(data,1)-1]/handles.Fs;
figure(1);
plot(time,data);

function edit5_Callback(hObject, eventdata, handles)
handles.analogdevice = get(hObject,'String');
guidata(hObject,handles); 
function edit5_CreateFcn(hObject, eventdata, handles)
handles.analogdevice = get(hObject,'String');
guidata(hObject,handles); 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% -------------------------VIDEO PARAMETERS -----------------------------%


% --- Executes on button press in checkbox1. % get video data
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.includevideo = get(hObject,'Value');
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox1

% --- Executes during object creation, after setting all properties.
function checkbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.includevideo = get(hObject,'Value');
guidata(hObject,handles);

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.videodevicenum = str2num(get(hObject,'String'));
guidata(hObject,handles); 
% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.videodevicenum = str2num(get(hObject,'String'));
guidata(hObject,handles); 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.videoadaptor = get(hObject,'String');
guidata(hObject,handles); 
% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.videoadaptor = get(hObject,'String');
guidata(hObject,handles); 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.videoformat = get(hObject,'String');
guidata(hObject,handles); 
% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.videoformat = get(hObject,'String');
guidata(hObject,handles); 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% set the channel that acquires exposure times from the camera
function exposure_channel_Callback(hObject, eventdata, handles)
handles.expchannel = str2num(get(hObject,'String'));
guidata(hObject,handles); 

function exposure_channel_CreateFcn(hObject, eventdata, handles)
handles.expchannel = str2num(get(hObject,'String'));
guidata(hObject,handles); 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function diskonly_CreateFcn(hObject, eventdata, handles)
if get(hObject,'Value')==1
    handles.LogMode = 'disk';
end
guidata(hObject,handles); 


function diskandmemory_CreateFcn(hObject, eventdata, handles)
if get(hObject,'Value')==1
    handles.LogMode = 'disk&memory';
end
guidata(hObject,handles);

function diskonly_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==1
    handles.LogMode = 'disk';
end
guidata(hObject,handles); 

function diskandmemory_Callback(hObject, eventdata, handles)
if get(hObject,'Value')==1
    handles.LogMode = 'disk&memory';
end
guidata(hObject,handles);

function vidwidth_edit_Callback(hObject, eventdata, handles)
handles.vidwidth_edit = get(hObject,'String');
handles.vid_width = str2num(get(hObject,'String'));
guidata(hObject,handles); 

function vidwidth_edit_CreateFcn(hObject, eventdata, handles)
handles.vidwidth_edit = get(hObject,'String');
handles.vid_width = str2num(get(hObject,'String'));
guidata(hObject,handles); 

function vidheight_edit_Callback(hObject, eventdata, handles)
handles.vidheight_edit = get(hObject,'String');
handles.vid_height = str2num(get(hObject,'String'));
guidata(hObject,handles);

function vidheight_edit_CreateFcn(hObject, eventdata, handles)
handles.vidheight_edit = get(hObject,'String');
handles.vid_height = str2num(get(hObject,'String'));
guidata(hObject,handles); 

% --- Executes on button press in play_pushbutton.
function play_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to play_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
curdir = pwd;
cd(handles.outputdir);
filetoplay = uigetfile('*.avi','Select file to play');
% code to play movie in _ims.mat saving format
%load(filetoplay);
%cd(curdir);
% numframes = size(ims,4);
% for iframe = 1:numframes
%     iframe
%     video_image = ims(:,:,1,iframe);
%     axes(handles.axes1);
%     imagesc(video_image);colormap(gray);
% end
% code to play movies in avi format
info = aviinfo(filetoplay);
numframes = info.NumFrames;
for iframe = 1:numframes
    if mod(iframe,round(info.FramesPerSecond))==0;
        disp([num2str(round(iframe/info.FramesPerSecond)),' seconds']);
    end
    mov = aviread(filetoplay,iframe);
    axes(handles.axes1);
    imagesc(mov.cdata);colormap(mov.colormap);
    axis image
end


% --- Executes on button press in focus_camera_togglebutton.
function focus_camera_togglebutton_Callback(hObject, eventdata, handles)
% hObject    handle to focus_camera_togglebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global STOP;
togglevalue = get(hObject,'Value');
if togglevalue == 1
    dvr_focus_camera(handles.axes1,handles.videodevicenum, handles.videoadaptor, handles.videoformat );
else
    STOP = 1;
    disp('stop executed');
end

function focus_camera_togglebutton_ButtonDownFcn(hObject, eventdata, handles)

%% Sutter Control
% --- Executes on button press in savecoords_checkbox.
function savecoords_checkbox_Callback(hObject, eventdata, handles)
handles.savecoords = get(hObject,'Value');
guidata(hObject,handles);

function savecoords_checkbox_CreateFcn(hObject, eventdata, handles)
handles.savecoords = get(hObject,'Value');
guidata(hObject,handles);

% --- Executes on button press in suttercontrol_button.
function suttercontrol_button_Callback(hObject, eventdata, handles)
scgui;









% --- Executes during object creation, after setting all properties.
function record_toggle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to record_toggle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


