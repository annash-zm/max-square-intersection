function varargout = irisan_max(varargin)
% IRISAN_MAX M-file for irisan_max.fig
%      IRISAN_MAX, by itself, creates a new IRISAN_MAX or raises the existing
%      singleton*.
%
%      H = IRISAN_MAX returns the handle to a new IRISAN_MAX or the handle to
%      the existing singleton*.
%
%      IRISAN_MAX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IRISAN_MAX.M with the given input arguments.
%
%      IRISAN_MAX('Property','Value',...) creates a new IRISAN_MAX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before irisan_max_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to irisan_max_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help irisan_max

% Last Modified by GUIDE v2.5 18-Nov-2018 13:30:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @irisan_max_OpeningFcn, ...
                   'gui_OutputFcn',  @irisan_max_OutputFcn, ...
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


% --- Executes just before irisan_max is made visible.
function irisan_max_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to irisan_max (see VARARGIN)

% Choose default command line output for irisan_max
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes irisan_max wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = irisan_max_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName]=uigetfile({'*txt','Pilih file .txt'});
if FileName~=0
    data=importdata([PathName,FileName]);
    [m n]=size(data);
    for i=1:m
        ro(i)={['R' num2str(i)]};
    end
    set(handles.uitable1,'data',data,'rowname',ro,...
        'columnname',{'x1','x2','y1','y2'},'columnwidth',{55});
    set(handles.edit1,'string',[PathName FileName]);
    set(handles.figure1,'userdata',ro);
    set(handles.uitable1,'columneditable',true)
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
data=get(handles.uitable1,'data');
ir=iris(data);

dlmwrite('irisan.txt', ir, 'delimiter', '\t', ...
         'precision', 6)
[m n]=size(data);
a=data(:,1:2);
b=data(:,3:4);
[v w]=size(data);
for i=1:v
        text(data(i,1),data(i,4),['\color{black}R' num2str(i)],...
            'fontsize',11,'fontweight','normal','fontname','cambria',...
            'HorizontalAlignment','left','VerticalAlignment','baseline')
end
data(m+1,:)=[min(min(a))-1 max(max(a))+1 min(min(b))-1 max(max(b))+1];
[m n]=size(data);
a=data(:,1:2);
b=data(:,3:4);
x=min(min(a)):max(max(a));
y=min(min(b)):max(max(b));
set(handles.figure1,'CurrentAxes',handles.axes1);
set(handles.axes1,'nextplot','replace');
for i=1:length(x)
    plot([x(i) x(i)],[y(1) y(length(y))],'k:');
    set(handles.axes1,'nextplot','add');
end
for i=1:length(y)
    plot([x(1) x(length(x))],[y(i) y(i)],'k:');
end

for i=1:m-1
    wr=rand(1,3);
    plot([data(i,1) data(i,1)],[data(i,3) data(i,4)],'color',wr,'linewidth',2.5);
    plot([data(i,1) data(i,2)],[data(i,3) data(i,3)],'color',wr,'linewidth',2.5);
    plot([data(i,1) data(i,2)],[data(i,4) data(i,4)],'color',wr,'linewidth',2.5);
    plot([data(i,2) data(i,2)],[data(i,3) data(i,4)],'color',wr,'linewidth',2.5);   
    text(data(i,1),data(i,4),['\color{blue}R' num2str(i)],...
        'fontsize',10,'fontweight','normal','fontname','cambria',...
            'HorizontalAlignment','left','VerticalAlignment','baseline')
end
A=mat_adjacency(ir);
B=BK_MaxClique(A);
B=B';
[m1 n1]=size(B);
for i=1:m1
    for j=1:n1
        if B(i,j)~=0
            C(i,j)=j;
        end
    end
end
for i=1:m1
    a=hapus_nol(C(i,:));
    iri=data(a(1),:);
    for j=1:n1
        if B(i,j)~=0
            iri=iris_wrn(iri,data(j,:));
        end
    end
    ir1(i,:)=iri;
end
[mw nw]=size(ir1);
for i=1:mw
    wr='k';
    plot([ir1(i,1) ir1(i,1)],[ir1(i,3) ir1(i,4)],'color',wr,'linewidth',5);
    plot([ir1(i,1) ir1(i,2)],[ir1(i,3) ir1(i,3)],'color',wr,'linewidth',5);
    plot([ir1(i,1) ir1(i,2)],[ir1(i,4) ir1(i,4)],'color',wr,'linewidth',5);
    plot([ir1(i,2) ir1(i,2)],[ir1(i,3) ir1(i,4)],'color',wr,'linewidth',5);
    a=(ir1(i,1)+ir1(i,2))/2;
    b=(ir1(i,3)+ir1(i,4))/2;
    plot(a,b,'s','markersize',25,'markerfacecolor',rand(1,3),'markeredgecolor','k');
    text(a,b,['\color{white}H' num2str(i)],...
            'fontsize',10,'fontweight','bold','fontname','cambria',...
            'HorizontalAlignment','center')
