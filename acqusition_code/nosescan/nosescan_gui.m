function varargout = nosescan_gui(varargin)
% NOSESCAN_GUI M-file for nosescan_gui.fig
%      NOSESCAN_GUI, by itself, creates a new NOSESCAN_GUI or raises the existing
%      singleton*.
%
%      H = NOSESCAN_GUI returns the handle to a new NOSESCAN_GUI or the handle to
%      the existing singleton*.
%
%      NOSESCAN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOSESCAN_GUI.M with the given input arguments.
%
%      NOSESCAN_GUI('Property','Value',...) creates a new NOSESCAN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nosescan_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nosescan_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nosescan_gui

% Last Modified by GUIDE v2.5 23-Jun-2015 13:36:32
global STOP; STOP = 0;

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nosescan_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @nosescan_gui_OutputFcn, ...
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


% --- Executes just before nosescan_gui is made visible.
function nosescan_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nosescan_gui (see VARARGIN)

% initialize everything
handles.width = 250;
handles.height = 250;
[handles.vidparams handles.aoparams] = nosescan_set_parameters(handles.width,handles.height);
handles.VID = nosescan_setup_camera();
handles.AO = nosescan_setup_ao();
handles.roi = [];

% Choose default command line output for nosescan_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nosescan_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = nosescan_gui_OutputFcn(hObject, eventdata, handles) 
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
nosescan_focus_camera(handles.VID,handles.vidparams);
if ~isempty(handles.roi)
    set(handles.VID,'ROIPosition', handles.roi);
end


% --- Executes on button press in set_roi.
function set_roi_Callback(hObject, eventdata, handles)
% hObject    handle to set_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('background has been cleared');
[handles.roi handles.fullimage] = nosescan_set_roi(handles.VID,handles.width,handles.height);
[handles.vidparams handles.aoparams] = nosescan_set_parameters(handles.width,handles.height);
set(handles.VID,'ROIPosition', handles.roi);


% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% save static variables - do from gui

starttime = clock;
fps = dvr_get_framerate(handles.VID);

fullimage = handles.fullimage; roi = handles.roi;
vidparams = handles.vidparams; aoparams = handles.aoparams;

saved_variables = {'fullimage';'roi';'starttime';'fps';'vidparams';'aoparams'};
uisave(saved_variables,['nosescan',datestr(now,'yymmdd-HHMMSS'),'.mat']);
% RUN
disp('running...');
nosescan_run(handles.VID,handles.AO,handles.vidparams,handles.aoparams);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a
%        double
handles.width = str2double(get(hObject,'String'));

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
handles.height = str2double(get(hObject,'String'));

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


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

