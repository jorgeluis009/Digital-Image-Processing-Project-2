function varargout = guiProject(varargin)
% clc
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guiProject_OpeningFcn, ...
                   'gui_OutputFcn',  @guiProject_OutputFcn, ...
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

function guiProject_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
    setGlobalx(1);
    eternalLoop(handles);

function eternalLoop(handles)
    camera = webcam;
    axes(handles.canvas);
    while(true)
        img = snapshot(camera);
        aux = getGlobalx();
        % disp(aux);
                
        switch aux
            case 1 % Original
                imshow(img);
            case 2 % Complement
                imshow(imcomplement(img));
            case 3 % Gamma
                val = handles.sliderGamma.Value;
                handles.text6.String = val;
                imshow(imadjust(img,[],[],val)); 
            case 4 % Hemianopsia
                imshow(Hem(img,50));
            case 5 % Spectre
                imshow(ApplySpectre(img),[]);
            case 6 % Gauss
                val = handles.GaussSlider.Value;
                imshow(imnoise(img,'gaussian',val));
                handles.text5.String = val;
            case 7 % Periodic Noise
                 imshow(res(img));
            case 8 % Rotation
                imshow(imrotate(img,90));
            case 9 % Grid
                [M,N,P] = size(img);
                n = 1:2:M;
                m = 1:2:N;
                gridRes = img(n,m,:);
                res = [gridRes,gridRes;gridRes,gridRes];
                imshow(res);
            case 10 % Color Reduction
                x = handles.NumColors.String;
                ApplyColorReduction(img,x);
            otherwise
                break;
        end
        
    end
    
function res = per(img)
    C=[15 15;40 0];
    [M N l]=size(img);
    [n,R,S]=imnoise3(M,N,C);
    img=im2double(img);
    
    n=autoadj(n);
    R=img(:,:,1);
    G=img(:,:,2);
    B=img(:,:,3);
    R=R+n;
    R=autoadj(R);
    
    G=G+n;
    G=autoadj(G);
    
    B=B+n;
    B=autoadj(B);
    
    res=cat(3,R,G,B);
    res=im2uint8(res);
        
function ApplyColorReduction(img,x)
    x = str2num(x);
    if isempty(x)
        x = 255;
    end
    if x > 256
        x = 255;
    end
     [ans,map] = rgb2ind(img,x,'nodither');
     imshow(ans,map)

function ans = ApplySpectre(img)
    img = rgb2gray(img);
    F = fft2(img);
    Fc = fftshift(F);
    ans = log(1+abs(Fc));
    
function setGlobalx(val)
    global x
    x = val;

function r = getGlobalx
    global x
    r = x;

function varargout = guiProject_OutputFcn(hObject, eventdata, handles) 
handles.output = hObject;
varargout{1} = handles.output;

function originalBTN_Callback(hObject, eventdata, handles)
    setGlobalx(1);
    disp(getGlobalx);

function negativeBTN_Callback(hObject, eventdata, handles)
    setGlobalx(2);

function gammaBTN_Callback(hObject, eventdata, handles)
    setGlobalx(3);

function hemBTN_Callback(hObject, eventdata, handles)
    setGlobalx(4);

function spectreBTN_Callback(hObject, eventdata, handles)
    setGlobalx(5);

function gaussBTN_Callback(hObject, eventdata, handles)
    setGlobalx(6);

function periodicBTN_Callback(hObject, eventdata, handles)
    setGlobalx(7);

function rotateBTN_Callback(hObject, eventdata, handles)
    setGlobalx(8);
    
function rejillaBTN_Callback(hObject, eventdata, handles)
    setGlobalx(9);

function colorBTN_Callback(hObject, eventdata, handles)
    setGlobalx(10);

function figure1_CloseRequestFcn(hObject, eventdata, handles)
delete(hObject);

function ExitBTN_Callback(hObject, eventdata, handles)
    setGlobalx(99);

function sliderGamma_Callback(hObject, eventdata, handles)

function sliderGamma_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function GaussSlider_Callback(hObject, eventdata, handles)

function GaussSlider_CreateFcn(hObject, eventdata, handles)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function NumColors_Callback(hObject, eventdata, handles)
% hObject    handle to NumColors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumColors as text
%        str2double(get(hObject,'String')) returns contents of NumColors as a double


% --- Executes during object creation, after setting all properties.
function NumColors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumColors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
