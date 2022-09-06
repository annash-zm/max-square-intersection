function varargout = graf(varargin)
% GRAF MATLAB code for graf.fig
%      GRAF, by itself, creates a new GRAF or raises the existing
%      singleton*.
%
%      H = GRAF returns the handle to a new GRAF or the handle to
%      the existing singleton*.
%
%      GRAF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAF.M with the given input arguments.
%
%      GRAF('Property','Value',...) creates a new GRAF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before graf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to graf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help graf

% Last Modified by GUIDE v2.5 16-Nov-2018 22:28:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @graf_OpeningFcn, ...
                   'gui_OutputFcn',  @graf_OutputFcn, ...
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


% --- Executes just before graf is made visible.
function graf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to graf (see VARARGIN)

% Choose default command line output for graf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes graf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = graf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
clc
data=dlmread('irisan.txt');
[m n]=size(data);
for i=1:m
    for j=1:n
        if data(i,j)~=0
            A(i,data(i,j))=1;
        end
    end
end
[m n]=size(A);
[x y]=poligon(m);
hold off
for i=1:m
    for j=1:n
        if A(i,j)~=0
            plot([x(i) x(j)],[y(i) y(j)],'-');
            hold on
        end
    end
end
for i=1:m
    plot(x(i),y(i),'o','markerfacecolor','y','markeredgecolor','k');
    text(x(i),y(i)+0.03,['\color{black}R' num2str(i)],'fontsize',11,'fontweight',...
            'normal','fontname','cambria','HorizontalAlignment','center','VerticalAlignment','baseline')
end
axis equal
set(hObject,'Color',[1 1 1],'xlim',[min(x)-0.3 max(x)+0.3],'xtick',[],'ytick',[]);
% Hint: place code in OpeningFcn to populate axes1