end
set(handles.axes1,'Color',[1 1 1],'XColor',[0 0 0],'YColor',[0 0 0]);
set(handles.axes1,'XLim',[min(x) max(x)],'YLim',[min(y) max(y)],...
       'ytick',y,'xgrid','off','ygrid','off');
xlabel('x','fontname','cambria','fontsize',11);
ylabel('y','fontname','cambria','fontsize',11);


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'data',[]);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Edit_Callback(hObject, eventdata, handles)
% hObject    handle to Edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Tambah_Callback(hObject, eventdata, handles)
% hObject    handle to Tambah (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable1,'data');
ro=get(handles.figure1,'userdata');
m=length(ro);
ro(m+1)={['R' num2str(m+1)]};
tmbah=zeros(1,4);
set(handles.uitable1,'data',[data; tmbah],'rowname',ro)
set(handles.uitable1,'columneditable',true)
set(handles.figure1,'userdata',ro);

% --------------------------------------------------------------------
function Kurangi_Callback(hObject, eventdata, handles)
% hObject    handle to Kurangi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Pilih Pasien yang dihapus : '};
dlg_title = 'Kurangi Data';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines);
a=str2double(answer);
if a~=0
    data=get(handles.uitable1,'data');
    ro=get(handles.figure1,'userdata');
    m=length(ro);
    ro=ro(1:m-1);
    t=0;
    for i=1:m
        if i~=a
            t=t+1;
            kurang(t,:)=data(i,:);
        end
    end
    set(handles.uitable1,'data',kurang,'rowname',ro)
    set(handles.uitable1,'columneditable',true)
    set(handles.figure1,'userdata',ro);
end

% --------------------------------------------------------------------
function Buka_Callback(hObject, eventdata, handles)
% hObject    handle to Buka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName]=uigetfile({'*txt','Pilih file .txt'});
if FileName~=0
    data=importdata([PathName,FileName]);
    [m n]=size(data);
    for i=1:m
        ro(i)={['R' num2str(i)]};
    end
    set(handles.uitable1,'data',data,'rowname',ro,...
        'columnname',{'x1','x2','y1','y2'},'columnwidth',{55});
    set(handles.edit1,'string',[PathName FileName]);
    set(handles.figure1,'userdata',ro);
    set(handles.uitable1,'columneditable',true)
end

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namafile,direktori]=uiputfile('*.txt','Simpan Data');
if namafile~=0
    eval(['cd ''' direktori ''';']);
    namafile=[namafile ''];
    fout=fopen(namafile,'wt');
    d=get(handles.uitable1,'data');
    [m n]=size(d);
    for i=1:m
        for j=1:n
            fprintf(fout,'%g  ',d(i,j));
        end
        fprintf(fout,'\n');
    end
    fclose(fout);
end

% --------------------------------------------------------------------
function Keluar_Callback(hObject, eventdata, handles)
% hObject    handle to Keluar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close

% --------------------------------------------------------------------
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=get(handles.uitable1,'data');
ro=get(handles.figure1,'userdata');
m=length(ro);
ro(m+1)={['R' num2str(m+1)]};
tmbah=zeros(1,4);
set(handles.uitable1,'data',[data; tmbah],'rowname',ro)
set(handles.uitable1,'columneditable',true)
set(handles.figure1,'userdata',ro);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Pilih Pasien yang dihapus : '};
dlg_title = 'Kurangi Data';
num_lines = 1;
answer = inputdlg(prompt,dlg_title,num_lines);
a=str2double(answer);
if a~=0
    data=get(handles.uitable1,'data');
    ro=get(handles.figure1,'userdata');
    m=length(ro);
    ro=ro(1:m-1);
    t=0;
    for i=1:m
        if i~=a
            t=t+1;
            kurang(t,:)=data(i,:);
        end
    end
    set(handles.uitable1,'data',kurang,'rowname',ro)
    set(handles.uitable1,'columneditable',true)
    set(handles.figure1,'userdata',ro);
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namafile,direktori]=uiputfile('*.txt','Simpan Data');
if namafile~=0
    eval(['cd ''' direktori ''';']);
    namafile=[namafile ''];
    fout=fopen(namafile,'wt');
    d=get(handles.uitable1,'data');
    [m n]=size(d);
    for i=1:m
        for j=1:n
            fprintf(fout,'%g  ',d(i,j));
        end
        fprintf(fout,'\n');
    end
    fclose(fout);
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tabelirisan


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mat_clique

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
graf


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
graf_clique
