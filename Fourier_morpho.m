function varargout = Fourier_morpho(varargin)
% FOURIER_MORPHO MATLAB code for Fourier_morpho.fig
%      FOURIER_MORPHO, by itself, creates a new FOURIER_MORPHO or raises the existing
%      singleton*.
%
%      H = FOURIER_MORPHO returns the handle to a new FOURIER_MORPHO or the handle to
%      the existing singleton*.
%
%      FOURIER_MORPHO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER_MORPHO.M with the given input arguments.
%
%      FOURIER_MORPHO('Property','Value',...) creates a new FOURIER_MORPHO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fourier_morpho_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fourier_morpho_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fourier_morpho

% Last Modified by GUIDE v2.5 29-Oct-2018 17:45:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fourier_morpho_OpeningFcn, ...
                   'gui_OutputFcn',  @Fourier_morpho_OutputFcn, ...
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

% --- Executes just before Fourier_morpho is made visible.
function Fourier_morpho_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fourier_morpho (see VARARGIN)

% Choose default command line output for Fourier_morpho
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fourier_morpho wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global sel axesimage menu next before select fou ck colo
colo(1,:)=[1 0 0];
colo(2,:)=[0 1 0];
colo(3,:)=[0 0 1];
fou={};
sel=1;
ck=[4.758e-06,-0.002496,0.3281,23.14,-162.2];
x=1:256;
ck=ck(1).*x.^4 + ck(2).*x.^3 + ck(3).*x.^2 + ck(4).*x + ck(5);
ck(1:6)=[0.9344  128.6399 12.7616   22.7793   37.1182   54.1751];
% UIWAIT makes ImageS wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%%%%%%%%%%%%%%%%%%%%%Menu File %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mf = uimenu(hObject,'Label','Open','ForegroundColor',[0 0 0]); 

opsi = uimenu(mf,'Label','Single image',...
    'Callback',{@loadsingleimage_Callback,handles});

opmi = uimenu(mf,'Label','Multiple images',...
    'Callback',{@loadmultipleimages_Callback,handles});


%%%%%%%%%%%%%%%%%%%%%Menu setup %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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




%%%%%%%%%%%%%%%%%%%%%Menu Fourier Analysis%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.ms = uimenu(hObject,'Label','Fourier','ForegroundColor',[0 0 0]);
menu.linearizedc = uimenu(menu.ms ,'Label','Linearized Ms3_6 Mr7_15 Mt16_50 Coefficients',...
    'Enable','off','Callback',{@linearizedc_Callback,handles});
menu.linearizedv  = uimenu(menu.ms ,'Label','Linearized Ms2 Mr3_8 Mt30_34 Coefficients',...
    'Enable','off','Callback',{@linearizedc2_Callback,handles});
menu.normalizedc = uimenu(menu.ms ,'Label','Linearized Set Coefficients',...
    'Enable','off','Callback',{@linearizeds_Callback,handles});
menu.Optimization = uimenu(menu.ms ,'Label','Optimization',...
    'Enable','off','Callback',{@optimization_Callback,handles});
%

%menu.normalizedv = uimenu(menu.ms ,'Label','Normalized Set Coefficients',...
%     'Enable','off','Callback',{@normalizedv_Callback,handles});


%%%%%%%%%%%%%%%%%%%%%Export Results%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
menu.exp = uimenu(hObject,'Label','Export','ForegroundColor',[0 0 0]);
menu.all = uimenu(menu.exp,'Label','Export All',...
     'Enable','off','Callback',{@eall_Callback,handles});
menu.sheet = uimenu(menu.exp,'Label','Export Spreadsheet',...
     'Enable','off','Callback',{@esheet_Callback,handles});
menu.image = uimenu(menu.exp,'Label','Export Images',...
     'Enable','off','Callback',{@eimages_Callback,handles});
menu.graph = uimenu(menu.exp,'Label','Export Graph',...
     'Enable','off','Callback',{@egraph_Callback,handles});
 
 %%%%%%%%%%%%%%%%%%%%%STATISTICS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 menu.statistics = uimenu(hObject,'Label','Statistics','ForegroundColor',[0 0 0]);
 menu.mean = uimenu(menu.statistics,'Label','Mean',...
     'Enable','off','Callback',{@emean_Callback,handles});
menu.median = uimenu(menu.statistics,'Label','Median',...
     'Enable','off','Callback',{@emedian_Callback,handles});
menu.variance = uimenu(menu.statistics,'Label','Variance',...
     'Enable','off','Callback',{@evariance_Callback,handles});
menu.std = uimenu(menu.statistics,'Label','Standard deviation',...
     'Enable','off','Callback',{@estd_Callback,handles});
 
 
 
%%%%%%%%%%%%%%%%%%%%%Menu help%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
help = uimenu(hObject,'Label','Help','ForegroundColor',[0 0 0]);
menu.doc = uimenu(help,'Label','Documentation',...
    'Callback',{@documentation_Callback,handles});
menu.aboutus = uimenu(help,'Label','About us',...
    'Callback',{@webpage_Callback,handles});
menu.colaboration = uimenu(help,'Label','Colaboration',...
    'Callback',{@colaboration_Callback,handles});
menu.version = uimenu(help,'Label','License software',...
    'Callback',{@license_Callback,handles},'Separator','on');

%%%%%%%%%%%%%%%%%%%%%AXES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
axesimage = axes('units','normalized', ...
    'position',[0 0 1 1]);
axis(axesimage,'off')

%%%%%%%%%%%%%%%%%%%%%AXES%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
before= uicontrol('units','normalized','Style','pushbutton',...
             'String','<','Position',[0.425,0,0.05,0.03],'visible','off','CallBack', {@beforeb_Callback,handles});
         
select= uicontrol('units','normalized','Style','edit',...
             'String','1','Position',[0.475,0,0.05,0.028],'visible','off','Enable','off');  
         
next= uicontrol('units','normalized','Style','pushbutton',...
             'String','>','Position',[0.525,0,0.05,0.03],'visible','off','Callback',{@nextb_Callback,handles});
       
% --- Outputs from this function are returned to the command line.
function varargout = Fourier_morpho_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Load single image     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loadsingleimage_Callback(hObject, eventdata, handles)
global I ni ims filename st pathname fou axesimage menu next before select maskroi mask comp untouch btn txt1 txt2 txt3 txt4 txt5 edit1 edit2 edit3 edit4 edit5 edit6   
try
    [filenamet, pathnamet, ~] = uigetfile('*.*', ...
        'Load image',pathname);
    if ~isnumeric(pathnamet)
        pathname=pathnamet;
        filename=filenamet;
    else
        return
    end
catch
    [filenamet, pathnamet, ~] = uigetfile('*.*', ...
        'Load image');
    if ~isnumeric(pathnamet)
        pathname=pathnamet;
        filename=filenamet;
    else
        return
    end
end

filename={filename};
ni=1;
ims=1;
I=imread([pathname, filename{ims}]);
if size(I,3)>3
    I=I(:,:,1:3);
end
if ~islogical(I)
I=im2bw(I);
end
cla
set(axesimage,'Position',[0 0 1 1])
set(next, 'Visible','off')
set(before, 'Visible','off')
set(select, 'Visible','off')
hold off
imshow(I)
set(findall(menu.setup, '-property','Enable'),'Enable','on')
set(findall(menu.ms, '-property','Enable'),'Enable','on')
set(findall(menu.exp, '-property','Enable'),'Enable','off')
set(findall(menu.statistics, '-property','Enable'),'Enable','off')
maskroi={};
mask={};
comp={};
untouch={};
fou{1}=0;
st = 1;
try
delete(edit1, edit2, edit3, edit4, edit5, edit6, txt1, txt2, txt3, txt4, txt5, btn)
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Load mutiple images     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loadmultipleimages_Callback(hObject, eventdata, handles)
global I ni ims st filename pathname fou axesimage menu next before select maskroi mask comp untouch edit1 edit2 edit3 edit4 edit5 edit6  txt1 txt2 txt3 txt4 txt5  btn
try
    [filenamet, pathnamet, ~] = uigetfile('*.*', ...
        'Load images', ...
        'MultiSelect', 'on',pathname);
    if ~isnumeric(pathnamet)
        pathname=pathnamet;
        filename=filenamet;
    else
        return
    end
catch
    [filenamet, pathnamet, ~] = uigetfile('*.*', ...
        'Load images', ...
        'MultiSelect', 'on');
    if ~isnumeric(pathnamet)
        pathname=pathnamet;
        filename=filenamet;
    else
        return
    end
end
if iscell(filename)
    ni=length(filename);
   cla
    set(axesimage,'Position',[0 0.05 1 .95])
    set(next, 'Visible','on')
    set(before, 'Visible','on')
    set(select, 'Visible','on')
   
else
    ni=1;
    filename={filename};
end

ims=1;
I=imread([pathname, filename{ims}]);
if size(I,3)>3
    I=I(:,:,1:3);
