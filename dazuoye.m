function varargout = dazuoye(varargin)
% DAZUOYE MATLAB code for dazuoye.fig
%      DAZUOYE, by itself, creates a new DAZUOYE or raises the existing
%      singleton*.
%
%      H = DAZUOYE returns the handle to a new DAZUOYE or the handle to
%      the existing singleton*.
%
%      DAZUOYE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAZUOYE.M with the given input arguments.
%
%      DAZUOYE('Property','Value',...) creates a new DAZUOYE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dazuoye_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dazuoye_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dazuoye

% Last Modified by GUIDE v2.5 23-Dec-2016 14:56:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dazuoye_OpeningFcn, ...
                   'gui_OutputFcn',  @dazuoye_OutputFcn, ...
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


% --- Executes just before dazuoye is made visible.
function dazuoye_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dazuoye (see VARARGIN)

% Choose default command line output for dazuoye
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dazuoye wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dazuoye_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
%打开图片
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile( ...
{'*.bmp;*.jpg;*.gif;*.tif','MATLAB Files (*.bmp,*.jpg,*.gif,*.tif)';
   '*.*',  'All Files (*.*)'}, ...
   'Pick a file');
im=imread([pathname,filename]);
axes(handles.axes1);
imshow(im);
title('原图像');

setappdata(gcf,'im',im);
setappdata(gcf,'delx',0);
setappdata(gcf,'dely',0);

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
I=getappdata(gcf,'gim');
switch value
    case 2
        axes(handles.axes4);
        cla reset
        flag0=0;
        setappdata(gcf,'flag',flag0);
        I=255-I;
        axes(handles.axes4);
        imshow(I);
        title('图像反转');
        
    case 3
       axes(handles.axes4);
       cla reset
       Ig =0.5*log(1+double(I));
       axes(handles.axes4);
       imshow(Ig,[]);
       title('对数变换');
      
    case 4
        axes(handles.axes4);
        cla reset
        Ig=im2double(I);
        Gamma=0.4;
        s=1;
        I=s*(Ig.^Gamma);
        axes(handles.axes4);
        imshow(I);
        title('伽马变换');
        
    case 5
        axes(handles.axes4);
        cla reset
        f0=0;
        g0=0;
        f1=20;
        g1=10;
        f2=180;
        g2=230;
        f3=255;
        g3=255;
        r1=(g1-g0)/(f1-f0);
        b1=g0-r1*f0;
        r2=(g2-g1)/(f2-f1);
        b2=g1-r2*f1;
        r3=(g3-g2)/(f3-f2);
        b3=g2-r3*f2;
        [m,n]=size(I);
        I=double(I);
        for i=1:m
            for j=1:n
                f=I(i,j);
                I1(i,j)=0;
                if(f>=f1)&(f<=f2)
                    I1(i,j)=r1*f+b2;
                else if(f>=f2)&(f<=f3)
                    I1(i,j)=r3*f+b3;
                    end
                end
            end
        end
end
imshow(mat2gray(I1));
axes(handles.axes4);
title('分段线性变换');

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
value=get(hObject,'Value');
I=getappdata(gcf,'gim');
switch value
    case 2
        [height,width] = size(I);  
        figure  
        subplot(221)  
        imshow(I) 
        title('原图');
        subplot(222)  
        imhist(I)  
        title('直方图');
        NumPixel = zeros(1,256);
        for i = 1:height  
            for j = 1: width  
                NumPixel(I(i,j) + 1) = NumPixel(I(i,j) + 1) + 1;
            end
        end
        ProbPixel = zeros(1,256);
        for i = 1:256  
            ProbPixel(i) = NumPixel(i) / (height * width * 1.0);  
        end
        CumuPixel = zeros(1,256);
        for i = 1:256  
    if i == 1  
        CumuPixel(i) = ProbPixel(i);  
    else  
        CumuPixel(i) = CumuPixel(i - 1) + ProbPixel(i);  
    end  
end  

CumuPixel = uint8(255 .* CumuPixel + 0.5);  
for i = 1:height  
    for j = 1: width  
        I(i,j) = CumuPixel(I(i,j));  
    end  
