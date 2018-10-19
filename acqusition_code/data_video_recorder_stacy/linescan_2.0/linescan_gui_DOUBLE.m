function varargout = linescan_gui_DOUBLE(varargin)
% LINESCAN_GUI M-file for linescan_gui.fig
%      LINESCAN_GUI, by itself, creates a new LINESCAN_GUI or raises the existing
%      singleton*.
%
%      H = LINESCAN_GUI returns the handle to a new LINESCAN_GUI or the handle to
%      the existing singleton*.
%
%      LINESCAN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINESCAN_GUI.M with the given input arguments.
%
%      LINESCAN_GUI('Property','Value',...) creates a new LINESCAN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before linescan_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to linescan_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help linescan_gui

% Last Modified by GUIDE v2.5 22-Oct-2013 13:22:37
global STOP; STOP = 0;

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @linescan_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @linescan_gui_OutputFcn, ...
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


% --- Executes just before linescan_gui is made visible.
function linescan_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to linescan_gui (see VARARGIN)

% initialize everything
handles.height = NaN;
[handles.vidparams handles.aoparams] = linescan_set_parameters_DOUBLE(handles.height);
handles.VID = linescan_setup_camera();
handles.AO = linescan_setup_ao();
handles.newthresholdA = 245;
handles.newthresholdB = 245;
handles.roi = [];

% Choose default command line output for linescan_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes linescan_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = linescan_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in focus_camera.
function focus_camera_Callback(hObject, eventdata, handles)
% hObject    handle to focus_camera (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
linescan_focus_camera(handles.VID,handles.vidparams);
if ~isempty(handles.roi)
    set(handles.VID,'ROIPosition', handles.roi);
end


% --- Executes on button press in set_roi.
function set_roi_Callback(hObject, eventdata, handles)
% hObject    handle to set_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.meanbgA = [];
handles.meanbgB = [];
disp('background has been cleared');
[handles.roi handles.fullimage handles.height] = linescan_set_roi_DOUBLE(handles.VID,handles.vidparams.width);
[handles.vidparams handles.aoparams] = linescan_set_parameters_DOUBLE(handles.height);
set(handles.VID,'ROIPosition', handles.roi);
%disp('click to set margins');
%k = waitforbuttonpress;
[handles.collimitsA,handles.collimitsB] = linescan_set_collimits_DOUBLE(handles.VID);
disp('ROI has been set');


% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in set_background.
function set_background_Callback(hObject, eventdata, handles)
% hObject    handle to set_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.meanbgA = [];
handles.meanbgB = [];
[handles.meanbgA handles.meanbgB] = linescan_get_bg_intensity_DOUBLE(handles.VID,handles.vidparams);
figure(1); plot([1:handles.vidparams.width],handles.meanbgA,'b',[1:handles.vidparams.width],handles.meanbgB,'r');
disp('background has been set');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% save static variables - do from gui
handles.vidparams.thresholdA = handles.newthresholdA;
handles.vidparams.thresholdB = handles.newthresholdB;
starttime = clock;
fps = dvr_get_framerate(handles.VID);
fullimage = handles.fullimage; roi = handles.roi; collimitsA = handles.collimitsA; collimitsB = handles.collimitsB;
meanbgA = handles.meanbgA; meanbgB = handles.meanbgB; 
vidparams = handles.vidparams; aoparams = handles.aoparams;
saved_variables = {'fullimage';'roi';'starttime';'collimitsA';'collimitsB';'meanbgA';'meanbgB';'fps';'vidparams';'aoparams'};
uisave(saved_variables,['linescan',datestr(now,'yymmdd-HHMMSS'),'.mat']);
% RUN
disp('running...');
linescan_run_DOUBLE(handles.VID,handles.AO,handles.vidparams,handles.aoparams,handles.meanbgA,handles.meanbgB,handles.collimitsA,handles.collimitsB);
%linescan_run_2pts(handles.VID,handles.AO,handles.vidparams,handles.aoparams,handles.meanbg,handles.collimits);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a
%        double
handles.newthresholdA = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global STOP;
STOP = 1;
disp('stop executed');



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.newthresholdB = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


