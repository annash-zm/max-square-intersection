function varargout = tabelirisan(varargin)
% TABELIRISAN M-file for tabelirisan.fig
%      TABELIRISAN, by itself, creates a new TABELIRISAN or raises the existing
%      singleton*.
%
%      H = TABELIRISAN returns the handle to a new TABELIRISAN or the handle to
%      the existing singleton*.
%
%      TABELIRISAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABELIRISAN.M with the given input arguments.
%
%      TABELIRISAN('Property','Value',...) creates a new TABELIRISAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tabelirisan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tabelirisan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tabelirisan

% Last Modified by GUIDE v2.5 20-Sep-2017 13:01:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tabelirisan_OpeningFcn, ...
                   'gui_OutputFcn',  @tabelirisan_OutputFcn, ...
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


% --- Executes just before tabelirisan is made visible.
function tabelirisan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tabelirisan (see VARARGIN)

% Choose default command line output for tabelirisan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tabelirisan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tabelirisan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
data=dlmread('irisan.txt');
[m n]=size(data);
A=mat_adjacency(data);
for i=1:m
    r(i)={['R' num2str(i)]};
end
set(hObject,'data',A,'rowname',r,'columnname',r,'columnwidth',{30})


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