end  
subplot(223)  
imshow(I)
title('直方图均衡化后图像');
subplot(224)  
imhist(I)
title('直方图均衡化后的直方图');
    case 3
        axes(handles.axes4);
        cla reset
     Im= I;
     mG = mean(Im(:));
     QG = std(double(Im(:)));
     k0 = 0.4;
     k1 = 0.02;
     k2 = 0.4;
     E = 4.0;
     for i = 2:size(I,1)-1
         for j = 2:size(I,2)-1
             Im1= Im(i-1:i+1,j-1:j+1);
             if (mean(Im1)<= k0*mG)&(std(double(Im1))>= k1*QG)&(std(double(Im1))<= k2*QG)
                 Im(i,j) = E*Im(i,j);
             end
         end
     end
     axes(handles.axes4);
     imshow(Im,[]);
     title('局部直方图处理');
end


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
%平移
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8
value=get(hObject,'Value');
I=getappdata(gcf,'im');
switch value
    case 2
        axes(handles.axes4);
        cla reset
        [w,h,p]=size(I);
        I2=zeros(size(I));
        for i=1:w
            for j=1:h
        I1(i,j,1)=2*I(i,j,1);
        I1(i,j,2)=2*I(i,j,2);
        I1(i,j,3)=2*I(i,j,3);
            end
        end
        I2=uint8(I1);
        axes(handles.axes4);
        imshow(I2);
        title('RGB亮度调节')
    case 3
        axes(handles.axes8);
        cla reset
        k = 2;
        Ihsi = rgb2hsv(I);
        I1(:,:,1) = Ihsi(:,:,1);
       I1(:,:,2) = Ihsi(:,:,2);
       I1(:,:,3) = Ihsi(:,:,3)*k;
        if(I1(:,:,3)>=255)
            I1(:,:,3) = 255;
        end
        if(I1(:,:,3)<=0)
            I1(:,:,3) = 0;
        end
        I1rgb = hsv2rgb(I1);
        axes(handles.axes8);
        imshow(I1rgb,[]);
        title('HSI亮度调节');
end


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9




% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

I=getappdata(gcf,'im');
Ig=rgb2gray(I);
Ig=double(Ig<100);
se=strel('diamond',3);
Ig=imerode(Ig,se);
axes(handles.axes4);
imshow(Ig);
title('腐蚀后的图像');

function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

im=getappdata(gcf,'im');
im=rgb2gray(im);
im=double(im<100);
se=strel('diamond',3);
im2=imdilate(im,se);
axes(handles.axes4);
imshow(im2);
title('膨胀后的图像');


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
im=getappdata(gcf,'im');
im=rgb2gray(im);
im=double(im<100);
SE=zeros(58,58);
SE(5:54,5:54)=1;
imf=imerode(im,SE);
imf=double(imf<0.95);
im4=1-im;
SEE=1-SE;
imf2=imerode(im4,SEE);
imf3=imf&imf2;
figure,
subplot(1,5,1);
imshow(im);
title('原图A');
subplot(1,5,2);
imshow(SE);
title('碰撞目的矩阵B');
subplot(1,5,3);
imshow(im4);
title('A的补');
subplot(1,5,4)
imshow(imf);
title('B腐蚀A后的图像');
subplot(1,5,5);
imshow(imf3);
title('碰撞后图像');

% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
value=get(hObject,'Value');
im=getappdata(gcf,'im');
switch value
    case 2
        imn=imnoise(im,'gaussian',0.02);
        axes(handles.axes5);
        imshow(imn);
        title('高斯噪声');
        setappdata(gcf,'imn',imn);
    case 3
        imn=imnoise(im,'salt & pepper',0.02);
        axes(handles.axes5);
        imshow(imn);
        title('椒盐噪声');
        setappdata(gcf,'imn',imn);
        
    case 4
        a = 10;
        b = 5;
        im = im2double(im);
        n_Erlang = zeros(size(im));
        for j=1:b
            n_Erlang = n_Erlang + (-1/a)*log(1 - rand(size(im)));
        end
        g_Erlang = im + n_Erlang;
        axes(handles.axes5);
        imshow(g_Erlang);
         title('伽马噪声')
        setappdata(gcf,'imn',g_Erlang);
    case 5
         a= 0.05;
         b= 0.1;
         im = im2double(im);
         n_rayleigh = a + (-b .* log(1 - rand(size(im)))).^0.5;
         g_rayleigh = im + n_rayleigh;
         axes(handles.axes5);
         imshow(g_rayleigh);
         title('瑞丽噪声');
         setappdata(gcf,'imn',g_rayleigh);
         
    case 6
        a= 0.3;
        b= 0.3;
        im = im2double(im);
        n_Uniform = a + (b-a)*rand(size(im));
        g_Uniform = im + n_Uniform;
        axes(handles.axes5);
        imshow(g_Uniform);
        title('均匀噪声');
        setappdata(gcf,'imn',g_Uniform);
    case 7
        a=0.8;
        im = im2double(im);
        n_Ex = (-1/a)*log(1 - rand(size(im)));
        g_Ex = im + n_Ex;
        axes(handles.axes5);
        imshow(g_Ex);
        title('指数噪声');
        setappdata(gcf,'imn',g_Ex);
end


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
im=getappdata(gcf,'gz');
switch value
     case 2
        axes(handles.axes6) ;
        cla reset
        m=3;n=3;
        w = fspecial('average', [m n]);
        f = imfilter(im, w, 'replicate');
        axes(handles.axes6);
        imshow(f);
        title('算数均值滤波');
      case 3
        axes(handles.axes6) ;
        cla reset
        im = im2double(im);
        m=3;n=3;
        f = exp(imfilter(log(im), ones(m, n), 'replicate')).^(1 / m / n);
        axes(handles.axes6);
        imshow(f);
        title('几何均值滤波');
      case 4
        axes(handles.axes6) ;
        cla reset
        im = im2double(im);
        m=3;
        n=3;
        f = m * n ./ imfilter(1./(im + eps),ones(m, n), 'replicate');
        axes(handles.axes6);
        imshow(f);
        title('谐波均值滤波');
        case 5
        axes(handles.axes6) ;
        cla reset
        im = im2double(im);
        m=3;n=3;q=1.5;
        f = imfilter(im.^(q+1), ones(m, n), 'replicate');
        f = f ./ (imfilter(im .^q, ones(m, n), 'replicate') + eps);
        axes(handles.axes6);
        imshow(f);
        title('逆谐波均值滤波');
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7



% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
 %I=getappdata(gcf,'im');
 value=get(hObject,'Value');
 I=getappdata(gcf,'gim');
 D0 = 20;
I = im2double(I);
 [M, N] = size(I);
        u = 0:(M - 1);
        v = 0:(N - 1);      
        idx = find(u > M/2);
        u(idx) = u(idx) - M;
        idy = find(v > N/2);
        v(idy) = v(idy) - N;        
        [V, U] = meshgrid(v, u);
