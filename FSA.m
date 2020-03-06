function varargout = FSA(varargin)
% FSA MATLAB code for FSA.fig
%      FSA, by itself, creates a new FSA or raises the existing
%      singleton*.
%
%      H = FSA returns the handle to a new FSA or the handle to
%      the existing singleton*.
%
%      FSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FSA.M with the given input arguments.
%
%      FSA('Property','Value',...) creates a new FSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FSA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FSA

% Last Modified by GUIDE v2.5 27-Feb-2020 11:34:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FSA_OpeningFcn, ...
    'gui_OutputFcn',  @FSA_OutputFcn, ...
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

% --- Executes just before FSA is made visible.
function FSA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FSA (see VARARGIN)

% Choose default command line output for FSA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FSA wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global  axesimage menu  Navigation Var
ck=[4.758e-06,-0.002496,0.3281,23.14,-162.2];
x=1:256;
ck=ck(1).*x.^4 + ck(2).*x.^3 + ck(3).*x.^2 + ck(4).*x + ck(5);
ck(1:6)=[0.9344  128.6399 12.7616   22.7793   37.1182   54.1751];
Var = struct('Color',[1 0  0; 0 1 0; 0 0 1],'Fourier',0,'Coef_lin',ck,'Path','','File','');

%%%%%%%%%%%%%%%%%%%%% Menu File %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.file = uimenu(hObject,'Label','Open','ForegroundColor',[0 0 0]);
menu.multi_file=uimenu(menu.file,'Label','load images',...
    'Callback',{@load_images_Callback,handles});


%%%%%%%%%%%%%%%%%%%%% Menu setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.setup = uimenu(hObject,'Label','Setup','ForegroundColor',[0 0 0]);
menu.color = uimenu(menu.setup,'Label','Complement color',...
    'Enable','off','Callback',{@complementC_Callback,handles});
menu.untouchedi = uimenu(menu.setup,'Label','Untouched edges',...
    'Enable','off','Callback',{@untouched_Callback,handles});
menu.roi = uimenu(menu.setup,'Label','ROI',...
    'Enable','off');
menu.roiellipse = uimenu(menu.roi,'Label','Ellipse',...
    'Enable','off','Callback',{@roi_Callback,handles,1});
menu.roipolygon = uimenu(menu.roi,'Label','Polygon',...
    'Enable','off','Callback',{@roi_Callback,handles,2});
menu.roirectangular = uimenu(menu.roi,'Label','Rectangular',...
    'Enable','off','Callback',{@roi_Callback,handles,3});
menu.roifreehand = uimenu(menu.roi,'Label','Freehand',...
    'Enable','off','Callback',{@roi_Callback,handles,4});


%%%%%%%%%%%%%%%%%%%%% Menu Fourier Analysis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.fourier = uimenu(hObject,'Label','Fourier','ForegroundColor',[0 0 0]);
menu.Optimization = uimenu(menu.fourier ,'Label','Optimization',...
    'Enable','off','Callback',{@optimization_Callback,handles});
menu.linearizedc = uimenu(menu.fourier ,'Label','Linearized Ms3_6 Mr7_15 Mt16_50 Coefficients',...
    'Enable','off','Callback',{@linearizedc_Callback,handles});
menu.linearizedv  = uimenu(menu.fourier ,'Label','Linearized Ms2 Mr3_8 Mt30_34 Coefficients',...
    'Enable','off','Callback',{@linearizedc2_Callback,handles});
menu.normalizedc = uimenu(menu.fourier ,'Label','Linearized Set Coefficients',...
    'Enable','off','Callback',{@linearizeds_Callback,handles});

%%%%%%%%%%%%%%%%%%%%% Graph %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.graph = uimenu(hObject,'Label','Graph','ForegroundColor',[0 0 0]);
menu.form_graphs = uimenu(menu.graph,'Label','Mean Harmonics of form',...
    'Enable','off','Callback',{@form_graphs_Callback,handles});
menu.roundness_graphs = uimenu(menu.graph,'Label','Mean Harmonics of roundness',...
    'Enable','off','Callback',{@roundness_graphs_Callback,handles});
menu.roughness_graphs = uimenu(menu.graph,'Label','Mean Harmonics of roughness',...
    'Enable','off','Callback',{@roughness_graphs_Callback,handles});
%%%%%%%%%%%%%%%%%%%%% Export Results %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.exp = uimenu(hObject,'Label','Export','ForegroundColor',[0 0 0]);
menu.stats = uimenu(menu.exp,'Label','Spectrums',...
    'Enable','off','Callback',{@spectrums_export_Callback,handles});
menu.sheet = uimenu(menu.exp,'Label','Range stats',...
    'Enable','off','Callback',{@range_stats_export_Callback,handles});
menu.image = uimenu(menu.exp,'Label','Labels image',...
    'Enable','off','Callback',{@labels_image_export_Callback,handles});

%%%%%%%%%%%%%%%%%%%%% Menu help %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.help = uimenu(hObject,'Label','Help','ForegroundColor',[0 0 0]);
menu.doc = uimenu(menu.help,'Label','User guide',...
    'Callback',{@user_guide_Callback,handles});
menu.aboutus = uimenu(menu.help,'Label','About us',...
    'Callback',{@aboutus_Callback,handles});
