function varargout = mat_clique(varargin)
% MAT_CLIQUE M-file for mat_clique.fig
%      MAT_CLIQUE, by itself, creates a new MAT_CLIQUE or raises the existing
%      singleton*.
%
%      H = MAT_CLIQUE returns the handle to a new MAT_CLIQUE or the handle to
%      the existing singleton*.
%
%      MAT_CLIQUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAT_CLIQUE.M with the given input arguments.
%
%      MAT_CLIQUE('Property','Value',...) creates a new MAT_CLIQUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mat_clique_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mat_clique_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mat_clique

% Last Modified by GUIDE v2.5 17-Nov-2018 21:05:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mat_clique_OpeningFcn, ...
                   'gui_OutputFcn',  @mat_clique_OutputFcn, ...
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


% --- Executes just before mat_clique is made visible.
function mat_clique_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mat_clique (see VARARGIN)

% Choose default command line output for mat_clique
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mat_clique wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mat_clique_OutputFcn(hObject, eventdata, handles) 
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
for i=1:m
    for j=1:n
        if data(i,j)~=0
            A(i,data(i,j))=1;
        end
    end
    r(i)={['R' num2str(i)]};
end
B=BK_MaxClique(A);
[b k]=size(B);
for i=1:k
    kol(i)={['H' num2str(i)]};
end
set(hObject,'data',B,'rowname',r,'columnname',kol,'columnwidth',{30})


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