switch value
    case 2
        axes(handles.axes4);
        cla reset
        D = sqrt(U.^2 + V.^2);
        H = 1 - exp(-(D.^2)./(2*(D0^2))); 
        F = fft2(I, size(H, 1), size(H, 2));
        g = real(ifft2(H.*F));
        g = g(1:size(I, 1), 1:size(I, 2));
        axes(handles.axes4);
        imshow(g);
        title('理想高通滤波');
    case 3   
        axes(handles.axes4);
        cla reset
        D = sqrt(U.^2 + V.^2);
        H = 1 - 1./(1 + (D./D0).^2); 
        F = fft2(I, size(H, 1), size(H, 2));
        g = real(ifft2(H.*F));
        g = g(1:size(I, 1), 1:size(I, 2));
        axes(handles.axes4);
        imshow(g);
        title('布特沃斯高通滤波');
    case 4
        axes(handles.axes4);
        cla reset
        D = sqrt(U.^2 + V.^2);
        H = 1 - double(D <= D0);
        F = fft2(I, size(H, 1), size(H, 2));
        g = real(ifft2(H.*F));
        g = g(1:size(I, 1), 1:size(I, 2));
       axes(handles.axes4);
        imshow(g);
        title('高斯高通滤波');
    case 5
        axes(handles.axes4);
        cla reset
        D = sqrt(U.^2 + V.^2);
        H = double(D <= D0);
        F = fft2(I, size(H, 1), size(H, 2));
        g = real(ifft2(H.*F));
        g = g(1:size(I, 1), 1:size(I, 2));
       axes(handles.axes4);
        imshow(g);
        title('理想低通滤波');
    case 6
        axes(handles.axes4);
        cla reset
        D = sqrt(U.^2 + V.^2);
        H = 1./(1 + (D./D0).^2);
        F = fft2(I, size(H, 1), size(H, 2));
        g = real(ifft2(H.*F));
        g = g(1:size(I, 1), 1:size(I, 2));
       axes(handles.axes4);
        imshow(g);
        title('布特沃斯低通滤波');
    case 7
        axes(handles.axes4);
        cla reset
        D = sqrt(U.^2 + V.^2);
        H = exp(-(D.^2)./(2*(D0^2)));
        F = fft2(I, size(H, 1), size(H, 2));
        g = real(ifft2(H.*F));
        g = g(1:size(I, 1), 1:size(I, 2));
        axes(handles.axes4);
        imshow(g);
        title('高斯低通滤波');
end


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imf=getappdata(gcf,'gim');
imf=fftshift(fft2(imf));
imf=im2double(imf);
axes(handles.axes8);
imshow(log(abs(imf)),[]);
title('原图的傅里叶谱');
[h w]=size(imf);
imf(h,w)=imf(h,w)*5000;
imfi=ifft2(imf);
axes(handles.axes4);
imshow(abs(imfi),[]);
title('傅里叶变换后图像');


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
im=getappdata(gcf,'gim');
suofang=get(hObject,'Value');
set(handles.edit5,'String',suofang);
I=im;
if(length(size(I))>2)
    I=rgb2gray(I);
end
im2=zeros(0.5*size(im));
[h u]=size(im);
for x=1:h
    for y=1:u
        v=ceil(suofang*x);
        w=ceil(suofang*y);
        im2(v,w)=im(x,y);
    end
end

axes(handles.axes1);
imshow(im2,[]);


% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
%旋转
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

j=get(hObject,'Value')*360;
set(handles.edit4,'String',j);
img=getappdata(gcf,'gim');
[h w]=size(img);
theta=j/180*pi;
rot=[cos(theta) -sin(theta) 0;sin(theta) cos(theta) 0;0 0 1]; 
pix1=[1 1 1]*rot;              
pix2=[1 w 1]*rot;              
pix3=[h 1 1]*rot;               
pix4=[h w 1]*rot;              

height=round(max([abs(pix1(1)-pix4(1))+0.5 abs(pix2(1)-pix3(1))+0.5]));    
width=round(max([abs(pix1(2)-pix4(2))+0.5 abs(pix2(2)-pix3(2))+0.5]));     
imgn=zeros(height,width);

delta_y=abs(min([pix1(1) pix2(1) pix3(1) pix4(1)]));            
delta_x=abs(min([pix1(2) pix2(2) pix3(2) pix4(2)]));            

[m n]=size(img);

r=1;
imgm=zeros(m+2*r+1,n+2*r+1);
imgm(r+1:m+r,r+1:n+r)=img;
imgm(1:r,r+1:n+r)=img(1:r,1:n); 
imgm(1:m+r,n+r+1:n+2*r+1)=imgm(1:m+r,n:n+r);
imgm(m+r+1:m+2*r+1,r+1:n+2*r+1)=imgm(m:m+r,r+1:n+2*r+1);
imgm(1:m+2*r+1,1:r)=imgm(1:m+2*r+1,r+1:2*r);