menu.colaboration = uimenu(menu.help,'Label','Colaboration',...
    'Callback',{@colaboration_Callback,handles});
menu.version = uimenu(menu.help,'Label','License software',...
    'Callback',{@license_Callback,handles},'Separator','on');

%%%%%%%%%%%%%%%%%%%%%AXES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axesimage = axes('Parent',gcf);
set(axesimage,'units','normalized','Position',[0 0.05 1 .95])
axis(axesimage,'off')

%%%%%%%%%%%%%%%%%%%%% Navigation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Navigation.before= uicontrol('units','normalized','Style','pushbutton',...
    'String','<','Position',[0.425,0,0.05,0.03],'Enable','off','CallBack', {@before_Callback,handles});

Navigation.select= uicontrol('units','normalized','Style','edit',...
    'String','1','Position',[0.475,0,0.05,0.028],'Enable','off');

Navigation.next= uicontrol('units','normalized','Style','pushbutton',...
    'String','>','Position',[0.525,0,0.05,0.03],'Enable','off','Callback',{@next_Callback,handles});
%%%%%%%%%% Set icon

warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jFrame=get(handle(handles.figure1), 'javaframe');
jicon=javax.swing.ImageIcon('icon.jpg');
jFrame.setFigureIcon(jicon);


% --- Outputs from this function are returned to the command line.
function varargout = FSA_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Load  images        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function load_images_Callback(hObject, eventdata, handles)
global Var menu Navigation
try
    [filenamet, pathnamet, ~] = uigetfile('*.*', ...
        'Load images', ...
        'MultiSelect', 'on',Var.Path);
    if ~isnumeric(pathnamet)
        Var.Path=pathnamet;
        Var.File=filenamet;
    else
        return
    end
catch
    [filenamet, pathnamet, ~] = uigetfile('*.*', ...
        'Load images', ...
        'MultiSelect', 'on');
    if ~isnumeric(pathnamet)
        Var.Path=pathnamet;
        Var.File=filenamet;
    else
        return
    end
end


if iscell(Var.File)  %% multiple
    Var.Number_I=length(Var.File);
    Var.Images=cell(1,Var.Number_I);
    for i=1:Var.Number_I
        I=binarize_image(imread([Var.Path, Var.File{i}]));
        Var.Images{i}=I;
    end
else
    Var.Number_I=1;  %% single
    Var.File={Var.File};
    Var.Images=cell(1,1);
    I=binarize_image(imread([Var.Path, Var.File{1}]));
    Var.Images{1}=I;
end

%%% Flags 
Var.Fourier=zeros(1,Var.Number_I);
Var.Selected_I=1;

%%% Reset Axes and Enable navigation tools
cla
set(Navigation.select, 'Enable','on')
set(Navigation.before, 'Enable','on')
set(Navigation.next, 'Enable','on')
set(Navigation.select, 'String',num2str(Var.Selected_I))
imshow(Var.Images{1})

%%%  Enable/disabled menu
set(findall(menu.setup, '-property','Enable'),'Enable','on')
set(findall(menu.fourier, '-property','Enable'),'Enable','on')
set(findall(menu.exp, '-property','Enable'),'Enable','off')
set(findall(menu.graph, '-property','Enable'),'Enable','off')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       next navigator     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function next_Callback(hObject, eventdata, handles)
global Navigation Var
if (Var.Selected_I+1)>Var.Number_I
    return
else
    Var.Selected_I=Var.Selected_I+1;
    set(Navigation.select, 'String',num2str(Var.Selected_I))
    imshow(Var.Images{Var.Selected_I})
end

if Var.Fourier(Var.Selected_I)==1
 contours_plot_Callback(@contours_plot_Callback, eventdata, handles)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       before navigator     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function before_Callback(hObject, eventdata, handles)
global Var Navigation
if (Var.Selected_I-1)<1
    return
else
    Var.Selected_I=Var.Selected_I-1;
    set(Navigation.select, 'String',num2str(Var.Selected_I))
    imshow(Var.Images{Var.Selected_I})
end

if Var.Fourier(Var.Selected_I)==1
    contours_plot_Callback(@contours_plot_Callback, eventdata, handles)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     Region of Interest      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function roi_Callback(hObject, eventdata, handles,typeroi)