end
if ~islogical(I)
I=im2bw(I);
end
hold off
imshow(I)
set(findall(menu.setup, '-property','Enable'),'Enable','on')
set(findall(menu.ms, '-property','Enable'),'Enable','on')
set(findall(menu.exp, '-property','Enable'),'Enable','off')
set(findall(menu.statistics, '-property','Enable'),'Enable','off')
set(before,'Position',[0.425,0,0.05,0.03]);
set(select,'Position',[0.475,0,0.05,0.028]);     
set(next,'Position',[0.525,0,0.05,0.03]);
maskroi={};
mask={};
comp={};
untouch={};
for i=1:ni
fou(i)={0};
st = 2;
end
set(select, 'String',num2str(ims))
try
delete(edit1, edit2, edit3, edit4, edit5, edit6, txt1, txt2, txt3, txt4, txt5, btn)
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       next navigator     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function nextb_Callback(hObject, eventdata, handles)
global I maskroi ni ene1 ims filename pathname ene xra yra fou colo centx centy ps select mask comp untouch mini axesimage rango
if (ims+1)>ni
    return
else
    ims=ims+1;
    set(select, 'String',num2str(ims))
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        imshow(I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)));
    catch
        imshow(I)
    end
    
    
end
if fou{ims}==1
    hold on
    for part=1:ps(ims)
        for i=1:3
            xt=xra{part,i,ims}; xt=xt{:};
            yt=yra{part,i,ims}; yt=yt{:};
            plot(xt,yt,'r','LineWidth',1,'Color',colo(i,:))
        end
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
       % hnd1=text(cx,cy,{num2str(part)});
        mini(mini==0)=0.01;
        dd=(mini(ims,part)*2)/6;
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        

        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
        
%         hnd1=text(cx,cy,ene(part,1:3,ims));
%         set(hnd1,'FontSize',10,'Color',[0 1 0])
    end
%     
 legend1=legend(['Harmonics:' num2str(rango(1,1)), ' to ',num2str(rango(2,1))],...
                   ['Harmonics:' num2str(rango(1,2)), ' to ',num2str(rango(2,2))],...
                   ['Harmonics:' num2str(rango(1,3)), ' to ',num2str(rango(2,3))]);
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
     hold off
     
else
     hold on
    for part=1:ps(ims)
        for i=1:2
            xt=xra{part,i,ims}; xt=xt{:};
            yt=yra{part,i,ims}; yt=yt{:};
            plot(xt,yt,'r','LineWidth',1,'Color',colo(i,:))
        end
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
       % hnd1=text(cx,cy,{num2str(part)});
        mini(mini==0)=0.01;
        dd=(mini(ims,part)*2)/6;
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
      %  set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        

%         hnd1=text(cx-mini(part)/3,cy-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
%         set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
%         hnd1=text(cx-mini(part)/3,cy-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
%         set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
        
%         hnd1=text(cx,cy,ene(part,1:3,ims));
%         set(hnd1,'FontSize',10,'Color',[0 1 0])
    end
%  if fou{ims}==1    
%  legend1=legend(['Harmonics:' num2str(rango(1,1)), ' to ',num2str(rango(2,1))],...
%                    ['Harmonics:' num2str(rango(1,2)), ' to ',num2str(rango(2,2))],...
%                    ['Harmonics:' num2str(rango(1,3)), ' to ',num2str(rango(2,3))]);
%     set(legend1,...
%         'Position',[0.85 0.85 0.067 0.099]);
%      hold off
%  else
%      legend1=legend(['Roundness:' ],...
%                    ['Form:'])
%                 
%     set(legend1,...
%         'Position',[0.85 0.85 0.067 0.099]);
%      hold off
%  end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       before navigator     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function beforeb_Callback(hObject, eventdata, handles)
global I  ims filename pathname xra yra fou colo centx centy ps  select maskroi mask comp untouch ene mini axesimage rango
if (ims-1)<1
    return
else
    ims=ims-1;
    set(select, 'String',num2str(ims))
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        imshow(I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)));
    catch
        imshow(I)
    end
end
if fou{ims}==1
    hold on
    for part=1:ps(ims)
        for i=1:3
            xt=xra{part,i,ims}; xt=xt{:};
            yt=yra{part,i,ims}; yt=yt{:};
            plot(xt,yt,'r','LineWidth',1,'Color',colo(i,:))
        end
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
       % hnd1=text(cx,cy,{num2str(part)});
        mini(mini==0)=0.01;
        dd=(mini(ims,part)*2)/6;
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        

        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
        
%         hnd1=text(cx,cy,ene(part,1:3,ims));
%         set(hnd1,'FontSize',10,'Color',[0 1 0])
    end

 legend1=legend(['Harmonics:' num2str(rango(1,1)), ' to ',num2str(rango(2,1))],...
                   ['Harmonics:' num2str(rango(1,2)), ' to ',num2str(rango(2,2))],...
                   ['Harmonics:' num2str(rango(1,3)), ' to ',num2str(rango(2,3))]);
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
 hold off