for i=1-delta_y:height-delta_y
    for j=1-delta_x:width-delta_x
        pix=[i j 1]/rot;                                                                                                                      
        float_Y=pix(1)-floor(pix(1)); 
        float_X=pix(2)-floor(pix(2));    
       
        if pix(1)>=-1 && pix(2)>=-1 && pix(1) <= h+1 && pix(2) <= w+1     
            
            pix_up_left=[floor(pix(1)) floor(pix(2))];        
            pix_up_right=[floor(pix(1)) ceil(pix(2))];
            pix_down_left=[ceil(pix(1)) floor(pix(2))];
            pix_down_right=[ceil(pix(1)) ceil(pix(2))]; 
        
            value_up_left=(1-float_X)*(1-float_Y);              
            value_up_right=float_X*(1-float_Y);
            value_down_left=(1-float_X)*float_Y;
            value_down_right=float_X*float_Y;
                                                            
            imgn(i+delta_y,j+delta_x)=value_up_left*imgm(pix_up_left(1)+2,pix_up_left(2)+2)+ ...
                                      value_up_right*imgm(pix_up_right(1)+2,pix_up_right(2)+2)+ ...
                                      value_down_left*imgm(pix_down_left(1)+2,pix_down_left(2)+2)+ ...
                                      value_down_right*imgm(pix_down_right(1)+2,pix_down_right(2)+2);
        end
    end
  
end
axes(handles.axes1);
 cla reset
axes(handles.axes1);
imshow(uint8(imgn));
title('旋转');


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
dely=get(hObject,'Value')*500;
delx=getappdata(gcf,'delx');
set(handles.edit3,'String',dely);
setappdata(gcf,'dely',dely);
im=getappdata(gcf,'gim');
I=im;
if(length(size(I))>2)
    I=rgb2gray(I);
end
[h u]=size(I);
for x=1:h
    for y=1:u
        v=ceil(delx+x);
        w=ceil(dely+y);
        im1(v,w)=I(x,y);
    end
end
axes(handles.axes1);
imshow(im1,[]);


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

dely=getappdata(gcf,'dely');
delx=get(hObject,'Value')*100;
setappdata(gcf,'delx',delx);
im=getappdata(gcf,'gim');
set(handles.edit2,'String',delx);
I=im;
if(length(size(I))>2)
    I=rgb2gray(I);
end
im2=zeros(size(im));
[h u]=size(im);
for x=1:h
    for y=1:u
        v=ceil(delx+x);
        w=ceil(dely+y);
        im4(v,w)=im(x,y);
    end
end

