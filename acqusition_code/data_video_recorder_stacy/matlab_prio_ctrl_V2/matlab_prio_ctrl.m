function varargout = matlab_prio_ctrl(varargin)
% MATLAB_PRIO_CTRL M-file for matlab_prio_ctrl.fig
%      MATLAB_PRIO_CTRL, by itself, creates a new MATLAB_PRIO_CTRL or raises the existing
%      singleton*.
%
%      H = MATLAB_PRIO_CTRL returns the handle to a new MATLAB_PRIO_CTRL or the handle to
%      the existing singleton*.
%
%      MATLAB_PRIO_CTRL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATLAB_PRIO_CTRL.M with the given input arguments.
%
%      MATLAB_PRIO_CTRL('Property','Value',...) creates a new MATLAB_PRIO_CTRL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matlab_prio_ctrl_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matlab_prio_ctrl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matlab_prio_ctrl

% Last Modified by GUIDE v2.5 14-Jul-2006 15:24:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matlab_prio_ctrl_OpeningFcn, ...
                   'gui_OutputFcn',  @matlab_prio_ctrl_OutputFcn, ...
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


% --- Executes just before matlab_prio_ctrl is made visible.
function matlab_prio_ctrl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matlab_prio_ctrl (see VARARGIN)

% Choose default command line output for matlab_prio_ctrl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes matlab_prio_ctrl wait for user response (see UIRESUME)
% uiwait(handles.figure1);

[pri_class pri_thread] = get_priority;
set(handles.processpop, 'value', pri_class)
set(handles.threadpop, 'value', pri_thread)


% --- Outputs from this function are returned to the command line.
function varargout = matlab_prio_ctrl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in processpop.
function processpop_Callback(hObject, eventdata, handles)
% hObject    handle to processpop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns processpop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        processpop

% --- Executes during object creation, after setting all properties.
function processpop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to processpop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in threadpop.
function threadpop_Callback(hObject, eventdata, handles)
% hObject    handle to threadpop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns threadpop contents as cell array
%        contents{get(hObject,'Value')} returns selected item from
%        threadpop


% --- Executes during object creation, after setting all properties.
function threadpop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threadpop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pri_proc = get(handles.processpop, 'value');
pri_th = get(handles.threadpop, 'value');
set_priority(-1, pri_proc, pri_th);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[pri_class pri_thread] = get_priority;
set(handles.processpop, 'value', pri_class)
set(handles.threadpop, 'value', pri_thread)



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


