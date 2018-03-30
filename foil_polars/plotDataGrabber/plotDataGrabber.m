function varargout = plotDataGrabber(varargin)
% PLOTDATAGRABBER MATLAB code for plotDataGrabber.fig
%      PLOTDATAGRABBER, by itself, creates a new PLOTDATAGRABBER or raises the existing
%      singleton*.
%
%      H = PLOTDATAGRABBER returns the handle to a new PLOTDATAGRABBER or the handle to
%      the existing singleton*.
%
%      PLOTDATAGRABBER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTDATAGRABBER.M with the given input arguments.
%
%      PLOTDATAGRABBER('Property','Value',...) creates a new PLOTDATAGRABBER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plotDataGrabber_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plotDataGrabber_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plotDataGrabber

% Last Modified by GUIDE v2.5 11-Feb-2018 18:09:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @plotDataGrabber_OpeningFcn, ...
    'gui_OutputFcn',  @plotDataGrabber_OutputFcn, ...
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


% --- Executes just before plotDataGrabber is made visible.
function plotDataGrabber_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plotDataGrabber (see VARARGIN)

% Choose default command line output for plotDataGrabber
handles.output = hObject;

handles.currentData = [];
handles.origin = [0 0];
handles.xrange = 1;
handles.yrange = 1;
handles.Uyrange = 1;
handles.Uxrange = 1;
handles.varname = 'var1';
handles.pointHandles = line;
handles.sw = 0; % If 1, user is selecting points
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plotDataGrabber wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plotDataGrabber_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function varName_Callback(hObject, eventdata, handles)
% hObject    handle to varName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of varName as text
%        str2double(get(hObject,'String')) returns contents of varName as a double
handles.varname = get(hObject,'String');
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function varName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to varName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rotccw.
function rotccw_Callback(hObject, eventdata, handles)
% hObject    handle to rotccw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.img = imrotate(handles.img,0.5,'bilinear','loose');
imghandle = imshow(handles.img, 'Parent', handles.ax);
set(imghandle, 'ButtonDownFcn', @pointSelect);
guidata(hObject,handles);

% --- Executes on button press in rotcw.
function rotcw_Callback(hObject, eventdata, handles)
% hObject    handle to rotcw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.img = imrotate(handles.img,-0.5,'bilinear','loose');
imghandle = imshow(handles.img, 'Parent', handles.ax);
set(imghandle, 'ButtonDownFcn', @pointSelect);
guidata(hObject,handles);


% --- Executes on button press in setAxRange.
function setAxRange_Callback(hObject, eventdata, handles)
% hObject    handle to setAxRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('Click the Origin\n')
[Ox,Oy] = ginput(1);

fprintf('Click the x axis range \n')
[Xx,~] = ginput(1);
fprintf('Click the y axis range \n')
[~,Yy] = ginput(1);

handles.xrange = Xx;
handles.yrange = Yy;
handles.origin = [Ox,Oy];
guidata(hObject,handles);


% --- Executes on button press in loadimage.
function loadimage_Callback(hObject, eventdata, handles)
% hObject    handle to loadimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,fpath,~] = uigetfile('*');
img = imread([fpath,filename]);
imghandle = imshow(img, 'Parent', handles.ax);
set(imghandle, 'ButtonDownFcn', @pointSelect);
handles.img = img;
guidata(hObject,handles);


function xrange_Callback(hObject, eventdata, handles)
% hObject    handle to xrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xrange as text
%        str2double(get(hObject,'String')) returns contents of xrange as a double
handles.Uxrange = str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function xrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yrange_Callback(hObject, eventdata, handles)
% hObject    handle to yrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yrange as text
%        str2double(get(hObject,'String')) returns contents of yrange as a double
handles.Uyrange = str2double(get(hObject,'String'));
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function yrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function pointSelect(hObject, handles)
handles = guidata(hObject);
buttsw = 1;
while handles.sw && buttsw
    handles = guidata(hObject);
    [xin,yin,button] = ginput(1);
    if button>1
        buttsw = 0;
        handles.selecton.Value = 0;
        handles.sw = 0;
    else
        
        x = (xin-handles.origin(1))*handles.Uxrange/(handles.xrange-handles.origin(1));
        y = (yin-handles.origin(2))*handles.Uyrange/(handles.yrange-handles.origin(2));
        fprintf('[ %f , %f ]\n',x,y)
        handles.currentData(end+1,:) = [x,y];
        hold(gca,'on');
        handles.pointHandles(end+1) = plot(gca,xin,yin,'r+','MarkerSize',10);
        guidata(hObject,handles);
    end
end

guidata(hObject,handles);

%    axesHandle  = get(hObject,'Parent');
%    guihandle = get(axesHandle,'Parent');
%    coordinates = get(axesHandle,'CurrentPoint');
%    coordinates = coordinates(1,1:2);
%    handles = guidata(guihandle);
%    x = (coordinates(1)-handles.origin(1))*handles.Uxrange/(handles.xrange-handles.origin(1));
%    y = (coordinates(2)-handles.origin(2))*handles.Uyrange/(handles.yrange-handles.origin(2));
%    fprintf('[ %f , %f ]\n',x,y)
%    handles.currentData(end+1,:) = coordinates;
%    hold(axesHandle,'on');
%    handles.pointHandles(end+1) = plot(axesHandle,coordinates(1),coordinates(2),'r+','MarkerSize',10);
%    guidata(guihandle,handles);


% --- Executes on button press in savepush.
function savepush_Callback(hObject, eventdata, handles)
% hObject    handle to savepush (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.pointHandles);
handles.pointHandles = line;
assignin('base', handles.varname, handles.currentData);
handles.currentData = [];
guidata(hObject,handles);


% --- Executes on button press in selecton.
function selecton_Callback(hObject, eventdata, handles)
% hObject    handle to selecton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of selecton
sw = get(hObject,'Value');
if sw
    handles.sw = 1;
    pointSelect(hObject,handles);
else
    handles.sw = 0;
end
guidata(hObject,handles)

% --- Executes on button press in delpoint.
function delpoint_Callback(hObject, eventdata, handles)
% hObject    handle to delpoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentData(end,:) = [];
delete(handles.pointHandles(end))
handles.pointHandles = handles.pointHandles(1:end-1);
guidata(hObject,handles);

% --- Executes on button press in delall.
function delall_Callback(hObject, eventdata, handles)
% hObject    handle to delall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.currentData = [];
delete(handles.pointHandles)
handles.pointHandles = line;
guidata(hObject,handles);