axes(handles.axes1);
imshow(im4,[]);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu11.
%
function popupmenu11_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
imj=getappdata(gcf,'gz');
img=uint8(zeros(size(imj)));
[m,n]=size(img);
switch value
    case 2
        axes(handles.axes6) ;
        cla reset
        for i=1:m
            for j=1:n
        if(i==1||i==m||j==1||j==n)
            img(i,j)=imj(i,j);
        else
            a(1)=imj(i-1,j-1);
            a(2)=imj(i-1,j);
            a(3)=imj(i-1,j+1);
            a(4)=imj(i,j-1);
            a(5)=imj(i,j);
            a(6)=imj(i,j+1);
            a(7)=imj(i+1,j-1);
            a(8)=imj(i+1,j);
            a(9)=imj(i+1,j+1);
            a=sort(a);
            img(i,j)=a(9);
        end
            end
        end
        axes(handles.axes6);
        imshow(uint8(img));
        title('最大值滤波');
    case 3
        axes(handles.axes6) ;
        cla reset
        for i=1:m
            for j=1:n
        if(i==1||i==m||j==1||j==n)
            img(i,j)=imj(i,j);
        else
            a(1)=imj(i-1,j-1);
            a(2)=imj(i-1,j);
            a(3)=imj(i-1,j+1);
            a(4)=imj(i,j-1);
            a(5)=imj(i,j);
            a(6)=imj(i,j+1);
            a(7)=imj(i+1,j-1);
            a(8)=imj(i+1,j);
            a(9)=imj(i+1,j+1);
            a=sort(a);
            img(i,j)=a(5);
        end
            end
        end
        axes(handles.axes6);
        imshow(uint8(img));
        title('中值滤波');
    case 4
        axes(handles.axes6) ;
        cla reset
        for i=1:m
            for j=1:n
                if(i==1||i==m||j==1||j==n)
                    img(i,j)=imj(i,j);
                else
            a(1)=imj(i-1,j-1);
            a(2)=imj(i-1,j);
            a(3)=imj(i-1,j+1);
            a(4)=imj(i,j-1);
            a(5)=imj(i,j);
            a(6)=imj(i,j+1);
            a(7)=imj(i+1,j-1);
            a(8)=imj(i+1,j);
            a(9)=imj(i+1,j+1);
            a=sort(a);
            img(i,j)=a(1);
                end
            end
        end
        axes(handles.axes6);
        imshow(uint8(img));
        title('最小值滤波');
    case 5
        axes(handles.axes6) ;
        cla reset
        n=3;
        d=2;
        a(1:n,1:n)=1;  
        [height, width]=size(imj);  
        imj1=double(imj);  
        imj2=imj1;  
        for i=1:height-n+1  
            for j=1:width-n+1  
                c=imj1(i:i+(n-1),j:j+(n-1)).*a;
                p=(min(c(:))+max(c(:)))/2;
                imj2(i+(n-1)/2,j+(n-1)/2)=p;   
            end
        end
        d=mat2gray(imj2);  
        axes(handles.axes6);
        imshow(d,[]);
        title('中点滤波');
    case 6
        axes(handles.axes6) ;
        cla reset
        a(1:n,1:n)=1;   
        [height, width]=size(imj);          
        imj1=double(imj);  
        imj2=imj1;  
        for i=1:height-n+1  
            for j=1:width-n+1  
            c=imj1(i:i+(n-1),j:j+(n-1)).*a;  
            p=sum(sum(c));                 
            p=p-min(c(:))-max(c(:));
            imj2(i+(n-1)/2,j+(n-1)/2)=p/(n*n-d);
            end  
        end  
    d=mat2gray(imj2); 
    axes(handles.axes6);
    imshow(d,[]);
    title('阿尔法修正滤波');
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(gcf,'gz');
value=get(hObject,'Value');
switch value
    case 2
        axes(handles.axes6) ;
        cla reset
        s = fftshift(fft2(I));
        [a,b]=size(s);
        a0=round(a/2);
        b0=round(b/2);
        d = 10;
        w=10;
        for i=1:a
            for j =1:b
        distance = sqrt((i-a0)^2+(j-b0)^2);
        if distance<=d+w/2 && distance>=d-w/2
            h=0;
        else
            h = 1;
        end
        s(i,j)=h*s(i,j);
            end
        end
        s = uint8(real(ifft2(ifftshift(s))));
        axes(handles.axes6);
        imshow(s);
        title('理想带阻滤波');
    case 3
        axes(handles.axes6) ;
        cla reset
      f = double(I);
      g = fft2(f);
      g = fftshift(g);
      [N1,N2]=size(g);
      n=2;
      d0=30;
      n1 = fix(N1/2);
      n2 = fix(N2/2);
      w=50;
      result = zeros(size(g));
      for i=1:N1
    for j =1:N2
        d = sqrt((i-n1)^2+(j-n2)^2);
        if d==0
            h=0;
        else
            h = 1/(1+(d*w/(d*d-d0*d0))^(2*n));
        end
        result(i,j)=h*g(i,j);
    end
      end
      result=ifftshift(result);
      X2=ifft2(result);
      X3=uint8(real(X2));
    axes(handles.axes6);
      imshow(X3);
      title('巴特沃斯带阻滤波');
    case 4
        axes(handles.axes6) ;
        cla reset
        im = im2double(I);
        D0=30;
        W=60;
        [M, N] = size(im);
        u = 0:(M - 1);
        v = 0:(N - 1);
        [V, U] = meshgrid(v, u);
        D = sqrt((U-M/2+0.5).^2 + (V-N/2+0.5).^2);
        H = 1-exp(-((D.^2-D0^2)./(D.*W)).^2);
        H=real(H);
        im=fftshift(fft2(im));
        im = im2uint8(abs(ifft2(im.*H)));
        axes(handles.axes6);
        imshow(im);
        title('高斯带阻滤波');
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu13


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2
imn=getappdata(gcf,'im');
gim=rgb2gray(imn);
axes(handles.axes1);
imshow(gim);
title('灰度处理后图像');
setappdata(gcf,'gim',gim);



% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(gcf,'im');
p=[0 0 0];
axes(handles.axes1);
p=get(handles.axes1,'currentpoint');
h=round(p(1,1));
w=round(p(1,2));
pp=uint8(ones(200,200,3));
img=getimage(handles.axes1);
c(1)=img(h,w,1);
c(2)=img(h,w,2);
c(3)=img(h,w,3);
for i=1:200
    for j=1:200
        pp(i,j,1)=c(1);
        pp(i,j,2)=c(2);
        pp(i,j,3)=c(3);
    end
end
axes(handles.axes7);
imshow(uint8(pp));



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(gcf,'imn');
gz=rgb2gray(I);
axes(handles.axes5);
imshow(gz);
title('灰度噪声');
setappdata(gcf,'gz',gz);


% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu16
value=get(hObject,'Value');
im=getappdata(gcf,'im');
switch value
case 2
     axes(handles.axes4);
     cla reset
    imR = im(:,:,1);
    imG = im(:,:,2);
    imB = im(:,:,3);
     
    imnew(:,:,1) = histeq(imR);
    imnew(:,:,2) = histeq(imG);
    imnew(:,:,3) = histeq(imB);
    
    axes(handles.axes4);
    imshow(imnew,[]);
    title('RGB均衡化');
    case 3
        axes(handles.axes8);
        cla reset
        imhsi = rgb2hsv(im);
        imH = imhsi(:,:,1);
        imS = imhsi(:,:,2);
        imI = imhsi(:,:,3);
        
        imnew(:,:,1) = histeq(imH);
        imnew(:,:,2) = histeq(imS);
        imnew(:,:,3) = histeq(imI);
        
        imnewrgb = hsv2rgb(imnew);
        axes(handles.axes8);
        imshow(imnewrgb,[]);
        title('HSI均衡化');
end


% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu17.
function popupmenu17_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
I=getappdata(gcf,'gim');
switch value
    case 2
        a = 31;
        b = 5;
        %使用高斯滤波器
        h = fspecial('gaussian',a,b);
        c = imfilter(I,h);
        axes(handles.axes4);
        imshow(c,[]);
end

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu17 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu17


% --- Executes during object creation, after setting all properties.
function popupmenu17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=getappdata(gcf,'gim');
a = 31;
b = 5;
h = fspecial('gaussian',a,b);
c = imfilter(I,h);
axes(handles.axes4);
imshow(c,[]);
title('平滑线性空间滤波');
% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
       axes(handles.axes6) ;
        cla reset
       I=getappdata(gcf,'gz');
        max=5;
        [h w]=size(I);
       Im= uint8(zeros(h,w));
        alreadyProcessed = false(size(I));
        for k = 3:2:max
            zmin = ordfilt2(I, 1, ones(k, k), 'symmetric');
            zmax = ordfilt2(I, k * k, ones(k, k),'symmetric');
            zmed = medfilt2(I, [k k], 'symmetric');
            processUsingLevelB = (zmed > zmin) & (zmax > zmed) & ...
                ~alreadyProcessed;
            zB = (img > zmin) & (zmax > I);
            outputZxy  = processUsingLevelB & zB;
            outputZmed = processUsingLevelB & ~zB;
            Im(outputZxy) = Im(outputZxy);
            Im(outputZmed) = zmed(outputZmed);
            alreadyProcessed = alreadyProcessed | processUsingLevelB;
            if all(alreadyProcessed(:))
                break;
            end
        end
        Im(~alreadyProcessed) = zmed(~alreadyProcessed);
       Im=uint8(Im);
        axes(handles.axes6);
        imshow(Im);
        title('自适应中值滤波');


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
I=getappdata(gcf,'im');
axes(handles.axes1);
imshow(I);
title('复原');
setappdata(gcf,'im',I);