global Var
rr=figure('Name','Selecting ROI','NumberTitle','off');
javaFrame = get(rr,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon.JPG'));
set(gcf, 'MenuBar', 'None')
imshow(Var.Images{Var.Selected_I})
[a,b,~]=size(Var.Images{Var.Selected_I});

switch typeroi
    case 1
        h = imellipse(gca, [round(b*0.25) round(a*0.25) round(b*0.5) round(a*0.5)]);
        wait(h);
        try
            bw=createMask(h);
        catch
            return
        end
    case 2
        try
            bw = roipoly;
        catch
            return
        end
    case 3
        h = imrect(gca, [round(b*0.25) round(a*0.25) round(b*0.5) round(a*0.5)]);
        wait(h);
        try
            bw=createMask(h);
        catch
            return
        end
    otherwise
        h = imfreehand;
        wait(h);
        try
            bw=createMask(h);
        catch
            return
        end
end
if ishandle(rr)
    close(rr)
else
    return
end

Var.Images{Var.Selected_I}=Var.Images{Var.Selected_I}.*bw;
imshow(Var.Images{Var.Selected_I})

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Complement color      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function complementC_Callback(hObject, eventdata, handles)
global Var 

choice = questdlg('Apply to all images?', ...
    'Complement', ...
    'Current','All','Cancel','Cancel');
% Handle response
switch choice
    case 'All'
        for i=1:Var.Number_I
            Var.Images{i}=1-Var.Images{i};
        end
    case 'Current'
        Var.Images{Var.Selected_I}=1-Var.Images{Var.Selected_I};
    case 'Cancel'
        return
end
imshow(Var.Images{Var.Selected_I})


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Untouched border      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function untouched_Callback(hObject, eventdata, handles)
global  Var

choice = questdlg('Apply to all images?', ...
    'Complement', ...
    'Current','All','Cancel','Cancel');
% Handle response
switch choice
    case 'All'
        for i=1:Var.Number_I
            Var.Images{i}=imclearborder(Var.Images{i});
        end
    case 'Current'
       Var.Images{Var.Selected_I}=imclearborder(Var.Images{Var.Selected_I});
    case 'Cancel'
        return
end
imshow(Var.Images{Var.Selected_I})


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%            OPTIMIZATION         %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function optimization_Callback(hObject, eventdata, handles)
global Var Navigation menu
Var.method=0;
Var.npart=zeros(Var.Number_I,1);
cla
Var.ene=cell(3,Var.Number_I,4);
Var.spectrum=cell(2,Var.Number_I);
Var.mini=zeros(Var.Number_I,Var.npart(Var.Selected_I));
Var.mc=cell(1,Var.Number_I);
Var.range=cell(1,Var.Number_I);
Var.peri_part=cell(1,Var.Number_I);
Var.centroid_part=cell(1,Var.Number_I);
Var.NPoints=cell(1,Var.Number_I);
for ims=1:Var.Number_I
    imshow(Var.Images{ims})
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hold on
    s  = regionprops(Var.Images{ims}, 'centroid','Extrema');
    extrema = cat(1, s.Extrema);
    left_most_top = extrema(1:8:end, :);
    [~, sort_order] = sortrows(fliplr(left_most_top));
    s2 = s(sort_order);
    Var.centroid_part{ims} = cat(1, s2.Centroid);
    Var.npart(ims)=length(s);
    ll=bwboundaries(Var.Images{ims});
    ll=ll(sort_order);
    Var.mc{ims}=zeros(Var.npart(ims),3);
    Var.range{ims}=zeros(Var.npart(ims),3,2);
    Var.NPoints{ims}=zeros(Var.npart(ims),1);
    Var.peri_part{ims}=cell(1,Var.npart(ims),3);
    Var.spectrum{1,ims}=cell(Var.npart(ims),1);
    Var.spectrum{2,ims}=cell(Var.npart(ims),1);
    for part=1:Var.npart(ims)
        %%%%%%%%%%%%%% (R, theta) Method
        [dth, rhon, fac,  Var.mini(ims,part)]=RTmethod(ll{part},Var.centroid_part{ims}(part,:),0);
             
        %%%% Analysis Fourier
        Var.NPoints{ims}(part) =length(rhon);
        rhow=fft(rhon, Var.NPoints{ims}(part));  
        rhom=abs(rhow/Var.NPoints{ims}(part));
        rhom = rhom(1:floor(Var.NPoints{ims}(part)/2));
       % Var.spectrum(1,part,ims)={rhom}; % Spectrum
        Var.spectrum{1,ims}{part}=rhom;
        sacum=cumsum(rhom);
        Var.spectrum{2,ims}{part}=sacum; 
        
        Var.mc{ims}(part,3)=ceil(0.1005*Var.NPoints{ims}(part) -0.4424);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% L method for general form
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Harmonic range to estimate of general form 
        dif=diff(sacum(1:12));
        data=[1:12;sacum(1:12)];
        %%%Removing zeros
        xr=(dif<median(dif)*.2)==1;
        data(:,xr+1)=[];
        
        %%%L method external function
        optimal_f=Lmethod(data,1);
        Var.mc{ims}(part,1)=optimal_f;
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%% L method for roundness
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%% Harmonic range to estimate of roundness
        data =Var.mc{ims}(part,1)+1:Var.mc{ims}(part,3);
        data(2,:)=sacum(Var.mc{ims}(part,1)+1:Var.mc{ims}(part,3));
        %%%L method external function
        optimal_r=Lmethod(data,0);
        Var.mc{ims}(part,2)=optimal_r;
        
        %%Harmonics Range 
        Var.range{ims}(part,1,1)=1;
        Var.range{ims}(part,1,2)=Var.mc{ims}(part,1);
        Var.range{ims}(part,2,1)=Var.mc{ims}(part,1)+1;
        Var.range{ims}(part,2,2)=Var.mc{ims}(part,2);
        Var.range{ims}(part,3,1)=Var.mc{ims}(part,2)+1;
        Var.range{ims}(part,3,2)=Var.mc{ims}(part,3);
        
        %%% Mean Energy
        Var.ene{1,ims,1}(part)=mean(rhom(Var.range{ims}(part,1,1):Var.range{ims}(part,1,2)));
        Var.ene{2,ims,1}(part)=mean(rhom(Var.range{ims}(part,2,1):Var.range{ims}(part,2,2)));
        Var.ene{3,ims,1}(part)=mean(rhom(Var.range{ims}(part,3,1):Var.range{ims}(part,3,2)));
        %%% Median Energy
        Var.ene{1,ims,2}(part)=median(rhom(Var.range{ims}(part,1,1):Var.range{ims}(part,1,2)));
        Var.ene{2,ims,2}(part)=median(rhom(Var.range{ims}(part,2,1):Var.range{ims}(part,2,2)));
        Var.ene{3,ims,2}(part)=median(rhom(Var.range{ims}(part,3,1):Var.range{ims}(part,3,2)));
        %%% Variance Energy
        Var.ene{1,ims,3}(part)=var(rhom(Var.range{ims}(part,1,1):Var.range{ims}(part,1,2)));
        Var.ene{2,ims,3}(part)=var(rhom(Var.range{ims}(part,2,1):Var.range{ims}(part,2,2)));
        Var.ene{3,ims,3}(part)=var(rhom(Var.range{ims}(part,3,1):Var.range{ims}(part,3,2)));
        %%% Sum of Harmonics
        Var.ene{1,ims,4}(part)=sum(rhom(Var.range{ims}(part,1,1):Var.range{ims}(part,1,2)));
        Var.ene{2,ims,4}(part)=sum(rhom(Var.range{ims}(part,2,1):Var.range{ims}(part,2,2)));
        Var.ene{3,ims,4}(part)=sum(rhom(Var.range{ims}(part,3,1):Var.range{ims}(part,3,2)));
        %%%%% Reconstructed Contour plot 
        for i=1:3
            har=Var.mc{ims}(part,i);
            rhom=zeros(size(rhow));
            rhom(1:har)=rhow(1:har);
            rhom(end-har+2:end)=rhow(end-har+2:end);
            P=ifft(rhom, Var.NPoints{ims}(part),'symmetric');
            P=P.*fac;
            [x,y] = pol2cart(dth,P);
            x1=x+Var.centroid_part{ims}(part,1);
            y1=y+Var.centroid_part{ims}(part,2);
            plot(x1,y1,'r','LineWidth',1,'Color',Var.Color (i,:))
            Var.peri_part{ims}{1,part,i}=x1;
            Var.peri_part{ims}{2,part,i}=y1;
        end
        %%%%% Text 
        Var.mini(Var.mini==0)=0.01;
        dd=(Var.mini(ims,part)*2)/6;
        hnd1=text(Var.centroid_part{ims}(part,1)-Var.mini(part)/3,Var.centroid_part{ims}(part,2)-Var.mini(part)/2,num2str(Var.ene{1,ims,1}(part),'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        
        hnd1=text(Var.centroid_part{ims}(part,1)-Var.mini(part)/3,Var.centroid_part{ims}(part,2)-Var.mini(part)/2+1.5*dd,num2str(Var.ene{2,ims,1}(part),'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(Var.centroid_part{ims}(part,1)-Var.mini(part)/3,Var.centroid_part{ims}(part,2)-Var.mini(part)/2+3*dd,num2str(Var.ene{3,ims,1}(part),'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
    end
    Var.Legend={'General form'; 'Roundness'; 'Roughness'};
    legend1=legend(Var.Legend{:});
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    hold off
    Var.Fourier(ims)=1;
    drawnow
    set(Navigation.select, 'String',num2str(ims))
end
Var.Selected_I=ims;
%%% Enable-Disable Menu
set(findall(menu.exp, '-property','Enable'),'Enable','on')
set(findall(menu.graph, '-property','Enable'),'Enable','on')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Linearized Constant1 Coefficients %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linearizedc_Callback(hObject, eventdata, handles)
global  Var 
Var.mc=[6 15 50];
Var.range=[3,6;7,15;16,50];
Var.Legend={'Harmonic: 3-6';'Harmonic:7-15 ';'Harmonic: 16-50'};
linearized_Analysis_Callback(@linearized_Analysis_Callback, eventdata, handles)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Linearized Constant2 Coefficients %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linearizedc2_Callback(hObject, eventdata, handles)
global  Var  
Var.mc=[2 8 34];
Var.range=[2,2;3,8;30,34];
Var.Legend={'Harmonic: 2-2';'Harmonic:3-8 ';'Harmonic: 30-34'};
linearized_Analysis_Callback(@linearized_Analysis_Callback, eventdata, handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%UIcontrols for Coefficients Set up %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linearizeds_Callback(hObject, eventdata, handles)
global   axesimage btn edit1 edit2 edit3 edit4 edit5 edit6  txt1 txt2 txt3 txt4 txt5  pos 
pos=get(axesimage,'Position');
set(axesimage,'Position',[0.2 0.1 0.8 .9])

txt1 = uicontrol('Style','text','units','normalized','Position',[0.01 0.597 .05 .02],'String','Interval 1');
txt2 = uicontrol('Style','text','units','normalized','Position',[0.01 0.559 .05 .02],'String','Interval 2');
txt3 = uicontrol('Style','text','units','normalized','Position',[0.01 0.519 .05 .02],'String','Interval 3');

txt4 = uicontrol('Style','text','units','normalized','Position',[0.07 0.63 .05 .02],'String','From');
txt5 = uicontrol('Style','text','units','normalized','Position',[0.13 0.63 .05 .02],'String','to');

edit1 = uicontrol('Style','edit','Units','normalized','Position',[0.07 0.59 .05 .03],'String','1','BackgroundColor',[1 1 1]);
edit2 = uicontrol('Style','edit','Units','normalized','Position',[0.13 0.59 .05 .03],'String','5','BackgroundColor',[1 1 1]);
edit3 = uicontrol('Style','edit','Units','normalized','Position',[0.07 0.55 .05 .03],'String','6','BackgroundColor',[1 1 1]);
edit4 = uicontrol('Style','edit','Units','normalized','Position',[0.13 0.55 .05 .03],'String','9','BackgroundColor',[1 1 1]);
edit5 = uicontrol('Style','edit','Units','normalized','Position',[0.07 0.51 .05 .03],'String','10','BackgroundColor',[1 1 1]);
edit6 = uicontrol('Style','edit','Units','normalized','Position',[0.13 0.51 .05 .03],'String','30','BackgroundColor',[1 1 1]);
btn= uicontrol('units','normalized','Style','pushbutton',...
    'String','Calculate','Position',[0.077,0.44,0.07,0.04],'Callback',{@manual_coeff_Callback,handles});


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     Set up Coefficients         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function manual_coeff_Callback(hObject, eventdata, handles)
global Var edit1 edit2 edit3 edit4 edit5 edit6  txt1 txt2 txt3 txt4 txt5 btn pos axesimage 
Var.mc=[str2num(get(edit2,'string')), str2num(get(edit4,'string')), str2num(get(edit6,'string'))];
Var.range=[str2num(get(edit1,'string')),str2num(get(edit2,'string'));str2num(get(edit3,'string')),str2num(get(edit4,'string'));str2num(get(edit5,'string')),str2num(get(edit6,'string'))];
Var.Legend={['Harmonic: ', num2str(Var.range(1,1)),'-',num2str(Var.range(1,2))];['Harmonic: ', num2str(Var.range(2,1)),'-',num2str(Var.range(2,2))];['Harmonic: ', num2str(Var.range(3,1)),'-',num2str(Var.range(3,2))]};
delete(edit1); delete(edit2); delete(edit3); delete(edit4);delete(edit5); delete(edit6);delete(txt1);delete(txt2);delete(txt3);delete(txt4);delete(txt5);delete(btn)
set(axesimage,'Position',pos)
linearized_Analysis_Callback(@linearized_Analysis_Callback, eventdata, handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%      Linearized Analysis          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linearized_Analysis_Callback(hObject, eventdata, handles)
global axesimage Var Navigation menu
Var.method=1;
Var.npart=zeros(Var.Number_I,1);
cla
set(axesimage,'Position',[0 0.05 1 .95])
Var.ene=cell(3,Var.Number_I,4);
Var.spectrum=cell(2,Var.Number_I);
Var.mini=zeros(Var.Number_I,Var.npart(Var.Selected_I));
Var.peri_part=cell(1,Var.Number_I);
Var.centroid_part=cell(1,Var.Number_I);
Var.NPoints=cell(1,Var.Number_I);
for ims=1:Var.Number_I
    imshow(Var.Images{ims})
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hold on
    s  = regionprops(Var.Images{ims}, 'centroid','Extrema');
    extrema = cat(1, s.Extrema);
    left_most_top = extrema(1:8:end, :);
    [~, sort_order] = sortrows(fliplr(left_most_top));
    s2 = s(sort_order);
    Var.centroid_part{ims} = cat(1, s2.Centroid);
    Var.npart(ims)=length(s);
    ll=bwboundaries(Var.Images{ims});
    ll=ll(sort_order);
    Var.peri_part{ims}=cell(1,Var.npart(ims),3);
    Var.NPoints{ims}=ones(Var.npart(ims),1)*512;
    Var.spectrum{1,ims}=cell(Var.npart(ims),1);
    Var.spectrum{2,ims}=cell(Var.npart(ims),1);
    for part=1:Var.npart(ims)
        
        %%%%%%%%%%%%%% (R, theta) Method
        [dth, rhon, fac,  Var.mini(ims,part)]=RTmethod(ll{part},Var.centroid_part{ims}(part,:),1);
             
        %%%% Analysis Fourier
        Pyy=fft(rhon, Var.NPoints{ims}(part));  
        Pyyr=abs(Pyy/Var.NPoints{ims}(part));
        Pyyr = Pyyr(1:Var.NPoints{ims}(part)/2);
        Var.spectrum{1,ims}{part}=Pyyr; % Spectrum
        spl=Var.Coef_lin.*Pyyr;
        Var.spectrum{2,ims}{part}=spl;% Linearized spectrum
        %%% Mean Energy
        Var.ene{1,ims,1}(part)=mean(spl(Var.range(1,1):Var.range(1,2)));
        Var.ene{2,ims,1}(part)=mean(spl(Var.range(2,1):Var.range(2,2)));
        Var.ene{3,ims,1}(part)=mean(spl(Var.range(3,1):Var.range(3,2)));
        %%% Median Energy
        Var.ene{1,ims,2}(part)=median(spl(Var.range(1,1):Var.range(1,2)));
        Var.ene{2,ims,2}(part)=median(spl(Var.range(2,1):Var.range(2,2)));
        Var.ene{3,ims,2}(part)=median(spl(Var.range(3,1):Var.range(3,2)));
        %%% Variance Energy
        Var.ene{1,ims,3}(part)=var(spl(Var.range(1,1):Var.range(1,2)));
        Var.ene{2,ims,3}(part)=var(spl(Var.range(2,1):Var.range(2,2)));
        Var.ene{3,ims,3}(part)=var(spl(Var.range(3,1):Var.range(3,2)));
         %%% Sum of Harmonics
        Var.ene{1,ims,4}(part)=sum(spl(Var.range(1,1):Var.range(1,2)));
        Var.ene{2,ims,4}(part)=sum(spl(Var.range(2,1):Var.range(2,2)));
        Var.ene{3,ims,4}(part)=sum(spl(Var.range(3,1):Var.range(3,2)));
        
        %%%%% Reconstructed Contour plot 
        for i=1:3
            har=Var.mc(i);
            Pyyr=zeros(size(Pyy));
            Pyyr(1:har)=Pyy(1:har);
            Pyyr(end-har+2:end)=Pyy(end-har+2:end);
            P=ifft(Pyyr, Var.NPoints{ims}(part),'symmetric');
            P=P.*fac;
            [x,y] = pol2cart(dth,P);
            x1=x+Var.centroid_part{ims}(part,1);
            y1=y+Var.centroid_part{ims}(part,2);
            plot(x1,y1,'r','LineWidth',1,'Color',Var.Color (i,:))
            Var.peri_part{ims}{1,part,i}=x1;
            Var.peri_part{ims}{2,part,i}=y1;
        end
        %%%%% Text 
        Var.mini(Var.mini==0)=0.01;
        dd=(Var.mini(ims,part)*2)/6;
        hnd1=text(Var.centroid_part{ims}(part,1)-Var.mini(part)/3,Var.centroid_part{ims}(part,2)-Var.mini(part)/2,num2str(Var.ene{1,ims,1}(part),'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        
        hnd1=text(Var.centroid_part{ims}(part,1)-Var.mini(part)/3,Var.centroid_part{ims}(part,2)-Var.mini(part)/2+1.5*dd,num2str(Var.ene{2,ims,1}(part),'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(Var.centroid_part{ims}(part,1)-Var.mini(part)/3,Var.centroid_part{ims}(part,2)-Var.mini(part)/2+3*dd,num2str(Var.ene{3,ims,1}(part),'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
    end
    
    legend1=legend(Var.Legend{:});
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    hold off
    Var.Fourier(ims)=1;
    drawnow
    set(Navigation.select, 'String',num2str(ims))
end
Var.Selected_I=ims;
%%% Enable-Disable Menu
set(findall(menu.exp, '-property','Enable'),'Enable','on')
set(findall(menu.graph, '-property','Enable'),'Enable','on')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%    Spectrums Stats Export        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%MEAN%%%%%%%%%

function spectrums_export_Callback(hObject, eventdata, handles)
global  Var
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',Var.Path);
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
catch
    [fileexport,pathexport]=uiputfile('*.txt');
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
end
fileID = fopen(pathexport,'w');
fprintf(fileID, ['Fourier Analysis ', date,'']);
for ii=1:Var.Number_I
    fprintf(fileID, '\n\n');
    
    if Var.method==1
        fprintf(fileID, [Var.File{ii}]);
        fprintf(fileID, '\n');
        fprintf(fileID, 'Normalized Spectrum \n');
        fprintf(fileID, 'Harmonic\t');
        fprintf(fileID, '%d\t',1:size(cell2mat(Var.spectrum{1,ii}(:)),2));
        for i=1:size(Var.spectrum{1,ii},1)
            fprintf(fileID, '\n');
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            fprintf(fileID,'%5.7f\t',cell2mat(Var.spectrum{1,ii}(i)));
        end
        
        fprintf(fileID, '\n');
        fprintf(fileID, 'Linearized Spectrum  \n');
        fprintf(fileID, 'Harmonic\t');
        fprintf(fileID, '%d\t',1:size(cell2mat(Var.spectrum{1,ii}(:)),2));
        
        for i=1:size(Var.spectrum{1,ii},1)
            fprintf(fileID, '\n');
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            fprintf(fileID,'%5.7f\t',cell2mat(Var.spectrum{2,ii}(i)));
        end
        
    else
        fprintf(fileID, [Var.File{ii}]);
        fprintf(fileID, '\n');
        fprintf(fileID, 'Normalized Spectrum \n');
        
        for i=1:size(Var.spectrum{1,ii},1)
            fprintf(fileID, 'Harmonic\t');
            fprintf(fileID, '%d\t',1:size(cell2mat(Var.spectrum{1,ii}(i)),2));
            fprintf(fileID, '\n');
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            fprintf(fileID,'%5.7f\t',cell2mat(Var.spectrum{1,ii}(i)));
            fprintf(fileID, '\n');
        end
        
        fprintf(fileID, '\n');
        fprintf(fileID, 'Cumulative Spectrum  \n');
        
        for i=1:size(Var.spectrum{2,ii},1)
            fprintf(fileID, 'Harmonic\t');
            fprintf(fileID, '%d\t',1:size(cell2mat(Var.spectrum{2,ii}(i)),2));
            fprintf(fileID, '\n');
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            fprintf(fileID,'%5.7f\t',cell2mat(Var.spectrum{2,ii}(i)));
            fprintf(fileID, '\n');
        end
        
    end 
    
end


fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Range Stats Export          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function range_stats_export_Callback(hObject, eventdata, handles)
global  Var
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',Var.Path);
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
catch
    [fileexport,pathexport]=uiputfile('*.txt');
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
end
fileID = fopen(pathexport,'w');
fprintf(fileID, ['Fourier Analysis ', date,'\n']);
fprintf(fileID, 'Normalized Spectrum ');
for ii=1:Var.Number_I
    fprintf(fileID, '\n\n');
    fprintf(fileID, [Var.File{ii}]);
    fprintf(fileID, '\n\t');
    for i=1:size(Var.spectrum{1,ii},1)
        fprintf(fileID, ['Part' num2str(i) '\t ']);
    end
    
    if Var.method==1
        for ri=1:3
            if ri==1
                fprintf(fileID,['\nRange General form(',num2str(Var.range(ri,1)),'-',num2str(Var.range(ri,2)),')\n']);
            elseif ri==2
                fprintf(fileID,['\nRange Roundness(',num2str(Var.range(ri,1)),'-',num2str(Var.range(ri,2)),')\n']);
            else
                fprintf(fileID,['\nRange Roughness(',num2str(Var.range(ri,1)),'-',num2str(Var.range(ri,2)),')\n']);
            end
            mean_s=Var.ene{ri,ii,1}(:);
            fprintf(fileID, 'Mean: \t');
            fprintf(fileID, '%7.8f\t',mean_s);
            median_s=Var.ene{ri,ii,2}(:);
            fprintf(fileID, '\nMedian:\t');
            fprintf(fileID, '%7.8f\t',median_s);
            var_s=Var.ene{ri,ii,3}(:);
            fprintf(fileID, '\nVariance:\t');
            fprintf(fileID, '%7.8f\t',var_s);
            sum_s=Var.ene{ri,ii,4}(:);
            fprintf(fileID, '\nSum:\t');
            fprintf(fileID, '%7.8f\t',sum_s);
            fprintf(fileID, '\n');
        end
    else
        for ri=1:3
            if ri==1
            fprintf(fileID,'\nRange General form\t');
            elseif ri==2
              fprintf(fileID,'\nRange Roundness\t');  
            else
              fprintf(fileID,'\nRange Roughness\t');  
            end

            for j=1:size(Var.spectrum{1,ii},1)
                if ri==1
                    fprintf(fileID,[num2str(Var.range{ii}(j,1,1)),' to',num2str(Var.range{ii}(j,1,2)),'\t']);
                elseif ri==2
                     fprintf(fileID,[num2str(Var.range{ii}(j,2,1)),' to ',num2str(Var.range{ii}(j,2,2)),'\t']);
                else
                    fprintf(fileID,[num2str(Var.range{ii}(j,3,1)),' to ',num2str(Var.range{ii}(j,3,2)),'\t']);
                end
            end
            mean_s=Var.ene{ri,ii,1}(:);
            fprintf(fileID, '\nMean: \t');
            fprintf(fileID, '%7.8f\t',mean_s);
            median_s=Var.ene{ri,ii,2}(:);
            fprintf(fileID, '\nMedian:\t');
            fprintf(fileID, '%7.8f\t',median_s);
            var_s=Var.ene{ri,ii,3}(:);
            fprintf(fileID, '\nVariance:\t');
            fprintf(fileID, '%7.8f\t',var_s);
            sum_s=Var.ene{ri,ii,4}(:);
            fprintf(fileID, '\nSum:\t');
            fprintf(fileID, '%7.8f\t',sum_s);
            fprintf(fileID, '\n');
        end
 
    end
    
    fprintf(fileID, '\n');
    
    
end


fclose(fileID);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Export labels image         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function labels_image_export_Callback(hObject, eventdata, handles)
global Var

try
    pathexport=uigetdir({'*.jpg'},'Save Image',Var.Path);
    if isnumeric(pathexport)
        return
    end
catch
    pathexport=uigetdir('*.jpg');
    if isnumeric(pathexport)
        return
    end
end
for ims=1:Var.Number_I
    imgOut=Var.Images{ims}*255;
    cen=Var.centroid_part{ims};
    imgOut = insertInImage(uint8(imgOut), @()text(cen(:,1),cen(:,2), num2str([1:Var.npart(ims)]')),...
            {'fontweight','bold','color','w','fontsize',26,...
            'linewidth',3,'margin',5,'edgecolor',[1 0 0],'backgroundcolor',[0.05 0.05 0.05]});
    k = strfind(Var.File{ims},'.');
    imwrite(imgOut,[pathexport,'\',Var.File{ims}(1:k-1),'_Label.jpg']);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          Form   graphs            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function form_graphs_Callback(hObject, eventdata, handles)
global Var

%%% Mean of sum of each image  
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{1,i,4});
std_t(i)=std(Var.ene{1,i,4});
end
title_g={'Mean of the sum of the images', 'Harmonics range of form'};
figure_graph_plot(mean_t,std_t,title_g)

%%% Mean of mean of each image  
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{1,i,1});
std_t(i)=std(Var.ene{1,i,1});
end
title_g={'Mean of the mean of the images', 'Harmonics range of form'};
figure_graph_plot(mean_t,std_t,title_g)

%%% Mean of median of each image   
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{1,i,2});
std_t(i)=std(Var.ene{1,i,2});
end
title_g={'Mean of the median of the images', 'Harmonics range of form'};
figure_graph_plot(mean_t,std_t,title_g)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Roundness graphs            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function roundness_graphs_Callback(hObject, eventdata, handles)
global Var

%%% Mean of sum of each image  
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{2,i,4});
std_t(i)=std(Var.ene{2,i,4});
end
title_g={'Mean of the sum of the images', 'Harmonics range of roundness'};
figure_graph_plot(mean_t,std_t,title_g)


%%% Mean of mean of each image  
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{2,i,1});
std_t(i)=std(Var.ene{2,i,1});
end
title_g={'Mean of the mean of the images', 'Harmonics range of roundness'};
figure_graph_plot(mean_t,std_t,title_g)

%%% Mean of median of each image   
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{2,i,2});
std_t(i)=std(Var.ene{2,i,2});
end
title_g={'Mean of the median of the images', 'Harmonics range of roundness'};
figure_graph_plot(mean_t,std_t,title_g)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Roughness  graphs           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function roughness_graphs_Callback(hObject, eventdata, handles)
global Var

%%% Mean of sum of each image  
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{3,i,4});
std_t(i)=std(Var.ene{3,i,4});
end
title_g={'Mean of the sum of the images', 'Harmonics range of roughnness'};
figure_graph_plot(mean_t,std_t,title_g)

%%% Mean of mean of each image  
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{3,i,1});
std_t(i)=std(Var.ene{3,i,1});
end
title_g={'Mean of the mean of the images', 'Harmonics range of roughnness'};
figure_graph_plot(mean_t,std_t,title_g)

%%% Mean of median of each image   
mean_t=zeros(1,Var.Number_I);
std_t=mean_t;
for i=1:Var.Number_I
mean_t(i)=mean(Var.ene{3,i,2});
std_t(i)=std(Var.ene{3,i,2});
end
title_g={'Mean of the median of the images', 'Harmonics range of roughnness'};
figure_graph_plot(mean_t,std_t,title_g)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           contours  plot          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function contours_plot_Callback(hObject, eventdata, handles)
global Var
hold on
for part=1:Var.npart(Var.Selected_I)
    for i=1:3 %%%% plot General, Roundness and Roughness contours
        xt=Var.peri_part{Var.Selected_I}{1,part,i};
        yt=Var.peri_part{Var.Selected_I}{2,part,i};
        plot(xt,yt,'r','LineWidth',1,'Color',Var.Color (i,:))
    end
     cx= Var.centroid_part{Var.Selected_I}(part,1);
    cy=Var.centroid_part{Var.Selected_I}(part,2);    Var.mini(Var.mini==0)=0.01;
    dd=(Var.mini(Var.Selected_I,part)*2)/6;
    hnd1=text(cx-Var.mini(part)/3,cy-Var.mini(part)/2,num2str(Var.ene{1,Var.Selected_I,1}(part),'%6.3f'));
    set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
    
    
    hnd1=text(cx-Var.mini(part)/3,cy-Var.mini(part)/2+1.5*dd,num2str(Var.ene{2,Var.Selected_I,1}(part),'%6.3f'));
    set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
    
    hnd1=text(cx-Var.mini(part)/3,cy-Var.mini(part)/2+3*dd,num2str(Var.ene{3,Var.Selected_I,1}(part),'%6.3f'));
    set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
    
end
legend1=legend(Var.Legend{:});
set(legend1,...
    'Position',[0.85 0.85 0.067 0.099]);
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         figure for graph          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function figure_graph_plot(mean_t,std_t,title_g)
global Var
figure1=figure('Color',[1 1 1]);
    axes1 = axes('Parent',figure1,'YGrid','on','XGrid','on','FontWeight','bold',...
    'FontSize',11);
    box(axes1,'on');
    hold(axes1,'all');
errorbar(mean_t,std_t,'-o','MarkerSize',7,...
    'MarkerEdgeColor','red','MarkerFaceColor','red')
xlim([0,Var.Number_I+1])
set(gca,'xtick',1:Var.Number_I,'xticklabel',Var.File)
title(title_g)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Help and about us         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function user_guide_Callback(hObject, eventdata, handles)
web('http://pds.uaz.edu.mx/descargas','-new','-notoolbar')
function aboutus_Callback(hObject, eventdata, handles)
web('http://www.laima-uaslp.org/researchers.html','-new','-notoolbar')
web('http://pds.uaz.edu.mx/investigadores','-new','-notoolbar')
function colaboration_Callback(hObject, eventdata, handles)
web('http://www.laima-uaslp.org/contact.html','-new','-notoolbar')
web('http://pds.uaz.edu.mx/investigadores','-new','-notoolbar')
function license_Callback(hObject, eventdata, handles)
web('http://pds.uaz.edu.mx/documents/384402/0/License.pdf/9988d2b6-dff5-305d-c4da-e9a3885a5a7b','-new','-notoolbar')