else  
    hold on
    for part=1:ps(ims)
        for i=1:2
            xt=xra{part,i,ims}; xt=xt{:};
            yt=yra{part,i,ims}; yt=yt{:};
            plot(xt,yt,'r','LineWidth',1,'Color',colo(i,:))
        end
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
       % hnd1=text(cx,cy,{num2str(part)});
        mini(mini==0)=0.01;
        dd=(mini(ims,part)*2)/6;

        hnd1=text(cx-mini(part)/3,cy-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        %set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
         legend1=legend(['Roundness:' ],...
                   ['Form:'])
                
%     set(legend1,...
%         'Position',[0.85 0.85 0.067 0.099]);
%      hold off
        
% 
%         hnd1=text(cx-mini(part)/3,cy-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
%         set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
%         hnd1=text(cx-mini(part)/3,cy-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
%         set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
        
%         hnd1=text(cx,cy,ene(part,1:3,ims));
%         set(hnd1,'FontSize',10,'Color',[0 1 0])
    end
 if fou{ims}==1    
 legend1=legend(['Harmonics:' num2str(rango(1,1)), ' to ',num2str(rango(2,1))],...
                   ['Harmonics:' num2str(rango(1,2)), ' to ',num2str(rango(2,2))],...
                   ['Harmonics:' num2str(rango(1,3)), ' to ',num2str(rango(2,3))]);
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
     hold off
 else
     legend1=legend(['Roundness:' ],...
                   ['Form:'])
                
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
     hold off
 end
    
end%-- 09/12/2018 09:02 p. m. --%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%     Region of Interest      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function roi_Callback(hObject, eventdata, handles,typeroi)
global maskroi mask I  ims comp pathname filename untouch
rr=figure('Name','Selecting ROI','NumberTitle','off');
javaFrame = get(rr,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon.JPG'));
set(gcf, 'MenuBar', 'None')
 I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
try
    if comp{ims}
        I=imcomplement(I);
    end
catch
try
    if untouch{ims}
        I=imclearborder(I(2:end-2,2:end-2,:));
    end
catch
    
end    
end
imshow(I)
[a,b,~]=size(I);

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
mask{ims}=bw;
new=regionprops(bw,'BoundingBox');
maskroi{ims}=new.BoundingBox;
r=round(maskroi{ims});
temp=mask{ims};
imshow(I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Complement color      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function complementC_Callback(hObject, eventdata, handles)
global I ims  maskroi mask comp ni pathname filename untouch
 I=imread([pathname, filename{ims}]);
     if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
choice = questdlg('Apply to all images?', ...
    'Complement', ...
    'Current','All','Cancel','Cancel');
% Handle response
switch choice
    case 'All'
        for i=1:ni
            try
             comp{i} = 1-comp{i};
             if isempty(comp{i})
                 comp{i}=1;
             end
            catch
             comp{i} = 1;   
            end
        end
    case 'Current'
        try
        comp{ims} = 1-comp{ims};
        if isempty(comp{ims})
                 comp{ims}=1;
        end
        catch
        comp{ims} = 1; 
        end
    case 'Cancel'
        return
end
try
    if comp{ims}
        I=imcomplement(I);
    end
catch
    
end
try
    if untouch{ims}
        I=imclearborder(I(2:end-2,2:end-2,:));
    end
catch
    
end
try
    r=round(maskroi{ims});
    temp=mask{ims};
    imshow(I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)));
catch
    imshow(I)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Untouched border      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function untouched_Callback(hObject, eventdata, handles)
global I ims maskroi mask comp untouch ni pathname filename
 I=imread([pathname, filename{ims}]);
     if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
choice = questdlg('Apply to all images?', ...
    'Complement', ...
    'Current','All','Cancel','Cancel');
% Handle response
switch choice
    case 'All'
        for i=1:ni
            try
             untouch{i} = 1-untouch{i};
             if isempty(untouch{i})
                 untouch{i}=1;
             end
            catch
             untouch{i} = 1;   
            end
        end
    case 'Current'
        try
        untouch{ims} = 1-untouch{ims};
        if isempty(untouch{ims})
                 untouch{ims}=1;
        end
        catch
        untouch{ims} = 1; 
        end
    case 'Cancel'
        return
end
try
    if comp{ims}
        I=imcomplement(I);
    end
catch
    
end


try
    r=round(maskroi{ims});
    temp=mask{ims};
    imshow(I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)));
    I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
catch
    imshow(I)
end

try
    if untouch{ims}
        I=imclearborder(I(2:end-2,2:end-2,:));
    end
    imshow(I)
catch
    imshow(I)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Linearized Constant1 Coefficients %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linearizedc_Callback(hObject, eventdata, handles)
global I ims espectrump ck xra yra fou colo centx next before centy ps maskroi mask comp untouch ni pathname filename select ene edit1 edit2 edit3 edit4 edit5 edit6  txt1 txt2 txt3 txt4 txt5 btn menu ran mini axesimage rango spectrum espectrum
ps=zeros(ni,1);
try
    delete(edit1, edit2, edit3, edit4, edit5, edit6, txt1, txt2, txt3, txt4, txt5, btn)
catch
end
set(findall(menu.linearizedc, '-property','Enable'),'Enable','off')
set(findall(menu.linearizedv, '-property','Enable'),'Enable','on')
set(findall(menu.normalizedc, '-property','Enable'),'Enable','on')
set(next, 'Position',[0.525,0,0.05,0.03])
set(before, 'Position',[0.425,0,0.05,0.03])
set(select, 'Position',[0.475,0,0.05,0.028])
if ni==1
    set(axesimage,'Position',[0 0 1 1])
else
    set(axesimage,'Position',[0 0.05 1 .95])
end

ene=cell(1,3,ni);
spectrum=cell(2,ni);
espectrum=cell(2,1,ni);
espectrump = cell(1,1,ni);
NbPoints =512;
ran=[6 15 50];
rango(1:2,1)=[3,6];
rango(1:2,2)=[7,15];

rango(1:2,3)=[16,50];
mini=zeros(ni,ps(ims));

for ims=1:ni
    spectrum(1,ims)={zeros(1,256)};
    spectrum(2,ims)={zeros(1,256)};
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
        I=im2bw(I);
        imshow(I);
    catch
        imshow(I)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hold on
    %     stats = regionprops(I,'PixelIdxList');
    s  = regionprops(I, 'centroid','Extrema');% s  = regionprops(I, 'centroid');
    extrema = cat(1, s.Extrema);
    left_most_top = extrema(1:8:end, :);
    [~, sort_order] = sortrows(fliplr(left_most_top));
    s2 = s(sort_order);
    centroids = cat(1, s2.Centroid);
    ps(ims)=length(s);
    ll=bwboundaries(I);
    ll=ll(sort_order);
    for part=1:ps(ims)
        l=ll{part};
        l(:,2)=l(:,2)-centroids(part,1);
        l(:,1)=l(:,1)-centroids(part,2);
        
        [theta,rho] = cart2pol(l(:,2),l(:,1));
        mini(ims,part)=min(rho);  %%% mini = numero de imagenes  %% ims = numero de imagen %% part = numero de particula
        
        %%%%%%%promedio%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [thetap,ia,~] = unique(theta,'stable');
        rhop=rho(ia);
        facp=max(rhop);
        rhop=rhop/facp;
        [thetap,ind]=sort(thetap);
        rhop=rhop(ind);
        if thetap(end)<=3.14159
            thetap(end+1)=pi;
            rhop(end+1)=mean([rhop(end) rhop(1)]);
        end
        NbPonitsp = 512;
        theta3p=(-pi+2*pi/(NbPonitsp)): 2*pi/(NbPonitsp):pi;
        rhoip=interp1(thetap,rhop, theta3p,'linear', 'extrap');
        Pyyp=fft(rhoip, NbPonitsp);
        espectrump(1,part,ims)= {abs(Pyyp)};
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        
        
        
        np=length(l);
        
        if np>512
            dth=linspace(-pi,pi,np);%%%%% Muestreo lineal
            rhon=zeros(size(dth));
            
            %%%% filtro%%%%%%%%%%%
            for j=1:np
                resta=abs(theta-dth(j));
                [~,kl]=min(resta);
                resta(kl)=100;
                [~,kl2]=min(resta);
                resta(kl2)=100;
                [~,kl3]=min(resta);
                rhon(j)=mean([rho(kl),rho(kl2),rho(kl3)]);
            end
            fac=max(rhon);
            rhon=rhon/max(rhon);
        else
            rhon=rhoip;
            dth=theta3p;
            fac=facp;
        end
        %%%normalizacion%%%
        
        
        
        %%%%determina si la señal es pa o impar, si es impar le quita el ultimo
        %%%%elemento
        p2=length(rhon);
        if mod(p2,2)
            p2=p2-1;
            rhon(end)=[];
            dth(end)=[];
        end
        Fs2 = p2;                           % Sampling frequency
        NF=Fs2;                          % points to FFT
        NbPoints = NF;
        Pyyr=fft(rhon,NbPoints)/length(rhon);
        Pyy=fft(rhon, NbPoints);
        Pyy2=abs(Pyyr);
        Pyy2(isnan(Pyy2))=0;
        Pyy2 = Pyy2(1:256);
        temp=spectrum{1,ims};
        spectrum(1,ims)={temp+Pyy2};
        espectrum(1,part,ims)={Pyy2};
        spl=ck.*Pyy2;
        temp=spectrum{2,ims};
        spectrum(2,ims)={temp+spl};
        espectrum(2,part,ims)={spl};
        %axes(axesimage)
        ene(part,1,ims)={mean(spl(3:6))};
        ene(part,2,ims)={mean(spl(7:15))};
        ene(part,3,ims)={mean(spl(16:50))};
        centx{part,ims}={centroids(part,1)}; centy{part,ims}={centroids(part,2)};
        
        %         n_ent = length(dth);
        %         dth = interp1( 1:n_ent, dth, linspace(1, n_ent, NbPoints) );
        for i=1:3
            har=ran(i);
            Pyy2=zeros(size(Pyy));
            Pyy2(1:har)=Pyy(1:har);
            Pyy2(end-har+2:end)=Pyy(end-har+2:end);
            P=ifft(Pyy2, NbPoints,'symmetric');
            P=P.*fac;
            [x,y] = pol2cart(dth,P);
            x1=x+centroids(part,1);
            y1=y+centroids(part,2);
            plot(x1,y1,'r','LineWidth',1,'Color',colo(i,:))
            xra{part,i,ims}={x1}; yra{part,i,ims}={y1};
        end
        %hnd1=text(centroids(part,1),centroids(part,2),{num2str(part)});
        mini(mini==0)=0.01;
        dd=(mini(ims,part)*2)/6;
        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        
        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
    end
    spectrum(1,ims)={spectrum{1,ims}/part};
    spectrum(2,ims)={spectrum{2,ims}/part};
    legend1=legend('Harmonic: 3-6','Harmonic:7-15 ','Harmonic: 16-50');
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    hold off
    fou(ims)={1};
    drawnow
end
set(select, 'String',num2str(ims))
set(findall(menu.exp, '-property','Enable'),'Enable','on')
set(findall(menu.statistics, '-property','Enable'),'Enable','on')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Linearized Constant2 Coefficients %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linearizedc2_Callback(hObject, eventdata, handles)
global I ims espectrum  espectrump ck xra yra fou colo centx centy ps maskroi mask before next comp untouch ni pathname filename select menu ene edit1 edit2 edit3 edit4 edit5 edit6  txt1 txt2 txt3 txt4 txt5 btn ran mini axesimage rango  spectrum 

%%%Ps = numero de particulas que contiene cada imagen
%%% ni = numero de imagenes 
%%%% ims = imagen que se esta analizando
%%% mini = minimo de rho de cada particula

ps=zeros(ni,1);
set(findall(menu.linearizedc, '-property','Enable'),'Enable','on')
set(findall(menu.linearizedv, '-property','Enable'),'Enable','off')
set(findall(menu.normalizedc, '-property','Enable'),'Enable','on')
try
delete(edit1, edit2, edit3, edit4, edit5, edit6, txt1, txt2, txt3, txt4, txt5, btn)
catch
end
ran=[2 8 34]; 
rango(1:2,1)=[2,2]; 
rango(1:2,2)=[3,8]; 
rango(1:2,3)=[30,34];  
ene=cell(1,3,ni);
NbPoints=512;
set(next, 'Position',[0.525,0,0.05,0.03])
set(before, 'Position',[0.425,0,0.05,0.03])
set(select, 'Position',[0.475,0,0.05,0.028])
if ni==1
set(axesimage,'Position',[0 0 1 1])
else
set(axesimage,'Position',[0 0.05 1 .95])
end
mini=zeros(ni,ps(ims));
spectrum=cell(2,ni);   %%% crea cell de 2 elementos uno para guardar la fft normal y otro la fft multiplicado por un factor
espectrum=cell(2,1,ni);
espectrump =cell(1,1,ni);
for ims=1:ni
    spectrum(1,ims)={zeros(1,256)};
    spectrum(2,ims)={zeros(1,256)};
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
        I=im2bw(I);
        imshow(I);
    catch
        imshow(I)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     hold on
    s  = regionprops(I, 'centroid','Extrema');% s  = regionprops(I, 'centroid');
    extrema = cat(1, s.Extrema);
    left_most_top = extrema(1:8:end, :);
    [~, sort_order] = sortrows(fliplr(left_most_top));
    s2 = s(sort_order);
    centroids = cat(1, s2.Centroid);
    ps(ims)=length(s);
    ll=bwboundaries(I);
    ll=ll(sort_order);
    for part=1:ps(ims)
        l=ll{part};
        l(:,2)=l(:,2)-centroids(part,1);
        l(:,1)=l(:,1)-centroids(part,2);
        [theta,rho] = cart2pol(l(:,2),l(:,1));
        mini(ims,part)=min(rho);
        
        
        %%%%%% promedio
        
          [thetap,ia,~] = unique(theta,'stable');
        rhop=rho(ia);
        facp=max(rhop);
        rhop=rhop/facp;
        [thetap,ind]=sort(thetap);
        rhop=rhop(ind);
        if thetap(end)<=3.14159
            thetap(end+1)=pi;
            rhop(end+1)=mean([rhop(end) rhop(1)]);
        end
        NbPonitsp = 512;
        theta3p=(-pi+2*pi/(NbPonitsp)): 2*pi/(NbPonitsp):pi;
        rhoip=interp1(thetap,rhop, theta3p,'linear', 'extrap');
        Pyyp=fft(rhoip, NbPonitsp);
        espectrump(1,part,ims)= {abs(Pyyp)};
        
        
        
        %%%%%%%%%%%%%%
        
        
        
        
        
         np=length(l);
         if np>512
            dth=linspace(-pi,pi,np);%%%%% Muestreo lineal
            rhon=zeros(size(dth));
            
            %%%% filtro%%%%%%%%%%%
            for j=1:np
                resta=abs(theta-dth(j));
                [~,kl]=min(resta);
                resta(kl)=100;
                [~,kl2]=min(resta);
                resta(kl2)=100;
                [~,kl3]=min(resta);
                rhon(j)=mean([rho(kl),rho(kl2),rho(kl3)]);
            end
            fac=max(rhon);
            rhon=rhon/max(rhon);
            
        else
            rhon=rhoip;
            dth=theta3p;
            fac=facp;
        end
         
    
     
    
    %%%%determina si la señal es pa o impar, si es impar le quita el ultimo
    %%%%elemento
    p2=length(rhon);
    if mod(p2,2)
        p2=p2-1;
        rhon(end)=[];
        dth(end)=[];
    end
    Fs2 = p2;                           % Sampling frequency
    NF=Fs2;                          % points to FFT
    NbPoints = NF;   
         Pyyr=fft(rhon,NbPoints)/length(rhon);
         Pyy=fft(rhon, NbPoints);
        
        Pyy2=abs(Pyyr);
        Pyy2(isnan(Pyy2))=0;
        Pyy2 = Pyy2(1:256);
        temp=spectrum{1,ims};
        spectrum(1,ims)={temp+Pyy2};
        espectrum(1,part,ims)= {Pyy2};
        spl=ck.*Pyy2; 
        temp=spectrum{2,ims};
        spectrum(2,ims)={temp+spl};
        espectrum (2,part,ims) = {spl};
        %axes(axesimage)        
        ene(part,1,ims)={mean(spl(2))}; 
        ene(part,2,ims)={mean(spl(3:8))};
        ene(part,3,ims)={mean(spl(30:34))};
        centx{part,ims}={centroids(part,1)}; centy{part,ims}={centroids(part,2)};
        for i=1:3
            har=ran(i);
            Pyy2=zeros(size(Pyy));
            Pyy2(1:har)=Pyy(1:har);
            Pyy2(end-har+2:end)=Pyy(end-har+2:end);
            P=ifft(Pyy2, NbPoints, 'symmetric');
            P=P.*fac;
            [x,y] = pol2cart(dth,P);
            x1=x+centroids(part,1);
            y1=y+centroids(part,2);
            plot(x1,y1,'r','LineWidth',1,'Color',colo(i,:))
            xra{part,i,ims}={x1}; yra{part,i,ims}={y1};
        end
        mini(mini==0)=0.01;      
        dd=(mini(ims,part)*2)/6;
        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        

        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
    end
    spectrum(1,ims)={spectrum{1,ims}/part};
    spectrum(2,ims)={spectrum{2,ims}/part};
    legend1=legend('Harmonic: 2','Harmonic:3-8 ','Harmonic: 30-34');
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    hold off
fou(ims)={1};
drawnow 
end
set(select, 'String',num2str(ims))
set(findall(menu.exp, '-property','Enable'),'Enable','on')
set(findall(menu.statistics, '-property','Enable'),'Enable','on')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Linearized set Coefficients     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function linearizeds_Callback(hObject, eventdata, handles)
global next before ni select axesimage btn edit1 edit2 edit3 edit4 edit5 edit6 rango txt1 txt2 txt3 txt4 txt5  menu

set(axesimage,'Position',[0.2 0.1 0.8 .9])
set(findall(menu.linearizedc, '-property','Enable'),'Enable','on')
set(findall(menu.linearizedv, '-property','Enable'),'Enable','on')
set(findall(menu.normalizedc, '-property','Enable'),'Enable','off')
set(findall(menu.Optimization, '-property','Enable'),'Enable','on')

txt1 = uicontrol('Style','text','units','normalized','Position',[0.01 0.597 .05 .02],'String','Interval 1');
txt2 = uicontrol('Style','text','units','normalized','Position',[0.01 0.559 .05 .02],'String','Interval 2');    
txt3 = uicontrol('Style','text','units','normalized','Position',[0.01 0.519 .05 .02],'String','Interval 3');  
    
txt4 = uicontrol('Style','text','units','normalized','Position',[0.07 0.63 .05 .02],'String','From');  
txt5 = uicontrol('Style','text','units','normalized','Position',[0.13 0.63 .05 .02],'String','to');

edit1 = uicontrol('Style','edit','Units','normalized','Position',[0.07 0.59 .05 .03],'CallBack',{@calledit1_Callback,handles},'String','1','BackgroundColor',[1 1 1]);
edit2 = uicontrol('Style','edit','Units','normalized','Position',[0.13 0.59 .05 .03],'CallBack',{@calledit2_Callback,handles},'String','5','BackgroundColor',[1 1 1]);
edit3 = uicontrol('Style','edit','Units','normalized','Position',[0.07 0.55 .05 .03],'CallBack',{@calledit3_Callback,handles},'String','6','BackgroundColor',[1 1 1]);
edit4 = uicontrol('Style','edit','Units','normalized','Position',[0.13 0.55 .05 .03],'CallBack',{@calledit4_Callback,handles},'String','9','BackgroundColor',[1 1 1]);
edit5 = uicontrol('Style','edit','Units','normalized','Position',[0.07 0.51 .05 .03],'CallBack',{@calledit5_Callback,handles},'String','10','BackgroundColor',[1 1 1]);
edit6 = uicontrol('Style','edit','Units','normalized','Position',[0.13 0.51 .05 .03],'CallBack',{@calledit6_Callback,handles},'String','30','BackgroundColor',[1 1 1]);
btn= uicontrol('units','normalized','Style','pushbutton',...
             'String','Calculate','Position',[0.077,0.44,0.07,0.04],'Callback',{@calcu_Callback,handles});
         
rango(1:2,1)=[1,5]; 
rango(1:2,2)=[6,9]; 
rango(1:2,3)=[10,30];         
if ni==1
set(next, 'Visible','off')
set(before, 'Visible','off')
set(select, 'Visible','off')       

else 
set(next, 'Position',[0.135,0.4,0.05,0.03])
set(before, 'Position',[0.035,0.4,0.05,0.03])
set(select, 'Position',[0.085,0.4,0.05,0.028])      

end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   Linearized set Coefficients 2   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function calcu_Callback(hObject, eventdata, handles)
global I ims espectrum espectrump ck xra yra fou colo centx centy ps maskroi mask comp untouch ni pathname filename select ene menu ran mini rango spectrum
ran=[rango(2,1), rango(2,2), rango(2,3)];         
ps=zeros(ni,1);
ene=cell(1,3,ni);
spectrum=cell(2,ni);
espectrum=cell(2,1,ni);
espectrump= cell(1,1,ni);
NbPoints=512; 
mini=zeros(ni,ps(ims));
for ims=1:ni
    spectrum(1,ims)={zeros(1,256)};
    spectrum(2,ims)={zeros(1,256)};
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
        I=im2bw(I);
        imshow(I);
    catch
        imshow(I)
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    hold on
    s  = regionprops(I, 'centroid','Extrema');% s  = regionprops(I, 'centroid');
    extrema = cat(1, s.Extrema);
    left_most_top = extrema(1:8:end, :);
    [~, sort_order] = sortrows(fliplr(left_most_top));
    s2 = s(sort_order);
    centroids = cat(1, s2.Centroid);
    ps(ims)=length(s);
    ll=bwboundaries(I);
    ll=ll(sort_order);
    for part=1:ps(ims)
        l=ll{part};
        l(:,2)=l(:,2)-centroids(part,1);
        l(:,1)=l(:,1)-centroids(part,2);
        [theta,rho] = cart2pol(l(:,2),l(:,1));
        [theta,ia,~] = unique(theta,'stable');
         mini(ims,part)=min(rho);
         
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 %%%%%% promedio
        
          [thetap,ia,~] = unique(theta,'stable');
        rhop=rho(ia);
        facp=max(rhop);
        rhop=rhop/facp;
        [thetap,ind]=sort(thetap);
        rhop=rhop(ind);
        if thetap(end)<=3.14159
            thetap(end+1)=pi;
            rhop(end+1)=mean([rhop(end) rhop(1)]);
        end
        NbPonitsp = 512;
        theta3p=(-pi+2*pi/(NbPonitsp)): 2*pi/(NbPonitsp):pi;
        rhoip=interp1(thetap,rhop, theta3p,'linear', 'extrap');
        Pyyp=fft(rhoip, NbPonitsp);
        espectrump(1,part,ims)= {abs(Pyyp)};
        
        
        
        %%%%%%%%%%%%%%
         
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         
         
         
         np=length(l);
         if np>512
            dth=linspace(-pi,pi,np);%%%%% Muestreo lineal
            rhon=zeros(size(dth));
            
            %%%% filtro%%%%%%%%%%%
            for j=1:np
                resta=abs(theta-dth(j));
                [~,kl]=min(resta);
                resta(kl)=100;
                [~,kl2]=min(resta);
                resta(kl2)=100;
                [~,kl3]=min(resta);
                rhon(j)=mean([rho(kl),rho(kl2),rho(kl3)]);
            end
            fac=max(rhon);
            rhon=rhon/max(rhon);
        else
            rhon=rhoip;
            dth=theta3p;
            fac=facp;
        end
         
     
    
    %%%%determina si la señal es pa o impar, si es impar le quita el ultimo
    %%%%elemento
    p2=length(rhon);
    if mod(p2,2)
        p2=p2-1;
        rhon(end)=[];
        dth(end)=[];
    end
    Fs2 = p2;                           % Sampling frequency
    NF=Fs2;                          % points to FFT
      NbPoints = NF;   
         Pyyr=fft(rhon,NbPoints)/length(rhon);
         Pyy=fft(rhon, NbPoints);
        
        Pyy2=abs(Pyyr);
        Pyy2(isnan(Pyy2))=0;
        Pyy2 = Pyy2(1:256);
        temp=spectrum{1,ims};
        spectrum(1,ims)={temp+Pyy2};
        espectrum(1,part,ims)= {Pyy2};
        spl=ck.*Pyy2; 
        temp=spectrum{2,ims};
        spectrum(2,ims)={temp+spl};
        espectrum (2,part,ims) = {spl};
        %axes(axesimage)
        ene(part,1,ims)={mean(spl(rango(1,1):rango(2,1)))}; 
        ene(part,2,ims)={mean(spl(rango(1,2):rango(2,2)))};
        ene(part,3,ims)={mean(spl(rango(1,3):rango(2,3)))};
        centx{part,ims}={centroids(part,1)}; centy{part,ims}={centroids(part,2)};
        for i=1:3
            har=ran(i);
            Pyy2=zeros(size(Pyy));
            Pyy2(1:har)=Pyy(1:har);
            Pyy2(end-har+2:end)=Pyy(end-har+2:end);
            P=ifft(Pyy2, NbPoints);
            P=P.*fac;
            [x,y] = pol2cart(dth,P);
            x1=x+centroids(part,1);
            y1=y+centroids(part,2);
            plot(x1,y1,'r','LineWidth',1,'Color',colo(i,:))
            xra{part,i,ims}={x1}; yra{part,i,ims}={y1};
        end
        mini(mini==0)=0.01;      
        dd=(mini(ims,part)*2)/6;
        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        

        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(centroids(part,1)-mini(part)/3,centroids(part,2)-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
    end
    spectrum(1,ims)={spectrum{1,ims}/part};
    spectrum(2,ims)={spectrum{2,ims}/part};
    legend1=legend(['Harmonic: 1-' num2str( ran(1))],['Harmonic:' num2str( ran(1)+1),'-',num2str( ran(2))],['Harmonic:' num2str( ran(2)+1),'-',num2str( ran(3))]);
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    hold off
fou(ims)={1};
drawnow 
end
set(select, 'String',num2str(ims))
set(findall(menu.exp, '-property','Enable'),'Enable','on')
set(findall(menu.statistics, '-property','Enable'),'Enable','on')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%           Export images           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function eimages_Callback(hObject, eventdata, handles)
global I ims xra yra fou colo centx centy ps maskroi mask comp untouch ni pathname filename ene rango mini

try
    [fileexport,pathexport]=uiputfile({'*.tiff'},'Save Image',pathname);
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
catch
    [fileexport,pathexport]=uiputfile('*.tiff');
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
end

for ims=1:ni
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    h=figure;
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
        I=im2bw(I);
        imshow(I);
    catch
        imshow(I)
    end
    
    hold on
    for part=1:ps(ims)
      if fou{ims}==1
        for i=1:3
            xt=xra{part,i,ims}; xt=xt{:};
            yt=yra{part,i,ims}; yt=yt{:};
            plot(xt,yt,'r','LineWidth',0.1,'Color',colo(i,:))
        end
        
      else 
            for i=1:2
            xt=xra{part,i,ims}; xt=xt{:};
            yt=yra{part,i,ims}; yt=yt{:};
            plot(xt,yt,'r','LineWidth',0.1,'Color',colo(i,:))
            end
      end
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
        %hnd1=text(cx,cy,ene(part,1:3,ims));
        mini(mini==0)=0.01;
        dd=(mini(ims,part)*2)/6;
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        

        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        if fou{ims}==1
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
        end
    end
    if fou{ims}==1
     legend1=legend(['Harmonics:' num2str(rango(1,1)), ' to ',num2str(rango(2,1))],...
                   ['Harmonics:' num2str(rango(1,2)), ' to ',num2str(rango(2,2))],...
                   ['Harmonics:' num2str(rango(1,3)), ' to ',num2str(rango(2,3))]);
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    else
    legend1=legend(['Roundness'],...
                   ['Form:']);
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    end
       % 'Position',[0.85 0.85 0.067 0.099]);
    set(h, 'Position', get(0,'Screensize')); % Maximize figure.
    print(h,[pathexport(1:end-5),num2str(ims),pathexport(end-4:end)],'-dtiff','-r600');
    close(h)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Export spreadsheet          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function esheet_Callback(hObject, eventdata, handles)
global I ims np fou centx centy ps maskroi mask comp untouch ni pathname filename ene rango espectrum
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',pathname);
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
fprintf(fileID, ['Fourier Analysis ', date,'  \n \n']);
%ene(part,1:3,ims)
if fou{ims}==1
for ii=1:ni
    fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:size(ene,1)
        if ~isempty (ene{i,1,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
        end
    end
    fprintf(fileID, '\n');
    fprintf(fileID, [num2str(rango(1,1)), ' to ',num2str(rango(2,1)), '\t ']);
    for i=1:size(ene,1)
        fprintf(fileID, [num2str(ene{i,1,ii}) '\t' ]);
    end
    
    fprintf(fileID, '\n');
    fprintf(fileID, [num2str(rango(1,2)), ' to ',num2str(rango(2,2)), '\t ']);
    for i=1:size(ene,1)
        fprintf(fileID, [num2str(ene{i,2,ii}) '\t' ]);
    end
    
        fprintf(fileID, '\n');
    fprintf(fileID, [num2str(rango(1,3)), ' to ',num2str(rango(2,3)), '\t ']);
    for i=1:size(ene,1)
        fprintf(fileID, [num2str(ene{i,3,ii}) '\t' ]);
    end
    
    fprintf(fileID, '\n');  
    fprintf(fileID, '\n');  

end

for ii=1:ni
    fprintf(fileID, '\n');
     fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Linearized Spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:256
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrum,2) %%%%%%%%%%%%%%exporta linearizado%%%%%%%%%%%%%%%%
        if ~isempty (espectrum{2,i,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            l=(espectrum{2,i,ii});
            for oi=1:256
            fprintf(fileID, [num2str(l(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  

end
for ii=1:ni
    fprintf(fileID, '\n');
    fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Normalized Spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:256
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrum,2)
        if ~isempty (espectrum{1,i,ii}) %%%%%%exporta  normalizado%%%%%
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            l=(espectrum{1,i,ii});
            for oi=1:256
            fprintf(fileID, [num2str(l(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  

end


else %%% exporta datos de optimizacion%%%
    for ii=1:ni
        fprintf(fileID, '\n');
         fprintf(fileID, [filename{ii} '\t \t']);
        fprintf(fileID, '\n');
        fprintf(fileID, 'Fourier Spectrum:\n');
        fprintf(fileID, 'Harmonics:\t');
         for i=1:np
         fprintf(fileID, [num2str(i),'\t']);
          end
        fprintf(fileID, '\n');

        for i=1:size(espectrum,2)
            if ~isempty (espectrum{1,i,ii})
                fprintf(fileID, ['Part' num2str(i) '\t ']);
                l=(espectrum{1,i,ii});
                r = length(l);
                for oi=1:r
                fprintf(fileID, [num2str(l(oi)) '\t']);
                end
                 fprintf(fileID, '\n');
            end
        end    
        fprintf(fileID, '\n');
        fprintf(fileID, '\n');  
    end
for ii=1:ni
    fprintf(fileID, '\n');
    fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Cumulated Spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:np
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrum,2)
        if ~isempty (espectrum{2,i,ii}) %%%%%%exporta  normalizado%%%%%
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            l=(espectrum{2,i,ii});
             r = length(l);
            for oi=1:r
            fprintf(fileID, [num2str(l(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  

end    

    
end


fclose(fileID);


for ims=1:ni
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    h=figure;
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
        I=im2bw(I);
        imshow(I);
    catch
        imshow(I)
    end
    
    hold on
    for part=1:ps(ims)
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
        hnd1=text(cx,cy,num2str(part));
        set(hnd1,'FontSize',12,'Color',[0 1 0])
    end
    
    set(h, 'Position', get(0,'Screensize')); % Maximize figure.
    print(h,[pathexport(1:end-4),num2str(ims),'_label','.tiff'],'-dtiff','-r200');
   close(h)
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%             Export All            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function eall_Callback(hObject, eventdata, handles)
global I ims xra  fou yra np colo centx centy ps maskroi mask comp untouch ni pathname filename ene  rango mini spectrum espectrum
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',pathname);
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
fprintf(fileID, ['Fourier Analysis ', date,'  \n \n']);
if fou{ims}==1
for ii=1:ni
    fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Mean of Linearized Spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:size(ene,1)
        if ~isempty (ene{i,1,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
        end
    end
    fprintf(fileID, '\n');
    fprintf(fileID, [num2str(rango(1,1)), ' to ',num2str(rango(2,1)), '\t ']);
    for i=1:size(ene,1)
        fprintf(fileID, [num2str(ene{i,1,ii}) '\t' ]);
    end
    
    fprintf(fileID, '\n');
    fprintf(fileID, [num2str(rango(1,2)), ' to ',num2str(rango(2,2)), '\t ']);
    for i=1:size(ene,1)
        fprintf(fileID, [num2str(ene{i,2,ii}) '\t' ]);
    end
    
        fprintf(fileID, '\n');
    fprintf(fileID, [num2str(rango(1,3)), ' to ',num2str(rango(2,3)), '\t ']);
    for i=1:size(ene,1)
        fprintf(fileID, [num2str(ene{i,3,ii}) '\t' ]);
    end
    
    fprintf(fileID, '\n');  
    fprintf(fileID, '\n');  

end
for ii=1:ni
    fprintf(fileID, '\n');
     fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Linearized Spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:256
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrum,2)
        if ~isempty (espectrum{2,i,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            l=(espectrum{2,i,ii});
            for oi=1:256
            fprintf(fileID, [num2str(l(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  

end
for ii=1:ni
    fprintf(fileID, '\n');
    fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Normalized Spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:256
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrum,2)
        if ~isempty (espectrum{1,i,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            l=(espectrum{1,i,ii});
            for oi=1:256
            fprintf(fileID, [num2str(l(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  

end
else
   for ii=1:ni
        fprintf(fileID, '\n');
         fprintf(fileID, [filename{ii} '\t \t']);
        fprintf(fileID, '\n');
        fprintf(fileID, 'Fourier Spectrum:\n');
        fprintf(fileID, 'Harmonics:\t');
         for i=1:np
         fprintf(fileID, [num2str(i),'\t']);
          end
        fprintf(fileID, '\n');

        for i=1:size(espectrum,2)
            if ~isempty (espectrum{1,i,ii})
                fprintf(fileID, ['Part' num2str(i) '\t ']);
                l=(espectrum{1,i,ii});
                r = length(l);
                for oi=1:r
                fprintf(fileID, [num2str(l(oi)) '\t']);
                end
                 fprintf(fileID, '\n');
            end
        end    
        fprintf(fileID, '\n');
        fprintf(fileID, '\n');  
    end
for ii=1:ni
    fprintf(fileID, '\n');
    fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Cumulated Spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:np
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrum,2)
        if ~isempty (espectrum{2,i,ii}) %%%%%%exporta  normalizado%%%%%
            fprintf(fileID, ['Part' num2str(i) '\t ']);
            l=(espectrum{2,i,ii});
             r = length(l);
            for oi=1:r
            fprintf(fileID, [num2str(l(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  

end    
      
end

fclose(fileID);

for ims=1:ni
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    h=figure;
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
        I=im2bw(I);
        imshow(I);
    catch
        imshow(I)
    end
    
    hold on
    for part=1:ps(ims)
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
        hnd1=text(cx,cy,num2str(part));
        set(hnd1,'FontSize',12,'Color',[0 1 0])
    end
    %set(h, 'Position', get(0,'Screensize')); % Maximize figure.
    ax = gca;
    outerpos = get(ax,'OuterPosition');
    ti = get(ax,'TightInset');
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    set(ax,'Position', [left bottom ax_width ax_height]);
    print(h,[pathexport(1:end-4),num2str(ims),'_label','.tiff'],'-dtiff','-r200');
    close(h)
    h=figure;
    imshow(I)
    hold on
    %%% imprime set1
    for part=1:ps(ims)
        for i=1:3
            xt=xra{part,i,ims}; xt=xt{:};
            yt=yra{part,i,ims}; yt=yt{:};
            plot(xt,yt,'r','LineWidth',0.1,'Color',colo(i,:))
        end
        cx=centx{part,ims}; cx=cx{:}; cy=centy{part,ims}; cy=cy{:};
        mini(mini==0)=0.01;
        dd=(mini(ims,part)*2)/6;
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2,num2str(ene{part,1,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[1 0 0])
        

        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+1.5*dd,num2str(ene{part,2,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 1 0])
        
        hnd1=text(cx-mini(part)/3,cy-mini(part)/2+3*dd,num2str(ene{part,3,ims},'%6.3f'));
        set(hnd1,'FontUnits','pixels','FontSize',dd*.35,'Color',[0 0 1])
    end
    legend1=legend(['Harmonics:' num2str(rango(1,1)), ' to ',num2str(rango(2,1))],...
                   ['Harmonics:' num2str(rango(1,2)), ' to ',num2str(rango(2,2))],...
                   ['Harmonics:' num2str(rango(1,3)), ' to ',num2str(rango(2,3))]);
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
    %set(h, 'Position', get(0,'Screensize')); % Maximize figure.
    ax = gca;
    outerpos = get(ax,'OuterPosition');
    ti = get(ax,'TightInset');
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    set(ax,'Position', [left bottom ax_width ax_height]);
    print(h,[pathexport(1:end-4),num2str(ims),'.tiff'],'-dtiff','-r300');
    close(h) 
end

figure1 = figure('Color',[1 1 1]);
axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',12);
%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0 256]);
box(axes1,'on');
% hold(axes1,'all');
set(figure1, 'Position', get(0,'Screensize'));
for i=1:ni
    plot(spectrum{1,i},'LineWidth',2);
        title(['Normalized',sprintf('\n'),'Single-Side Mean of all particles Amplitude Spectrum of X(t)'],...
    'FontWeight','bold',...
    'FontSize',12); 
    % Maximize figure.
    l=filename{i};
    k = strfind(l,'.');
    print(figure1,[pathexport(1:end-4),'_N_',l(1:k-1),'.tiff'],'-dtiff','-r200');
end
for i=1:ni
    plot(spectrum{2,i},'LineWidth',2);
        title(['Linearized',sprintf('\n'),'Single-Side Mean of all particles Amplitude Spectrum of X(t)'],...
    'FontWeight','bold',...
    'FontSize',12); 
    % Maximize figure.
    l=filename{i};
    k = strfind(l,'.');
    print(figure1,[pathexport(1:end-4),'_L_',l(1:k-1),'.tiff'],'-dtiff','-r200');
end
close(figure1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Export Graph         %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function egraph_Callback(hObject, eventdata, handles)
global spectrum ni pathname filename
try
    [fileexport,pathexport]=uiputfile({'*.tiff'},'Save Graph',pathname);
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
catch
    [fileexport,pathexport]=uiputfile('*.tiff');
    if isnumeric(pathexport)
        return
    else
        pathexport=[pathexport fileexport];
    end
end

figure1 = figure('Color',[1 1 1]);
% Create axes
axes1 = axes('Parent',figure1,'FontWeight','bold','FontSize',12);
%% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[0 256]);
box(axes1,'on');
% hold(axes1,'all');

set(figure1, 'Position', get(0,'Screensize'));
for i=1:ni
    plot(spectrum{1,i},'LineWidth',2);
        title(['Normalized',sprintf('\n'),'Single-Side Mean Amplitude Spectrum of X(t)'],...
    'FontWeight','bold',...
    'FontSize',12); 
    % Maximize figure.
    l=filename{i};
    k = strfind(l,'.');
    print(figure1,[pathexport(1:end-5),'_N_',l(1:k-1),pathexport(end-4:end)],'-dtiff','-r100');
end
for i=1:ni
    plot(spectrum{2,i},'LineWidth',2);
        title(['Linearized',sprintf('\n'),'Single-Side Mean Amplitude Spectrum of X(t)'],...
    'FontWeight','bold',...
    'FontSize',12); 
    % Maximize figure.
    l=filename{i};
    k = strfind(l,'.');
    print(figure1,[pathexport(1:end-5),'_L_',l(1:k-1),pathexport(end-4:end)],'-dtiff','-r100');
end
close(figure1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         OPTIMIZATION     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function optimization_Callback(hObject, eventdata, handles)
global  I ims espectrum  espectrump np ck xra ene1 yra fou colo centx centy ps maskroi mask before next comp untouch ni pathname filename select menu ene edit1 edit2 edit3 edit4 edit5 edit6  txt1 txt2 txt3 txt4 txt5 btn ran mini axesimage rango  spectrum 
ps=zeros(ni,1);
set(findall(menu.linearizedc, '-property','Enable'),'Enable','on')
set(findall(menu.linearizedv, '-property','Enable'),'Enable','on')
set(findall(menu.normalizedc, '-property','Enable'),'Enable','on')
set(findall(menu.Optimization, '-property','Enable'),'Enable','off')
ene=cell(2,1,ni);
ene1=cell(1,2,ni);
try
delete(edit1, edit2, edit3, edit4, edit5, edit6, txt1, txt2, txt3, txt4, txt5, btn)
catch
end
set(next, 'Position',[0.525,0,0.05,0.03])
set(before, 'Position',[0.425,0,0.05,0.03])
set(select, 'Position',[0.475,0,0.05,0.028])
if ni==1
set(axesimage,'Position',[0 0 1 1])
else
set(axesimage,'Position',[0 0.05 1 .95])
end
mini=zeros(ni,ps(ims));
spectrum=cell(2,ni);
espectrum=cell(2,1,ni);
espectrump=cell(1,1,ni)
colo=lines(3);

for ims=1:ni
%     spectrum(1,ims)={zeros(1,256)};
%     spectrum(2,ims)={zeros(1,256)};
    I=imread([pathname, filename{ims}]);
    if size(I,3)>3
        I=I(:,:,1:3);
    end
    if ~islogical(I)
        I=im2bw(I);
    end
    try
        if comp{ims}
            I=imcomplement(I);
        end
    catch
        
    end
    
    try
        if untouch{ims}
            I=imclearborder(I(2:end-2,2:end-2,:));
        end
    catch
        
    end
    
    try
        r=round(maskroi{ims});
        temp=mask{ims};
        I=I(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3)).*temp(r(2):r(2)-1+r(4),r(1):r(1)-1+r(3));
        I=im2bw(I);
        imshow(I);
    catch
        imshow(I)
    end
     hold on
    s  = regionprops(I, 'centroid','Extrema');% s  = regionprops(I, 'centroid');
    extrema = cat(1, s.Extrema);
    left_most_top = extrema(1:8:end, :);
    [~, sort_order] = sortrows(fliplr(left_most_top));
    s2 = s(sort_order);
    centroids = cat(1, s2.Centroid);
    ps(ims)=length(s);
    ll=bwboundaries(I);
    ll=ll(sort_order);
    for part=1:ps(ims)
        l=ll{part};
        l(:,2)=l(:,2)-centroids(part,1);
        l(:,1)=l(:,1)-centroids(part,2);
        [theta,rho] = cart2pol(l(:,2),l(:,1));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         np=length(l);
        dth=linspace(-pi,pi,np);%%%%% Muestreo lineal
        rhon=zeros(size(dth));
    
     mini(ims,part)=min(rhon);
       [thetap,ia,~] = unique(theta,'stable');
        rhop=rho(ia);
        facp=max(rhop);
        rhop=rhop/facp;
        [thetap,ind]=sort(thetap);
        rhop=rhop(ind);
        if thetap(end)<=3.14159
            thetap(end+1)=pi;
            rhop(end+1)=mean([rhop(end) rhop(1)]);
        end
        NbPonitsp = 512;
        theta3p=(-pi+2*pi/(NbPonitsp)): 2*pi/(NbPonitsp):pi;
        rhoip=interp1(thetap,rhop, theta3p,'linear', 'extrap');
        Pyyp=fft(rhoip, NbPonitsp);
        espectrump(1,part,ims)= {Pyyp};
        
     
     
     
     
    %%%% filtro%%%%%%%%%%%
    for j=1:np
        resta=abs(theta-dth(j));
        [~,kl]=min(resta);
        resta(kl)=100;
        [~,kl2]=min(resta);
        resta(kl2)=100;
        [~,kl3]=min(resta);
        rhon(j)=mean([rho(kl),rho(kl2),rho(kl3)]);
    end
    
    
    %%%normalizacion%%%
    fac=max(rhon);
    rhon=rhon/max(rhon);
     
    
    %%%%determina si la señal es pa o impar, si es impar le quita el ultimo
    %%%%elemento
  
    p2=length(rhon);
    if mod(p2,2)
        p2=p2-1;
        rhon(end)=[];
        dth(end)=[];
    end
    Fs2 = p2;                           % Sampling frequency
    NF=Fs2;                          % points to FFT
    

   
 
  %%% Pyyr se utiliza para la transformada de Fourier
    Pyyr=fft(rhon,NF)/length(rhon);
    Pyy=abs(Pyyr); %%%% Se utliza para calcular el acumulado
    Pyyr=fft(rhon,NF);
    %     figure
    %     plot(f(1:end),2*abs(Pyy(1:NbPoints/2+1)))
    Pyy=Pyy(1:p2/2+1); %%%% toma la mitad de los coeficientes de la FFT
    Pyy=Pyy/sum(Pyy);
    np = length(Pyy);
    spectrum(1,ims)={zeros(1,length(Pyy))};
    spectrum(2,ims)={zeros(1,length(Pyy))};
     
     centx{part,ims}={centroids(part,1)}; centy{part,ims}={centroids(part,2)};
    %%% calcula acumulado%%%%%%%%%
    facum=zeros(1,length(Pyy));
    facum(1)=Pyy(1);
    for j=2:length(facum)
        facum(j)=facum(j-1)+Pyy(j);
    end
    
       temp=spectrum{1,ims};
        spectrum(1,ims)={temp+Pyy};
        espectrum(1,part,ims)= {Pyy};
        spl=facum; 
        temp=spectrum{2,ims};
        spectrum(2,ims)={temp+spl};
        espectrum (2,part,ims) = {spl};
        
      
    
     NS=zeros(1,length(1:100));
    for har=1:100
        Pyy2=zeros(size(Pyyr));
        Pyy2(1:har)=Pyyr(1:har);
        Pyy2(end-har+2:end)=Pyyr(end-har+2:end);
        P=ifft(Pyy2, NF);
        [NS(har), ~] = nashsutcliffe([dth;P]',[dth;rhon]');
    end
%       ene(part,1,ims)={Pyy2(1:har)};
%       ene(part,2,ims)={ Pyy2(end-har+2:end)};
%         ene(part,3,ims)={mean(spl(16:50))};
        centx{part,ims}={centroids(part,1)}; centy{part,ims}={centroids(part,2)};
     ai=find(NS<=0);
    ai=ai(end)+1;
    ydata=NS(ai:30);
    tdata =ai:30;
    
    
    
    mi=(ydata(3)-ydata(1))/(tdata(3)-tdata(1));
    ori=ydata(3)-(mi*tdata(3));
    
    mi2=(ydata(end)-ydata(end-3))/(tdata(end)-tdata(end-3));
    ori2=ydata(end-1)-(mi2*tdata(end-1));
    
    fun = @(x)sseval(x,tdata,ydata);
    x0 = [mi,ori,mi2,ori2];
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    lb = [mi-2*sqrt(abs(mi)),ori-2*sqrt(abs(ori)),mi2-2*sqrt(abs(mi2)),ori2-2*sqrt(abs(ori2))];
    ub = [mi+2*sqrt(abs(mi)),ori+2*sqrt(abs(ori)),mi2+2*sqrt(abs(mi2)),ori2+2*sqrt(abs(ori2))];
    
    %     optio=optimset('Display','iter');
    [bestx,~] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[]);%,optio);
    [~,uu]=min([(ydata-(bestx(1)*tdata+bestx(2))).^2; (ydata-(bestx(3)*tdata+bestx(4))).^2]);
    uu=find(uu==1) ;
    um(1,part) =uu(end)+ai+1;
    
    
%     yfit1 =bestx(1)*tdata+bestx(2);
%     yfit2 =bestx(3)*tdata+bestx(4);
%     figure
%     plot(tdata,ydata);
%     hold on
%     xlim=get(gca,'xlim');
%     ylim=get(gca,'ylim');
%     plot(tdata,yfit2,'g');
%     plot(tdata,yfit1,'r');
%     set(gca,'xlim',xlim,'ylim',ylim)
    
    
    %%%%%%%%%%%%%roundness
    uf=[um(1,part),80];
    ydata=NS(uf(1):uf(2));
    tdata =uf(1):uf(2);
    
    
    mi=(ydata(3)-ydata(1))/(tdata(3)-tdata(1));
    ori=ydata(3)-(mi*tdata(3));
    
    mi2=(ydata(end)-ydata(end-3))/(tdata(end)-tdata(end-3));
    ori2=ydata(end-1)-(mi2*tdata(end-1));
    
    fun = @(x)sseval(x,tdata,ydata);
    x0 = [mi,ori,mi2,ori2];
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    lb = [mi-2*sqrt(mi),ori-2*sqrt(ori),mi2-2*sqrt(mi2),ori2-2*sqrt(ori2)];
    ub = [mi+2*sqrt(mi),ori+2*sqrt(ori),mi2+2*sqrt(mi2),ori2+2*sqrt(ori2)];
    
    [bestx,~] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,[]);%,optio);
    [~,uu]=min([(ydata-(bestx(1)*tdata+bestx(2))).^2; (ydata-(bestx(3)*tdata+bestx(4))).^2]);
    uu=find(uu==1) ;
    um(2,part) =uu(end)+um(1,part);
    
%     yfit1 =bestx(1)*tdata+bestx(2);
%     yfit2 =bestx(3)*tdata+bestx(4);
%     figure
%     plot(tdata,ydata);
%     hold on
%     xlim=get(gca,'xlim');
%     ylim=get(gca,'ylim');
%     plot(tdata,yfit2,'g');
%     plot(tdata,yfit1,'r');
%     set(gca,'xlim',xlim,'ylim',ylim)
%     figure (fig1)
    for i=1:2
        har=um(i,part);
        Pyy2=zeros(size(Pyyr));
        Pyy2(1:har)=Pyyr(1:har);
        Pyy2(end-har+2:end)=Pyyr(end-har+2:end);
        P=ifft(Pyy2, NF);
        P=P.*fac;
        try
            [x,y] = pol2cart(dth,P);
        catch
            [x,y] = pol2cart(dth(1:min([length(dth),length(P)])),P(1:min([length(dth),length(P)])));
        end
        x1=x+centroids(part,1);
        y1=y+centroids(part,2);
        plot(x1,y1,'r','LineWidth',1,'Color',colo(i,:))
         xra{part,i,ims}={x1}; yra{part,i,ims}={y1};
    end
    um2 = um';
        ene(part,1,ims)={facum(um2(part,2))-facum(um2(part,1))};
       % ene(part,2,ims)={mean(spl(3:8))};
     %ene1 =  facum(um(2,part,ims))-facum(um(1,part,ims));
     text(centroids(part,1)-20,centroids(part,2), num2str( facum(um(2,part))-facum(um(1,part))),'color', [0 1 0],'FontSize',8)
    end
spectrum(1,ims)={spectrum{1,ims}/part};
spectrum(2,ims)={spectrum{2,ims}/part};
set(select, 'String',num2str(ims))
set(findall(menu.exp, '-property','Enable'),'Enable','on')
set(findall(menu.statistics, '-property','Enable'),'Enable','on')

 legend1=legend(['Roundness:' ],...
                   ['Form:']);
                   
    set(legend1,...
        'Position',[0.85 0.85 0.067 0.099]);
%     set(h, 'Position', get(0,'Screensize')); % Maximize figure.
%     print(h,[pathexport(1:end-5),num2str(ims),pathexport(end-4:end)],'-dtiff','-r600');
%     close(h)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         Statistics     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%MEAN%%%%%%%%%

function emean_Callback(hObject, eventdata, handles)
global  espectrump  ni pathname filename 
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',pathname);
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
fprintf(fileID, ['Fourier Analysis ', date,'  \n \n']);
for ii=1:ni
    fprintf(fileID, '\n');
     fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Mean spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:512
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrump,1) 
        if ~isempty (espectrump{1,i,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
         
            AllC = {cat(1, espectrump{1,:,:})};
             a=cell2mat(AllC);
             a = mean(a);
          
            NbPoints = 512;
              P=ifft(a, NbPoints);
            theta3=(-pi+2*pi/(NbPoints)): 2*pi/(NbPoints):pi;
            [x,y] = pol2cart(theta3,P);
           figure
            plot(x,y,'r','LineWidth',1)
            for oi=1:512
            fprintf(fileID, [num2str(a(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  
end
%%%MEDIAN%%%%%
function emedian_Callback(hObject, eventdata, handles)
global  espectrump  ni pathname filename 
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',pathname);
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
fprintf(fileID, ['Fourier Analysis ', date,'  \n \n']);
for ii=1:ni
    fprintf(fileID, '\n');
     fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Median spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:512
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrump,1) 
        if ~isempty (espectrump{1,i,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
         
            AllC = {cat(1, espectrump{1,:,:})};
             a=cell2mat(AllC);
             a = median(a);
          
            NbPoints = 512;
              P=ifft(a, NbPoints);
            theta3=(-pi+2*pi/(NbPoints)): 2*pi/(NbPoints):pi;
            [x,y] = pol2cart(theta3,P);
           figure
            plot(x,y,'r','LineWidth',1)
            for oi=1:512
            fprintf(fileID, [num2str(a(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  
end
%%%VARIANCE%%%%
function evariance_Callback(hObject, eventdata, handles)
global  espectrump  ni pathname filename 
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',pathname);
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
fprintf(fileID, ['Fourier Analysis ', date,'  \n \n']);
for ii=1:ni
    fprintf(fileID, '\n');
     fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Median spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:512
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrump,1) 
        if ~isempty (espectrump{1,i,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
         
            AllC = {cat(1, espectrump{1,:,:})};
             a=cell2mat(AllC);
             a = nanvar(a);
          
            NbPoints = 512;
              P=ifft(a, NbPoints);
            theta3=(-pi+2*pi/(NbPoints)): 2*pi/(NbPoints):pi;
            [x,y] = pol2cart(theta3,P);
           figure
            plot(x,y,'r','LineWidth',1)
            for oi=1:512
            fprintf(fileID, [num2str(a(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  
end
%%%STD%%%%%%%
function estd_Callback(hObject, eventdata, handles)
global  espectrump  ni pathname filename 
try
    [fileexport,pathexport]=uiputfile({'*.txt'},'Save File',pathname);
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
fprintf(fileID, ['Fourier Analysis ', date,'  \n \n']);
for ii=1:ni
    fprintf(fileID, '\n');
     fprintf(fileID, [filename{ii} '\t \t']);
    fprintf(fileID, '\n');
    fprintf(fileID, 'Median spectrum:\n');
    fprintf(fileID, 'Harmonics:\t');
    for i=1:512
    fprintf(fileID, [num2str(i),'\t']);
    end
    fprintf(fileID, '\n');
    
    for i=1:size(espectrump,1) 
        if ~isempty (espectrump{1,i,ii})
            fprintf(fileID, ['Part' num2str(i) '\t ']);
         
            AllC = {cat(1, espectrump{1,:,:})};
             a=cell2mat(AllC);
             a = nanstd(a);
            NbPoints = 512;
              P=ifft(a, NbPoints);
            theta3=(-pi+2*pi/(NbPoints)): 2*pi/(NbPoints):pi;
            [x,y] = pol2cart(theta3,P);
           figure
            plot(x,y,'r','LineWidth',1)
            for oi=1:512
            fprintf(fileID, [num2str(a(oi)) '\t']);
            end
             fprintf(fileID, '\n');
        end
    end    
    fprintf(fileID, '\n');
    fprintf(fileID, '\n');  
end

function calledit1_Callback(hObject, eventdata, handles)
global rango edit1
val=str2double(get(edit1, 'String'));
if ~isnan(val)
rango(1,1)=val;
else
set(edit1, 'String',num2str(rango(1,1)))
end

function calledit2_Callback(hObject, eventdata, handles)
global rango edit2
val=str2double(get(edit2, 'String'));
if ~isnan(val)
rango(2,1)=val;
else
set(edit2, 'String',num2str(rango(2,1)))
end

function calledit3_Callback(hObject, eventdata, handles)
global rango edit3
val=str2double(get(edit3, 'String'));
if ~isnan(val)
rango(1,2)=val;
else
set(edit3, 'String',num2str(rango(1,2)))
end

function calledit4_Callback(hObject, eventdata, handles)
global rango edit4
val=str2double(get(edit4, 'String'));
if ~isnan(val)
rango(2,2)=val;
else
set(edit4, 'String',num2str(rango(2,2)))
end

function calledit5_Callback(hObject, eventdata, handles)
global rango edit5
val=str2double(get(edit5, 'String'));
if ~isnan(val)
rango(1,3)=val;
else
set(edit5, 'String',num2str(rango(1,3)))
end

function calledit6_Callback(hObject, eventdata, handles)
global rango edit6
val=str2double(get(edit6, 'String'));
if ~isnan(val)
rango(2,3)=val;
else
set(edit6, 'String',num2str(rango(2,3)))
end