% --- Executes on selection change in popupmenu18.
function popupmenu18_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
value=get(hObject,'Value');
I=getappdata(gcf,'gz');
switch value
    case 2
        axes(handles.axes6) ;
        cla reset
      Im= fftshift(fft2(I));
      [a,b]=size(Im);
      d = 10;
      w=10;
      for i=1:a
          for j =1:b
              distance = sqrt((i-round(a/2))^2+(j-round(b/2))^2);
              if distance<=d+w/2 && distance>=d-w/2
                  h=0;
              else
            h = 1;
              end
              Im(i,j)=(1-h)*Im(i,j);
          end
      end
      Im = uint8(real(ifft2(ifftshift(Im))));
      axes(handles.axes6);
      imshow(Im);
      title('理想带通滤波');
    case 3
        axes(handles.axes6) ;
        cla reset
        f = double(I);%change data type
        g = fft2(f);%fft change
        g = fftshift(g);%fft 平移
        [N1,N2]=size(g);
        n=2;
        d0=30;
        n1 = fix(N1/2);
        n2 = fix(N2/2);
        w=5;
        r = zeros(size(g));
        for i=1:N1
            for j =1:N2
                d = sqrt((i-n1)^2+(j-n2)^2);
                if d==0
                    h=0;
                else
                    h = 1/(1+(d*w/(d*d-d0*d0))^(2*n));
                end
                hh=1-h;
                r(i,j)=hh*g(i,j);
            end
        end
        r=ifftshift(r);
        X2=ifft2(r);
        X3=uint8(real(X2));
        axes(handles.axes6);
        imshow(X3);
        title('巴特沃斯带通滤波');
    case 4
        axes(handles.axes6) ;
        cla reset
        IA=I;
        Y=fft2(double(IA));
        Y=fftshift(Y);
        [f1,f2]=freqspace(size(IA),'meshgrid');
        D = 10/size(IA,1);
        W = 5;
        r = f1.^2+f2.^2;
        Hd=ones(size(IA));
        for i=1:size(IA,1)
            for j=1:size(IA,2)
                t=((r(i,j)*r(i,j)-D*D)/(r(i,j)*W))^2;
                Hd(i,j)=exp(-t);
                Hd(i,j) = 1-Hd(i,j);
            end
        end
        Ya=Y.*Hd;
        Ya=ifftshift(Ya);
        Ia=real(ifft2(Ya));
        axes(handles.axes6)
imshow(uint8(Ia));
title('高斯带通滤波处理后的图像');
end



% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu18 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu18


% --- Executes during object creation, after setting all properties.
function popupmenu18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu19.
function popupmenu19_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu19 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu19


% --- Executes during object creation, after setting all properties.
function popupmenu19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
        I=getappdata(gcf,'gim');
        lp=[0   -1   0;-1   4   -1; 0    -1   0 ];
        lpI=conv2(I,lp,'same');
        axes(handles.axes8);
        imshow(uint8(lpI));
        title('拉普拉斯图像');
        implus=imadd(I,immultiply(uint8(lpI),1));
        axes(handles.axes4);
        imshow(uint8(implus));
        title('拉普拉斯锐化');  

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

oneDDFTtest(10000);
title('一维傅里叶变换');

function oneDDFTtest(n)
N=256;
t=0:2*pi/N:2*pi;%中间是步长
tp=t(1:256);
y=zeros(1,N);
for i=1:2:n
    y=y+4*sin(i*tp)/(i*pi);
end

for i=1:256;
  x(i)=oneDDFT(i)*y';
end
figure;subplot(2,1,1);plot(y);
subplot(2,1,2);bar(abs(x));


function oneDbasis= oneDDFT(k)
N=256;
x=0:N-1;
oneDbasis=exp(-j*2*pi*(x*k)/N);

% Hint: get(hObject,'Value') returns toggle state of togglebutton5





% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu22 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu22


% --- Executes during object creation, after setting all properties.
function popupmenu22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
