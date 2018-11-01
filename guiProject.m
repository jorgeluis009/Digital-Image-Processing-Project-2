function varargout = guiProject(varargin)
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
        disp(aux);
                
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
            case 6  
                disp('positive one')
            otherwise
                disp('other value')
        end
        
    end

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
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
handles.output = hObject;
varargout{1} = handles.output;


% --- Executes on button press in originalBTN.
function originalBTN_Callback(hObject, eventdata, handles)
    setGlobalx(1);
    disp(getGlobalx);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
% Hint: delete(hObject) closes the figure+
delete(hObject);

function ExitBTN_Callback(hObject, eventdata, handles)
    setGlobalx(99);

function sliderGamma_Callback(hObject, eventdata, handles)

function sliderGamma_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
