function varargout = AC(varargin)
%% ACYCLE
%% time-series analysis software for paleoclimate projects and education
%%
%
% AC MATLAB code for AC.fig
%
%      This is the main function of the Acycle software.
%
%% ************************************************************************
% Please acknowledge the program author on any publication of scientific 
% results based in part on use of the program and cite the following
% article in which the program was described:
%
%       Mingsong Li, Linda Hinnov, Lee Kump. Acycle: Time-series analysis
%       software for paleoclimate projects and education, Computers & Geosciences,
%       127: 12-22. https://doi.org/10.1016/j.cageo.2019.02.011
%
% If you publish results using techniques such as correlation coefficient,
% sedimentary noise model, power decomposition analysis, evolutionary fast
% Fourier transform, wavelet transform, Bayesian changepoint, (e)TimeOpt,
% or other approaches, please also cite original publications,
% as detailed in "AC_Users_Guide.pdf" file at
% 
% https://github.com/mingsongli/acycle/wiki
% https://github.com/mingsongli/acycle/blob/master/doc/AC_Users_Guide.pdf
%
% Program Author:
%           Mingsong Li, PhD
%           School of Earth and Space Sciences
%           Peking University
%           Beijing 100871, China

%
% Email:    : msli@pku.edu.cn ; limingsonglms@gmail.com
% Website:  https://github.com/mingsongli/acycle
%           https://acycle.org
%           http://mingsongli.com
%
% Copyright (C) 2017-2023
%
% This program is a free software; you can redistribute it and/or modify it
% under the terms of the GNU GENERAL PUBLIC LICENSE as published by the 
% Free Software Foundation.
%
% This program is distributed in the hope that it will be useful, but 
% WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
% or FITNESS FOR A PARTICULAR PURPOSE.
%
% You should have received a copy of the GNU General Public License. If
% not, see < https://www.gnu.org/licenses/ >
%
%**************************************************************************
%%
%      AC, by itself, creates a new AC or raises the existing
%      singleton*.
%
%      H = AC returns the handle to a new AC or the handle to
%      the existing singleton*.
%
%      AC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AC.M with the given input arguments.
%
%      AC('Property','Value',...) creates a new AC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AC

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AC_OpeningFcn, ...
                   'gui_OutputFcn',  @AC_OutputFcn, ...
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


% --- Executes just before AC is made visible.
function AC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AC (see VARARGIN)

% Monitor Size
set(0,'Units','centimeters')
MonitorPos = get(0,'MonitorPositions');
handles.MonitorPos = MonitorPos;
handles.MonZoom = 1;
if MonitorPos(1,4) < 30
     handles.MonZoom = 1.2;
elseif  MonitorPos(1,4) < 38 % Macbook pro 16 retina
    handles.MonZoom = 1.1;   
elseif  MonitorPos(1,4) < 45 % Macbook pro 16 retina
    handles.MonZoom = 1;   
elseif  MonitorPos(1,4) < 55
    handles.MonZoom = .9;
elseif  MonitorPos(1,4) < 65
    handles.MonZoom = 0.75;
elseif  MonitorPos(1,4) < 75  % 32 inch 4k
    handles.MonZoom = 0.65;
elseif  MonitorPos(1,4) < 90
    handles.MonZoom = 0.5;
else
    handles.MonitorZoom = 0.4;
end

set(0,'Units','normalized') % set units as normalized
set(gcf,'position',[0.5,0.1,0.45,0.8] * handles.MonZoom) % set position

set(gcf,'DockControls', 'off')
set(gcf,'Color', 'white')
set(gcf,'units','norm') % set location

%% language

lang_choice = load('ac_lang.txt');
langdict = readtable('langdict.xlsx');
lang_id = langdict.ID;
lang_var = table2cell(langdict(:, 2 + lang_choice));

[~, c61] = ismember('c61',lang_id);
set(gcf,'Name',lang_var{c61})
    
if lang_choice > 0
    % menu
    [~, locb] = ismember('menu01',lang_id);
    set(handles.menu_file,'text',lang_var{locb})
    [~, locb] = ismember('menu02',lang_id);
    set(handles.menu_edit,'text',lang_var{locb})
    [~, locb] = ismember('menu03',lang_id);
    set(handles.menu_plotall,'text',lang_var{locb})
    [~, locb] = ismember('menu04',lang_id);
    set(handles.menu_basic,'text',lang_var{locb})
    [~, locb] = ismember('menu05',lang_id);
    set(handles.menu_math,'text',lang_var{locb})
    [~, locb] = ismember('menu06',lang_id);
    set(handles.menuac,'text',lang_var{locb})
    [~, locb] = ismember('menu07',lang_id);
    set(handles.menu_help,'text',lang_var{locb})
    % File
    [~, locb] = ismember('menu20',lang_id);
    set(handles.menu_folder,'text',lang_var{locb})
    [~, locb] = ismember('menu21',lang_id);
    set(handles.menu_newtxt,'text',lang_var{locb})
    [~, locb] = ismember('menu22',lang_id);
    set(handles.menu_savefig,'text',lang_var{locb})
    [~, locb] = ismember('menu23',lang_id);
    set(handles.menu_open,'text',lang_var{locb})
    [~, locb] = ismember('menu24',lang_id);
    set(handles.menu_opendir,'text',lang_var{locb})
    [~, locb] = ismember('menu25',lang_id);
    set(handles.menu_extract,'text',lang_var{locb})
    % Edit
    [~, locb] = ismember('menu30',lang_id);
    set(handles.menu_refreshlist,'text',lang_var{locb})
    [~, locb] = ismember('menu31',lang_id);
    set(handles.menu_rename,'text',lang_var{locb})
    [~, locb] = ismember('menu32',lang_id);
    set(handles.menu_cut,'text',lang_var{locb})
    [~, locb] = ismember('menu33',lang_id);
    set(handles.menu_copy,'text',lang_var{locb})
    [~, locb] = ismember('menu34',lang_id);
    set(handles.menu_paste,'text',lang_var{locb})
    [~, locb] = ismember('menu35',lang_id);
    set(handles.menu_delete,'text',lang_var{locb})
    % Plot
    [~, locb] = ismember('menu40',lang_id);
    set(handles.menu_plot,'text',lang_var{locb})
    [~, locb] = ismember('menu41',lang_id);
    set(handles.menu_plotpro_2d,'text',lang_var{locb})
    [~, locb] = ismember('menu42',lang_id);
    set(handles.menu_plotn,'text',lang_var{locb})
    [~, locb] = ismember('menu43',lang_id);
    set(handles.menu_plotn2,'text',lang_var{locb})
    [~, locb] = ismember('menu46',lang_id);
    set(handles.menu_samplerate,'text',lang_var{locb})
    [~, locb] = ismember('menu47',lang_id);
    set(handles.menu_datadistri,'text',lang_var{locb})
    [~, locb] = ismember('menu48',lang_id);
    set(handles.menu_sound,'text',lang_var{locb})
    % Basic Series
    [~, locb] = ismember('menu50',lang_id);
    set(handles.menu_insol,'text',lang_var{locb})
    [~, locb] = ismember('menu51',lang_id);
    set(handles.menu_laskar,'text',lang_var{locb})
    [~, locb] = ismember('menu52',lang_id);
    set(handles.menu_LOD,'text',lang_var{locb})
    [~, locb] = ismember('menu53',lang_id);
    set(handles.linegenerator,'text',lang_var{locb})
    [~, locb] = ismember('menu54',lang_id);
    set(handles.menu_LR04,'text',lang_var{locb})
    [~, locb] = ismember('menu55',lang_id);
    set(handles.menu_examples,'text',lang_var{locb})
    [~, locb] = ismember('menu56',lang_id);
    set(handles.menu_example_hawaiiCO2,'text',lang_var{locb})
    [~, locb] = ismember('menu57',lang_id);
    set(handles.menu_example_inso2Ma,'text',lang_var{locb})
    [~, locb] = ismember('menu58',lang_id);
    set(handles.menu_example_la04etp,'text',lang_var{locb})
    [~, locb] = ismember('menu59',lang_id);
    set(handles.menu_example_redp7,'text',lang_var{locb})
    [~, locb] = ismember('menu60',lang_id);
    set(handles.menu_example_PETM,'text',lang_var{locb})
    [~, locb] = ismember('menu61',lang_id);
    set(handles.menu_example_Newark,'text',lang_var{locb})
    [~, locb] = ismember('menu62',lang_id);
    set(handles.menu_example_wayao,'text',lang_var{locb})
    [~, locb] = ismember('menu63',lang_id);
    set(handles.menu_example_GD2GR,'text',lang_var{locb})
    [~, locb] = ismember('menu64',lang_id);
    set(handles.menu_example_marsimage,'text',lang_var{locb})
    [~, locb] = ismember('menu65',lang_id);
    set(handles.menu_example_plotdigitizer,'text',lang_var{locb})
    [~, locb] = ismember('menu66',lang_id);
    set(handles.menu_extinction_CSA,'text',lang_var{locb})
    [~, locb] = ismember('menu67',lang_id);
    set(handles.menu_example_sphalerite,'text',lang_var{locb})
    % Math
    [~, locb] = ismember('menu70',lang_id);
    set(handles.menu_sort,'text',lang_var{locb})
    [~, locb] = ismember('menu71',lang_id);
    set(handles.menu_interp,'text',lang_var{locb})
    [~, locb] = ismember('menu93',lang_id);
    set(handles.menu_interpolationGUI,'text',lang_var{locb})
    [~, locb] = ismember('menu72',lang_id);
    set(handles.menu_interpseries,'text',lang_var{locb})
    [~, locb] = ismember('menu73',lang_id);
    set(handles.menu_selectinterval,'text',lang_var{locb})
    [~, locb] = ismember('menu74',lang_id);
    set(handles.menu_add,'text',lang_var{locb})
    [~, locb] = ismember('menu75',lang_id);
    set(handles.menu_multiply,'text',lang_var{locb})
    [~, locb] = ismember('menu76',lang_id);
    set(handles.menu_gap,'text',lang_var{locb})
    [~, locb] = ismember('menu77',lang_id);
    set(handles.menu_desection,'text',lang_var{locb})
    [~, locb] = ismember('menu78',lang_id);
    set(handles.menu_depeaks,'text',lang_var{locb})
    [~, locb] = ismember('menu79',lang_id);
    set(handles.menu_clip,'text',lang_var{locb})
    [~, locb] = ismember('menu80',lang_id);
    set(handles.menu_cpt,'text',lang_var{locb})
    [~, locb] = ismember('menu81',lang_id);
    set(handles.menu_norm,'text',lang_var{locb})
    [~, locb] = ismember('menu82',lang_id);
    set(handles.menu_pca,'text',lang_var{locb})
    [~, locb] = ismember('menu83',lang_id);
    set(handles.menu_log10,'text',lang_var{locb})
    [~, locb] = ismember('menu84',lang_id);
    set(handles.menu_derivative,'text',lang_var{locb})
    [~, locb] = ismember('menu85',lang_id);
    set(handles.menu_function,'text',lang_var{locb})
    [~, locb] = ismember('menu86',lang_id);
    set(handles.menu_utilities,'text',lang_var{locb})
    [~, locb] = ismember('menu87',lang_id);
    set(handles.menu_maxmin,'text',lang_var{locb})
    [~, locb] = ismember('menu88',lang_id);
    set(handles.menu_image,'text',lang_var{locb})
    [~, locb] = ismember('menu89',lang_id);
    set(handles.menu_imshow,'text',lang_var{locb})
    [~, locb] = ismember('menu90',lang_id);
    set(handles.menu_rgb2gray,'text',lang_var{locb})
    [~, locb] = ismember('menu94',lang_id);
    set(handles.menu_rgb2lab,'text',lang_var{locb})
    [~, locb] = ismember('menu91',lang_id);
    set(handles.menu_improfile,'text',lang_var{locb})
    [~, locb] = ismember('menu92',lang_id);
    set(handles.menu_digitizer,'text',lang_var{locb})
    % Time series
    [~, locb] = ismember('menu100',lang_id);
    set(handles.menu_prewhiten,'text',lang_var{locb})
    [~, locb] = ismember('menu101',lang_id);
    set(handles.menu_smooth1,'text',lang_var{locb})
    [~, locb] = ismember('menu102',lang_id);
    set(handles.menu_bootstrap,'text',lang_var{locb})
    [~, locb] = ismember('menu103',lang_id);
    set(handles.menu_smooth,'text',lang_var{locb})
    [~, locb] = ismember('menu104',lang_id);
    set(handles.menu_movGauss,'text',lang_var{locb})
    [~, locb] = ismember('menu105',lang_id);
    set(handles.menu_movmedian,'text',lang_var{locb})
    [~, locb] = ismember('menu106',lang_id);
    set(handles.menu_whiten,'text',lang_var{locb})
    [~, locb] = ismember('menu107',lang_id);
    set(handles.menu_power,'text',lang_var{locb})
    [~, locb] = ismember('menu108',lang_id);
    set(handles.menu_period,'text',lang_var{locb})
    [~, locb] = ismember('menu109',lang_id);
    set(handles.menu_waveletGUI,'text',lang_var{locb})
    [~, locb] = ismember('menu110',lang_id);
    set(handles.menu_CSA,'text',lang_var{locb})
    [~, locb] = ismember('menu128',lang_id);
    set(handles.menu_recplot,'text',lang_var{locb})
    [~, locb] = ismember('menu111',lang_id);
    set(handles.menu_coh,'text',lang_var{locb})
    [~, locb] = ismember('menu112',lang_id);
    set(handles.menu_leadlag,'text',lang_var{locb})
    [~, locb] = ismember('menu113',lang_id);
    set(handles.menu_filter,'text',lang_var{locb})
    [~, locb] = ismember('menu114',lang_id);
    set(handles.menu_dynfilter,'text',lang_var{locb})
    [~, locb] = ismember('menu115',lang_id);
    set(handles.menu_AM,'text',lang_var{locb})
    [~, locb] = ismember('menu116',lang_id);
    set(handles.menu_agebuild,'text',lang_var{locb})
    [~, locb] = ismember('menu117',lang_id);
    set(handles.menu_sr2age,'text',lang_var{locb})
    [~, locb] = ismember('menu118',lang_id);
    set(handles.menu_age,'text',lang_var{locb})
    [~, locb] = ismember('menu119',lang_id);
    set(handles.menu_correlation,'text',lang_var{locb})
    [~, locb] = ismember('menu120',lang_id);
    set(handles.menu_pda,'text',lang_var{locb})
    [~, locb] = ismember('menu121',lang_id);
    set(handles.menu_sednoise,'text',lang_var{locb})
    [~, locb] = ismember('menu122',lang_id);
    set(handles.menu_dynos,'text',lang_var{locb})
    [~, locb] = ismember('menu123',lang_id);
    set(handles.menu_rho,'text',lang_var{locb})
    [~, locb] = ismember('menu124',lang_id);
    set(handles.menu_ecoco,'text',lang_var{locb})
    [~, locb] = ismember('menu125',lang_id);
    set(handles.menu_timeOpt,'text',lang_var{locb})
    [~, locb] = ismember('menu126',lang_id);
    set(handles.menu_eTimeOpt,'text',lang_var{locb})
    [~, locb] = ismember('menu127',lang_id);
    set(handles.menu_specmoments,'text',lang_var{locb})
    %
    [~, locb] = ismember('menu140',lang_id);
    set(handles.menu_read,'text',lang_var{locb})
    [~, locb] = ismember('menu141',lang_id);
    set(handles.menu_manuals,'text',lang_var{locb})
    [~, locb] = ismember('menu142',lang_id);
    set(handles.menu_findupdates,'text',lang_var{locb})
    [~, locb] = ismember('l01',lang_id);
    set(handles.menu_lang,'text',lang_var{locb})
    [~, locb] = ismember('menu143',lang_id);
    set(handles.menu_contact,'text',lang_var{locb})
    [~, locb] = ismember('menu144',lang_id);
    set(handles.menu_email,'text',lang_var{locb})
    % unit language
    set(handles.main_unit_en,'Visible','on','Value',0)
    % listbox 1
    for ii = 1:6
        [~, locb] = ismember(['MainListOrder',num2str(ii)],lang_id);
        sortorder{ii} = lang_var{locb};
    end
    set(handles.popupmenu2,'String',sortorder)
else
    set(handles.main_unit_en,'Visible','off','Value',0)
end
%% push_up
h_push_up = uicontrol('Style','pushbutton','Tag','push_up');%,'BackgroundColor','white','ForegroundColor','white');  % set style, Tag
%jEdit = findjobj(h_push_up);   % find java
%jEdit.Border = [];  % hide border
set(h_push_up,'Units','normalized') % set units as normalized
set(h_push_up,'Position', [0.02,0.945,0.06,0.05]) % set position


[lia, locb] = ismember('menu08',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Up<br>one level';  % tooltip
end

set(h_push_up,'tooltip',tooltip,'CData',imread('menu_up.jpg'))  % set tooltip and button image
set(h_push_up,'Callback',@push_up_clbk)  % set callback function

%% push_folder
h_push_folder = uicontrol('Style','pushbutton','Tag','push_folder');%,'BackgroundColor','white');  % set style, Tag
% jEdit = findjobj(h_push_folder);   % find java
% jEdit.Border = [];  % hide border
set(h_push_folder,'Units','normalized') % set units as normalized
set(h_push_folder,'Position', [0.106,0.945,0.065,0.05]) % set position

[lia, locb] = ismember('menu09',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Open<br>working folder';  % tooltip
end

set(h_push_folder,'tooltip',tooltip,'CData',imread('menu_folder.jpg'))  % set tooltip and button image
set(h_push_folder,'Callback',@push_folder_clbk)  % set callback function

%% push_plot
h_push_plot = uicontrol('Style','pushbutton','Tag','push_plot');%,'BackgroundColor','white');  % set style, Tag
% jEdit = findjobj(h_push_plot);   % find java
% jEdit.Border = [];  % hide border
set(h_push_plot,'Units','normalized') % set units as normalized
set(h_push_plot,'Position', [0.2,0.945,0.06,0.05]) % set position

[lia, locb] = ismember('menu10',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Plot Pro';  % tooltip
end

set(h_push_plot,'tooltip',tooltip,'CData',imread('menu_plot.jpg'))  % set tooltip and button image
%set(h_push_plot,'Callback',@push_plot_clbk)  % set callback function
set(h_push_plot,'Callback',@push_plot_clbk)  % set callback function

%% push_refresh
h_push_refresh = uicontrol('Style','pushbutton','Tag','push_refresh');%,'BackgroundColor','white');  % set style, Tag
% jEdit = findjobj(h_push_refresh);   % find java
% jEdit.Border = [];  % hide border
set(h_push_refresh,'Units','normalized') % set units as normalized
set(h_push_refresh,'Position', [0.28,0.945,0.06,0.05]) % set position

[lia, locb] = ismember('menu11',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Refresh<br>list box';  % tooltip
end


set(h_push_refresh,'tooltip',tooltip,'CData',imread('menu_refresh.jpg'))  % set tooltip and button image
set(h_push_refresh,'Callback',@push_refresh_clbk)  % set callback function

%% push_robot
h_push_robot = uicontrol('Style','pushbutton','Tag','push_robot');%,'BackgroundColor','white');  % set style, Tag
% jEdit = findjobj(h_push_robot);   % find java
% jEdit.Border = [];  % hide border
set(h_push_robot,'Units','normalized') % set units as normalized
set(h_push_robot,'Position', [0.36,0.945,0.06,0.05]) % set position

[lia, locb] = ismember('menu12',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Mini-robot';  % tooltip
end


set(h_push_robot,'tooltip',tooltip,'CData',imread('menu_robot.jpg'))  % set tooltip and button image
set(h_push_robot,'Callback',@push_robot_clbk)  % set callback function

%% push_openfolder
h_push_openfolder = uicontrol('Style','pushbutton','Tag','push_openfolder');%,'BackgroundColor','white');  % set style, Tag
% jEdit = findjobj(h_push_openfolder);   % find java
% jEdit.Border = [];  % hide border
set(h_push_openfolder,'Units','normalized') % set units as normalized
set(h_push_openfolder,'Position', [0.02,0.9,0.06,0.04]) % set position

[lia, locb] = ismember('menu13',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Change<br>directory';  % tooltip
end

set(h_push_openfolder,'tooltip',tooltip,'CData',imread('menu_open.jpg'))  % set tooltip and button image
set(h_push_openfolder,'Callback',@push_openfolder_clbk)  % set callback function
%%
if ispc
    set(h_push_folder,'BackgroundColor','white') % 
    set(h_push_up,'BackgroundColor','white') % 
    set(h_push_plot,'BackgroundColor','white') % 
    set(h_push_refresh,'BackgroundColor','white') % 
    set(h_push_robot,'BackgroundColor','white') % 
    set(h_push_openfolder,'BackgroundColor','white') % 
end

% sort

[lia, locb] = ismember('menu15',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Sort<br>dataset';  % tooltip
end
if lang_choice > 0
    set(handles.popupmenu2,'position', [0.6,0.92,0.15,0.06],'tooltip',tooltip)
    set(handles.popupmenu1,'position', [0.76,0.92,0.13,0.06],'tooltip',tooltip)
else
    set(handles.popupmenu2,'position', [0.6,0.92,0.22,0.06],'tooltip',tooltip)
    set(handles.popupmenu1,'position', [0.83,0.92,0.13,0.06],'tooltip',tooltip)
end
% unit
[lia, locb] = ismember('menu14',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Select unit<br>for dataset';  % tooltip
end

% unit language
[lia, locb] = ismember('menu26',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = '<html>Unit in English';  % tooltip
end
set(handles.main_unit_en,'position', [0.89,0.955,0.07,0.025],'tooltip',tooltip,'Value',0)

% working directory
[lia, locb] = ismember('menu16',lang_id);
if lia
    tooltip = lang_var{locb};
else
    tooltip = 'Working directory';  % tooltip
end
set(handles.edit_acfigmain_dir,'position', [0.081,0.9,0.9,0.04],'tooltip',tooltip)
set(handles.listbox_acmain,'position', [0.02,0.008,0.96,0.884])

set(handles.listbox_acmain,'value', [])

if ismac
    handles.slash_v = '/';
elseif ispc
    handles.slash_v = '\';
end

handles.acfigmain = gcf;  %handles of the ac main window
figure(handles.acfigmain)
set(handles.acfigmain, 'WindowKeyPressFcn', @KeyPress)
h=get(gcf,'Children');  % get all content
h1=findobj(h,'FontUnits','norm');  % find all font units as points
set(h1,'FontUnits','points','FontSize',12);  % set as norm
h2=findobj(h,'FontUnits','points');  % find all font units as points
set(h2,'FontUnits','points','FontSize',11.5);  % set as norm

% Choose default command line output for AC
handles.output = hObject;
path_root = pwd;
set(handles.edit_acfigmain_dir,'String',path_root);
handles.foldname = 'foldname'; % default file name

handles.path_temp = [path_root,handles.slash_v,'temp'];
handles.working_folder = [handles.path_temp,handles.slash_v,handles.foldname];
% if ad_pwd.txt exist; then go to this folder
if exist('ac_pwd.txt', 'file') == 2
    GETac_pwd;
    if isdir(ac_pwd)
        cd(ac_pwd)
    end
else
    ac_pwd_str = which('refreshcolor.m');
    [ac_pwd_dir,~,~] = fileparts(ac_pwd_str);
    fileID = fopen(fullfile(ac_pwd_dir,'ac_pwd.txt'),'w');
    fprintf(fileID,'%s',pwd);
    fclose(fileID);
end
handles.sortdata = 'date descend';
handles.val1 = 4;
set(handles.popupmenu2,'value',handles.val1)
refreshcolor;
cd(path_root) %back to root path

handles.doubleclick = 0;
handles.unit = 'unit'; % default file name
handles.unit_type = 0;
handles.t1 = 55;
handles.f1 = 0.0;
handles.f2 = 0.08;
handles.sr1 = 1;
handles.sr2 = 30;
handles.srstep = .1;
handles.nsim = 2000;
handles.red = 2;
handles.adjust = 0;
handles.slices = 1;
handles.index_selected = 1;
handles.pad = 50000;
handles.prewhiten_linear = 'notlinear';
handles.prewhiten_lowess = 'notlowess';
handles.prewhiten_rlowess = 'notrlowess';
handles.prewhiten_loess = 'notloess';
handles.prewhiten_rloess = 'notloess';
handles.prewhiten_polynomial2 = 'not2nd';
handles.prewhiten_polynomialmore = 'notmore';
handles.MTMtabtchi = 'notabtchi';
handles.nw = 2;
handles.copycut = 'copy';
handles.nplot = 0;
handles.filetype = {'.txt','.csv','','.res','.dat','.out'};
handles.acfig = gcf;
handles.math_sort = 1;
handles.math_unique = 1;
handles.math_deleteempty = 1;
handles.math_derivative = 1;
assignin('base','unit',handles.unit)
assignin('base','unit_type',handles.unit_type)

% language
handles.lang_choice = lang_choice;
handles.lang_id = lang_id;
handles.lang_var = lang_var;

handles.main_unit_selection = get(handles.main_unit_en,'Value');
handles.popupmenu1_default = get(handles.popupmenu1,'String');

% Update handles structure
guidata(hObject, handles);

% Deployment doesn't work
% logo
if ispc
    try
        Ilogo = imread('acycle_logo.jpg');
        javaImage = im2java(Ilogo);
        newIcon = javax.swing.ImageIcon(javaImage);    
        figFrame = get(handles.acfigmain,'JavaFrame');
        figFrame.setFigureIcon(newIcon);
    catch
    end
end
% Deployment doesn't work


% Update reminder
pause(0.0001);%
% if isdeployed
%     copyright;
% end
%try 
    % If the software has not been used for 30 days, checking updates
%    ac_check_opendate;
%catch
%end
% bug fixed: window system32 may be the default working folder, but not
% writable.
try
    tempname1 = 'temp_test_acycle.txt';
    fileID = fopen(fullfile(pwd,tempname1),'w+');
    fprintf(fileID,'%s\n',datestr(datetime('now')));
    fclose(fileID);
    delete(tempname1)
catch
    
    [lia1, locb1] = ismember('menu17',lang_id);
    [~, locb2] = ismember('menu18',lang_id);
    [~, locb3] = ismember('menu19',lang_id);
    if lia1
        tooltip1 = lang_var{locb1};
        tooltip2 = lang_var{locb2};
        tooltip3 = lang_var{locb3};
    else
        tooltip1 = 'Change working folder. ';  % tooltip
        tooltip2 = 'Current working folder may be not writable!';
        tooltip3 = 'Folder';
    end
    msgbox([tooltip1,tooltip2],tooltip3);
end

% --- Outputs from this function are returned to the command line.
function varargout = AC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Mar 17, 2020
function KeyPress(hObject, EventData, handles)

handles = guidata(hObject);
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a20',lang_id);
    a20 = handles.lang_var{locb1};
    [~, locb1] = ismember('main29',lang_id);
    main29 = handles.lang_var{locb1};
    [~, locb] = ismember('a21',lang_id);
    a21 = handles.lang_var{locb};
end


if strcmp(EventData.Modifier,'control') 
    if strcmp(EventData.Key,'c')
    %disp('ctrl + c')
    contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
    plot_selected = get(handles.listbox_acmain,'Value');
    nplot = length(plot_selected);   % length
    CDac_pwd;
    handles.nplot = nplot;
        handles.data_name = {};
        handles.file = {};
        for i = 1 : nplot
           filename = char(contents(plot_selected(i)));
           handles.data_name{i} = strrep2(filename, '<HTML><FONT color="blue">', '</FONT></HTML>');
           handles.file{i} = [ac_pwd,handles.slash_v,handles.data_name{i}];
        end
    handles.copycut = 'copy';
    cd(pre_dirML);
    guidata(hObject, handles);
    end
end
if strcmp(EventData.Modifier,'control')
    if strcmp(EventData.Key,'x')
    %disp('ctrl + x')
    contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
    plot_selected = get(handles.listbox_acmain,'Value');
    nplot = length(plot_selected);   % length
    CDac_pwd;
    handles.nplot = nplot;
        handles.data_name = {};
        handles.file = {};
        for i = 1 : nplot
           filename = char(contents(plot_selected(i)));
           handles.data_name{i} = strrep2(filename, '<HTML><FONT color="blue">', '</FONT></HTML>');
           handles.file{i} = [ac_pwd,handles.slash_v,handles.data_name{i}];
        end
    handles.copycut = 'cut';
    cd(pre_dirML);
    guidata(hObject, handles);
    end
end
if strcmp(EventData.Modifier,'control')
    if strcmp(EventData.Key,'v')
    %disp('ctrl + v')
    CDac_pwd;
    copycut = handles.copycut; % cut or copy
    nplot = handles.nplot; % number of selected files
    if nplot == 0
        return
    end
    for i = 1:nplot
        if strcmp(copycut,'cut')
            new_name = handles.data_name{i};
            new_name_w_dir = [ac_pwd,handles.slash_v,new_name];
            if exist(new_name_w_dir)
                if handles.lang_choice == 0
                    answer = questdlg(['Cover existed file ',new_name,'?'],...
                        'Warning',...
                        'Yes','No','No');
                else
                    answer = questdlg([a20,new_name,'?'],...
                        main29,'Yes','No','No');
                    
                end
                % Handle response
                switch answer
                    case 'Yes'
                        movefile(handles.file{i}, ac_pwd)
                    case 'No'
                end
            else
                movefile(handles.file{i}, ac_pwd)
            end
        elseif strcmp(copycut,'copy')
            % paste copied files
            try
                new_name = handles.data_name{i};
                new_name_w_dir = [ac_pwd,handles.slash_v,new_name];
                if exist(new_name_w_dir)
                    [~,dat_name,ext] = fileparts(new_name);
                    for i = 1:100
                        new_name = [dat_name,'_copy',num2str(i),ext];
                        if exist([ac_pwd,handles.slash_v,new_name])
                        else
                            break
                        end
                    end
                end
                new_file = [ac_pwd,handles.slash_v,new_name];
                file_list = handles.file;
                copyfile(file_list{i}, new_file)
            catch
                if handles.lang_choice == 0
                    disp('No data copied')
                else
                    disp(a21)
                end
            end
        end
    end
    d = dir; %get files
    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
    refreshcolor;
    if isdir(pre_dirML)
        cd(pre_dirML);
    end
    guidata(hObject,handles)
    end
end


function push_up_clbk(hObject, handles)
handles = guidata(hObject);
CDac_pwd; % cd working dir
cd ..;
refreshcolor;
cd(pre_dirML); % return view dir
guidata(hObject,handles)


function push_folder_clbk(hObject, handles)

handles = guidata(hObject);
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a22',lang_id);
    a22 = handles.lang_var{locb1};
end

GETac_pwd;
if ismac
    try
        system(['open ',ac_pwd]);
    catch
        if handles.lang_choice == 0
            disp('  error: space between folder name')
        else
            disp(a22)
        end
    end
elseif ispc
    winopen(ac_pwd);
end


function push_plot_clbk(hObject, handles)
handles = guidata(hObject);

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('dd01',lang_id);
    dd01 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd24',lang_id);
    dd24 = handles.lang_var{locb1};
end

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
check = [];

% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,dat_name,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        elseif sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0

            imfinfo1 = imfinfo(plot_filter_s); % image information
            supportcolor = {'grayscale', 'truecolor'};

            if strcmp(imfinfo1.ColorType,'CIELab')
                im_name = imread(plot_filter_s);

                aDouble = double(im_name); 

                cielab(:,:,1) = aDouble(:,:,1) ./ (255/100);
                cielab(:,:,2) = aDouble(:,:,2)-128;
                cielab(:,:,3) = aDouble(:,:,3)-128;
                hFig1 = figure;                    
                subplot(3,1,1)
                imshow(cielab(:,:,1),[0 100])
                title('L*')
                subplot(3,1,2)
                imshow(cielab(:,:,2),[-128 127])
                title('a*')
                subplot(3,1,3)
                imshow(cielab(:,:,3),[-128 127])
                title('b*')
                set(gcf,'Name',[dat_name,ext],'NumberTitle','off')

                hFig2 = figure;
                imshow(lab2rgb(cielab));
                set(gcf,'Name',[dat_name,'Lab2RGB',ext],'NumberTitle','off')

            elseif any(strcmp(supportcolor,imfinfo1.ColorType))
                im_name = imread(plot_filter_s);
                hFig1 = figure;
                imshow(im_name);
                set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                [warnMsg, warnId] = lastwarn;
                if ~isempty(warnMsg)
                    close(hFig1)
                    imscrollpanel_ac(plot_filter_s);
                end
            else
                try
                    % GRB and Grayscale supported here
                    im_name = imread(plot_filter_s);
                    hFig1 = figure;
                    lastwarn('') % Clear last warning message
                    imshow(im_name);
                    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                    [warnMsg, warnId] = lastwarn;
                    if ~isempty(warnMsg)
                        close(hFig1)
                        imscrollpanel_ac(data_name);
                    end
                catch
                    if handles.lang_choice == 0
                        warndlg('Image color space not supported. Convert to RGB or Grayscale')
                    else
                        warndlg(dd24)
                    end
                end
            end
        end
    end
end
if check == 1
    GETac_pwd; 
    for i = 1: nplot
        plot_no = plot_selected(i);
        handles.plot_s{i} = fullfile(ac_pwd,char(contents(plot_no)));
    end
    current_data = load(handles.plot_s{1});
    handles.current_data = current_data;
    handles.dat_name = handles.plot_s{1};
    handles.nplot = nplot;
    guidata(hObject, handles);
    PlotPro2DLineGUI(handles);
end


% --- Executes on button press in push_refresh.
function push_refresh_clbk(hObject, handles)
handles = guidata(hObject);
CDac_pwd; % cd working dir
refreshcolor;
cd(pre_dirML); % return view dir

% --- Executes on button press in push_openfolder.
function push_openfolder_clbk(hObject, eventdata, handles)
handles = guidata(hObject);


%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a24',lang_id);
    a24 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd24',lang_id);
    dd24 = handles.lang_var{locb1};
end

pre_dirML = pwd;
GETac_pwd;
selpath = uigetdir(ac_pwd);
if selpath == 0
else
    if isdir(selpath)
        if handles.lang_choice == 0
            disp(['>>  Change working folder to ',selpath])
        else
            disp([a24,selpath])
        end
        cd(selpath)
        refreshcolor;
        cd(pre_dirML); % return view dir
    end
end


% --- Executes on button press in push_robot.
function push_robot_clbk(hObject, eventdata, handles)
% hObject    handle to push_robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a25',lang_id);
    a25 = handles.lang_var{locb1};
    [~, locb1] = ismember('a26',lang_id);
    a26 = handles.lang_var{locb1};
    [~, locb1] = ismember('a27',lang_id);
    a27 = handles.lang_var{locb1};
    [~, locb1] = ismember('a28',lang_id);
    a28 = handles.lang_var{locb1};
    [~, locb1] = ismember('a29',lang_id);
    a29 = handles.lang_var{locb1};
    [~, locb1] = ismember('a30',lang_id);
    a30 = handles.lang_var{locb1};
    [~, locb1] = ismember('a31',lang_id);
    a31 = handles.lang_var{locb1};
    [~, locb1] = ismember('a32',lang_id);
    a32 = handles.lang_var{locb1};
    [~, locb1] = ismember('a33',lang_id);
    a33 = handles.lang_var{locb1};
end

unit = handles.unit;
unit_type = handles.unit_type;
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
check = 0;
% check

% fix a bug in wavelet ...
%
%#function fminbnd
%#function chisquare_solve

for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
    else
        [~,dat_name,ext] = fileparts(plot_filter_s);
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        end
    end
end

if check == 1
    for i = 1:nplot
        plot_no = plot_selected(i);
        plot_filter_s1 = char(contents(plot_no));
        GETac_pwd; 
        plot_filter_s = fullfile(ac_pwd,plot_filter_s1);
        try
            data_filterout = load(plot_filter_s);
        catch       
            fid = fopen(plot_filter_s);
            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
            fclose(fid);
            if iscell(data_ft)
                try
                    data_filterout = cell2mat(data_ft);
                catch
                    fid = fopen(plot_filter_s,'at');
                    fprintf(fid,'%d\n',[]);
                    fclose(fid);
                    fid = fopen(plot_filter_s);
                    data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                    if handles.lang_choice == 0
                        disp(['>>  Read data: ', dat_name])
                    else
                        disp([a25, dat_name])
                    end
                    fclose(fid);
                    try
                        data_filterout = cell2mat(data_ft);
                    catch
                        if handles.lang_choice == 0
                            warndlg(['Check selected data: ',dat_name],'Data Error!')
                        else
                            warndlg([a26,dat_name],a27)
                        end
                    end
                end
            end
        end
        handles.data_filterout = data_filterout;
        handles.dat_name = dat_name;
        guidata(hObject, handles);
        RobotGUI(handles)
        
    end
else
    if handles.lang_choice == 0
        warndlg({'No selected data';'';...
            'Please first select at leaset one *.txt data file.';...
            '';'FORMAT:';'';'<No header>';'';...
            '1st column: depth or time';'';'2nd column: value';''})
    else
        warndlg({a28;'';...
            a29;...
            '';a30;'';a31;'';...
            a32;'';a33;''})
    end
end


% --- Executes on selection change in listbox_acmain.
function listbox_acmain_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acmain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acmain contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acmain

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a23',lang_id);
    a23 = handles.lang_var{locb1};
    [~, locb1] = ismember('a24',lang_id);
    a24 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd24',lang_id);
    dd24 = handles.lang_var{locb1};
    [~, locb1] = ismember('a34',lang_id);
    a34 = handles.lang_var{locb1};
end


persistent chk
if isempty(chk)
      chk = 1;
      pause(0.35); %Add a delay to distinguish single click from a double click
      if chk == 1
          chk = [];
          handles.doubleclick = 0;
      end
else
      chk = [];
      handles.doubleclick = 1;
end

        
if handles.doubleclick
    index_selected = get(hObject,'Value');
    file_list = get(hObject,'String');
    filename = file_list{index_selected};
    try
        % if selected item is a folder, try to open the folder.
        CDac_pwd; % cd working dir
        filename1 = strrep2(filename, '<HTML><FONT color="blue">', '</FONT></HTML>');
        filename = fullfile(ac_pwd,filename1);
        cd(filename)
        refreshcolor;
        cd(pre_dirML);
        if handles.lang_choice == 0
            disp(['>>  Change directory to < ', filename1, ' >'])
        else
            disp([a24,' < ', filename1, ' >'])
        end
    catch
        [~,dat_name,ext] = fileparts(filename);
        filetype = handles.filetype;
        %disp(ext)
        if isdeployed
            % bug start:   Warning: The Open function cannot be used in compiled applications.
            if strcmp(ext,'.fig')
                try openfig(filename)
                catch
                    GETac_pwd;
                    if ispc
                        winopen(ac_pwd);
                    elseif ismac
                        system(['open ',ac_pwd]);
                    end
                end
            elseif ismember(ext,{'.txt','.csv','.res','.dat'})
                try
                    [data1,~] = importdata(filename);
                    if isstruct(data1)
                        data1 = data1.data;
                    end
                    nlen = length(data1(:,1));
                    ncol = length(data1(1,:));
                    % open in GUI
                    ftab = figure;%('Position',[200 200 400 150]);
                    set(0,'Units','normalized') % set units as normalized
                    set(gcf,'units','norm') % set location
                    set(ftab,'Name',[dat_name,ext],'NumberTitle','off')
                    widthtab = .05 + .05*ncol;
                    if widthtab > 0.4; widthtab = 0.4; end                  
                    set(ftab,'Position',[.3 .2 widthtab .7]) % set location
                    t = uitable('Parent',ftab,'Data',data1,'Units','normalized','Position',[0.011,0.012,0.97,0.984]);

                    if nlen > 15
                        %msgbox('See Terminal/Command Window for details')
                        disp(['>>  ',dat_name,ext])
                        disp(['>>  Total rows: ', num2str(nlen)])
                        disp('>>  First 10 and last 5 rows:')
                        disp(data1(1:10,:))
                        disp('       ... ...')
                        disp(data1(end-4:end,:))
                    else
                        %msgbox('See Terminal/Command Window for details')
                        disp('>>  Data:')
                        disp(data1)
                    end
                catch
                    if ispc
                        winopen(ac_pwd);
                    elseif ismac
                        system(['open ',ac_pwd]);
                    else
                    end
                end
            elseif ismember(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})
                try
                    if handles.lang_choice == 0
                        hwarn = warndlg('Wait, large image? can be very slow ...');
                    else
                        hwarn = warndlg(a23);
                    end
                    im_name = imread(filename);
                    hFig1 = figure;
                    lastwarn('') % Clear last warning message
                    imshow(im_name);
                    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                    [warnMsg, warnId] = lastwarn;
                    if ~isempty(warnMsg)
                        close(hFig1)
                        imscrollpanel_ac(filename);
                    end
                    try close(hwarn)
                    catch
                    end
                catch
                    if handles.lang_choice == 0
                        warndlg('Image color space not supported. Convert to RGB or Grayscale')
                    else
                        warndlg(dd24)
                    end

                end
            elseif ismember(ext,{'.pdf'})
                openpdf(filename)
            else
                if ispc
                    winopen(ac_pwd);
                elseif ismac
                    system(['open ',ac_pwd]);
                else
                end
            end
            % bug end:   Warning: The Open function cannot be used in compiled applications.
        else
            if strcmp(ext,'.fig')
                try
                    openfig(filename);
                    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                catch
                end
            elseif ismember(ext,{'.txt','.csv','.res','.dat'})
                try
                    system(['open ',filename]);
                catch
                 try
                    
                    [data1,~] = importdata(filename);
                    if isstruct(data1)
                        data1 = data1.data;
                    end
                    nlen = length(data1(:,1));
                    ncol = length(data1(1,:));
                    % open in GUI
                    ftab = figure;%('Position',[200 200 400 150]);
                    set(0,'Units','normalized') % set units as normalized
                    set(gcf,'units','norm') % set location
                    set(ftab,'Name',[dat_name,ext],'NumberTitle','off')
                    widthtab = .05 + .05*ncol;
                    if widthtab > 0.4; widthtab = 0.4; end                  
                    set(ftab,'Position',[.3 .2 widthtab .7]) % set location
                    t = uitable('Parent',ftab,'Data',data1,'Units','normalized','Position',[0.011,0.012,0.97,0.984]);
                    
                catch
                    [data1,~] = importdata(filename);
                    try
                        nlen = length(data1(:,1));
                        if nlen> 15
                            if handles.lang_choice == 0
                                msgbox('See Terminal/Command Window for details')
                            else
                                msgbox(a34)
                            end
                            disp(['>>  ',dat_name,ext])
                            disp(['>>  Total rows: ', num2str(nlen)])
                            disp('>>  First 10 and last 5 rows:')
                            disp(data1(1:10,:))
                            disp('                  ... ...')
                            disp(data1(end-4:end,:))
                        else
                            if handles.lang_choice == 0
                                msgbox('See Terminal/Command Window for details')
                            else
                                msgbox(a34)
                            end
                            disp('>> Data:')
                            disp(data1)
                        end
                    catch
                        try system(['open ',filename]);
                        catch
                            if ispc
                                winopen(ac_pwd);
                            elseif ismac
                                system(['open ',ac_pwd]);
                            else
                            end
                        end
                    end
                 end
                end
            elseif ismember(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})
                try
                    system(['open ',filename]);
                catch
                    try 
                        if handles.lang_choice == 0
                            hwarn = warndlg('Wait, large image? can be very slow ...');
                        else
                            hwarn = warndlg(a23);
                        end
                        im_name = imread(filename);
                        hFig1 = figure;
                        lastwarn('') % Clear last warning message
                        imshow(im_name);
                        set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                        [warnMsg, warnId] = lastwarn;
                        if ~isempty(warnMsg)
                            close(hFig1)
                            imscrollpanel_ac(filename);
                        end
                        %hwarn = warndlg('Wait, large image? can be very slow ...');
                        try close(hwarn)
                        catch
                        end
                    catch
                        if handles.lang_choice == 0
                            warndlg('Image color space not supported. Convert to RGB or Grayscale')
                        else
                            warndlg(dd24)
                        end

                    end
                end
            elseif ismember(ext,{'.pdf','.ai','.ps'})
                try
                    uiopen(filename,1);
                catch
                end
            elseif ismember(ext,{'.doc','.docx','.ppt','.pptx','.xls','.xlsx'})
                try
                    uiopen(filename,1);
                catch
                end
            else
                GETac_pwd;
                if ispc
                    winopen(ac_pwd);
                elseif ismac
                    system(['open ',ac_pwd]);
                else
                end
            end
        end
    end
else
    handles.index_selected  = get(hObject,'Value');
end
guidata(hObject,handles)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over listbox_acmain.
function listbox_acmain_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acmain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function listbox_acmain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acmain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_acfigmain_dir_Callback(hObject, eventdata, handles)
% hObject    handle to edit_acfigmain_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_acfigmain_dir as text
%        str2double(get(hObject,'String')) returns contents of edit_acfigmain_dir as a double

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a35',lang_id);
    a35 = handles.lang_var{locb1};
end


address = get(hObject,'String');
CDac_pwd;
if isdir(address)
    cd(address)
else
    if handles.lang_choice == 0
        errordlg('Error: address not exist')
    else
        errordlg(a35)
    end
end
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML);
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function edit_acfigmain_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_acfigmain_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function menu_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)
% hObject    handle to menu_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function menu_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_edit_Callback(hObject, eventdata, handles)
% hObject    handle to menu_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function menu_plotall_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function menu_plotall_Callback(hObject, eventdata, handles)
% hObject    handle to menu_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function menu_plot_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plotall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length


%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a23',lang_id);
    a23 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('dd24',lang_id);
    dd24 = handles.lang_var{locb1};
    [~, locb1] = ismember('a26',lang_id);
    a26 = handles.lang_var{locb1};
    [~, locb1] = ismember('a27',lang_id);
    a27 = handles.lang_var{locb1};
    [~, locb1] = ismember('a36',lang_id);
    a36 = handles.lang_var{locb1};
    [~, locb1] = ismember('a37',lang_id);
    a37 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('a38',lang_id);
    a38 = handles.lang_var{locb1};
    [~, locb1] = ismember('a39',lang_id);
    a39 = handles.lang_var{locb1};
    [~, locb1] = ismember('a40',lang_id);
    a40 = handles.lang_var{locb1};
    [~, locb1] = ismember('main34',lang_id);
    main34 = handles.lang_var{locb1};
    [~, locb1] = ismember('main23',lang_id);
    main23 = handles.lang_var{locb1};
    [~, locb1] = ismember('main21',lang_id);
    main21 = handles.lang_var{locb1};
end


% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    if isdir(plot_filter_s)
        return
    else
        [~,dat_name,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        elseif strcmp(ext,'.fig')
            plot_filter_s = char(contents(plot_selected(1)));
            try openfig(plot_filter_s);
            catch
            end
        elseif strcmp(ext,{'.pdf','.ai','.ps'})
            plot_filter_s = char(contents(plot_selected(1)));
            open(plot_filter_s);
        elseif sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0

            if handles.lang_choice == 0
                hwarn = warndlg('Wait, large image? can be very slow ...');
            else
                hwarn = warndlg(a23);
            end
            imfinfo1 = imfinfo(plot_filter_s); % image information
            supportcolor = {'grayscale', 'truecolor'};

            if strcmp(imfinfo1.ColorType,'CIELab')
                im_name = imread(plot_filter_s);

                aDouble = double(im_name); 

                cielab(:,:,1) = aDouble(:,:,1) ./ (255/100);
                cielab(:,:,2) = aDouble(:,:,2)-128;
                cielab(:,:,3) = aDouble(:,:,3)-128;
                hFig1 = figure;                    
                subplot(3,1,1)
                imshow(cielab(:,:,1),[0 100])
                title('L*')
                subplot(3,1,2)
                imshow(cielab(:,:,2),[-128 127])
                title('a*')
                subplot(3,1,3)
                imshow(cielab(:,:,3),[-128 127])
                title('b*')
                set(gcf,'Name',[dat_name,ext],'NumberTitle','off')

                hFig2 = figure;
                imshow(lab2rgb(cielab));
                set(gcf,'Name',[dat_name,'Lab2RGB',ext],'NumberTitle','off')

            elseif any(strcmp(supportcolor,imfinfo1.ColorType))
                im_name = imread(plot_filter_s);
                hFig1 = figure;
                imshow(im_name);
                set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                [warnMsg, warnId] = lastwarn;
                if ~isempty(warnMsg)
                    close(hFig1)
                    imscrollpanel_ac(plot_filter_s);
                end
            else
                try
                    % GRB and Grayscale supported here
                    im_name = imread(plot_filter_s);
                    hFig1 = figure;
                    lastwarn('') % Clear last warning message
                    imshow(im_name);
                    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                    [warnMsg, warnId] = lastwarn;
                    if ~isempty(warnMsg)
                        close(hFig1)
                        imscrollpanel_ac(data_name);
                    end
                catch
                    if handles.lang_choice == 0
                        warndlg('Image color space not supported. Convert to RGB or Grayscale')
                    else
                        hwarn = warndlg(dd24);
                    end
                end
            end
        end
        
    end
end
plotsucess = 0;
if check == 1
    figf = figure;
    hold on;
    for i = 1:nplot
        plot_no = plot_selected(i);
        plot_filter_s1 = char(contents(plot_no));
        GETac_pwd; 
        plot_filter_s = fullfile(ac_pwd,plot_filter_s1);
        [~,plotseries,~] = fileparts(plot_filter_s);
        handles.plot_list{i} = plotseries;
        try
            data_filterout = load(plot_filter_s);
        catch       
            fid = fopen(plot_filter_s);
            try data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                fclose(fid);
                if iscell(data_ft)
                    try
                        data_filterout = cell2mat(data_ft);
                    catch
                        fid = fopen(plot_filter_s,'at');
                        fprintf(fid,'%d\n',[]);
                        fclose(fid);
                        fid = fopen(plot_filter_s);
                        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                        fclose(fid);
                        try
                            data_filterout = cell2mat(data_ft);
                        catch
                            if handles.lang_choice == 0
                                warndlg(['Check data: ',dat_name],'Data Error!')
                            else
                                warndlg([a26,dat_name],a27)
                            end
                        end
                    end
                end
            catch
                if handles.lang_choice == 0
                    warndlg({'Cannot find the data.'; 'Folder Name may contain NO language other than ENGLISH'})
                else
                    warndlg({a36; a37})
                end
                try
                    close(figf);
                catch
                end
            end
        end     

        data_filterout = data_filterout(~any(isnan(data_filterout),2),:);
        
        
        try plot(data_filterout(:,1),data_filterout(:,2:end),'LineWidth',1)
            plotsucess = 1;
            % save current data for R
            assignin('base','currentdata',data_filterout);
            datar = num2str(data_filterout(1,2));
            for ii=2:length(data_filterout(:,1))
                r1 =data_filterout(ii,2); 
                datar = [datar,',',num2str(r1)];
            end
            assignin('base','currentdataR',datar);
            %
        catch
            if handles.lang_choice == 0
                errordlg([plot_filter_s1,' : data error. Check data'],'Data Error')
            else
                errordlg([plot_filter_s1,' : data error. Check data'],'Data Error')
            end
            if handles.lang_choice == 0
                errordlg([plot_filter_s1,' : data error. Check data'],'Data Error')
            else
                errordlg([a26,plot_filter_s1],a27)
                warndlg([a26,dat_name],a27)
            end
            if plotsucess > 0
            else
                close(figf)
                continue
            end   
        end
    end
    set(gca,'XMinorTick','on','YMinorTick','on')
    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
        if handles.unit_type == 0
            xlabel(['Unit (',handles.unit,')'])
        elseif handles.unit_type == 1
            xlabel(['Depth (',handles.unit,')'])
        else
            xlabel(['Time (',handles.unit,')'])
        end
    else
        if handles.unit_type == 0
            xlabel([main34,' (',handles.unit,')'])
        elseif handles.unit_type == 1
            xlabel([main23,' (',handles.unit,')'])
        else
            xlabel([main21, ' (',handles.unit,')'])
        end
    end
    %title(plot_filter_s1, 'Interpreter', 'none')
    legend(handles.plot_list, 'Interpreter', 'none')
    hold off
    set(gcf,'color','w');
    if handles.lang_choice == 0
        set(gcf,'Name','Acycle: Plot Preview','NumberTitle','off');
    else
        set(gcf,'Name',a38,'NumberTitle','off');
    end
    % multiple column data
    if plotsucess > 0
        try
        coln = length(data_filterout(1,:)); % 1: end
        colnend = coln -1;
        if and(nplot == 1, colnend > 1)            
            if coln < 7
                figf2 = figure;
                for colni = 2:coln
                    subplot(colnend,1,colni-1)
                    plot(data_filterout(:,1),data_filterout(:,colni),'LineWidth',1)
                    set(gca,'XMinorTick','on','YMinorTick','on')
                    if handles.unit_type == 0
                        title(['Column #', num2str(colni)], 'Interpreter', 'none')
                    else
                        title([a39, num2str(colni),a40], 'Interpreter', 'none')
                    end
                    set(figf2,'Name',[dat_name,ext],'NumberTitle','off')
                    if handles.unit_type == 0
                        xlabel(['Unit (',handles.unit,')'])
                    elseif handles.unit_type == 1
                        xlabel(['Depth (',handles.unit,')'])
                    else
                        xlabel(['Time (',handles.unit,')'])
                    end
                end
            elseif coln < 13
                figf2 = figure;
                colnhf= ceil(colnend/2);
                for colni = 2:coln
                    subplot(colnhf,2,colni-1)
                    plot(data_filterout(:,1),data_filterout(:,colni),'LineWidth',1)
                    set(gca,'XMinorTick','on','YMinorTick','on')
                    if handles.unit_type == 0
                        title(['Column #', num2str(colni)], 'Interpreter', 'none')
                    else
                        title([a39, num2str(colni),a40], 'Interpreter', 'none')
                    end
                    set(figf2,'Name',[dat_name,ext],'NumberTitle','off')
                    
                    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                        if handles.unit_type == 0
                            xlabel(['Unit (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel(['Depth (',handles.unit,')'])
                        else
                            xlabel(['Time (',handles.unit,')'])
                        end
                    else
                        if handles.unit_type == 0
                            xlabel([main34,' (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel([main23,' (',handles.unit,')'])
                        else
                            xlabel([main21, ' (',handles.unit,')'])
                        end
                    end
                end
            elseif coln < 19
                figf2 = figure;
                colnhf= ceil(colnend/3);
                for colni = 2:coln
                    subplot(colnhf,3,colni-1)
                    plot(data_filterout(:,1),data_filterout(:,colni),'LineWidth',1)
                    set(gca,'XMinorTick','on','YMinorTick','on')
                    if handles.unit_type == 0
                        title(['Column #', num2str(colni)], 'Interpreter', 'none')
                    else
                        title([a39, num2str(colni),a40], 'Interpreter', 'none')
                    end
                    set(figf2,'Name',[dat_name,ext],'NumberTitle','off')

                    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                        if handles.unit_type == 0
                            xlabel(['Unit (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel(['Depth (',handles.unit,')'])
                        else
                            xlabel(['Time (',handles.unit,')'])
                        end
                    else
                        if handles.unit_type == 0
                            xlabel([main34,' (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel([main23,' (',handles.unit,')'])
                        else
                            xlabel([main21, ' (',handles.unit,')'])
                        end
                    end
                end
            elseif coln < 25
                figf2 = figure;
                colnhf= ceil(colnend/4);
                for colni = 2:coln
                    subplot(colnhf,4,colni-1)
                    plot(data_filterout(:,1),data_filterout(:,colni),'LineWidth',1)
                    set(gca,'XMinorTick','on','YMinorTick','on')
                    if handles.unit_type == 0
                        title(['Column #', num2str(colni)], 'Interpreter', 'none')
                    else
                        title([a39, num2str(colni),a40], 'Interpreter', 'none')
                    end
                    set(figf2,'Name',[dat_name,ext],'NumberTitle','off')

                    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                        if handles.unit_type == 0
                            xlabel(['Unit (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel(['Depth (',handles.unit,')'])
                        else
                            xlabel(['Time (',handles.unit,')'])
                        end
                    else
                        if handles.unit_type == 0
                            xlabel([main34,' (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel([main23,' (',handles.unit,')'])
                        else
                            xlabel([main21, ' (',handles.unit,')'])
                        end
                    end
                end
            else
                colnhf= ceil(24/4);
                figf2 = figure;
                for colni = 2:25
                    subplot(colnhf,4,colni-1)
                    plot(data_filterout(:,1),data_filterout(:,colni),'LineWidth',1)
                    set(gca,'XMinorTick','on','YMinorTick','on')
                    set(figf2,'Name',[dat_name,ext],'NumberTitle','off')
                    if handles.unit_type == 0
                        title(['Column #', num2str(colni)], 'Interpreter', 'none')
                    else
                        title([a39, num2str(colni),a40], 'Interpreter', 'none')
                    end

                    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                        if handles.unit_type == 0
                            xlabel(['Unit (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel(['Depth (',handles.unit,')'])
                        else
                            xlabel(['Time (',handles.unit,')'])
                        end
                    else
                        if handles.unit_type == 0
                            xlabel([main34,' (',handles.unit,')'])
                        elseif handles.unit_type == 1
                            xlabel([main23,' (',handles.unit,')'])
                        else
                            xlabel([main21, ' (',handles.unit,')'])
                        end
                    end
                end
                if coln<50
                    figf2 = figure;
                    for colni = 26:coln
                        subplot(colnhf,4,colni-25)
                        plot(data_filterout(:,1),data_filterout(:,colni),'LineWidth',1)
                        set(gca,'XMinorTick','on','YMinorTick','on')
                        if handles.unit_type == 0
                            title(['Column #', num2str(colni)], 'Interpreter', 'none')
                        else
                            title([a39, num2str(colni),a40], 'Interpreter', 'none')
                        end
                        set(figf2,'Name',[dat_name,ext],'NumberTitle','off')

                        if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                            if handles.unit_type == 0
                                xlabel(['Unit (',handles.unit,')'])
                            elseif handles.unit_type == 1
                                xlabel(['Depth (',handles.unit,')'])
                            else
                                xlabel(['Time (',handles.unit,')'])
                            end
                        else
                            if handles.unit_type == 0
                                xlabel([main34,' (',handles.unit,')'])
                            elseif handles.unit_type == 1
                                xlabel([main23,' (',handles.unit,')'])
                            else
                                xlabel([main21, ' (',handles.unit,')'])
                            end
                        end
                    end
                else
                    figf2 = figure;
                    for colni = 26:49
                        subplot(6,4,colni-25)
                        plot(data_filterout(:,1),data_filterout(:,colni),'LineWidth',1)
                        set(gca,'XMinorTick','on','YMinorTick','on')
                        if handles.unit_type == 0
                            title(['Column #', num2str(colni)], 'Interpreter', 'none')
                        else
                            title([a39, num2str(colni),a40], 'Interpreter', 'none')
                        end
                        set(figf2,'Name',[dat_name,ext],'NumberTitle','off')
                        if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                            if handles.unit_type == 0
                                xlabel(['Unit (',handles.unit,')'])
                            elseif handles.unit_type == 1
                                xlabel(['Depth (',handles.unit,')'])
                            else
                                xlabel(['Time (',handles.unit,')'])
                            end
                        else
                            if handles.unit_type == 0
                                xlabel([main34,' (',handles.unit,')'])
                            elseif handles.unit_type == 1
                                xlabel([main23,' (',handles.unit,')'])
                            else
                                xlabel([main21, ' (',handles.unit,')'])
                            end
                        end
                    end
                end
            end        
        end
        catch
            plot(data_filterout(:,1),data_filterout(:,2:end),'LineWidth',1)
        end
    end
end
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function menu_basic_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_basic_Callback(hObject, eventdata, handles)
% hObject    handle to menu_basic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function menu_math_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_math_Callback(hObject, eventdata, handles)
% hObject    handle to menu_math (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function menu_help_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_help_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
str = get(hObject, 'String');
val = get(hObject,'Value');

handles.unit = str{val};

if ismember(val, [0, 8, 16])
    handles.unit_type = 0;
elseif ismember(val, 2:7)
    handles.unit_type = 1;
elseif ismember(val, 9:15)
    handles.unit_type = 2;
elseif ismember(val, 17:22)
    handles.unit_type = 2;
end

assignin('base','unit',handles.unit)
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function menu_read_Callback(hObject, eventdata, handles)
% hObject    handle to menu_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
filename = 'UpdateLog.txt';
url = 'https://github.com/mingsongli/acycle/blob/master/doc/UpdateLog.txt';
if isdeployed
    web(url,'-browser')
else
    try uiopen(filename,1);
    catch
        if ispc
            try open(filename)
            catch
                try winopen(filename)
                catch
                    try web(url,'-browser')
                    catch
                    end
                end
            end
        elseif ismac
                try system(['open ',filename]);
                catch
                    try web(url,'-browser')
                    catch
                    end
                end
        else
            web(url,'-browser')
        end
    end
end

% --------------------------------------------------------------------
function menu_manuals_Callback(hObject, eventdata, handles)
% hObject    handle to menu_manuals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%filename = which('AC_Users_Guide.pdf');
%openpdf(filename);
url2 = 'https://github.com/mingsongli/acycle/blob/master/doc/Acycle_Users_Guide.pdf';
web(url2,'-browser')
url = 'https://acycle.org/manual/';
web(url,'-browser')


% --------------------------------------------------------------------
function menu_findupdates_Callback(hObject, eventdata, handles)
% hObject    handle to menu_findupdates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

url = 'https://github.com/mingsongli/acycle';
web(url,'-browser')
url = 'https://acycle.org/downloads/';
web(url,'-browser')

% --------------------------------------------------------------------
function menu_contact_Callback(hObject, eventdata, handles)
% hObject    handle to menu_contact (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);
copyright(handles)

% --------------------------------------------------------------------
function menu_selectinterval_Callback(hObject, eventdata, handles)
% hObject    handle to menu_selectinterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a45',lang_id);
    a45 = handles.lang_var{locb1};
    [~, locb1] = ismember('a46',lang_id);
    a46 = handles.lang_var{locb1};
    [~, locb1] = ismember('a47',lang_id);
    a47 = handles.lang_var{locb1};
    [~, locb1] = ismember('a48',lang_id);
    a48 = handles.lang_var{locb1};
    [~, locb1] = ismember('a49',lang_id);
    a49 = handles.lang_var{locb1};
    [~, locb1] = ismember('a50',lang_id);
    a50 = handles.lang_var{locb1};
    [~, locb1] = ismember('a51',lang_id);
    a51 = handles.lang_var{locb1};
    [~, locb1] = ismember('a52',lang_id);
    a52 = handles.lang_var{locb1};
    [~, locb1] = ismember('main35',lang_id);
    main35 = handles.lang_var{locb1};
end


for i = 1:nplot
    data_name = char(contents(plot_selected(i)));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    if isdir(data_name) == 1
    else
        [~,dat_name,ext] = fileparts(data_name);
    if sum(strcmp(ext,handles.filetype)) > 0
        GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        data = load(data_name);
        time = data(:,1);
        value = data(:,2);
        npts = length(time);
        if handles.lang_choice == 0
            prompt = {'Enter the START of interval:','Enter the END of interval:','Apply to ALL? (1 = yes)'};
            dlg_title = 'Input Select interval';
        else
            prompt = {a45,a46,a47};
            dlg_title = a48;
        end
        num_lines = 1;
        defaultans = {num2str(time(1)),num2str(time(npts)),'0'};
        options.Resize='on';
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
        if ~isempty(answer)
            xmin_cut = str2double(answer{1});
            xmax_cut = str2double(answer{2});
            ApplyAll = str2double(answer{3});

            if ApplyAll == 1
                for ii = 1:nplot
                    data_name = char(contents(plot_selected(ii)));
                    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
                    if isdir(data_name) == 1
                    else
                        [~,dat_name,ext] = fileparts(data_name);
                        if handles.lang_choice == 0
                            disp(['>>  Processing ',data_name])
                        else
                            disp([a49,data_name])
                        end
                        if sum(strcmp(ext,handles.filetype)) > 0
                            GETac_pwd; data_name = fullfile(ac_pwd,data_name);
                            data = load(data_name);
                            time = data(:,1);
                            if or (max(time) < xmin_cut, min(time) > xmax_cut)
                                if handles.lang_choice == 0
                                    errordlg(['No overlap between selected interval and ',dat_name],'Error')
                                    disp('      Error, no overlap')
                                else
                                    errordlg([a50,dat_name],main35)
                                    disp(a51)
                                end
                                continue
                            end
                            if and (min(time) > xmin_cut, max(time) < xmax_cut)
                                if handles.lang_choice == 0
                                    disp('      Selected interval too large, skipped')
                                else
                                    disp(a52)
                                end
                                continue
                            end
                            [current_data] = select_interval(data,xmin_cut,xmax_cut); 
                            name1 = [dat_name,'_',num2str(xmin_cut),'_',num2str(xmax_cut),ext];  % New name
                            CDac_pwd; % cd ac_pwd dir
                            dlmwrite(name1, current_data, 'delimiter', ' ', 'precision', 9);
                        end
                    end
                end
                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
                return
            else

                if or (max(time) < xmin_cut, min(time) > xmax_cut)
                    if handles.lang_choice == 0
                        errordlg(['No overlap between selected interval and ',dat_name],'Error')
                        disp('      Error, no overlap')
                    else
                        errordlg([a50,dat_name],main35)
                        disp(a51)
                    end
                    return
                end
                if and (min(time) > xmin_cut, max(time) < xmax_cut)
                    if handles.lang_choice == 0
                        disp('      Selected interval too large, skipped')
                    else
                        disp(a52)
                    end
                    return
                end
                [current_data] = select_interval(data,xmin_cut,xmax_cut); 
                name1 = [dat_name,'_',num2str(xmin_cut),'_',num2str(xmax_cut),ext];  % New name

                CDac_pwd; % cd ac_pwd dir
                dlmwrite(name1, current_data, 'delimiter', ' ', 'precision', 9);
                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
            end
        end
    end
    end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_interp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_interp_Callback(hObject, eventdata, handles)
% hObject    handle to menu_interp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a60',lang_id);
    a60 = handles.lang_var{locb1};
    [~, locb1] = ismember('a61',lang_id);
    a61 = handles.lang_var{locb1};
    [~, locb1] = ismember('a62',lang_id);
    a62 = handles.lang_var{locb1};
    [~, locb1] = ismember('menu71',lang_id);
    menu71 = handles.lang_var{locb1};
end

if handles.lang_choice == 0
    disp(['Select ',num2str(nplot),' data'])
else
    disp([a60,' ',num2str(nplot),a62])
end
for nploti = 1:nplot
    data_name_all = (contents(plot_selected));
    data_name = char(data_name_all{nploti});
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
    if isdir(data_name) == 1
    else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0

            try
                fid = fopen(data_name);
                data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
                fclose(fid);
                if iscell(data_ft)
                    try
                        data = cell2mat(data_ft);
                    catch
                        fid = fopen(data_name,'at');
                        fprintf(fid,'%d\n',[]);
                        fclose(fid)
                        fid = fopen(data_name);
                        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                        fclose(fid);
                        data = cell2mat(data_ft);
                    end
                end
            catch
                data = load(data_name);
            end 
                time = data(:,1);
                srmedian = median(diff(time));
                if handles.lang_choice == 0
                    dlg_title = 'Interpolation';
                    prompt = {'New sample rate (default = median):'};
                else
                    dlg_title = menu71;
                    prompt = {a61};
                end
                num_lines = 1;
                defaultans = {num2str(srmedian)};
                options.Resize='on';
                answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);

                if ~isempty(answer)
                    interpolate_rate = str2double(answer{1});
                    data_interp = interpolate(data,interpolate_rate);
                    name1 = [dat_name,'-rsp',num2str(interpolate_rate),ext];  % New name
                    CDac_pwd
                    dlmwrite(name1, data_interp, 'delimiter', ' ', 'precision', 9); 
                    d = dir; %get files
                    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                    refreshcolor;
                    cd(pre_dirML); % return to matlab view folder
                end
        end
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_norm_Callback(hObject, eventdata, handles)
% hObject    handle to menu_norm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            data = load(data_name);
            time = data(:,1);
            value = (data(:,2)-mean(data(:,2)))/std(data(:,2));
            data1 = [time,value];
            name1 = [dat_name,'-stand',ext];
            CDac_pwd
            dlmwrite(name1, data1, 'delimiter', ' ', 'precision', 9); 
            d = dir; %get files
            set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
            refreshcolor;
            cd(pre_dirML); % return to matlab view folder
        end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_clip_Callback(hObject, eventdata, handles)
% hObject    handle to menu_clip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a60',lang_id);
    a60 = handles.lang_var{locb1};
    [~, locb1] = ismember('a62',lang_id);
    a62 = handles.lang_var{locb1};
    [~, locb1] = ismember('a63',lang_id);
    a63 = handles.lang_var{locb1};
    [~, locb1] = ismember('a64',lang_id);
    a64 = handles.lang_var{locb1};
    [~, locb1] = ismember('a65',lang_id);
    a65 = handles.lang_var{locb1};
    [~, locb1] = ismember('a66',lang_id);
    a66 = handles.lang_var{locb1};
    [~, locb1] = ismember('a67',lang_id);
    a67 = handles.lang_var{locb1};
    [~, locb1] = ismember('menu79',lang_id);
    menu79 = handles.lang_var{locb1};
end

if handles.lang_choice == 0
    disp(['Select ',num2str(nplot),' data'])
else
    disp([a60,' ',num2str(nplot),a62])
end
for nploti = 1:nplot
    data_name_all = (contents(plot_selected));
    data_name = char(data_name_all{nploti});
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    if handles.lang_choice == 0
        disp(['>>  Processing clipping:', data_name]);
    else
        disp([a63, data_name]);
    end
    GETac_pwd; 
    data_name = fullfile(ac_pwd,data_name);

    if isdir(data_name) == 1
    else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            try
                fid = fopen(data_name);
                data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
                fclose(fid);
                if iscell(data_ft)
                    try
                        data = cell2mat(data_ft);
                    catch
                        fid = fopen(data_name,'at');
                        fprintf(fid,'%d\n',[]);
                        fclose(fid);
                        fid = fopen(data_name);
                        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                        fclose(fid);
                        data = cell2mat(data_ft);
                    end
                end
            catch
                data = load(data_name);
            end
            if handles.lang_choice == 0
                prompt = {'Threshold value (default = mean)'; 'Keep high/low? (1=high; 0=low)';'Clipped data (0 = set to 0; 1 = delete; 2 = threshold)'};
                dlg_title = 'Clipping:';
            else
                prompt = {a64; a65; a67};
                dlg_title = menu79;
            end
            num_lines = 1;
            defaultans = {num2str(nanmean(data(:,2))), '1','0'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
                if ~isempty(answer)

                    clip_value = str2double(answer{1});
                    clip_high  = str2double(answer{2});
                    clip_set  = str2double(answer{3});

                    time = data(:,1);
                    y = data(:,2);
                    
                    if clip_high == 1
                        if clip_set == 0
                            y(y<clip_value) = clip_value;
                            y = y - clip_value;
                            name1 = [dat_name,'-clip<',num2str(clip_value),'-0',ext];
                        elseif clip_set ==1
                            time(y<clip_value) = [];
                            y(y<clip_value) = [];
                            name1 = [dat_name,'-clip<',num2str(clip_value),'-D',ext];
                        elseif clip_set ==2
                            y(y<clip_value) = clip_value;
                            name1 = [dat_name,'-clip<',num2str(clip_value),'-threshold',ext];
                        else
                            if handles.lang_choice == 0
                                errordlg('Error, input must be either 1, 2 or 0')
                            else
                                errordlg(a66)
                            end
                        end
                        
                    else
                        if clip_set == 0
                            y(y>clip_value) = clip_value;
                            y = y - clip_value;
                            name1 = [dat_name,'-clip>',num2str(clip_value),'-0',ext];
                        elseif clip_set ==1
                            time(y>clip_value) = [];
                            y(y>clip_value) = [];
                            name1 = [dat_name,'-clip>',num2str(clip_value),'-D',ext];
                        elseif clip_set ==2
                            y(y>clip_value) = clip_value;
                            name1 = [dat_name,'-clip>',num2str(clip_value),'-threshold',ext];
                        else
                            if handles.lang_choice == 0
                                errordlg('Error, input must be either 1, 2 or 0')
                            else
                                errordlg(a66)
                            end
                        end
                    end

                        data1 = [time,y];
                        CDac_pwd
                        dlmwrite(name1, data1, 'delimiter', ' ', 'precision', 9);
                        d = dir; %get files
                        set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                        refreshcolor;
                        cd(pre_dirML); % return to matlab view folder
                else
                    errordlg('Error, input must be a positive integer')
                end
        end
    end
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function menu_log10_Callback(hObject, eventdata, handles)
% hObject    handle to menu_log10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            data = load(data_name);
            time = data(:,1);
            value = log10(data(:,2));
            data1 = [time,value];
            name1 = [dat_name,'-log10',ext];
            %csvwrite(name1,data1)
            % cd ac_pwd dir
            CDac_pwd
            dlmwrite(name1, data1, 'delimiter', ' ', 'precision', 9); 
            d = dir; %get files
            set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
            refreshcolor;
            cd(pre_dirML); % return to matlab view folder
        end
        end
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function menu_bootstrap_Callback(hObject, eventdata, handles)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0

                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                guidata(hObject, handles);
                SmoothBootGUI(handles);
            end
        end
end
guidata(hObject, handles);


% % --------------------------------------------------------------------
% function menu_bootstrap_Callback(hObject, eventdata, handles)
% % hObject    handle to menu_smooth (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
% plot_selected = get(handles.listbox_acmain,'Value');
% nplot = length(plot_selected);   % length
% 
% if nplot == 1
%     
%     %language
%     lang_id = handles.lang_id;
%     if handles.lang_choice > 0
%         [~, locb1] = ismember('menu102',lang_id);
%         menu102 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a70',lang_id);
%         a70 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a71',lang_id);
%         a71 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a72',lang_id);
%         a72 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a73',lang_id);
%         a73 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a74',lang_id);
%         a74 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a75',lang_id);
%         a75 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a76',lang_id);
%         a76 = handles.lang_var{locb1};
%         [~, locb1] = ismember('a77',lang_id);
%         a77 = handles.lang_var{locb1};
%     end
%     
%     data_name = char(contents(plot_selected));
%     data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
%     GETac_pwd; data_name = fullfile(ac_pwd,data_name);
%         if isdir(data_name) == 1
%         else
%             [~,dat_name,ext] = fileparts(data_name);
%         if sum(strcmp(ext,handles.filetype)) > 0
% 
%         try
%             fid = fopen(data_name);
%             data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
%             fclose(fid);
%             if iscell(data_ft)
%                 data = cell2mat(data_ft);
%             end
%         catch
%             data = load(data_name);
%         end 
% 
%             time = data(:,1);
%             value = data(:,2);
%             span_d = (time(end)-time(1))* 0.1;
%             if handles.lang_choice == 0
%                 dlg_title = 'Bootstrap';
%                 prompt = {'Window (unit)','Method: "loess/lowess/rloess/rlowess"',...
%                     'Number of bootstrap sampling'};
%             else
%                 dlg_title = menu102;
%                 prompt = {a70,a71,a72};
%             end
%             num_lines = 1;
%             defaultans = {num2str(span_d),'loess','1000'};
%             options.Resize='on';
%             answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
%             if ~isempty(answer)
%                 span_v = str2double(answer{1});
%                 method = (answer{2});
%                 bootn = str2double(answer{3});
%                 
%                 span = span_v/(time(end)-time(1));
%                 if handles.lang_choice == 0
%                     hwarn1 = warndlg('Slow process. Wait ...','Smoothing');
%                 else
%                     hwarn1 = warndlg(a73,a74);
%                 end
%                 [meanboot,bootstd,bootprt] = smoothciML(time,value,method,span,bootn);
%                 try close(hwarn1)
%                 catch
%                 end
%                 data(:,4) = meanboot;
%                 data(:,2) = meanboot - 2*bootstd;
%                 data(:,3) = meanboot - bootstd;
%                 data(:,5) = meanboot + bootstd;
%                 data(:,6) = meanboot + 2*bootstd;
%                 data1 = [time,bootprt];
%                 name = [dat_name,'_',num2str(span_v),'_',method,'_',num2str(bootn),'_bootstp_meanstd',ext];  % New name
%                 name1 = [dat_name,'_',num2str(span_v),'_',method,'_',num2str(bootn),'_bootstp_percentile',ext];
%                 if handles.lang_choice == 0
%                     disp(['>>  Save [time, mean-2std, mean-std, mean, mean+std, mean+2std] as :',name])
%                     disp(['>>  Save [time, percentiles] as :',name1])
%                     disp('>>        Percentiles are ')
%                 else
%                     disp([a75,name])
%                     disp([a76,name1])
%                     disp(a77)
%                 end
%                 disp('>>        [0.5,2.5,5,25,50,75,95,97.5,99.5]')
%                 CDac_pwd
%                 dlmwrite(name, data, 'delimiter', ' ', 'precision', 9); 
%                 dlmwrite(name1, data1, 'delimiter', ' ', 'precision', 9); 
%                 d = dir; %get files
%                 set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
%                 refreshcolor;
%                 cd(pre_dirML); % return to matlab view folder
%             end
%         end
%         end
% end
% guidata(hObject, handles);



% --------------------------------------------------------------------
function menu_derivative_Callback(hObject, eventdata, handles)
% hObject    handle to menu_derivative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length


%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a60',lang_id);
    a60 = handles.lang_var{locb1};
    [~, locb1] = ismember('a62',lang_id);
    a62 = handles.lang_var{locb1};
    [~, locb1] = ismember('a80',lang_id);
    a80 = handles.lang_var{locb1};
    [~, locb1] = ismember('a81',lang_id);
    a81 = handles.lang_var{locb1};
    [~, locb1] = ismember('a82',lang_id);
    a82 = handles.lang_var{locb1};
end

if handles.lang_choice == 0
    disp(['Select ',num2str(nplot),' data'])
else
    disp([a60,' ',num2str(nplot),a62])
end

for nploti = 1:nplot
    data_name_all = (contents(plot_selected));
    data_name = char(data_name_all{nploti});
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    if handles.lang_choice == 0
        disp(['>>  Processing derivative:', data_name]);
    else
        disp([a80, data_name]);
    end
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            try
                fid = fopen(data_name);
                data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
                fclose(fid);
                if iscell(data_ft)
                    try
                        data = cell2mat(data_ft);
                    catch
                        fid = fopen(data_name,'at');
                        fprintf(fid,'%d\n',[]);
                        fclose(fid);
                        fid = fopen(data_name);
                        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                        fclose(fid);
                        data = cell2mat(data_ft);
                    end
                end
            catch
                data = load(data_name);
            end
            if handles.lang_choice == 0
                prompt = {'Derivative (1=1st, 2=2nd ...)'};
                dlg_title = 'Approximate Derivatives:';
            else
                prompt = {a81};
                dlg_title = a82;
            end
            num_lines = 1;
            defaultans = {num2str(handles.math_derivative)};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                derivative_n = str2double(answer{1});
                % check
                int_gt_0 = @(n) (rem(n,1) == 0) & (n > 0);
                math_derivative = int_gt_0(derivative_n);

                if math_derivative == 1
                    data = data(~any(isnan(data),2),:); % remove NaN values
                    data = sortrows(data);
                    time  = data(:,1);
                    value = data(:,2);
                    for i=1:derivative_n
                        value= diff(value)./diff(time);
                        time = time(1:length(time)-1,1);
                    end
                    data1 = [time,value];
                    % remember settings
                    handles.math_derivative = derivative_n;
                    name1 = [dat_name,'_',num2str(derivative_n),'derv',ext];
                    CDac_pwd
                    dlmwrite(name1, data1, 'delimiter', ' ', 'precision', 9);
                    d = dir; %get files
                    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                    refreshcolor;
                    cd(pre_dirML); % return to matlab view folder
                end
            end
        end
        end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function menu_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_period_Callback(hObject, eventdata, handles)
% hObject    handle to menu_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                guidata(hObject, handles);
                evofftGUI(handles);
            end
        end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_power_Callback(hObject, eventdata, handles)
% hObject    handle to menu_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                guidata(hObject, handles);
                spectrum(handles);
            end
        end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_filter_Callback(hObject, eventdata, handles)
% hObject    handle to menu_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                handles.dat_name = dat_name;
                guidata(hObject, handles);
                ft(handles);
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_AM_Callback(hObject, eventdata, handles)
% hObject    handle to menu_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a85',lang_id);
    a85 = handles.lang_var{locb1};
    [~, locb1] = ismember('a86',lang_id);
    a86 = handles.lang_var{locb1};
    [~, locb1] = ismember('a87',lang_id);
    a87 = handles.lang_var{locb1};
end

if nplot == 1
    data_name = char(contents(plot_selected));
    dat_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,dat_name);
        if isdir(data_name) == 1
            if handles.lang_choice == 0
                warndlg('Error: select the data file not a folder')
            else
                warndlg(a85)
            end
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                data = load(data_name);
                
                % sort
                data = sortrows(data);
                % unique
                data=findduplicate(data);
                % remove empty 
                data(any(isinf(data),2),:) = [];
                
                diffx = diff(data(:,1));
                if max(diffx) - min(diffx) > eps('single')
                    if handles.lang_choice == 0
                        hwarn = warndlg('Warning: Interpolation using median sampling rate');
                    else
                        hwarn = warndlg(a86);
                    end
                    set(gcf,'units','norm') % set location
                    %set(gcf,'position',[0.2,0.6,0.2,0.1])
                    figure(hwarn);
                    interpolate_rate = median(diffx);
                    [data]=interpolate(data,interpolate_rate);
                end
                
                % remove mean of the 2nd column
                data(:,2) = data(:,2) - mean(data(:,2));
                %
                t=data(:,1);
                dt=t(2)-t(1);
                nyquist = 1/(2*dt);
                fl = 0;
                fh = nyquist;
                fc = 1/2*nyquist;

                [tanhilb,~,~] = tanerhilbertML(data,fc,fl,fh);

                data_am = [tanhilb(:,1), tanhilb(:,3)];
                
                name1 = [dat_name,'-AM',ext];
                name2 = [dat_name,'-AMf',ext];
                CDac_pwd
                dlmwrite(name1, data_am, 'delimiter', ' ', 'precision', 9);
                dlmwrite(name2, [tanhilb(:,1), tanhilb(:,2)], 'delimiter', ' ', 'precision', 9);
                if handles.lang_choice == 0
                    msgbox('See main window for amplitude modulation')
                else
                    msgbox(a87)
                end

                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
            
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_age_Callback(hObject, eventdata, handles)
% hObject    handle to menu_age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
agescale(handles)


% --------------------------------------------------------------------
function menu_dynos_Callback(hObject, eventdata, handles)
% hObject    handle to menu_dynos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0

                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                handles.dat_name = dat_name;
                guidata(hObject, handles);
                DYNOS(handles);
            end
        end
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function menu_ecoco_Callback(hObject, eventdata, handles)
% hObject    handle to menu_ecoco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                handles.dat_name = dat_name;
                guidata(hObject, handles);
                eCOCOGUI(handles);
            end
        end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_laskar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function menu_laskar_Callback(hObject, eventdata, handles)
% hObject    handle to menu_laskar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);
basicseries(handles);


% --- Executes during object creation, after setting all properties.
function menu_LR04_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_LR04_Callback(hObject, eventdata, handles)
% hObject    handle to menu_LR04 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a90',lang_id);
    a90 = handles.lang_var{locb1};
    [~, locb1] = ismember('a91',lang_id);
    a91 = handles.lang_var{locb1};
    [~, locb1] = ismember('a92',lang_id);
    a92 = handles.lang_var{locb1};
    [~, locb1] = ismember('a93',lang_id);
    a93 = handles.lang_var{locb1};
    [~, locb1] = ismember('a94',lang_id);
    a94 = handles.lang_var{locb1};
    [~, locb1] = ismember('a95',lang_id);
    a95 = handles.lang_var{locb1};
end
if handles.lang_choice == 0
    prompt = {'Start Age in ka (>= 0):',...
                    'End Age in ka (<= 5320):'};
    dlg_title = 'LR04 stack: Plio-Pleistocene d18O_ben)';
else
    prompt = {a90,a91};
    dlg_title = a92;
end
num_lines = 1;
defaultans = {'0','5320'};
options.Resize='on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
if ~isempty(answer)
    t1 = str2double(answer{1});
    t2 = str2double(answer{2});
    LR04stack = load('LR04stack5320ka.txt');
    LR04stack_s = select_interval(LR04stack,t1,t2);
    figure;
    plot(LR04stack_s(:,1),LR04stack_s(:,2),'LineWidth',1);
    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
        xlabel('Time (ka)')
        ylabel('Global Benthic \delta^{18}O')
        title(['LR04 Stack: ',num2str(t1),'_',num2str(t2),' ka'], 'Interpreter', 'none')
    else
        xlabel(a93)
        ylabel(a94)
        title([a95,num2str(t1),'_',num2str(t2),' ka'], 'Interpreter', 'none')
    end
    set(gca,'XMinorTick','on','YMinorTick','on')
    filename = ['LR04_Stack_',num2str(t1),'_',num2str(t2),'ka.txt'];
    % cd ac_pwd dir
    CDac_pwd
    dlmwrite(filename, LR04stack_s, 'delimiter', ' ', 'precision', 9);
    d = dir; %get files
    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
    refreshcolor;
    cd(pre_dirML); % return to matlab view folder
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function menu_plotn_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plotn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length


%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('main21',lang_id);
    main21 = handles.lang_var{locb1};
    [~, locb1] = ismember('main23',lang_id);
    main23 = handles.lang_var{locb1};
    [~, locb1] = ismember('main34',lang_id);
    main34 = handles.lang_var{locb1};
end

% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        else
            return
        end
    end
end

if check == 1
    figure;
    hold on;
    for i = 1:nplot
        plot_no = plot_selected(i);
            plot_filter_s = char(contents(plot_no));
            GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    try
        fid = fopen(plot_filter_s);
        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
        fclose(fid);
        if iscell(data_ft)
            dat = cell2mat(data_ft);
        end
    catch
        dat = load(plot_filter_s);
    end
            
            
            dat = dat(~any(isnan(dat),2),:);
            dat(:,2) = (dat(:,2)-mean(dat(:,2)))/std(dat(:,2));
            plot(dat(:,1),dat(:,2),'LineWidth',1);
    end
    set(gca,'XMinorTick','on','YMinorTick','on')
    hold off
    title(contents(plot_selected), 'Interpreter', 'none')
    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
        if handles.unit_type == 0
            xlabel(['Unit (',handles.unit,')'])
        elseif handles.unit_type == 1
            xlabel(['Depth (',handles.unit,')'])
        else
            xlabel(['Time (',handles.unit,')'])
        end
    else
        if handles.unit_type == 0
            xlabel([main34,' (',handles.unit,')'])
        elseif handles.unit_type == 1
            xlabel([main23,' (',handles.unit,')'])
        else
            xlabel([main21,' (',handles.unit,')'])
        end
    end
end
guidata(hObject,handles)

% --------------------------------------------------------------------
function menu_plotn2_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plotn2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('main21',lang_id);
    main21 = handles.lang_var{locb1};
    [~, locb1] = ismember('main23',lang_id);
    main23 = handles.lang_var{locb1};
    [~, locb1] = ismember('main34',lang_id);
    main34 = handles.lang_var{locb1};
end
% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        else
            return
        end
    end
end

if check == 1
    xlimit = zeros(nplot,2);
    figure;
    hold on;
    for i = 1:nplot
        plot_no = plot_selected(i);
            plot_filter_s = char(contents(plot_no));
            GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
         try
            fid = fopen(plot_filter_s);
            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
            fclose(fid);
            if iscell(data_ft)
                dat = cell2mat(data_ft);
            end
        catch
            dat = load(plot_filter_s);
         end 
            
        dat = dat(~any(isnan(dat),2),:);
        dat(:,2) = (dat(:,2)-mean(dat(:,2)))/std(dat(:,2));
        plot(dat(:,1),dat(:,2) - 2*(i-1),'LineWidth',1);  % modify to fit with the order of title
        xlimit(i,:) = [dat(1,1) dat(length(dat(:,1)),1)];
    end
    set(gca,'XMinorTick','on','YMinorTick','on')
    hold off
    title(contents(plot_selected), 'Interpreter', 'none')
    xlim([min(xlimit(:,1)) max(xlimit(:,2))])
    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
        if handles.unit_type == 0
            xlabel(['Unit (',handles.unit,')'])
        elseif handles.unit_type == 1
            xlabel(['Depth (',handles.unit,')'])
        else
            xlabel(['Time (',handles.unit,')'])
        end
    else
        if handles.unit_type == 0
            xlabel([main34,' (',handles.unit,')'])
        elseif handles.unit_type == 1
            xlabel([main23,' (',handles.unit,')'])
        else
            xlabel([main21,' (',handles.unit,')'])
        end
    end

end
guidata(hObject,handles)

% --------------------------------------------------------------------
function menu_rename_Callback(hObject, eventdata, handles)
% hObject    handle to menu_rename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a100',lang_id);
    a100 = handles.lang_var{locb1};
    [~, locb1] = ismember('a101',lang_id);
    a101 = handles.lang_var{locb1};
    [~, locb1] = ismember('a102',lang_id);
    a102 = handles.lang_var{locb1};
end

% check
if nplot == 1
    CDac_pwd;
    plot_filter_s = char(contents(plot_selected));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    if handles.lang_choice == 0
        prompt = {'Enter new file name:'};
        dlg_title = 'Rename                           ';
    else
        prompt = {a100};
        dlg_title = a101;
    end
    num_lines = 1;
    defaultans = {plot_filter_s};
    options.Resize='on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    newname = char(answer);
    if ~isempty(newname)
        try
            movefile(plot_filter_s,newname)
        catch
            if handles.lang_choice == 0
                msgbox('Error: Cannot copy or move a file or directory onto itself.')
            else
                msgbox(a102)
            end
        end
        d = dir; %get files
        set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
        refreshcolor;
        cd(pre_dirML);
    end
end

% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_import_Callback(hObject, eventdata, handles)
% hObject    handle to menu_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a105',lang_id);
    a105 = handles.lang_var{locb1};
    [~, locb1] = ismember('a106',lang_id);
    a106 = handles.lang_var{locb1};
    [~, locb1] = ismember('a107',lang_id);
    a107 = handles.lang_var{locb1};
    [~, locb1] = ismember('a108',lang_id);
    a108 = handles.lang_var{locb1};
end
if handles.lang_choice == 0
    [filename, pathname] = uigetfile({'*.txt;*.csv','Files (*.txt;*.csv)'},...
        'Import data (*.csv,*.txt)');
else
    [filename, pathname] = uigetfile({'*.txt;*.csv',a105},...
        a106);
end
if filename == 0
    if handles.lang_choice == 0
        open_data = 'Tips: open 2 colume data';
        h = helpdlg(open_data,'Tips: Close');
    else
        open_data = a107;
        h = helpdlg(open_data,a108);
    end
    
    uiwait(h); 
else
    aaa = [pathname,filename];
    data=load(aaa);
    
    CDac_pwd % cd ac_pwd dir
    dlmwrite(handles.foldname, data, 'delimiter', ' ', 'precision', 9); 
    d = dir; %get files
    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
    refreshcolor;
    cd(pre_dirML); % return to matlab view folder
    handles.current_data = data;
    guidata(hObject,handles)
end

% --------------------------------------------------------------------
function menu_savefig_Callback(hObject, eventdata, handles)
% hObject    handle to menu_savefig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a109',lang_id);
    a109 = handles.lang_var{locb1};
    [~, locb1] = ismember('a110',lang_id);
    a110 = handles.lang_var{locb1};
end
if handles.lang_choice == 0
    prompt = {'Name of ACYCLE figure:'};
    dlg_title = 'Filename';
else
    prompt = {a109};
    dlg_title = a110;
end
num_lines = 1;
defaultans = {'.AC.fig'};
options.Resize='on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
newname = char(answer);
if ~isempty(newname)
    CDac_pwd % cd ac_pwd dir
    savefig(newname)
    refreshcolor;
    cd(pre_dirML); % return to matlab view folder
end


% --------------------------------------------------------------------
function menu_depeaks_Callback(hObject, eventdata, handles)
% hObject    handle to menu_depeaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a113',lang_id);
    a113 = handles.lang_var{locb1};
    [~, locb1] = ismember('a114',lang_id);
    a114 = handles.lang_var{locb1};
    [~, locb1] = ismember('a115',lang_id);
    a115 = handles.lang_var{locb1};
end

if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            
            data = load(data_name);
            time = data(:,1);
            value = data(:,2);
            npts = length(time);
            if handles.lang_choice == 0
                prompt = {'Enter Mininum value:','Enter Maximum value:'};
                dlg_title = 'Input MIN and MAX value';
            else
                prompt = {a113,a114};
                dlg_title = a115;
            end
            num_lines = 1;
            defaultans = {num2str(min(value)),num2str(max(value))};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                ymin_cut = str2double(answer{1});
                ymax_cut = str2double(answer{2});
                [current_data]=depeaks(data,ymin_cut,ymax_cut); 

                name1 = [dat_name,'-dpks',num2str(ymin_cut),'_',num2str(ymax_cut),ext];  % New name
                CDac_pwd
                dlmwrite(name1, current_data, 'delimiter', ' ', 'precision', 9); 
                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
            end
        end
        end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menuac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menuac_Callback(hObject, eventdata, handles)
% hObject    handle to menuac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function menu_prewhiten_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_prewhiten_Callback(hObject, eventdata, handles)
% hObject    handle to menu_prewhiten (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0

                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                guidata(hObject, handles);
                prewhiten(handles);
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_agebuild_Callback(hObject, eventdata, handles)
% hObject    handle to menu_agebuild (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a118',lang_id);
    a118 = handles.lang_var{locb1};
    [~, locb1] = ismember('a119',lang_id);
    a119 = handles.lang_var{locb1};
    [~, locb1] = ismember('a120',lang_id);
    a120 = handles.lang_var{locb1};
    [~, locb1] = ismember('a121',lang_id);
    a121 = handles.lang_var{locb1};
    [~, locb1] = ismember('a122',lang_id);
    a122 = handles.lang_var{locb1};
    [~, locb1] = ismember('a123',lang_id);
    a123 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('main21',lang_id);
    main21 = handles.lang_var{locb1};
    [~, locb1] = ismember('main23',lang_id);
    main23 = handles.lang_var{locb1};
    [~, locb1] = ismember('main26',lang_id);
    main26 = handles.lang_var{locb1};
    [~, locb1] = ismember('main27',lang_id);
    main27 = handles.lang_var{locb1};
end

if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
    if isdir(data_name) == 1
    else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0

            data = load(data_name);
            if handles.lang_choice == 0
                prompt = {'Enter period (kyr):','Use 1 = peak; 0 = trough:'};
                dlg_title = 'Input period';
            else
                prompt = {a118,a119};
                dlg_title = a120;
            end
            num_lines = 1;
            defaultans = {'41','1'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                period = str2double(answer{1});
                pkstrough = str2double(answer{2});
                %
                data = data(~any(isnan(data),2),:); % remove NaN values
                data = sortrows(data);  % sort first column
                data=findduplicate(data); % remove duplicate number
                data(any(isinf(data),2),:) = []; % remove empty
                %
                if pkstrough == 1
                    [datapks,~] = getpks(data);
                    plot_filter_s ='max';
                else
                    data(:,2) = -1*data(:,2);
                    [datapks,~] = getpks(data);
                    plot_filter_s ='min';
                end

                [nrow, ~] = size(datapks);
                
                % age model
                datapksperiod = 1:nrow;
                datapksperiod = datapksperiod*period;
                datapksperiod = datapksperiod';
                agemodel = [datapks(:,1),datapksperiod];
                
                % sed. rate 
                sedrate = zeros(nrow+2,2);
                sedrate(1,1) = data(1,1);
                sedrate(2:end-1,1) = datapks(:,1);
                sedrate(end,1) = data(end,1);
                sedrate0 = diff(agemodel(:,1))./diff(agemodel(:,2));
                sedrate(2:end-2,2) = sedrate0;
                sedrate(1,2) = sedrate(2,2);
                sedrate(end-1,2) = sedrate(end-2,2);
                sedrate(end,2) = sedrate(end-2,2);
                % full age model
                agemodelfull = zeros(nrow+2,2);
                agemodelfull(2:end-1,:) = agemodel;
                agemodelfull(1,1) = data(1,1);
                agemodelfull(1,2) = datapksperiod(1) - (agemodelfull(2,1)-agemodelfull(1,1)) * sedrate(1,2);
                agemodelfull(end,1) = data(end,1);
                agemodelfull(end,2) = datapksperiod(end) + (agemodelfull(end,1)-agemodelfull(end-1,1)) * sedrate(end,2);

                name1 = [dat_name,'-agemodel-',num2str(period),'_',plot_filter_s,ext];
                name2 = [dat_name,'-sed.rate-',num2str(period),'_',plot_filter_s,ext];

                CDac_pwd
                dlmwrite(name1, agemodel, 'delimiter', ' ', 'precision', 9);
                dlmwrite(name2, sedrate,  'delimiter', ' ', 'precision', 9);
                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
                
                figure;
                set(gcf,'units','norm') % set location
                set(gcf,'position',[0.01,0.55,0.45,0.4]) % set position
                set(gcf,'color','w');
                plot(agemodelfull(:,1), agemodelfull(:,2),'k','LineWidth',1)
                if handles.lang_choice == 0
                    set(gcf,'Name','Acycle: Build Age Model | Age Model','NumberTitle','off')
                    xlabel(['Depth (',handles.unit,')'])
                    ylabel('Time (kyr)')
                    title(['Age Model: ', num2str(period), ' kyr cycle: ', plot_filter_s])
                else
                    set(gcf,'Name',a121,'NumberTitle','off')
                    xlabel([main23,' (',handles.unit,')'])
                    ylabel([main21,' (kyr)'])
                    title([main27,': ', num2str(period), a122, plot_filter_s])
                end
                
                set(gca,'XMinorTick','on','YMinorTick','on')
                xlim([agemodelfull(1,1), agemodelfull(end,1)])
                ylim([agemodelfull(1,2), agemodelfull(end,2)])
                
                figure;
                set(gcf,'color','w');
                set(gcf,'units','norm') % set location
                set(gcf,'position',[0.01,0.05,0.45,0.4]) % set position
                stairs(sedrate(:,1), sedrate(:,2),'k','LineWidth',1)
                if handles.lang_choice == 0
                    set(gcf,'Name','Acycle: Build Age Model | Sedimentation Rate')
                    xlabel(['Depth (',handles.unit,')'])
                    ylabel(['Sedimentation rate (',handles.unit,'/kyr)'])
                    title(['Sedimentation rate: ', num2str(period), ' kyr cycle: ', plot_filter_s])
                else
                    set(gcf,'Name',a123)
                    xlabel([main23,' (',handles.unit,')'])
                    ylabel([main26,' (',handles.unit,'/kyr)'])
                    title([main26,': ', num2str(period), a122, plot_filter_s])
                end
                xlim([sedrate(1,1), sedrate(end,1)])
                ylim([0, max(sedrate(:,2)) * 2])
                set(gca,'XMinorTick','on','YMinorTick','on')
            end
        end
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_function_Callback(hObject, eventdata, handles)
% hObject    handle to menu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a125',lang_id);
    a125 = handles.lang_var{locb1};
    [~, locb1] = ismember('a126',lang_id);
    a126 = handles.lang_var{locb1};
    [~, locb1] = ismember('a127',lang_id);
    a127 = handles.lang_var{locb1};
    [~, locb1] = ismember('a128',lang_id);
    a128 = handles.lang_var{locb1};
    [~, locb1] = ismember('a129',lang_id);
    a129 = handles.lang_var{locb1};
end

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            
            data = load(data_name);
            if handles.lang_choice == 0
                prompt = {'a for the 1st column: x(i) = a * x(i) + b',...
                    'b for the 1st column: x(i) = a * x(i) + b',...
                    'c for the 2nd column: y(i) = c * y(i) + d',...
                    'd for the 2nd column: y(i) = c * y(i) + d'};
                dlg_title = 'Input parameters';
            else
                prompt = {a125,a126,a127,a128};
                dlg_title = a129;
            end
            num_lines = 1;
            defaultans = {'1','0','1','0'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
            a = str2double(answer{1});
            b = str2double(answer{2});
            c = str2double(answer{3});
            d = str2double(answer{4});

            data(:,1) = a * data(:,1) + b;
            data(:,2) = c * data(:,2) + d;
            if and(and(a == 1, b==0), and(c==1, d==0))
            else
                CDac_pwd
                dlmwrite([dat_name,'-new',ext], data, 'delimiter', ' ', 'precision', 9);
                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
            end
            end
        end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_maxmin_Callback(hObject, eventdata, handles)
% hObject    handle to menu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('dd16',lang_id);
    dd16 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd17',lang_id);
    dd17 = handles.lang_var{locb1};
    [~, locb1] = ismember('a130',lang_id);
    a130 = handles.lang_var{locb1};
    [~, locb1] = ismember('a131',lang_id);
    a131 = handles.lang_var{locb1};
    [~, locb1] = ismember('a132',lang_id);
    a132 = handles.lang_var{locb1};
end

if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0

        try
            fid = fopen(data_name);
            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
            fclose(fid);
            if iscell(data_ft)
                data = cell2mat(data_ft);
            end
        catch
            data = load(data_name);
        end 
        
            x = data(:,1);
            if handles.lang_choice == 0
                dlg_title = 'Find Max/Min value and indice';
                prompt = {'Interval start','Interval end','Max or Min (1 = max, else = min)','Tested column'};
            else
                dlg_title = a130;
                prompt = {dd16,dd17,a131,a132};
            end
            num_lines = 1;
            defaultans = {num2str(min(x)),num2str(max(x)),'1','2'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                t1 = str2double(answer{1});
                t2 = str2double(answer{2});
                maxmin = str2double(answer{3});
                ind = str2double(answer{4});
                [dat] = select_interval(data,t1,t2);
                y = dat(:,ind);
                if maxmin == 1  
                    [m,i] = max(y);
                else
                    [m,i] = min(y);
                end
                disp(dat(i,:))
            end
        end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_cpt_Callback(hObject, eventdata, handles)
% hObject    handle to menu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a135',lang_id);
    a135 = handles.lang_var{locb1};
    [~, locb1] = ismember('a136',lang_id);
    a136 = handles.lang_var{locb1};
    [~, locb1] = ismember('a137',lang_id);
    a137 = handles.lang_var{locb1};
    [~, locb1] = ismember('a138',lang_id);
    a138 = handles.lang_var{locb1};
    [~, locb1] = ismember('a139',lang_id);
    a139 = handles.lang_var{locb1};
    [~, locb1] = ismember('a140',lang_id);
    a140 = handles.lang_var{locb1};
    [~, locb1] = ismember('a141',lang_id);
    a141 = handles.lang_var{locb1};
    [~, locb1] = ismember('a142',lang_id);
    a142 = handles.lang_var{locb1};
    [~, locb1] = ismember('a143',lang_id);
    a143 = handles.lang_var{locb1};
    [~, locb1] = ismember('a144',lang_id);
    a144 = handles.lang_var{locb1};
end

% Function of Bayesian changepoint technique

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0

        try
            fid = fopen(data_name);
            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
            fclose(fid);
            if iscell(data_ft)
                data = cell2mat(data_ft);
            end
        catch
            data = load(data_name);
        end 
        
            x = data(:,1);
            if handles.lang_choice == 0
                dlg_title = 'Ruggieri (2013) Bayesian Changepoint';
                prompt = {...
                    'k_max, max no. of change points allowed',...
                    'd_min, min distance between consecutive change points',...
                    'k_0, variance scaling hyperparameter',...
                    'v_0,  pseudo data point',...
                    'sig_0, pseudo data variance (maybe halved)',...
                    'n, number of sampled solutions',...
                    'Save data? (1 = yes, 0 = no)'};
            else
                dlg_title = a135;
                prompt = {...
                    a136,...
                    a137,...
                    a138,...
                    a139,...
                    a140,...
                    a141,...
                    a142};
            end
            num_lines = 1;
            sig_0 = var(data(:,2));
            k_0 = ceil( abs(x(end)-x(1))/44 ); % default value, 1/sub-interval*25%
            defaultans = {'10','1','0.01',num2str(k_0),num2str(sig_0),'500','1'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                if length(x)> 500
                    if handles.lang_choice == 0
                        warndlg('Large dataset, wait...')
                    else
                        warndlg(a143)
                    end
                end
                k_max = str2double(answer{1}); % default is 10
                d_min = str2double(answer{2}); % at least twice as many data points as free parameters
                    % in the regression model. Ensure enough data is
                    % available to estimate the parameters of the model
                    % accurately
                k_0 = str2double(answer{3}); % set k0 to be small, yielding a wide prior distribution
                    % on the regression coefficients
                v_0 = str2double(answer{4}); % may be <25% of the size of the minimum allowed sub-interval
                sig_0 = str2double(answer{5}); %  this will not be larger than the overall variance of the
                    % data set, one option is to conservatively set the
                    % prior variance sig_0^2, equal to the variance of the
                    % data set being used
                num_samp = str2double(answer{6});
                savedata = str2double(answer{7});
                % 
                [mod,cpt,R_2] = bayes_cpt(data,k_max,d_min,k_0,v_0,sig_0,num_samp);
                if savedata == 1
                    CDac_pwd

                    dlmwrite([dat_name,'-BayesRegModel',ext], mod, 'delimiter', ' ', 'precision', 9);
                    dlmwrite([dat_name,'-BayesChangepoint',ext], cpt, 'delimiter', ' ', 'precision', 9);
                    if handles.lang_choice == 0
                        disp(['>> ',dat_name,ext,' Bayesian change points output saved. R_2 is ',num2str(R_2)])
                    else
                        disp(['>> ',dat_name,ext,a144,num2str(R_2)])
                    end

                    
                    d = dir; %get files
                    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                    refreshcolor;
                    cd(pre_dirML); % return to matlab view folder
                end
            end
        end
        end
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function menu_imshow_Callback(hObject, eventdata, handles)
% hObject    handle to menu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('dd01',lang_id);
    dd01 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd24',lang_id);
    dd24 = handles.lang_var{locb1};
end


if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
            
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0

                imfinfo1 = imfinfo(data_name); % image information
                supportcolor = {'grayscale', 'truecolor'};
                
                if strcmp(imfinfo1.ColorType,'CIELab')
                    im_name = imread(data_name);
                    
                    aDouble = double(im_name); 
                    
                    cielab(:,:,1) = aDouble(:,:,1) ./ (255/100);
                    cielab(:,:,2) = aDouble(:,:,2)-128;
                    cielab(:,:,3) = aDouble(:,:,3)-128;
                    hFig1 = figure;                    
                    subplot(3,1,1)
                    imshow(cielab(:,:,1),[0 100])
                    title('L*')
                    subplot(3,1,2)
                    imshow(cielab(:,:,2),[-128 127])
                    title('a*')
                    subplot(3,1,3)
                    imshow(cielab(:,:,3),[-128 127])
                    title('b*')
                    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                    
                    hFig2 = figure;
                    imshow(lab2rgb(cielab));
                    set(gcf,'Name',[dat_name,'Lab2RGB',ext],'NumberTitle','off')
                    
                elseif any(strcmp(supportcolor,imfinfo1.ColorType))
                    im_name = imread(data_name);
                    hFig1 = figure;
                    imshow(im_name);
                    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                    [warnMsg, warnId] = lastwarn;
                    if ~isempty(warnMsg)
                        close(hFig1)
                        imscrollpanel_ac(data_name);
                    end
                else
                    try
                        % GRB and Grayscale supported here
                        im_name = imread(data_name);
                        hFig1 = figure;
                        lastwarn('') % Clear last warning message
                        imshow(im_name);
                        set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                        [warnMsg, warnId] = lastwarn;
                        if ~isempty(warnMsg)
                            close(hFig1)
                            imscrollpanel_ac(data_name);
                        end
                    catch
                        if handles.lang_choice == 0
                            warndlg('Image color space not supported. Convert to RGB or Grayscale')
                        else
                            warndlg(dd24)
                        end
                    end
                end
                
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_rgb2gray_Callback(hObject, eventdata, handles)
% hObject    handle to menu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a146',lang_id);
    a146 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd24',lang_id);
    dd24 = handles.lang_var{locb1};
end

if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
            
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0
                try
                    im_name = imread(data_name);
                    
                    imfinfo1 = imfinfo(data_name); % image information

                    if strcmp(imfinfo1.ColorType,'truecolor')
                        I = rgb2gray(im_name);
                        figure
                        imshow(I)
                        dat_name = [dat_name,'-gray',ext];
                        set(gcf,'Name',dat_name,'NumberTitle','off')
                        CDac_pwd;
                        imwrite(I,dat_name)
                        d = dir; %get files
                        set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                        refreshcolor;
                        cd(pre_dirML); % return to matlab view folder
                    else
                        warndlg(['This is not a RGB image. Color Type is: ',imfinfo1.ColorType])

                    end
                
                catch
                    if handles.lang_choice == 0
                        warndlg('Image color space not supported. Convert to RGB or Grayscale')
                    else
                        warndlg(dd24)
                    end
                end
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_rgb2lab_Callback(hObject, eventdata, handles)
% hObject    handle to menu_rgb2lab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
            
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0
                try
                    im_name = imread(data_name);
                    
                    imfinfo1 = imfinfo(data_name); % image information

                    if strcmp(imfinfo1.ColorType,'truecolor')
                        I = rgb2lab(im_name);
                        figure
                        subplot(3,1,1)
                        imshow(I(:,:,1),[0 100])
                        title('L*')
                        subplot(3,1,2)
                        imshow(I(:,:,2),[-128 127])
                        title('a*')
                        subplot(3,1,3)
                        imshow(I(:,:,3),[-128 127])
                        title('b*')
                        dat_name = [dat_name,'-Lab.tif'];
                        
                        set(gcf,'Name',dat_name,'NumberTitle','off')
                        CDac_pwd;
                        imwrite(I,dat_name,'tif','ColorSpace','CIELab')
                        d = dir; %get files
                        set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                        refreshcolor;
                        cd(pre_dirML); % return to matlab view folder
                    else
                        warndlg(['This is not a RGB image. Color Type is: ',imfinfo1.ColorType])
                    end

                catch
                    warndlg('Image color space not supported.')
                end
            end
        end
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function menu_improfile_Callback(hObject, eventdata, handles)
% hObject    handle to menu_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
[~, locb1] = ismember('a145',lang_id);
a145 = handles.lang_var{locb1};
[~, locb1] = ismember('a147',lang_id);
a147 = handles.lang_var{locb1};
[~, locb1] = ismember('a148',lang_id);
a148 = handles.lang_var{locb1};
[~, locb1] = ismember('a149',lang_id);
a149 = handles.lang_var{locb1};
[~, locb1] = ismember('a150',lang_id);
a150 = handles.lang_var{locb1};
[~, locb1] = ismember('a151',lang_id);
a151 = handles.lang_var{locb1};
[~, locb1] = ismember('a152',lang_id);
a152 = handles.lang_var{locb1};
[~, locb1] = ismember('a153',lang_id);
a153 = handles.lang_var{locb1};
[~, locb1] = ismember('a154',lang_id);
a154 = handles.lang_var{locb1};
[~, locb1] = ismember('a155',lang_id);
a155 = handles.lang_var{locb1};
[~, locb1] = ismember('a156',lang_id);
a156 = handles.lang_var{locb1};
[~, locb1] = ismember('a157',lang_id);
a157 = handles.lang_var{locb1};
[~, locb1] = ismember('dd24',lang_id);
dd24 = handles.lang_var{locb1};
[~, locb1] = ismember('dd01',lang_id);
dd01 = handles.lang_var{locb1};
[~, locb1] = ismember('main24',lang_id);
main24 = handles.lang_var{locb1};
[~, locb1] = ismember('main36',lang_id);
main36 = handles.lang_var{locb1};
[~, locb1] = ismember('main37',lang_id);
main37 = handles.lang_var{locb1};


if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0
                %try
                hwarn = warndlg(dd01);
                I = imread(data_name);
                imfinfo1 = imfinfo(data_name); % image information
                figI = figure;
                lastwarn('') % Clear last warning message

                if strcmp(imfinfo1.ColorType,'CIELab')
                    aDouble = double(I); 
                    cielab(:,:,1) = aDouble(:,:,1) ./ (255/100);
                    cielab(:,:,2) = aDouble(:,:,2)-128;
                    cielab(:,:,3) = aDouble(:,:,3)-128;
                    %I = lab2rgb(cielab);
                    I = cielab(:,:,1);
                    imshow(I,[0 100]);
                else
                    imshow(I);
                end

                [warnMsg, warnId] = lastwarn;
                if ~isempty(warnMsg)
                    close(figI)
                    imscrollpanel_ac(data_name);
                    figI = gcf;
                end
                
                try close(hwarn)
                catch
                end

                if strcmp(imfinfo1.ColorType,'CIELab')
                    set(gcf,'Name',[dat_name,' L*',a147],'NumberTitle','off')
                else
                    set(gcf,'Name',[dat_name,a147],'NumberTitle','off')
                end

                choice = questdlg(a148, ...
                    a147, 'Continue','Cancel','Continue');

            
                case1 = 'Continue';
                case2 = 'Cancel';

                switch choice
                    %case 'Continue'
                    case case1
                        figure(figI)
                        hold on; 
                        dcm_obj = datacursormode(figI);
                        set(dcm_obj,'DisplayStyle','datatip','SnapToDataVertex','off','Enable','on')
                        Sure = input(a150);

                        c_info = getCursorInfo(dcm_obj);
                        % number of cursors
                        m = length(c_info);

                        CursorInfo_value = zeros(m,2);

                        if m >= 2

                            for i = 1 : m
                               CursorInfo_value(i,1)=c_info(i).Position(:,1);
                               CursorInfo_value(i,2)=c_info(i).Position(:,2);
                            end

                            if strcmp(imfinfo1.ColorType,'CIELab')
                                figure(figI)
                                plot(CursorInfo_value(:,1), CursorInfo_value(:,2), 'g-','LineWidth',3)
                                hold off
                                pause(0.1)
                                figure
                                imshow(cielab(:,:,1),[0 100]);
                                hold on
                                plot(CursorInfo_value(:,1), CursorInfo_value(:,2), 'g-','LineWidth',3)
                                set(gcf,'Name',[dat_name,': L*'],'NumberTitle','off')
                                pause(0.1)
                                [cx,cy,c1,xi,yi] = improfile(I,CursorInfo_value(:,1),CursorInfo_value(:,2));

                                figure;
                                imshow(cielab(:,:,2),[-128 127]);
                                hold on
                                plot(CursorInfo_value(:,1), CursorInfo_value(:,2), 'g-','LineWidth',3)
                                hold off
                                set(gcf,'Name',[dat_name,': a*'],'NumberTitle','off')
                                [~,~,c2,~,~] = improfile(cielab(:,:,2),CursorInfo_value(:,1),CursorInfo_value(:,2));
                                pause(0.1)

                                figure;
                                imshow(cielab(:,:,3),[-128 127]);
                                hold on
                                plot(CursorInfo_value(:,1), CursorInfo_value(:,2), 'g-','LineWidth',3)
                                hold off
                                set(gcf,'Name',[dat_name,': b*'],'NumberTitle','off')
                                [~,~,c3,~,~] = improfile(cielab(:,:,3),CursorInfo_value(:,1),CursorInfo_value(:,2));
                                pause(0.1)
                            else
                                % RGB or grayscale
                                plot(CursorInfo_value(:,1), CursorInfo_value(:,2), 'g-','LineWidth',3)
                                [cx,cy,c,xi,yi] = improfile(I,CursorInfo_value(:,1),CursorInfo_value(:,2));
                            end

                            % pixels
                            cxd = diff(cx);
                            cyd = diff(cy);
                            czd = cxd.*cxd + cyd.*cyd;
                            z = cumsum(sqrt(czd));
                            cz = [0;z];
                            % control pixels
                            cxd = diff(xi);
                            cyd = diff(yi);
                            czd = cxd.*cxd + cyd.*cyd;
                            zc = cumsum(sqrt(czd));
                            czp = [0;zc];
                            czp = [(1:length(xi))',czp];

                            if strcmp(imfinfo1.ColorType,'CIELab')
                                data = [cz,c1,c2,c3];
                            else
                                if strcmp(imfinfo1.ColorType,'grayscale')
                                    data = [cz,c];
                                elseif strcmp(imfinfo1.ColorType,'truecolor')
                                    c = reshape(c,[],3);
                                    data = [cz,c];
                                else
                                    c = reshape(c,[],4);
                                    data = [cz,c];
                                end
                            end

                            name = [dat_name,'-profile.txt'];
                            name1= [dat_name,'-controlpoints.txt'];
                            name2= [dat_name,'-controlpixels.txt'];
                            data1 = [xi,yi];

                            CDac_pwd
                            dlmwrite(name , data, 'delimiter', ' ', 'precision', 9);
                            dlmwrite(name1, data1, 'delimiter', ' ', 'precision', 9);
                            disp([a154,name1])
                            disp([a155,name1])                                

                            dlmwrite(name2, czp, 'delimiter', ' ', 'precision', 9);
                            disp([a149,name2])
                            d = dir; %get files
                            set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                            refreshcolor;
                            cd(pre_dirML); % return to matlab view folder

                            % plot
                            figure;
                            plot(data(:,1),data(:,2:end));
                            hold on
                            for i = 1:length(zc)
                                xline(zc(i),'k--')
                            end
                            hold off
                            title(name, 'Interpreter', 'none'); 
                            
                            xlabel(a157);

                            xlim([0,z(end)])
                            set(gca,'XMinorTick','on','YMinorTick','on')
                            if strcmp(imfinfo1.ColorType,'grayscale')
                                ylabel(a156)
                            elseif strcmp(imfinfo1.ColorType,'CIELab')
                                ylabel('CIELab')
                                legend('L*','a*','b*')
                            elseif strcmp(imfinfo1.ColorType,'truecolor')
                                ylabel('RGB')
                                legend('Red','Green','Blue')
                            else
                                if handles.lang_choice == 0
                                    ylabel('Value')
                                else
                                    ylabel(main24)
                                end
                            end
                        else
                            warndlg(a145)
                        end
                    %case 'Cancel'
                    case case2

                        try close(figI)
                        catch
                        end
                end

            end
        end        
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_cut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_refresh

% --------------------------------------------------------------------
function menu_cut_Callback(hObject, eventdata, handles)
% hObject    handle to menu_cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
CDac_pwd;
handles.nplot = nplot;
handles.data_name = {};
handles.file = {};
for i = 1 : nplot
   filename = char(contents(plot_selected(i)));
   handles.data_name{i} = strrep2(filename, '<HTML><FONT color="blue">', '</FONT></HTML>');
   handles.file{i} = [ac_pwd,handles.slash_v,handles.data_name{i}];
end
handles.copycut = 'cut';
cd(pre_dirML);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_copy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to menu_copy

% --------------------------------------------------------------------
function menu_copy_Callback(hObject, eventdata, handles)
% hObject    handle to menu_copy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
CDac_pwd;
handles.nplot = nplot;
handles.data_name = {};
handles.file = {};
for i = 1 : nplot
   filename = char(contents(plot_selected(i)));
   handles.data_name{i} = strrep2(filename, '<HTML><FONT color="blue">', '</FONT></HTML>');
   handles.file{i} = [ac_pwd,handles.slash_v,handles.data_name{i}];
end
handles.copycut = 'copy';
cd(pre_dirML);
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function menu_paste_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to menu_copy

% --------------------------------------------------------------------
function menu_paste_Callback(hObject, eventdata, handles)
% hObject    handle to menu_paste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CDac_pwd;
copycut = handles.copycut; % cut or copy
nplot = handles.nplot; % number of selected files
if nplot == 0
    return
end

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a158',lang_id);
    a158 = handles.lang_var{locb1};
    [~, locb1] = ismember('a159',lang_id);
    a159 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('main30',lang_id);
    main30 = handles.lang_var{locb1};
    [~, locb1] = ismember('main31',lang_id);
    main31 = handles.lang_var{locb1};
    [~, locb1] = ismember('main29',lang_id);
    main29 = handles.lang_var{locb1};
    
    case1 = main30;
    case2 = main31;
else
    case1 = 'Yes';
    case2 = 'No';
end

disp('debug 1')
for i = 1:nplot
    if strcmp(copycut,'cut')
        % cut
        new_name = handles.data_name{i};
        new_name_w_dir = [ac_pwd,handles.slash_v,new_name];
        if exist(new_name_w_dir)
            if handles.lang_choice == 0
                answer = questdlg(['Cover existed file ',new_name,'?'],...
                    'Warning',...
                    'Yes','No','No');
            else
                answer = questdlg([a158,new_name,'?'],main29,main30,main31,main31);
            end
            % Handle response
            switch answer
                case case1
                    movefile(handles.file{i}, ac_pwd)
                case case2
            end
        else
            movefile(handles.file{i}, ac_pwd)
        end
    elseif strcmp(copycut,'copy')
        % paste copied files
        try
            new_name = handles.data_name{i};
            new_name_w_dir = [ac_pwd,handles.slash_v,new_name];
            if exist(new_name_w_dir)
                [~,dat_name,ext] = fileparts(new_name);
                for i = 1:100
                    new_name = [dat_name,'_',num2str(i),ext];
                    if exist([ac_pwd,handles.slash_v,new_name])
                    else
                        break
                    end
                end
            end
            new_file = [ac_pwd,handles.slash_v,new_name];
            file_list = handles.file;
            copyfile(file_list{i}, new_file)
            disp(file_list)
        catch
            if handles.lang_choice == 0
                disp('No data copied')
            else
                disp(a159)
            end
        end
    else
        disp(' failed')
    end
end
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
if isdir(pre_dirML)
    cd(pre_dirML);
end
guidata(hObject,handles)

% --------------------------------------------------------------------
function menu_delete_Callback(hObject, eventdata, handles)
% hObject    handle to menu_delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
deletefile = 0;

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a160',lang_id);
    a160 = handles.lang_var{locb1};
    [~, locb1] = ismember('a161',lang_id);
    a161 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('main30',lang_id);
    main30 = handles.lang_var{locb1};
    [~, locb1] = ismember('main31',lang_id);
    main31 = handles.lang_var{locb1};
    [~, locb1] = ismember('main29',lang_id);
    main29 = handles.lang_var{locb1};
    
    case1 = main30;
    case2 = main31;
else
    case1 = 'Yes';
    case2 = 'No';
end
if handles.lang_choice == 0 
    choice = questdlg('You are going to DELETE the selected file(s)', ...
        'Warning', 'Yes','No','No');
else
    choice = questdlg(a160, ...
        main29, main30,main31,main31);
end
% Handle response
switch choice
    case case2
        deletefile = 0;
    case case1
        deletefile = 1;
end

if deletefile == 1
    list_content = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
    selected = handles.index_selected;  % read selection in listbox 1; minus 2 for listbox
    nplot = length(selected);   % length
    CDac_pwd; % cd working dir
    % handles.listnumber = handles.listnumber - nplot;
        
    for i = 1:nplot
        plot_no = selected(i);
        plot_filter_selection = char(list_content(plot_no));

        file_type = exist(plot_filter_selection);
            if file_type == 0
                plot_filter_selection = strrep2(plot_filter_selection, '<HTML><FONT color="blue">', '</FONT></HTML>');
            end
        if isdir(plot_filter_selection)
            if handles.lang_choice == 0 
                choice = questdlg('DELETE selected folder and files within it', ...
                    'Warning', 'Yes','No','No');
            else
                choice = questdlg(a161, ...
                    main29, main30,main31,main31);
            end
            % Handle response
            switch choice
                case case2
                case case1
                    status = rmdir(plot_filter_selection,'s');
            end
        else
            recycle on;
            delete(plot_filter_selection);
        end
    end
    d = dir; %get files
    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
    refreshcolor;
    cd(pre_dirML);
    guidata(hObject,handles)
end


% --------------------------------------------------------------------
function menu_add_Callback(hObject, eventdata, handles)
% hObject    handle to menu_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length
% check
check = 0;
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        if sum(strcmp(ext,handles.filetype)) > 0
            if nplot >1
                check = 1; % selection can be executed 
            end
        else
            return
        end
    end
end

if check == 1
    plot_filter_s2 = char(contents(plot_selected(1)));
    GETac_pwd; plot_filter_s2 = fullfile(ac_pwd,plot_filter_s2);
    dat_new = load(plot_filter_s2);
    for i = 1:nplot
        plot_no = plot_selected(i);
        plot_filter_s = char(contents(plot_no));
        data_filterout = load(fullfile(ac_pwd,plot_filter_s));
        dat_new = [dat_new; data_filterout];
        dat_merge = sortrows(dat_new);
    end
    dat_merge = findduplicate(dat_merge);
    CDac_pwd
    dlmwrite('mergedseries.txt', dat_merge, 'delimiter', ' ', 'precision', 9);
    d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder
end
guidata(hObject,handles)


% --------------------------------------------------------------------
function menu_multiply_Callback(hObject, eventdata, handles)
% hObject    handle to menu_multiply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length
% check
check = 0;
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        if sum(strcmp(ext,handles.filetype)) > 0
            if nplot == 2
                check = 1; % selection can be executed 
            end
        else
            return
        end
    end
end

if check == 1
    plot_filter_s2 = char(contents(plot_selected(1)));
    GETac_pwd; plot_filter_s2 = fullfile(ac_pwd,plot_filter_s2);
    dat_new = load(plot_filter_s2);
    dat_new1 = dat_new;
    dat_new2 = dat_new;
    for i = 1:nplot
        plot_no = plot_selected(i);
        plot_filter_s = char(contents(plot_no));
        data_filterout = load(fullfile(ac_pwd,plot_filter_s));
        dat_new1 = [dat_new(:,1),  dat_new1(:,2).* data_filterout(:,2)];
        dat_new2 = [data_filterout(:,1),  dat_new2(:,2).* data_filterout(:,2)];
    end
    CDac_pwd
    dlmwrite('multipliedseries1.txt', dat_new1, 'delimiter', ' ', 'precision', 9);
    dlmwrite('multipliedseries2.txt', dat_new2, 'delimiter', ' ', 'precision', 9);
    d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder
end
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function menu_sort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --------------------------------------------------------------------
function menu_sort_Callback(hObject, eventdata, handles)
% hObject    handle to menu_sort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%<<<<<<< HEAD
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('main38',lang_id);
    main38 = handles.lang_var{locb1};
    [~, locb1] = ismember('a49',lang_id);
    a49 = handles.lang_var{locb1};
    [~, locb1] = ismember('a62',lang_id);
    a62 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('a163',lang_id);
    a163 = handles.lang_var{locb1};
    [~, locb1] = ismember('a164',lang_id);
    a164 = handles.lang_var{locb1};
    [~, locb1] = ismember('a165',lang_id);
    a165 = handles.lang_var{locb1};
    [~, locb1] = ismember('a166',lang_id);
    a166 = handles.lang_var{locb1};
    [~, locb1] = ismember('a167',lang_id);
    a167 = handles.lang_var{locb1};
    [~, locb1] = ismember('a168',lang_id);
    a168 = handles.lang_var{locb1};
    [~, locb1] = ismember('a169',lang_id);
    a169 = handles.lang_var{locb1};
    [~, locb1] = ismember('a170',lang_id);
    a170 = handles.lang_var{locb1};
end
if handles.lang_choice == 0
    disp(['Select ',num2str(nplot),' data'])
else
    disp([main38,' ',num2str(nplot),a62])
end
for nploti = 1:nplot
    if handles.lang_choice == 0
        prompt = {'Sort data in ascending order?','Unique values in data?','Remove empty row?','Apply to ALL'};
        dlg_title = 'Sort, Unique & Remove empty (1 = yes)';
    else
        prompt = {a163,a164,a165,a166};
        dlg_title = a167;
    end
    num_lines = 1;
    defaultans = {num2str(handles.math_sort),num2str(handles.math_unique),num2str(handles.math_deleteempty),'0'};
    options.Resize='on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    if ~isempty(answer)
        datasort = str2double(answer{1});
        dataunique = str2double(answer{2});
        dataempty = str2double(answer{3});
        dataApply2ALL = str2double(answer{4});

        if dataApply2ALL == 1
            for nploti = 1:nplot
            % Apply settings to all data
                data_name_all = (contents(plot_selected));
                data_name = char(data_name_all{nploti});
                data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
                GETac_pwd; 
                data_name = fullfile(ac_pwd,data_name);
                if handles.lang_choice == 0
                    disp(['>>  Processing ', data_name]);
                else
                    disp([a49, data_name]);
                end
                data_error = 0;
                if isdir(data_name) == 1
                else
                    [~,dat_name,ext] = fileparts(data_name);
                    if sum(strcmp(ext,handles.filetype)) > 0
                        try
                            data = load(data_name);
                        catch
                            fid = fopen(data_name);
                            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
                            fclose(fid);
                            if iscell(data_ft)
                                try
                                    data = cell2mat(data_ft);
                                catch
                                    fid = fopen(data_name,'at');
                                    fprintf(fid,'%d\n',[]);
                                    fclose(fid);
                                    fid = fopen(data_name);
                                    data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                                    fclose(fid);
                                    try
                                        data = cell2mat(data_ft);
                                    catch
                                        if handles.lang_choice == 0
                                            warndlg(['Check data file: ', dat_name],'Data Error!')
                                            disp(['      Error! Skipped. Check the data file:', dat_name]);
                                        else
                                            warndlg([a168, dat_name],a169)
                                            disp([a170, dat_name]);
                                        end
                                        data_error = 1;
                                    end
                                end
                            end
                        end
                        if data_error ==1
                        else
                            data = data(~any(isnan(data),2),:); % remove NaN values
                            if datasort == 1
                                data = sortrows(data);
                                name1 = [dat_name,'-so'];
                            end
                            if dataunique == 1
                                data=findduplicate(data);
                                name1 = [dat_name,'-u'];  % New name
                            end
                            if (datasort + dataunique) == 2
                                name1 = [dat_name,'-su'];  % New name
                            end
                            if dataempty == 1
                                data(any(isinf(data),2),:) = [];
                                if (datasort + dataunique) > 0
                                    name1 = [name1,'e'];  % New name
                                else
                                    name1 = [dat_name,'-e'];  % New name
                                end
                            end
                            if (datasort + dataunique + dataempty) > 0
                                name2 = [name1,ext];
                            else
                                name2 = [dat_name,ext];
                            end
                            % remember settings
                            handles.math_sort = datasort;
                            handles.math_unique = dataunique;
                            handles.math_deleteempty = dataempty;

                            CDac_pwd
                            dlmwrite(name2, data, 'delimiter', ' ', 'precision', 9);
                        end
                    end
                end
            end
            d = dir; %get files
            set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
            refreshcolor;
            cd(pre_dirML); % return to matlab view folder
            return
        else
            data_name_all = (contents(plot_selected));
            data_name = char(data_name_all{nploti});
            data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
            GETac_pwd;
            data_name = fullfile(ac_pwd,data_name);
            if handles.lang_choice == 0
                disp(['>>  Processing ', data_name]);
            else
                disp([a49, data_name]);
            end
            data_error = 0;
            if isdir(data_name) == 1
            else
                [~,dat_name,ext] = fileparts(data_name);
                if sum(strcmp(ext,handles.filetype)) > 0
                    try
                        data = load(data_name);
                    catch
                        fid = fopen(data_name);
                        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
                        fclose(fid);
                        if iscell(data_ft)
                            try
                                data = cell2mat(data_ft);
                            catch
                                fid = fopen(data_name,'at');
                                fprintf(fid,'%d\n',[]);
                                fclose(fid);
                                fid = fopen(data_name);
                                data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                                fclose(fid);
                                try
                                    data = cell2mat(data_ft);
                                catch
                                    % length of 2 columns are not equal
                                    lengthmin = min(length(data_ft{1,1}), length(data_ft{1,2}));
                                    data_ft1 = data_ft{1,1};
                                    data_ft2 = data_ft{1,2};
                                    data_ft_new{1,1} = data_ft1(1:lengthmin);
                                    data_ft_new{1,2} = data_ft2(1:lengthmin);
                                    try 
                                        data = cell2mat(data_ft_new);
                                    catch
                                        if handles.lang_choice == 0
                                            warndlg(['Check data file: ', dat_name],'Data Error!')
                                            disp(['      Error! Skipped. Check the data file:', dat_name]);
                                        else
                                            warndlg([a168, dat_name],a169)
                                            disp([a170, dat_name]);
                                        end
                                        data_error = 1;
                                    end
                                end
                            end
                        end
                    end
                    if data_error == 1
                    else
                        data = data(~any(isnan(data),2),:); % remove NaN values
                        if datasort == 1
                            data = sortrows(data);
                            name1 = [dat_name,'-so'];
                        end
                        if dataunique == 1
                            data=findduplicate(data);
                            name1 = [dat_name,'-u'];  % New name
                        end
                        if (datasort + dataunique) == 2
                            name1 = [dat_name,'-su'];  % New name
                        end
                        if dataempty == 1
                            data(any(isinf(data),2),:) = [];
                            if (datasort + dataunique) > 0
                                name1 = [name1,'e'];  % New name
                            else
                                name1 = [dat_name,'-e'];  % New name
                            end
                        end
                        if (datasort + dataunique + dataempty) > 0
                            name2 = [name1,ext];
                        else
                            name2 = [dat_name,ext];
                        end
                        % remember settings
                        handles.math_sort = datasort;
                        handles.math_unique = dataunique;
                        handles.math_deleteempty = dataempty;

                        CDac_pwd
                        dlmwrite(name2, data, 'delimiter', ',', 'precision', 9);
                        d = dir; %get files
                        set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                        refreshcolor;
                        cd(pre_dirML); % return to matlab view folder
                    end
                end
            end
        end
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_sr2age_Callback(hObject, eventdata, handles)
% hObject    handle to menu_sr2age (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            
            data = load(data_name);
            data = data(~any(isnan(data),2),:);
            data = sortrows(data);
            
            time = data(:,1);
            value = data(:,2);
            npts = length(time);
            agemodel = zeros(npts,2);
            agemodel(:,1) = time;
            for i = 2:npts
                agemodel(i,2) = 100*(time(i)-time(i-1))/value(i-1)+agemodel(i-1,2);
            end
            name1 = [dat_name,'-agemod',ext];  % New name
                CDac_pwd
            dlmwrite(name1, agemodel, 'delimiter', ' ', 'precision', 9);
            d = dir; %get files
            set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
            refreshcolor;
            cd(pre_dirML); % return to matlab view folder
        end
        end
end
guidata(hObject, handles);



% --------------------------------------------------------------------
function menu_plotpro_2d_Callback(hObject, eventdata, handles)
% hObject    handle to menu_plotpro_2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('dd01',lang_id);
    dd01 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd24',lang_id);
    dd24 = handles.lang_var{locb1};
end

% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,dat_name,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        elseif sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0

            imfinfo1 = imfinfo(plot_filter_s); % image information
            supportcolor = {'grayscale', 'truecolor'};

            if strcmp(imfinfo1.ColorType,'CIELab')
                im_name = imread(plot_filter_s);

                aDouble = double(im_name); 

                cielab(:,:,1) = aDouble(:,:,1) ./ (255/100);
                cielab(:,:,2) = aDouble(:,:,2)-128;
                cielab(:,:,3) = aDouble(:,:,3)-128;
                hFig1 = figure;                    
                subplot(3,1,1)
                imshow(cielab(:,:,1),[0 100])
                title('L*')
                subplot(3,1,2)
                imshow(cielab(:,:,2),[-128 127])
                title('a*')
                subplot(3,1,3)
                imshow(cielab(:,:,3),[-128 127])
                title('b*')
                set(gcf,'Name',[dat_name,ext],'NumberTitle','off')

                hFig2 = figure;
                imshow(lab2rgb(cielab));
                set(gcf,'Name',[dat_name,'Lab2RGB',ext],'NumberTitle','off')

            elseif any(strcmp(supportcolor,imfinfo1.ColorType))
                im_name = imread(plot_filter_s);
                hFig1 = figure;
                imshow(im_name);
                set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                [warnMsg, warnId] = lastwarn;
                if ~isempty(warnMsg)
                    close(hFig1)
                    imscrollpanel_ac(plot_filter_s);
                end
            else
                try
                    % GRB and Grayscale supported here
                    im_name = imread(plot_filter_s);
                    hFig1 = figure;
                    lastwarn('') % Clear last warning message
                    imshow(im_name);
                    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
                    [warnMsg, warnId] = lastwarn;
                    if ~isempty(warnMsg)
                        close(hFig1)
                        imscrollpanel_ac(data_name);
                    end
                catch
                    if handles.lang_choice == 0
                        warndlg('Image color space not supported. Convert to RGB or Grayscale')
                    else
                        warndlg(dd24)
                    end
                end
            end
        end
    end
end
if check == 1
    GETac_pwd; 
    for i = 1: nplot
        plot_no = plot_selected(i);
        handles.plot_s{i} = fullfile(ac_pwd,char(contents(plot_no)));
    end
    assignin('base','ac_pwd',ac_pwd);  % save current folder
    current_data = load(handles.plot_s{1});
    handles.current_data = current_data;
    handles.dat_name = handles.plot_s{1};
    handles.nplot = nplot;
    guidata(hObject, handles);
    PlotPro2DLineGUI(handles);
end


% --------------------------------------------------------------------
function menu_rho_Callback(hObject, eventdata, handles)
% hObject    handle to menu_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
nsim_yes = 0;


%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('main38',lang_id);
    main38 = handles.lang_var{locb1};  % Monte Carlo
    [~, locb1] = ismember('main39',lang_id);
    main39 = handles.lang_var{locb1};  % Monte Carlo
    [~, locb1] = ismember('main37',lang_id);
    main37 = handles.lang_var{locb1};  % Cancel
    [~, locb1] = ismember('a180',lang_id);
    a180 = handles.lang_var{locb1};
    [~, locb1] = ismember('a181',lang_id);
    a181 = handles.lang_var{locb1};
    [~, locb1] = ismember('a182',lang_id);
    a182 = handles.lang_var{locb1};
    [~, locb1] = ismember('a183',lang_id);
    a183 = handles.lang_var{locb1};
    [~, locb1] = ismember('a184',lang_id);
    a184 = handles.lang_var{locb1};
    [~, locb1] = ismember('a185',lang_id);
    a185 = handles.lang_var{locb1};
    [~, locb1] = ismember('a186',lang_id);
    a186 = handles.lang_var{locb1};
    [~, locb1] = ismember('a187',lang_id);
    a187 = handles.lang_var{locb1};
    [~, locb1] = ismember('a188',lang_id);
    a188 = handles.lang_var{locb1};
    [~, locb1] = ismember('a189',lang_id);
    a189 = handles.lang_var{locb1};
    [~, locb1] = ismember('a190',lang_id);
    a190 = handles.lang_var{locb1};
    [~, locb1] = ismember('a191',lang_id);
    a191 = handles.lang_var{locb1};
    [~, locb1] = ismember('a192',lang_id);
    a192 = handles.lang_var{locb1};
    [~, locb1] = ismember('a193',lang_id);
    a193 = handles.lang_var{locb1};
    [~, locb1] = ismember('a194',lang_id);
    a194 = handles.lang_var{locb1};
    [~, locb1] = ismember('a195',lang_id);
    a195 = handles.lang_var{locb1};
    [~, locb1] = ismember('a196',lang_id);
    a196 = handles.lang_var{locb1};
    [~, locb1] = ismember('a197',lang_id);
    a197 = handles.lang_var{locb1};
    [~, locb1] = ismember('a198',lang_id);
    a198 = handles.lang_var{locb1};
    [~, locb1] = ismember('a199',lang_id);
    a199 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('main21',lang_id);
    main21 = handles.lang_var{locb1};
    [~, locb1] = ismember('main23',lang_id);
    main23 = handles.lang_var{locb1};
    [~, locb1] = ismember('main34',lang_id);
    main34 = handles.lang_var{locb1};
    [~, locb1] = ismember('main35',lang_id);
    main35 = handles.lang_var{locb1};
    [~, locb1] = ismember('main40',lang_id);
    main40 = handles.lang_var{locb1};
    [~, locb1] = ismember('main41',lang_id);
    main41 = handles.lang_var{locb1};
    [~, locb1] = ismember('menu46',lang_id);
    menu46 = handles.lang_var{locb1};
    
end

if handles.lang_choice == 0
    choice = questdlg('Single run or Monte Carlo Simulation', ...
        'Select', 'Single','Monte Carlo','Cancel','Single');
    case1= 'Single';
    case2= 'Monte Carlo';
    case3= 'Cancel';
else
    choice = questdlg(a180,main38, a181,main39,main37,a181);
    case1= a181;
    case2= main39;
    case3= main37;
end
% Handle response
switch choice
    case case1
        nsim_yes = 0;
    case case2
        nsim_yes = 1;
    case case3
        nsim_yes = 2;
end
if nsim_yes < 2
    contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
    plot_selected = get(handles.listbox_acmain,'Value');
    nplot = length(plot_selected);   % length
    if nplot > 1
        if handles.lang_choice == 0
            warndlg('Select 1 data only','Error');
        else
            warndlg(a182,main35);
        end
    end
    if nplot == 1
        data_name = char(contents(plot_selected));
        data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
        GETac_pwd; data_name = fullfile(ac_pwd,data_name);
            if isdir(data_name) == 1
            else
                [~,dat_name,ext] = fileparts(data_name);
                if sum(strcmp(ext,handles.filetype)) > 0
                    data = load(data_name);
                    samplerate = diff(data(:,1));
                    ndata = length(data(:,1));
                    datalength = data(length(data(:,1)),1)-data(1,1);
                    samp95 = prctile(samplerate,95);  % new version; 1-2 * sample 95% percentile

                    if nsim_yes == 0

                        if .3 * datalength > 400
                            window1 = 400;
                        else
                            window1 = .3 * datalength;
                        end
                        if handles.lang_choice == 0
                            prompt = {'Window',...
                            'Sampling rate (Default = 95% percentile)'};
                            dlg_title = 'Evolutionary RHO in AR(1)';
                        else
                            prompt = {main41,a183};
                            dlg_title = a184;
                        end
                        num_lines = 1;
                        defaultans = {num2str(window1),num2str(samp95)};
                        options.Resize='on';
                        answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
                        if ~isempty(answer)
                            window = str2double(answer{1});
                            interpolate_rate= str2double(answer{2});
                            [data_even] = interpolate(data,interpolate_rate);
                            [rhox] = erhoAR1(data_even,window);

                            figure; plot(rhox(:,1),rhox(:,2),'LineWidth',1)

                            if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                                if handles.unit_type == 0
                                    xlabel(['Unit (',handles.unit,')'])
                                elseif handles.unit_type == 1
                                    xlabel(['Depth (',handles.unit,')'])
                                else
                                    xlabel(['Time (',handles.unit,')'])
                                end
                                ylabel('RHO in AR(1)')
                                title(['Window',' = ',num2str(window),'. ','Sampling rate',' = ',num2str(interpolate_rate)])
                            else
                                if handles.unit_type == 0
                                    xlabel([main34,' (',handles.unit,')'])
                                elseif handles.unit_type == 1
                                    xlabel([main23,' (',handles.unit,')'])
                                else
                                    xlabel([main21,' (',handles.unit,')'])
                                end
                                ylabel(a185)
                                title([main41,' = ',num2str(window),'. ',menu46,' = ',num2str(interpolate_rate)])
                            end

                            set(gca,'XMinorTick','on','YMinorTick','on')
                            name1 = [dat_name,'-rho1.txt'];
                            CDac_pwd
                            if exist([pwd,handles.slash_v,name1])
                                for i = 1:100
                                    name1 = [dat_name,'-rho1-',num2str(i),'.txt'];
                                    if exist([pwd,handles.slash_v,name1])
                                    else
                                         break
                                    end
                                end
                            end
                            dlmwrite(name1, rhox, 'delimiter', ' ', 'precision', 9); 
                            if handles.lang_choice == 0
                                disp(['>>  Save rho1    : ',name1])   
                            else
                                disp([a186,name1])   
                            end

                            cd(pre_dirML); % return to matlab view folder
                        end
                    else
                        if handles.lang_choice == 0
                            prompt = {'Monte Carlo simulations',...
                            'Window ranges from',...
                            'Window ranges to',...
                            'Sampling rate from',...
                            'Sampling rate to',...
                            'Plot: interpolation',...
                            'Plot: shift grids (Default = 15; no shift = 1)'};
                            dlg_title = 'Monte Carlo Simulation of eRHO in AR(1)';
                        else
                            prompt = {a187,a188,a189,a190,a191,a192,a193};
                            dlg_title = a194;
                        end
                        num_lines = 1;
                        if ndata > 1000
                            interpn = 1000;
                        else
                            interpn = ndata;
                        end

                        if .3 * datalength > 400
                            window1 = 400;
                            window2 = 500;
                        else
                            window1 = .3 * datalength;
                            window2 = .4 * datalength;
                        end

                        defaultans = {'1000',num2str(window1),num2str(window2),...
                            num2str(samp95),num2str(2*samp95),num2str(interpn),'15'};
                        options.Resize='on';
                        answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
                        if ~isempty(answer)
                            nsim = str2double(answer{1});
                            window1 = str2double(answer{2});
                            window2 = str2double(answer{3});
                            samprate1 = str2double(answer{4});
                            samprate2 = str2double(answer{5});
                            nout = str2double(answer{6});
                            shiftwin = str2double(answer{7});

                            % Waitbar
                            if handles.lang_choice == 0
                                hwaitbar = waitbar(0,'Noise estimation - rho1: Monte Carlo processing ...',...    
                                   'WindowStyle','modal');
                            else
                                hwaitbar = waitbar(0,a195,'WindowStyle','modal');
                            end
                            hwaitbar_find = findobj(hwaitbar,'Type','Patch');
                            set(hwaitbar_find,'EdgeColor',[0 0.9 0],'FaceColor',[0 0.9 0]) % changes the color to blue
                            steps = 100;
                            % step estimation for waitbar
                            nmc_n = round(nsim/steps);
                            waitbarstep = 1;
                            waitbar(waitbarstep / steps)
                            %
                          if nsim >= 50
                            samplez = samprate1+(samprate2-samprate1)*rand(1,nsim);
                            window_sim = window1 + (window2-window1) * rand(1,nsim);
                            y_grid = linspace(data(1,1),data(length(data(:,1)),1),nout);
                            y_grid = y_grid';
                            powy = zeros(nout,nsim);
                            if shiftwin > 1
                                for i=1:nsim
                                    window = window_sim(i);
                                    interpolate_rate= samplez(i);
                                    [data_even] = interpolate(data,interpolate_rate);
                                    [rhox] = erhoAR1(data_even,window);
                                    y_grid_rand = -1*window/2 + window * rand(1);
                                    % interpolation
                                    powy(:,i)=interp1((rhox(:,1)+y_grid_rand),rhox(:,2),y_grid);
                                    if handles.lang_choice == 0
                                        disp(['Simulation step = ',num2str(i),' / ',num2str(nsim)]);
                                    else
                                        disp([a196,num2str(i),' / ',num2str(nsim)]);
                                    end

                                    if rem(i,nmc_n) == 0
                                        waitbarstep = waitbarstep+1; 
                                        if waitbarstep > steps; waitbarstep = steps; end
                                        pause(0.001);%
                                        waitbar(waitbarstep / steps)
                                    end
                                end
                            elseif shiftwin == 1
                                for i=1:nsim
                                    window = window_sim(i);
                                    interpolate_rate= samplez(i);
                                    [data_even] = interpolate(data,interpolate_rate);
                                    [rhox] = erhoAR1(data_even,window);
                                    % interpolation
                                    powy(:,i)=interp1(rhox(:,1),rhox(:,2),y_grid);
                                    if handles.lang_choice == 0
                                        disp(['Simulation step = ',num2str(i),' / ',num2str(nsim)]);
                                    else
                                        disp([a196,num2str(i),' / ',num2str(nsim)]);
                                    end
                                    if rem(i,nmc_n) == 0
                                        waitbarstep = waitbarstep+1; 
                                        if waitbarstep > steps; waitbarstep = steps; end
                                        pause(0.001);%
                                        waitbar(waitbarstep / steps)
                                    end
                                end
                            end  

                            if ishandle(hwaitbar)
                                close(hwaitbar);
                            end

                            percent =[2.5,5,10,15.865,25,50,75,84.135,90,95,97.5];
                            npercent  = length(percent);
                            npercent2 = (length(percent)-1)/2;
                            powyp = prctile(powy, percent,2);

                            for i = 1: npercent
                                powyadjustp1=powyp(:,i);
                                powyad_p_nan(:,i) = powyadjustp1(~isnan(powyadjustp1));
                            end
                            y_grid_nan = y_grid(~isnan(powyp(:,1)));

                            figure;hold all
                            colorcode = [221/255,234/255,224/255; ...
                            201/255,227/255,209/255; ...
                            176/255,219/255,188/255;...
                            126/255,201/255,146/255;...
                            67/255,180/255,100/255];
                            for i = 1:npercent2
                                fill([y_grid_nan; (fliplr(y_grid_nan'))'],[powyad_p_nan(:,npercent+1-i);...
                                (fliplr(powyad_p_nan(:,i)'))'],colorcode(i,:),'LineStyle','none');
                            end
                            plot(y_grid,powyp(:,npercent2+1),'Color',[0,120/255,0],'LineWidth',1.5,'LineStyle','--')
                            hold off

                            set(gca,'XMinorTick','on','YMinorTick','on')

                            if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                                if handles.unit_type == 0
                                    xlabel(['Unit (',handles.unit,')'])
                                elseif handles.unit_type == 1
                                    xlabel(['Depth (',handles.unit,')'])
                                else
                                    xlabel(['Time (',handles.unit,')'])
                                end
                                ylabel('RHO in AR(1)')
                                legend('2.5% - 97.5%', '5% - 95%', '10% - 90%','15.87% - 84.14%', '25% - 75%', 'Median')
                                title(['Window',': ',num2str(window1),'_',num2str(window2),...
                                    '. ','Sampling Rate',': ',num2str(samprate1),'_',num2str(samprate2)], 'Interpreter', 'none')
                            else
                                if handles.unit_type == 0
                                    xlabel([main34,' (',handles.unit,')'])
                                elseif handles.unit_type == 1
                                    xlabel([main23,' (',handles.unit,')'])
                                else
                                    xlabel([main21,' (',handles.unit,')'])
                                end
                                ylabel(a185)
                                legend('2.5% - 97.5%', '5% - 95%', '10% - 90%','15.87% - 84.14%', '25% - 75%', main40)
                                title([main41,': ',num2str(window1),'_',num2str(window2),...
                                    '. ',menu46,': ',num2str(samprate1),'_',num2str(samprate2)], 'Interpreter', 'none')
                            end


                            name1 = [dat_name,'-rho1-median.txt'];
                            data1 = [y_grid_nan,powyad_p_nan(:,npercent2+1)];
                            name2 = [dat_name,'-rho1-percentile.txt'];
                            data2 = [y_grid_nan,powyad_p_nan];
                            CDac_pwd
                            if exist([pwd,handles.slash_v,name1]) || exist([pwd,handles.slash_v,name2])
                                for i = 1:100
                                    name1 = [dat_name,'-rho1-median-',num2str(i),'.txt'];
                                    name1 = [dat_name,'-rho1-percentile-',num2str(i),'.txt'];
                                    if exist([pwd,handles.slash_v,name1]) || exist([pwd,handles.slash_v,name2])
                                    else
                                         break
                                    end
                                end
                            end
                            dlmwrite(name1, data1, 'delimiter', ' ', 'precision', 9); 
                            dlmwrite(name2, data2, 'delimiter', ' ', 'precision', 9); 
                            if handles.lang_choice == 0
                                disp(['>>  Save rho1 median    : ',name1])   
                                disp(['>>  Save rho1 percentile: ',name2])  
                            else
                                disp([a197,name1])   
                                disp([a198,name2])  
                            end
                            d = dir; %get files
                            set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                            refreshcolor;
                            cd(pre_dirML);
                          else
                              if handles.lang_choice == 0
                                  errordlg('Number simulations is too few, try 1000','Error');
                              else
                                  errordlg(a199,main35);
                              end
                          end
                    end
                    end
                end
            end
    end
guidata(hObject, handles);
end

% --------------------------------------------------------------------
function menu_folder_Callback(hObject, eventdata, handles)
% hObject    handle to menu_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a201',lang_id);
    a201 = handles.lang_var{locb1};
    [~, locb1] = ismember('a202',lang_id);
    a202 = handles.lang_var{locb1};
    [~, locb1] = ismember('a203',lang_id);
    a203 = handles.lang_var{locb1};
end

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    dat_name = char(contents(plot_selected));
    dat_name = strrep2(dat_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,dat_name);
    if isdir(data_name) == 1
    else
        [~,dat_name,ext] = fileparts(data_name);
    end
else
    dat_name = 'newfolder';
end
if handles.lang_choice == 0
    prompt = {'Type name of the folder'};
    dlg_title = 'Type name of the folder';
else
    prompt = {a201};
    dlg_title = a201;
end
num_lines = 1;
if handles.lang_choice == 0
    defaultans = {[dat_name,'_new']};
else
    defaultans = {[dat_name,a203]};
end
%defaultans = {'newfolder'};
options.Resize='on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
if ~isempty(answer)
    foldername = (answer{1});
    
    CDac_pwd;   
    mkdir([ac_pwd,handles.slash_v,foldername]);
    if ~isdeployed
        % add path for MatLab version
        addpath(genpath([ac_pwd,handles.slash_v,foldername]));
    end
    cd(ac_pwd);
    refreshcolor;
    cd(pre_dirML);
end


% --------------------------------------------------------------------
function menu_email_Callback(hObject, eventdata, handles)
% hObject    handle to menu_email (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
url = 'mingsongli.com';
web(url,'-browser')

% --------------------------------------------------------------------
function menu_samplerate_Callback(hObject, eventdata, handles)
% hObject    handle to menu_samplerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    
    [~, locb1] = ismember('main21',lang_id);
    main21 = handles.lang_var{locb1};
    [~, locb1] = ismember('main23',lang_id);
    main23 = handles.lang_var{locb1};
    [~, locb1] = ismember('main34',lang_id);
    main34 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('a205',lang_id);
    a205 = handles.lang_var{locb1};
    [~, locb1] = ismember('a206',lang_id);
    a206 = handles.lang_var{locb1};
    [~, locb1] = ismember('a207',lang_id);
    a207 = handles.lang_var{locb1};
    [~, locb1] = ismember('a208',lang_id);
    a208 = handles.lang_var{locb1};
    [~, locb1] = ismember('a209',lang_id);
    a209 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('menu46',lang_id);
    menu46 = handles.lang_var{locb1};
    [~, locb1] = ismember('main06',lang_id);
    main06 = handles.lang_var{locb1};
    [~, locb1] = ismember('main05',lang_id);
    main05 = handles.lang_var{locb1};
    [~, locb1] = ismember('main40',lang_id);
    main40 = handles.lang_var{locb1};
    [~, locb1] = ismember('dd40',lang_id);
    dd40 = handles.lang_var{locb1};
    [~, locb1] = ismember('main42',lang_id);
    main42 = handles.lang_var{locb1};
end

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length
% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,dat_name,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        end
    end
end

if check == 1
    for i = 1:nplot
        plot_no = plot_selected(i);
            plot_filter_s = char(contents(plot_no));
            GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
            
     try
        fid = fopen(plot_filter_s);
        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
        fclose(fid);
        if iscell(data_ft)
            data_filterout = cell2mat(data_ft);
        end
    catch
        data_filterout = load(plot_filter_s);
    end 
            
            t = data_filterout(:,1);
            dt = diff(t);
            len_t = length(t);
            figure;
            datasamp = [t(1:len_t-1),dt];
            datasamp = datasamp(~any(isnan(datasamp),2),:);
            stairs(datasamp(:,1),datasamp(:,2),'LineWidth',1,'Color','k');
            set(gca,'XMinorTick','on','YMinorTick','on')
            set(gcf,'Color', 'white')
            set(0,'Units','normalized') % set units as normalized
            set(gcf,'units','norm') % set location
            set(gcf,'position',[0.1,0.4,0.45,0.45]) % set position
            
            if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                set(gcf,'Name', 'Sampling rate (original domain)','NumberTitle','off')
                if handles.unit_type == 0
                    xlabel(['Unit (',handles.unit,')'])
                    ylabel('Unit')
                elseif handles.unit_type == 1
                    xlabel(['Depth (',handles.unit,')'])
                    ylabel(handles.unit)
                else
                    xlabel(['Time (',handles.unit,')'])
                    ylabel(handles.unit)
                end
                title([[dat_name,ext],': ','sampling rate'], 'Interpreter', 'none')
                
            else
                set(gcf,'Name', a205,'NumberTitle','off')
                if handles.unit_type == 0
                    xlabel([main34,' (',handles.unit,')'])
                    ylabel(main34)
                elseif handles.unit_type == 1
                    xlabel([main23,' (',handles.unit,')'])
                    ylabel(handles.unit)
                else
                    xlabel([main21,' (',handles.unit,')'])
                    ylabel(handles.unit)
                end
                title([[dat_name,ext],': ',lower(menu46)], 'Interpreter', 'none')
            end
            
            
            xlim([min(datasamp(:,1)),max(datasamp(:,1))])
            ylim([0.9*min(dt) max(dt)*1.1])
            
            figure;
            histfit(dt,[],'kernel')
            set(gcf,'Color', 'white')
            set(0,'Units','normalized') % set units as normalized
            set(gcf,'units','norm') % set location
            set(gcf,'position',[0.55,0.4,0.45,0.45]) % set position
            
            if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
            
                title([[dat_name,ext],': kernel fit of sampling rates'], 'Interpreter', 'none')
                set(gcf,'Name', 'Sampling rate: distribution','NumberTitle','off')
                if handles.unit_type == 0
                    xlabel(['Sampling rate (',handles.unit,')'])
                elseif handles.unit_type == 1
                    xlabel(['Sampling rate (',handles.unit,')'])
                else
                    xlabel(['Sampling rate (',handles.unit,')'])
                end
                ylabel('Number')
                note = ['max: ',num2str(max(dt)),'; mean: ',num2str(mean(dt)),...
                    '; median: ',num2str(median(dt)),'; min: ',num2str(min(dt)),...
                    '; variance: ',num2str(var(dt))];
            else
                title([[dat_name,ext],a206], 'Interpreter', 'none')
                set(gcf,'Name', a207,'NumberTitle','off')
                if handles.unit_type == 0
                    xlabel([a208,handles.unit,')'])
                elseif handles.unit_type == 1
                    xlabel([a208,handles.unit,')'])
                else
                    xlabel([a208,handles.unit,')'])
                end
                ylabel(a209)
                note = [main06,':',num2str(max(dt)),',',dd40,': ',num2str(mean(dt)),...
                    ',',lower(main40),': ',num2str(median(dt)),',',main05,': ',num2str(min(dt)),...
                    ',',lower(main42),': ',num2str(var(dt))];
            end
            legend(note)
            %text(mean(dt),len_t/10,note);
    end
end
guidata(hObject,handles)

% --------------------------------------------------------------------
function menu_datadistri_Callback(hObject, eventdata, handles)
% hObject    handle to menu_datadistri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    
    [~, locb1] = ismember('a210',lang_id);
    a210 = handles.lang_var{locb1};
    [~, locb1] = ismember('a211',lang_id);
    a211 = handles.lang_var{locb1};
    [~, locb1] = ismember('main02',lang_id);
    main02 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('main06',lang_id);
    main06 = handles.lang_var{locb1};
    [~, locb1] = ismember('main05',lang_id);
    main05 = handles.lang_var{locb1};
    [~, locb1] = ismember('main40',lang_id);
    main40 = handles.lang_var{locb1};
    [~, locb1] = ismember('main42',lang_id);
    main42 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('dd40',lang_id);
    dd40 = handles.lang_var{locb1};
end

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length
% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,dat_name,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        end
    end
end

if check == 1
    for i = 1:nplot
        plot_no = plot_selected(i);
            plot_filter_s = char(contents(plot_no));
            GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    try
        fid = fopen(plot_filter_s);
        data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
        fclose(fid);
        if iscell(data_ft)
            data_filterout = cell2mat(data_ft);
        end
    catch
        data_filterout = load(plot_filter_s);
    end 

            datax = data_filterout(:,2);
            figure;
            set(gcf,'Color', 'white')
            histfit(datax,[],'kernel')
            if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                set(gcf,'Name', 'Data Distribution','NumberTitle','off')
                title([[dat_name,ext],': kernel fit of the data'], 'Interpreter', 'none')
                xlabel('Data')
                note = ['max: ',num2str(max(datax)),'; mean: ',num2str(mean(datax)),...
                    '; median: ',num2str(median(datax)),'; min: ',num2str(min(datax)),...
                    '; variance: ',num2str(var(datax))];
            else
                set(gcf,'Name', a210,'NumberTitle','off')
                title([[dat_name,ext],a211], 'Interpreter', 'none')
                xlabel(main02)
                note = [main06,':',num2str(max(datax)),',',dd40,': ',num2str(mean(datax)),...
                    ',',lower(main40),': ',num2str(median(datax)),',',main05,': ',num2str(min(datax)),...
                    ',',lower(main42),': ',num2str(var(datax))];
            end
            legend(note)
            ylabel('#')
    end
end
guidata(hObject,handles)

            
% --------------------------------------------------------------------
function menu_pda_Callback(hObject, eventdata, handles)
% hObject    handle to menu_pda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    
    [~, locb1] = ismember('main43',lang_id);
    main43 = handles.lang_var{locb1};
    [~, locb1] = ismember('main44',lang_id);
    main44 = handles.lang_var{locb1};
    [~, locb1] = ismember('main45',lang_id);
    main45 = handles.lang_var{locb1};
    [~, locb1] = ismember('menu120',lang_id);
    menu120 = handles.lang_var{locb1};
    main45 = handles.lang_var{locb1};
    [~, locb1] = ismember('main41',lang_id);
    main41 = handles.lang_var{locb1};
    [~, locb1] = ismember('main02',lang_id);
    main02 = handles.lang_var{locb1};
    [~, locb1] = ismember('main32',lang_id);
    main32 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('a215',lang_id);
    a215 = handles.lang_var{locb1};
    [~, locb1] = ismember('a216',lang_id);
    a216 = handles.lang_var{locb1};
    [~, locb1] = ismember('a217',lang_id);
    a217 = handles.lang_var{locb1};
    [~, locb1] = ismember('a218',lang_id);
    a218 = handles.lang_var{locb1};
    [~, locb1] = ismember('a219',lang_id);
    a219 = handles.lang_var{locb1};
    [~, locb1] = ismember('a220',lang_id);
    a220 = handles.lang_var{locb1};
    [~, locb1] = ismember('a221',lang_id);
    a221 = handles.lang_var{locb1};
    [~, locb1] = ismember('a222',lang_id);
    a222 = handles.lang_var{locb1};
    [~, locb1] = ismember('a223',lang_id);
    a223 = handles.lang_var{locb1};
    [~, locb1] = ismember('a224',lang_id);
    a224 = handles.lang_var{locb1};
    [~, locb1] = ismember('a225',lang_id);
    a225 = handles.lang_var{locb1};
    [~, locb1] = ismember('a226',lang_id);
    a226 = handles.lang_var{locb1};
    [~, locb1] = ismember('a227',lang_id);
    a227 = handles.lang_var{locb1};
    [~, locb1] = ismember('a228',lang_id);
    a228 = handles.lang_var{locb1};
    [~, locb1] = ismember('a229',lang_id);
    a229 = handles.lang_var{locb1};
    [~, locb1] = ismember('a230',lang_id);
    a230 = handles.lang_var{locb1};
    [~, locb1] = ismember('a231',lang_id);
    a231 = handles.lang_var{locb1};
    [~, locb1] = ismember('a232',lang_id);
    a232 = handles.lang_var{locb1};
    [~, locb1] = ismember('a233',lang_id);
    a233 = handles.lang_var{locb1};
    [~, locb1] = ismember('a234',lang_id);
    a234 = handles.lang_var{locb1};
end

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length
% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        else
            if handles.lang_choice == 0
                errordlg('Error: Selected file must be a supported type (*.txt,*.csv).');
            else
                errordlg(a215);
            end
        end
    end
end

if check == 1
    if handles.lang_choice == 0
        prompt = {'Paired frequency bands (space delimited):',...
            'Window (kyr):',...
            'Time-bandwidth product, nw:',...
            'Lower cutoff frequency (>= 0)',...
            'Upper cutoff frequency (<= nyquist)',...
            'Step of calculations (kyr):',...
            'Zero-padding number:',...
            'Save results (1 = Yes; 0 = No):',...
            'Padding depth: 0=No, 1=zero, 2=mirror; 3=mean; 4=random'};
        dlg_title = 'Power Decomposition analysis';
    else
        prompt = {a216,a217,a218,a219,a220,a221,a222,a223,a224};
        dlg_title = menu120;
    end
    num_lines = 1;
    defaultans = {'1/45 1/25','500','2',num2str(handles.f1),num2str(handles.f2),'1','5000','1','1'};
    options.Resize='on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    if ~isempty(answer)
        f3 = str2num(answer{1});
        window = str2double(answer{2});
        nw = str2double(answer{3});
        ftmin = str2double(answer{4});
        fterm = str2double(answer{5});
        step = str2double(answer{6});
        pad = str2double(answer{7});
        savedata = str2double(answer{8});
        padtype = str2double(answer{9});
        for i = 1:nplot
            
            plot_no = plot_selected(i);
            plot_filter_s = char(contents(plot_no));
            plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
            GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
            [~,dat_name,ext] = fileparts(plot_filter_s);
            data = load(plot_filter_s);
            
            data = data(~any(isnan(data),2),:);
            diffx = diff(data(:,1));
            if any(diffx(:) < 0)
                if handles.lang_choice == 0
                     warndlg('Warning: data not sorted. Now sorting ... ')
                     disp('>>  %==========        sorting')
                else
                    warndlg(a225)
                     disp(a226)
                end
                 data = sortrows(data); % sort data
            end
            if any(diffx(:) == 0)
                if handles.lang_choice == 0
                    warndlg('Warning: duplicated numbers are replaced with the mean')
                else
                    warndlg(a227)
                end
                data=findduplicate(data); % find duplicate
            end
            if max(diffx)-min(diffx) <= eps(5)
                if handles.lang_choice == 0
                    warndlg('Warning: Data may not be evenly spaced. Interpolation using median sampling rate')
                else
                    warndlg(a228)
                end
                data = interpolate(data,median(diffx));
            end
            if padtype > 0
                data = zeropad2(data,window,padtype);
            end
            if handles.lang_choice == 0
                disp1 = ['Data',': ',plot_filter_s, 'Window',' = ',num2str(window),' kyr; NW =',num2str(nw)];
                disp2 = ['    cutoff freqency:',num2str(ftmin),'_',num2str(fterm),'; ','Step',' =',num2str(step),'; ','Padding',' = ',num2str(pad)];
                disp3 = ['    pairs of frequency bands:'];
                disp4 = 'Wait ... ...';
            else
                disp1 = [main02,': ',plot_filter_s, main41,' = ',num2str(window),' kyr; NW =',num2str(nw)];
                disp2 = [a229,':',num2str(ftmin),'_',num2str(fterm),'; ',main32,' =',num2str(step),'; ',main43,' = ',num2str(pad)];
                disp3 = [a230];
                disp4 = main44;
            end
            disp(disp1)
            disp(disp2)
            disp(disp3)
            disp(f3)
            disp(disp4)
            [pow]=pdan(data,f3,window,nw,ftmin,fterm,step,pad);
            figure;
            plot(pow(:,1),pow(:,2),'k','LineWidth',1);
            set(gca,'XMinorTick','on','YMinorTick','on')
            if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                xlabel('Time (kyr)')
                ylabel('Power ratio')
            else
                xlabel(a231)
                ylabel(a232)
            end
            title(plot_filter_s, 'Interpreter', 'none')
            if savedata == 1
                name1 = [dat_name,'-win',num2str(window),'-pda',ext];
                CDac_pwd  % cd ac_pwd dir
                dlmwrite(name1, pow, 'delimiter', ' ', 'precision', 9);
                disp(name1)
                if handles.lang_choice == 0
                    disp('col #1      col #2   col #3   col #4')
                    disp('depth/time  ratio    target   all')
                else
                    disp(a233)
                    disp(a234)
                end
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
            end
            
        end
        if handles.lang_choice == 0
            disp('Done')
        else
            disp(main45)
        end
    end
end
%end
guidata(hObject,handles)


% --------------------------------------------------------------------
function menu_desection_Callback(hObject, eventdata, handles)
% hObject    handle to menu_desection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    
    %language
    lang_id = handles.lang_id;
    if handles.lang_choice > 0

        [~, locb1] = ismember('a240',lang_id);
        a240 = handles.lang_var{locb1};
        [~, locb1] = ismember('a241',lang_id);
        a241 = handles.lang_var{locb1};
        [~, locb1] = ismember('a242',lang_id);
        a242 = handles.lang_var{locb1};
        [~, locb1] = ismember('a243',lang_id);
        a243 = handles.lang_var{locb1};
    end

    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                
                dat = load(data_name);
                dat = sortrows(dat);
                xmin = dat(1);
                xmax = dat(length(dat(:,1)));
                if handles.lang_choice == 0
                    prompt = {'Start and End point(s) of section(s):'};
                    dlg_title = 'Remove Section(s)';
                else
                    prompt = {a240};
                    dlg_title = a241;
                end
                num_lines = 1;
                defaultans = {''};
                options.Resize='on';
                answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
                if ~isempty(answer)
                    answer = answer{1};
                    answer1 = textscan(answer,'%f','Delimiter',{';','*',',','\t','\b',' '},'Delimiter',',');
                    sec = answer1{1};
                    n_sec = length(sec);
                    if mod(n_sec,2) == 1
                        if handles.lang_choice == 0
                            errordlg('Error: must be 2x points')
                        else
%<<<<<<< HEAD
                            errordlg(a242)
                        end
%=======
                            
                            [data0] = select_interval(dat,xmin,sec(1));
                            data_mer = data0;
                            d_accum = 0;
                            for i = 1: n_sec/2
                                d = sec(2*i) - sec(2*i-1);
                                d_accum = d + d_accum;
                                if i == n_sec/2
                                    [data1] = select_interval(dat,sec(2*i),xmax);
                                    data1(:,1) = data1(:,1) - d_accum;
                                    data_mer = [data_mer;data1];
                                else
                                    [data2] = select_interval(dat,sec(2*i),sec(2*i+1));
                                    data2(:,1) = data2(:,1) - d_accum;
                                    data_mer = [data_mer;data2];
                                end    
                            end
                            name1 = [dat_name,'-desec',ext];
                            disp(['>> Removed sections are ',answer])
                            CDac_pwd  % cd ac_pwd dir
                            dlmwrite(name1, data_mer, 'delimiter', ' ', 'precision', 9); 
                            refreshcolor;
                            cd(pre_dirML); % return to matlab view folder
%>>>>>>> dev_nolang
                        %end
                    else

                        [data0] = select_interval(dat,xmin,sec(1));
                        data_mer = data0;
                        d_accum = 0;
                        for i = 1: n_sec/2
                            d = sec(2*i) - sec(2*i-1);
                            d_accum = d + d_accum;
                            if i == n_sec/2
                                [data1] = select_interval(dat,sec(2*i),xmax);
                                data1(:,1) = data1(:,1) - d_accum;
                                data_mer = [data_mer;data1];
                            else
                                [data2] = select_interval(dat,sec(2*i),sec(2*i+1));
                                data2(:,1) = data2(:,1) - d_accum;
                                data_mer = [data_mer;data2];
                            end    
                        end
                        name1 = [dat_name,'-desec',ext];
                        if handles.lang_choice == 0
                            disp(['>> Removed sections are ',answer])
                        else
                            disp([a243,answer])
                        end
                        
                        CDac_pwd  % cd ac_pwd dir
                        dlmwrite(name1, data_mer, 'delimiter', ',', 'precision', 9); 
                        refreshcolor;
                        cd(pre_dirML); % return to matlab view folder
                    end
                end
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_gap_Callback(hObject, eventdata, handles)
% hObject    handle to menu_gap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    
    %language
    lang_id = handles.lang_id;
    if handles.lang_choice > 0

        [~, locb1] = ismember('a245',lang_id);
        a245 = handles.lang_var{locb1};
        [~, locb1] = ismember('a246',lang_id);
        a246 = handles.lang_var{locb1};
        [~, locb1] = ismember('a247',lang_id);
        a247 = handles.lang_var{locb1};
        [~, locb1] = ismember('a248',lang_id);
        a248 = handles.lang_var{locb1};
    end
    
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                
                dat = load(data_name);
                dat = sortrows(dat);
                xmin = dat(1);
                xmax = dat(length(dat(:,1)));
                if handles.lang_choice  == 0
                    prompt = {'Location and duration of the gap(s): (comma-separated)'};
                        dlg_title = 'Add Gap(s)';
                else
                    prompt = {a245};
                        dlg_title = a246;
                end
                    num_lines = 1;
                    defaultans = {''};
                    options.Resize='on';
                    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
                    if ~isempty(answer)
                        answer = answer{1};
                        answer1 = textscan(answer,'%f','Delimiter',{';','*',',','\t','\b',' '},'Delimiter',',');
                        sec = answer1{1};
                        n_sec = length(sec);
                        if mod(n_sec,2) == 1
                            if handles.lang_choice  == 0
                                errordlg('Error: 1 location must have 1 duration')
                            else
                                errordlg(a247)
                            end
                        else
                            [data0] = select_interval(dat,xmin,sec(1));
                            data_mer = data0;
                            d_accum = 0;
                            for i = 1: n_sec/2
                                d = sec(2*i);
                                d_accum = d + d_accum;
                                if i == n_sec/2
                                    [data1] = select_interval(dat,sec(2*i-1),xmax);
                                    data1(:,1) = data1(:,1) + d_accum;
                                    data_mer = [data_mer;data1];
                                else
                                    [data2] = select_interval(dat,sec(2*i-1),sec(2*i+1));
                                    data2(:,1) = data2(:,1) + d_accum;
                                    data_mer = [data_mer;data2];
                                end    
                            end
                            name1 = [dat_name,'-wgap',ext];
                            if handles.lang_choice  == 0
                                disp(['>> Gap location and duration are ',answer])
                            else
                                disp([a248,answer])
                            end
                            CDac_pwd  % cd ac_pwd dir
                            dlmwrite(name1, data_mer, 'delimiter', ' ', 'precision', 9); 
                            refreshcolor;
                            cd(pre_dirML); % return to matlab view folder
                        end
                    end
            end
        end
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menu_insol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to menu_copy
% --------------------------------------------------------------------
function menu_insol_Callback(hObject, eventdata, handles)
% hObject    handle to menu_insol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
Insolation(handles);


% --------------------------------------------------------------------
function Official_Callback(hObject, eventdata, handles)
% hObject    handle to Official (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function github_Callback(hObject, eventdata, handles)
% hObject    handle to github (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function menu_newtxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to menu_copy

% --------------------------------------------------------------------
function menu_newtxt_Callback(hObject, eventdata, handles)
% hObject    handle to menu_newtxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0

    [~, locb1] = ismember('menu21',lang_id);
    menu21 = handles.lang_var{locb1};
    [~, locb1] = ismember('a250',lang_id);
    a250 = handles.lang_var{locb1};
    [~, locb1] = ismember('a251',lang_id);
    a251 = handles.lang_var{locb1};
    [~, locb1] = ismember('a252',lang_id);
    a252 = handles.lang_var{locb1};
    [~, locb1] = ismember('a253',lang_id);
    a253 = handles.lang_var{locb1};
    [~, locb1] = ismember('a254',lang_id);
    a254 = handles.lang_var{locb1};
    [~, locb1] = ismember('a255',lang_id);
    a255 = handles.lang_var{locb1};
end
    
if nplot == 1
    dat_name = char(contents(plot_selected));
    dat_name = strrep2(dat_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,dat_name);
    if isdir(data_name) == 1
    else
        [~,dat_name,ext] = fileparts(data_name);
    end
else
    if handles.lang_choice  == 0
        dat_name = 'untitled';
    else
        dat_name = a250;
    end
end
if handles.lang_choice  == 0
    prompt = {'Name of the new text file'};
    dlg_title = 'New text file';
    num_lines = 1;
    defaultans = {[dat_name,'_','empty','.txt']};
else
    prompt = {a251};
    dlg_title = menu21;
    num_lines = 1;
    defaultans = {[dat_name,'_',a255,'.txt']};
end
%defaultans = {'untitled.txt'};
options.Resize='on';
answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
if ~isempty(answer)
    
    CDac_pwd;
    filename = answer{1};
    if length(filename) < 4
        filename = [filename,'.txt'];
    else
        if strcmp(filename(end-3:end),'.txt')
        else
            filename = [filename,'.txt'];
        end
    end
    
    if exist([ac_pwd,handles.slash_v,filename])
        
        if handles.lang_choice  == 0
            warndlg('File name exists. An alternative name used','File Name Warning')
        else
            warndlg(a252,a253)
        end
        
        for i = 1:100
            filename = [filename(1:end-4),'_',num2str(i),'.txt'];
            if exist([ac_pwd,handles.slash_v,filename])
            else
                break
            end
        end
    end
    if handles.lang_choice  == 0
        disp(['>>  Create a new data file entitled: ',filename])
    else
        disp([a254,filename])
    end
    fid = fopen([ac_pwd,handles.slash_v,filename], 'wt' );
    fclose(fid);
    cd(ac_pwd);
    refreshcolor;
    cd(pre_dirML);
end


% --------------------------------------------------------------------
function menu_open_Callback(hObject, eventdata, handles)
% hObject    handle to menu_open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%language
lang_id = handles.lang_id;
if handles.lang_choice > 0

    [~, locb1] = ismember('a258',lang_id);
    a258 = handles.lang_var{locb1};
    [~, locb1] = ismember('a259',lang_id);
    a259 = handles.lang_var{locb1};
end

if handles.lang_choice  == 0
    [filename, pathname] = uigetfile({'*.fig','Files (*.fig)'},...
        'Open *.fig file');
else
    [filename, pathname] = uigetfile({'*.fig',a258},...
        a259);
end
if filename == 0
else
    aaa = [pathname,filename];
    openfig(aaa)
end

% --- Executes during object creation, after setting all properties.
function menu_refreshlist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_refresh
% --- Executes on mouse press over axes background.
function menu_refreshlist_Callback(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
CDac_pwd; % cd working dir
refreshcolor;
cd(pre_dirML); % return view dir

% --- Executes during object creation, after setting all properties.
function menu_opendir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --------------------------------------------------------------------
function menu_opendir_Callback(hObject, eventdata, handles)
% hObject    handle to menu_opendir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CDac_pwd; % cd working dir
if ismac
    system(['open ',ac_pwd]);
elseif ispc
    winopen(ac_pwd);
end
cd(pre_dirML); % return view dir


% removed?????

% --- Executes on mouse press over axes background.
function axes_plot_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        elseif sum(strcmp(ext,{'.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.TIF'})) > 0
            try 
                im_name = imread(plot_filter_s);
                figure;
                imshow(im_name)
                set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
            catch
            end
        end
    end
end

if check == 1
    for i = 1: nplot
        plot_no = plot_selected(i);
        handles.plot_s{i} = fullfile(ac_pwd,char(contents(plot_no)));
    end
    handles.nplot = nplot;
    guidata(hObject, handles);
    PlotAdv(handles);
end


% --------------------------------------------------------------------
function menu_extract_Callback(hObject, eventdata, handles)
% hObject    handle to menu_extract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
nplot = length(plot_selected);   % length

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0

    [~, locb1] = ismember('menu25',lang_id);
    menu25 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('a260',lang_id);
    a260 = handles.lang_var{locb1};
    [~, locb1] = ismember('a261',lang_id);
    a261 = handles.lang_var{locb1};
    [~, locb1] = ismember('a262',lang_id);
    a262 = handles.lang_var{locb1};
    [~, locb1] = ismember('a263',lang_id);
    a263 = handles.lang_var{locb1};
    [~, locb1] = ismember('a264',lang_id);
    a264 = handles.lang_var{locb1};
    [~, locb1] = ismember('a265',lang_id);
    a265 = handles.lang_var{locb1};
end


% check
for i = 1:nplot
plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        else
            if handles.lang_choice == 0
                errordlg('Error: unsupported file type')
            else
                errordlg(a260)
            end
        end
    end
end

if check == 1
    for i = 1:nplot
        plot_no = plot_selected(i);
        plot_filter_s = char(contents(plot_no));
        plot_filter_s = fullfile(ac_pwd,plot_filter_s);
        [~,dat_name,ext] = fileparts(plot_filter_s);
        if handles.lang_choice == 0
            prompt = {'new 1st column = old column #',...
                'new 2nd column = old column #'};
            dlg_title = 'Extract data';
        else
            prompt = {a261,...
                a262};
            dlg_title = menu25;
        end
        num_lines = 1;
        defaultans = {'1','2'};
        options.Resize='on';
        answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
        if ~isempty(answer)
            c1 = str2double(answer{1});
            c2 = str2double(answer{2});
            c0 = c2;
            if or(c1<1, c2<1)
                if handles.lang_choice == 0
                    errordlg('Error: Input column number is no less than 1')
                else
                    errordlg(a263)
                end
            else
                try
                    data = load(plot_filter_s);
                catch       
                    fid = fopen(plot_filter_s);
                    data_ft = textscan(fid,'%f',c0,'Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
                    %size(data_ft)
                    fclose(fid);
                    if iscell(data_ft)
                        data = cell2mat(data_ft);
                    end
                end
                [~, ncol] = size(data);

                data = data(~any(isnan(data),2),:);
                try
                    data_new(:,1) = data(:,c1);
                    data_new(:,2) = data(:,c2);
                    CDac_pwd  % cd ac_pwd dir
                    % save data
                    name1 = [dat_name,'-c',num2str(c1),'-c',num2str(c2),ext];  % New name

                    dlmwrite(name1, data_new, 'delimiter', ' ', 'precision', 9);
                    if handles.lang_choice == 0
                        disp(['Extract data from columns ',num2str(c1),' & ',num2str(c2),' : ',dat_name,ext])
                    else
                        disp([a264,num2str(c1),' & ',num2str(c2),' : ',dat_name,ext])
                    end
                    d = dir; %get files
                    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                    refreshcolor;
                    cd(pre_dirML); % return to matlab view folder
                catch
                    if handles.lang_choice == 0
                        errordlg('Error! Input column number may be too large')
                    else
                        errordlg(a265)
                    end
                    
                end
            end
        end
    end
end

guidata(hObject,handles)


% --------------------------------------------------------------------
function menu_pca_Callback(hObject, eventdata, handles)
% hObject    handle to menu_pca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = handles.index_selected;  % read selection in listbox 1
%<<<<<<< HEAD
nplot = length(plot_selected);   % length

%=======
nplot = length(plot_selected);   % length  % only work for 1 data file. needs more work if more data is selected
%>>>>>>> dev_nolang
% check
for i = 1:nplot
    plot_no = plot_selected(i);
    plot_filter_s = char(contents(plot_no));
    plot_filter_s = strrep2(plot_filter_s, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; plot_filter_s = fullfile(ac_pwd,plot_filter_s);
    if isdir(plot_filter_s)
        return
    else
        [~,~,ext] = fileparts(plot_filter_s);
        check = 0;
        if sum(strcmp(ext,handles.filetype)) > 0
            check = 1; % selection can be executed 
        end
    end
end

if check == 1;
      
    %language
    lang_id = handles.lang_id;
    [~, locb1] = ismember('a268',lang_id);
    a268 = handles.lang_var{locb1};
    
    [~, locb1] = ismember('a269',lang_id);
    a269 = handles.lang_var{locb1};
    
    if handles.lang_choice > 0
        [~, locb1] = ismember('a270',lang_id);
        a270 = handles.lang_var{locb1};

        [~, locb1] = ismember('a271',lang_id);
        a271 = handles.lang_var{locb1};
        [~, locb1] = ismember('a272',lang_id);
        a272 = handles.lang_var{locb1};
    end

    data_new = [];
    nrow = [];
    data_pca = [];
    if handles.lang_choice 
        disp('>>  Principal component analysis of ')
    else
        disp(a270)
    end
    for i = 1:nplot
        plot_no = plot_selected(i);
        plot_filter_s = char(contents(plot_no));
        plot_filter_s = fullfile(ac_pwd,plot_filter_s);
        % read data
        try
            data_filterout = load(plot_filter_s);
        catch       
            fid = fopen(plot_filter_s);
            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', Inf);
            fclose(fid);
            if iscell(data_ft)
                data_filterout = cell2mat(data_ft);
            end
        end
        data_filterout = data_filterout(~any(isnan(data_filterout),2),:); %remove empty
        
        if nplot == 1
            data_new = data_filterout;
        else
            if i == 1
                data_new(:,i) = data_filterout(:,2);
                data_pca = data_filterout(:,1);
                disp(['>>   ',plot_filter_s]);
            else
                [nrow(i-1),~] = size(data_new);
                if nrow(i-1) ~= length(data_filterout(:,2))
                    if handles.lang_choice 
                        errordlg('Error: number of rows of series must be the same')
                    else
                        errordlg(a271)
                    end
                    
                else
                    data_new(:,i) = data_filterout(:,2);
                    data_pca = data_filterout(:,1);
                    disp(['>>   ',plot_filter_s]);
                end
            end
            data_new = [data_pca, data_new];
        end
    end


    
    prompt = {a269};
    dlg_title = a268;
    num_lines = 1;
    defaultans = {'1'};
    options.Resize='on';
    answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
    if ~isempty(answer)
        depthtime = str2double(answer{1});
        % if data contains depth/time column, remove it
        if depthtime == 1
            data_new2 = data_new(:,2:end);
        else
            data_new2 = data_new;
        end

        % pca
        [coeff, pc, latent, tsquared, explained, mu] = pca(data_new2); 
        if depthtime == 1
            pcn = [data_new(:,1),pc];
            disp('>>    col#1: depth/time; col#2: PC1; col#3: PC2 ...')
        else
            pcn = pc;
            disp('>>    col#1: PC1; col#2: PC2; col#3: PC3 ...')
        end
        disp('>>  %=======%=======%=======%=======%============')
        % coeff: principal component coefficients
        % pc: principal component scores
        % latent: principal component variances
        % tsquared: Hotelling's T-squared statistic for each observation in X.
        % explained: the percentage of the total variance explained by each principal component 
        % mu, the estimated mean of each variable in X.
        [~,dat_name,~] = fileparts(char(contents(plot_selected(1))));% first file name
        ext = '.txt';
        if nplot == 1
            name1 = [dat_name,'-PCA',ext];
            name2 = [dat_name,'-PCA-coeff',ext];
            name3 = [dat_name,'-PCA-latent-explained-mu',ext];
            name4 = [dat_name,'-PCA-tsquared',ext];
        else
            name1 = [dat_name,'-w-others-PCA',ext];  % New name
            name2 = [dat_name,'-w-others-PCA-coeff',ext];
            name3 = [dat_name,'-w-others-PCA-latent-explained-mu',ext];
            name4 = [dat_name,'-w-others-PCA-tsquared',ext];
        end

        CDac_pwd; % cd ac_pwd dir
        dlmwrite(name1, pcn, 'delimiter', ' ', 'precision', 9);
        dlmwrite(name2, coeff, 'delimiter', ' ', 'precision', 9);
        dlmwrite(name3, [latent,explained,mu'], 'delimiter', ' ', 'precision', 9);
        dlmwrite(name4, [data_new(:,1),tsquared], 'delimiter', ' ', 'precision', 9);
        d = dir; %get files
        set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
        refreshcolor;
        cd(pre_dirML); % return to matlab view folder
        
        if handles.lang_choice 
            disp('>>  Principal component analysis: Done')
        else
            disp(a272)
        end

        disp('>>  %=======%=======%=======%=======%============')
        disp('>>Principal component analysis:')
        disp('>>  *-PCA-coeff.txt')
        disp('>>    principal component coefficients')
        disp('>>  *-PCA-latent-explained-mu.txt')
        disp('>>    col#1: PC variances; col#2: % of each PC; col#3: mean of each variable')
        disp('>>  *-tsquared.txt')
        disp('>>    Hotelling T-squared statistic for each observation')
        disp('>>  *-PCA.txt')
        disp('>>    principal component')
    end
end
guidata(hObject,handles)



% --------------------------------------------------------------------
function menu_smooth1_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menu_utilities_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menu_image_Callback(hObject, eventdata, handles)
% hObject    handle to menu_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_menu_utilities_Callback(hObject, eventdata, handles)
% hObject    handle to menu_utilities (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function menu_whiten_Callback(hObject, eventdata, handles)
% hObject    handle to menu_utilities (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                handles.dat_name = dat_name;
                guidata(hObject, handles);
                prewhitenGUI(handles);
            end
        end
end
guidata(hObject, handles);
% --------------------------------------------------------------------
function menu_sednoise_Callback(hObject, eventdata, handles)
% hObject    handle to menu_utilities (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_timeOpt_Callback(hObject, eventdata, handles)
% hObject    handle to menu_timeOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length

if nplot == 1
    
    %language
    lang_id = handles.lang_id;
    if handles.lang_choice > 0

        [~, locb1] = ismember('a274',lang_id);
        a274 = handles.lang_var{locb1};

        [~, locb1] = ismember('a275',lang_id);
        a275 = handles.lang_var{locb1};
        [~, locb1] = ismember('a276',lang_id);
        a276 = handles.lang_var{locb1};
    else
        a274 = '(e)TimeOpt may have advanced version in astrochron. ';
        a275 = 'Visit';
        a276 = ' for more infomation';
    end

    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                handles.dat_name = dat_name;
                guidata(hObject, handles);
                timeOptGUI(handles);
%                 if handles.lang_choice > 0
% 
%                     h=warndlg(['(e)TimeOpt may have advanced version in astrochron. ',...
%                     'Visit',' https://cran.r-project.org/package=astrochron',' for more infomation'],...
%                     '(e)TimeOpt');
%                 else
%                     
%                     h=warndlg([a274,a275,' https://cran.r-project.org/package=astrochron',a276],...
%                     '(e)TimeOpt');
%                 end
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_eTimeOpt_Callback(hObject, eventdata, handles)
% hObject    handle to menu_eTimeOpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    %language
    lang_id = handles.lang_id;
    if handles.lang_choice > 0

        [~, locb1] = ismember('a274',lang_id);
        a274 = handles.lang_var{locb1};

        [~, locb1] = ismember('a275',lang_id);
        a275 = handles.lang_var{locb1};
        [~, locb1] = ismember('a276',lang_id);
        a276 = handles.lang_var{locb1};
    else
        a274 = '(e)TimeOpt may have advanced version in astrochron. ';
        a275 = 'Visit';
        a276 = ' for more infomation';
    end

    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                handles.dat_name = dat_name;
                guidata(hObject, handles);
                eTimeOptGUI(handles);
%                 if handles.lang_choice
%                     h=warndlg(['(e)TimeOpt may have advanced version in astrochron. ',...
%                     'Visit',' https://cran.r-project.org/package=astrochron',' for more infomation'],...
%                     '(e)TimeOpt');
%                 else
%                     h=warndlg([a274,a275,' https://cran.r-project.org/package=astrochron',a276],...
%                     '(e)TimeOpt');
%                 end
            end
        end
end
guidata(hObject, handles);



% --------------------------------------------------------------------
function menu_smooth_Callback(hObject, eventdata, handles)
% hObject    handle to menu_smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    
    %language
    lang_id = handles.lang_id;
    if handles.lang_choice > 0

        [~, locb1] = ismember('main24',lang_id);
        main24 = handles.lang_var{locb1};
        [~, locb1] = ismember('menu103',lang_id);
        menu103 = handles.lang_var{locb1};

        [~, locb1] = ismember('a280',lang_id);
        a280 = handles.lang_var{locb1};
        [~, locb1] = ismember('a281',lang_id);
        a281 = handles.lang_var{locb1};
        [~, locb1] = ismember('a282',lang_id);
        a282 = handles.lang_var{locb1};
        [~, locb1] = ismember('a283',lang_id);
        a283 = handles.lang_var{locb1};
    end

    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0

            try
                fid = fopen(data_name);
                data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
                fclose(fid);
                if iscell(data_ft)
                    data = cell2mat(data_ft);
                end
            catch
                data = load(data_name);
            end 

            time = data(:,1);
            value = data(:,2);
            npts = length(time);
            if handles.lang_choice == 0
                dlg_title = 'Moving Mean';
                prompt = {'Window (number of data points, e.g., 3, 5, 7, ...):'};
            else
                dlg_title = menu103;
                prompt = {a280};
            end
            num_lines = 1;
            defaultans = {'3'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                smooth_v = str2double(answer{1});
                %data(:,2) = movemean(data(:,2),smooth_v,'omitnan');
                data(:,2) = movemean(data(:,2),smooth_v);
                if handles.lang_choice == 0
                    name1 = [dat_name,'_',num2str(smooth_v),'ptsm',ext];  % New name
                else
                    name1 = [dat_name,'_',num2str(smooth_v),a283,ext];  % New name
                end
                CDac_pwd
                dlmwrite(name1, data, 'delimiter', ' ', 'precision', 9); 
                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
                figure;
                plot(time,value,'k')
                hold on;
                plot(time,data(:,2),'r','LineWidth',2.5)
                title([dat_name,ext], 'Interpreter', 'none')
                xlabel(handles.unit)
                if handles.lang_choice == 0
                    ylabel('Value')
                    legend('Raw',[num2str(smooth_v),'points-smoothed'])
                else
                    ylabel(main24)
                    legend(a281,[num2str(smooth_v),a282])
                end
                hold off;
            end
        end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_movmedian_Callback(hObject, eventdata, handles)
% hObject    handle to menu_movmedian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    
    %language
    lang_id = handles.lang_id;
    if handles.lang_choice > 0

        [~, locb1] = ismember('main24',lang_id);
        main24 = handles.lang_var{locb1};
        [~, locb1] = ismember('main35',lang_id);
        main35 = handles.lang_var{locb1};
        [~, locb1] = ismember('menu105',lang_id);
        menu105 = handles.lang_var{locb1};

        [~, locb1] = ismember('a280',lang_id);
        a280 = handles.lang_var{locb1};
        [~, locb1] = ismember('a281',lang_id);
        a281 = handles.lang_var{locb1};
        [~, locb1] = ismember('a284',lang_id);
        a284 = handles.lang_var{locb1};
        [~, locb1] = ismember('a285',lang_id);
        a285 = handles.lang_var{locb1};
        [~, locb1] = ismember('a286',lang_id);
        a286 = handles.lang_var{locb1};
    end
    
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
        try
            fid = fopen(data_name);
            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
            fclose(fid);
            if iscell(data_ft)
                data = cell2mat(data_ft);
            end
        catch
            data = load(data_name);
        end 

            time = data(:,1);
            value = data(:,2);
            npts = length(time);
            if handles.lang_choice == 0
                dlg_title = 'Moving Median';
                prompt = {'Window (number of data points, e.g., 3, 5, 7, ...):'};
            else
                dlg_title = menu105;
                prompt = {a280};
            end
            num_lines = 1;
            defaultans = {'3'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                smooth_v = str2double(answer{1});
                % median-smoothing
                try data(:,2) = moveMedian(data(:,2),smooth_v);
                    if handles.lang_choice == 0
                        name1 = [dat_name,'_',num2str(smooth_v),'pts-median',ext];  % New name
                    else
                        name1 = [dat_name,'_',num2str(smooth_v),a284,ext];  % New name
                    end
                    CDac_pwd
                    dlmwrite(name1, data, 'delimiter', ' ', 'precision', 9); 
                    d = dir; %get files
                    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                    refreshcolor;
                    cd(pre_dirML); % return to matlab view folder
                    mvmedianfig = figure;
                    plot(time,value,'k')
                    hold on;
                    plot(time,data(:,2),'r','LineWidth',2.5)
                    title([dat_name,ext], 'Interpreter', 'none')
                    xlabel(handles.unit)
                    
                    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                        ylabel('Value')
                        legend('Raw',[num2str(smooth_v),'pts-median smoothed'])
                    else
                        ylabel(main24)
                        legend(a281,[num2str(smooth_v),a285])
                    end

                    hold off;
                catch
                    if handles.lang_choice == 0
                        msgbox('Data error, empty value?','Error')
                    else
                        msgbox(a286,main35)
                    end
                end
            end
        end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_movGauss_Callback(hObject, eventdata, handles)
% hObject    handle to menu_movGauss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    
    %language
    lang_id = handles.lang_id;
    if handles.lang_choice > 0

        [~, locb1] = ismember('main24',lang_id);
        main24 = handles.lang_var{locb1};
        [~, locb1] = ismember('main35',lang_id);
        main35 = handles.lang_var{locb1};
        [~, locb1] = ismember('a286',lang_id);
        a286 = handles.lang_var{locb1};

        [~, locb1] = ismember('a288',lang_id);
        a288 = handles.lang_var{locb1};
        [~, locb1] = ismember('a281',lang_id);
        a281 = handles.lang_var{locb1};
        [~, locb1] = ismember('a287',lang_id);
        a287 = handles.lang_var{locb1};
        [~, locb1] = ismember('a289',lang_id);
        a289 = handles.lang_var{locb1};
    end
    
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
        try
            fid = fopen(data_name);
            data_ft = textscan(fid,'%f%f','Delimiter',{';','*',',','\t','\b',' '},'EmptyValue', NaN);
            fclose(fid);
            if iscell(data_ft)
                data = cell2mat(data_ft);
            end
        catch
            data = load(data_name);
        end 

            time = data(:,1);
            value = data(:,2);
            npts = length(time);
            if handles.lang_choice == 0
                dlg_title = 'Gaussian-weighted moving average filter';
                prompt = {'Window (number of data points, 4, 11, etc.):'};
            else
                dlg_title = a287;
                prompt = {a288};
            end
            num_lines = 1;
            defaultans = {'4'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                window = round(str2double(answer{1}));
                % median-smoothing data numbers
                % median-smoothing
                try data(:,2) = smoothdata(data(:,2),'gaussian',window); 
                    name1 = [dat_name,'_',num2str(window),'pts-Gauss',ext];  % New name
                    CDac_pwd
                    dlmwrite(name1, data, 'delimiter', ' ', 'precision', 9); 
                    d = dir; %get files
                    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                    refreshcolor;
                    cd(pre_dirML); % return to matlab view folder
                    mvmedianfig = figure;
                    plot(time,value,'k')
                    hold on;
                    plot(time,data(:,2),'r','LineWidth',2.5)
                    title([dat_name,ext], 'Interpreter', 'none')
                    xlabel(handles.unit)
                    
                    if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
                        ylabel('Value')
                        legend('Raw',[num2str(window),' pts-Gauss smoothed'])
                    else
                        ylabel(main24)
                        legend(a281,[num2str(smooth_v),a289])
                    end
                    
                    hold off;
                catch
                    if handles.lang_choice == 0
                        msgbox('Data error, empty value?','Error')
                    else
                        msgbox(a286,main35)
                    end
                end
            end
        end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_examples_Callback(hObject, eventdata, handles)
% hObject    handle to menu_examples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_example_PETM_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_PETM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-SvalbardPETM-logFe.txt');

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a292',lang_id);
    a292 = handles.lang_var{locb1};
end
[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);
time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Depth (m)')
else
    xlabel(a292)
end
ylabel('Log(Fe)')
CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder


% --------------------------------------------------------------------
function menu_example_GD2GR_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_GD2GR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-Guandao2AnisianGR.txt');
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a292',lang_id);
    a292 = handles.lang_var{locb1};
    [~, locb1] = ismember('a293',lang_id);
    a293 = handles.lang_var{locb1};
end
[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);

time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Depth (m)')
    ylabel('Gamma ray (cpm)')
else
    xlabel(a292)
    ylabel(a293)
end
    
CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder


% --------------------------------------------------------------------
function menu_extinction_CSA_Callback(hObject, eventdata, handles)
% hObject    handle to menu_extinction_CSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-CSA-extinction.txt');
data = load(data_name);

figure;
scatter(data,data,200,[0 0.4470 0.7410],'filled','MarkerFaceAlpha',0.5);
xlim([0 300])
ylim([0 300])
xlabel('Ma')
ylabel('Ma')
%axis equal

CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder

% --------------------------------------------------------------------
function menu_example_inso2Ma_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_inso2Ma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-Insol-t-0-2000ka-day-80-lat-65-meandaily-La04.txt');
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a290',lang_id);
    a290 = handles.lang_var{locb1};
    [~, locb1] = ismember('a294',lang_id);
    a294 = handles.lang_var{locb1};
end
[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);

time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Time (kyr)')
    ylabel('Insolation (W/m^{2})')
else
    xlabel(a290)
    ylabel(a294)
end
    
CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder


% --------------------------------------------------------------------
function menu_example_la04etp_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_la04etp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-La2004-1E.5T-1P-0-2000.txt');
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a291',lang_id);
    a291 = handles.lang_var{locb1};
    [~, locb1] = ismember('a295',lang_id);
    a295 = handles.lang_var{locb1};
end

[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);
time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Age (ka)')
    ylabel('ETP')
else
    xlabel(a291)
    ylabel(a295)
end
    
CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder

% --------------------------------------------------------------------
function menu_example_redp7_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_redp7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-Rednoise0.7-2000.txt');
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a296',lang_id);
    a296 = handles.lang_var{locb1};
    [~, locb1] = ismember('main24',lang_id);
    main24 = handles.lang_var{locb1};
end
[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);

time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Number (#)')
    ylabel('Value')
else
    xlabel(a296)
    ylabel(main24)
end
    
CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder

% --------------------------------------------------------------------
function menu_example_wayao_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_wayao (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-WayaoCarnianGR0.txt');
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a292',lang_id);
    a292 = handles.lang_var{locb1};
    [~, locb1] = ismember('a293',lang_id);
    a293 = handles.lang_var{locb1};
end
[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);

time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Depth (m)')
    ylabel('Gamma ray (cpm)')
else
    xlabel(a292)
    ylabel(a293)
end
    
CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder


% --------------------------------------------------------------------
function menu_example_Newark_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_Newark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-LateTriassicNewarkDepthRank.txt');

[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);
%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a292',lang_id);
    a292 = handles.lang_var{locb1};
    [~, locb1] = ismember('a297',lang_id);
    a297 = handles.lang_var{locb1};
end
time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Depth (m)')
    ylabel('Depth Rank')
else
    xlabel(a292)
    ylabel(a297)
end
    
CDac_pwd
copyfile(data_name,pwd);
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder


% --------------------------------------------------------------------
function menu_example_marsimage_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_marsimage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-HiRISE-PSP_002733_1880_RED.jpg');
[loc,dat_name,ext] = fileparts(data_name);
if sum(strcmp(ext,{'.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.TIF'})) > 0
    im_name = imread(data_name);
    figure;
    imshow(im_name)
    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
end

CDac_pwd
copyfile(data_name,pwd)
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder

% --------------------------------------------------------------------
function menu_example_hawaiiCO2_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_hawaiiCO2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-LaunaLoa-Hawaii-CO2-monthly-mean.txt');

%language
lang_id = handles.lang_id;
if handles.lang_choice > 0
    [~, locb1] = ismember('a298',lang_id);
    a298 = handles.lang_var{locb1};
    [~, locb1] = ismember('a299',lang_id);
    a299 = handles.lang_var{locb1};
    [~, locb1] = ismember('main01',lang_id);
    main01 = handles.lang_var{locb1};
end
% url = 'https://www.esrl.noaa.gov/gmd/ccgg/trends/data.html'
% Dr. Pieter Tans, NOAA/ESRL (www.esrl.noaa.gov/gmd/ccgg/trends/) and 
% Dr. Ralph Keeling, Scripps Institution of Oceanography (scrippsco2.ucsd.edu/).

[~,dat_name,ext] = fileparts(data_name);
data = load(data_name);

time = data(:,1);
value = data(:,2);
figure;
plot(time,value)
title([dat_name,ext], 'Interpreter', 'none')
    
if or (handles.lang_choice == 0, get(handles.main_unit_en,'Value') == 0)
    xlabel('Year')
    ylabel('pCO_2 (ppm)')
else
    xlabel(a298)
    ylabel(a299)
end
    
CDac_pwd
copyfile(data_name,pwd);
if handles.lang_choice == 0 
    disp(['>> Data saved: ',[dat_name,ext]])
else
    disp([main01,': ',[dat_name,ext]])
end
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder


% --------------------------------------------------------------------
function menu_digitizer_Callback(hObject, eventdata, handles)
% hObject    handle to menu_digitizer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1

    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
            
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,{'.bmp','.BMP','.gif','.GIF','.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.tiff','.TIF','.TIFF'})) > 0
                try
                    handles.figname = data_name;
                    guidata(hObject, handles);
                    DataExtractML(handles);
                catch
                    if handles.lang_choice == 0
                        warndlg('Image color space not supported. Convert to RGB or Grayscale')
                    else
                        % language
                        lang_var = handles.lang_var;
                        [~, locb1] = ismember('dd24',handles.lang_id);
                        dd24 = lang_var{locb1};
                        warndlg(dd24)
                    end

                end
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_example_plotdigitizer_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_plotdigitizer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-PlotDigitizer.jpg');
[loc,dat_name,ext] = fileparts(data_name);
if sum(strcmp(ext,{'.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.TIF'})) > 0
    im_name = imread(data_name);
    figure;
    imshow(im_name)
    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
end

CDac_pwd
copyfile(data_name,pwd)
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder



% --------------------------------------------------------------------
function menu_example_sphalerite_Callback(hObject, eventdata, handles)
% hObject    handle to menu_example_sphalerite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_name = which('Example-Sphalerite.jpg');
[loc,dat_name,ext] = fileparts(data_name);
if sum(strcmp(ext,{'.jpg','.jpeg','.JPG','.JPEG','.png','.PNG','.tif','.TIF'})) > 0
    im_name = imread(data_name);
    figure;
    imshow(im_name)
    set(gcf,'Name',[dat_name,ext],'NumberTitle','off')
end

CDac_pwd
copyfile(data_name,pwd)
d = dir; %get files
set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
refreshcolor;
cd(pre_dirML); % return to matlab view folder

% --------------------------------------------------------------------
function linegenerator_Callback(hObject, eventdata, handles)
% hObject    handle to linegenerator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
    if isdir(data_name) == 1
        handles.current_data = [];
        guidata(hObject, handles);
        linegenerator(handles);
    else
        [~,~,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0

            current_data = load(data_name);
            handles.current_data = current_data;
            handles.data_name = data_name;
            guidata(hObject, handles);

            linegenerator(handles);
        end
    end        
else
    handles.current_data = [];
    guidata(hObject, handles);
    linegenerator(handles);
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_specmoments_Callback(hObject, eventdata, handles)
% hObject    handle to menu_specmoments (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%#function bsxfun
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,dat_name,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                handles.dat_name = dat_name;
                guidata(hObject, handles);
                SpectralMomentsGUI(handles);
            end
        end
end
guidata(hObject, handles);



% --------------------------------------------------------------------
function menu_interpseries_Callback(hObject, eventdata, handles)
% hObject    handle to menu_interpseries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
InterplationSeries(handles)


% --------------------------------------------------------------------
function menu_LOD_Callback(hObject, eventdata, handles)
% hObject    handle to menu_LOD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LODGUI(handles)


% --------------------------------------------------------------------
function menu_coh_Callback(hObject, eventdata, handles)
% hObject    handle to menu_coh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
coherenceGUI(handles)


% --------------------------------------------------------------------
function menu_dynfilter_Callback(hObject, eventdata, handles)
% hObject    handle to menu_dynfilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; 
    filename = fullfile(ac_pwd,data_name);
        if isdir(filename) == 1
        else
            [~,~,ext] = fileparts(filename);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(filename);
                handles.current_data = current_data;
                handles.filename = filename;
                handles.data_name = data_name;
                handles.ext = ext;
                guidata(hObject, handles);
                DynamicFilter(handles);
            end
        end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_leadlag_Callback(hObject, eventdata, handles)
% hObject    handle to menu_leadlag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
leadlagGUI(handles)


% --------------------------------------------------------------------
function menu_correlation_Callback(hObject, eventdata, handles)
% hObject    handle to menu_correlation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CorrelationGUI(handles)


% --------------------------------------------------------------------
function menu_CSA_Callback(hObject, eventdata, handles)
% hObject    handle to menu_CSA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                guidata(hObject, handles);
                circularspecGUI(handles);
            end
        end
end
guidata(hObject, handles);


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
str1 = get(handles.popupmenu2,'string');
val1 = get(handles.popupmenu2,'value');
handles.val1 = val1;
handles.sortdata = str1{val1};
CDac_pwd; % cd working dir
refreshcolor;
cd(pre_dirML);
guidata(hObject, handles);

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



% --------------------------------------------------------------------
function menu_waveletGUI_Callback(hObject, eventdata, handles)
% hObject    handle to menu_waveletGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot <= 2
    data_name = char(contents(plot_selected));
    if nplot == 1
        data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
        GETac_pwd; 
        data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                guidata(hObject, handles);
                waveletGUI(handles);
            end
        end
    else
        data_name1 = data_name(1,:);
        data_name1 = strrep2(data_name1, '<HTML><FONT color="blue">', '</FONT></HTML>');
        GETac_pwd; 
        data_name1 = fullfile(ac_pwd,data_name1);
        
        data_name2 = data_name(2,:);
        data_name2 = strrep2(data_name2, '<HTML><FONT color="blue">', '</FONT></HTML>');
        GETac_pwd; 
        data_name2 = fullfile(ac_pwd,data_name2);
        data_name = [data_name1;data_name2];
        if or(isdir(data_name1) == 1,  isdir(data_name1) == 1)
        else
            %[~,~,ext] = fileparts(data_name1);
            %if sum(strcmp(ext,handles.filetype)) > 0
                disp('debug')
                handles.data_name = data_name;
                guidata(hObject, handles);
                waveletGUI(handles);
            %end
        end
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_interpolationGUI_Callback(hObject, eventdata, handles)
% hObject    handle to menu_interpolationGUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot <= 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; 
    data_name = fullfile(ac_pwd,data_name);
    if isdir(data_name) == 1
    else
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0
            current_data = load(data_name);
            handles.current_data = current_data;
            handles.data_name = data_name;
            handles.dat_name = dat_name;
            handles.ext = ext;
            guidata(hObject, handles);
            interpolationGUI(handles);
        end
    end
end
guidata(hObject, handles);


% --------------------------------------------------------------------
function menu_sound_Callback(hObject, eventdata, handles)
% hObject    handle to menu_sound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
    if isdir(data_name) == 1
    else
        
        lang_id = handles.lang_id;
        lang_var = handles.lang_var;
        [~, sound01] = ismember('sound01',lang_id);
        [~, sound02] = ismember('sound02',lang_id);
        [~, sound03] = ismember('sound03',lang_id);
        [~, sound04] = ismember('sound04',lang_id);
        
        [~,dat_name,ext] = fileparts(data_name);
        if sum(strcmp(ext,handles.filetype)) > 0

            data = load(data_name);

            prompt = {lang_var{sound02},...
                lang_var{sound03},...
                lang_var{sound04}};
            dlg_title = lang_var{sound01};
            num_lines = 1;
            defaultans = {'5','1','1'};
            options.Resize='on';
            answer = inputdlg(prompt,dlg_title,num_lines,defaultans,options);
            if ~isempty(answer)
                a = str2double(answer{1});
                b = str2double(answer{2});
                c = str2double(answer{3});
                if c == 1
                    y = repmat( data(:,2)-mean(data(:,2)), [a,1]);
                else
                    y = repmat( data(:,2), [a,1]);
                end
                sound(y, b * 8192)
                
                name1 = [dat_name,'_rep-',num2str(a),'-rate-',num2str(b*8192),'.wav'];  % New name
                CDac_pwd
                audiowrite(name1,y,b*8192)
                d = dir; %get files
                set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
                refreshcolor;
                cd(pre_dirML); % return to matlab view folder
            end
        end
    end
end
guidata(hObject, handles);

%<<<<<<< HEAD
% --------------------------------------------------------------------
function menu_lang_Callback(hObject, eventdata, handles)
% hObject    handle to menu_lang (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);
languageGUI(handles)


% --------------------------------------------------------------------
function menu_recplot_Callback(hObject, eventdata, handles)
% hObject    handle to menu_recplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.listbox_acmain,'String')); % read contents of listbox 1 
plot_selected = get(handles.listbox_acmain,'Value');
nplot = length(plot_selected);   % length
if nplot == 1
    data_name = char(contents(plot_selected));
    data_name = strrep2(data_name, '<HTML><FONT color="blue">', '</FONT></HTML>');
    GETac_pwd; data_name = fullfile(ac_pwd,data_name);
        if isdir(data_name) == 1
        else
            [~,~,ext] = fileparts(data_name);
            if sum(strcmp(ext,handles.filetype)) > 0
                current_data = load(data_name);
                handles.current_data = current_data;
                handles.data_name = data_name;
                guidata(hObject, handles);
                RecPlotGUI(handles);
            end
        end
end
guidata(hObject, handles);



% --- Executes on button press in main_unit_en.
function main_unit_en_Callback(hObject, eventdata, handles)
% hObject    handle to main_unit_en (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of main_unit_en

if get(hObject,'Value') > 0
    % listbox 1
    lang_id = handles.lang_id;
    lang_var = handles.lang_var;
    for ii = 1:22
        [~, locb] = ismember(['MainUnit',num2str(ii)],lang_id);
        sortorder{ii} = lang_var{locb};
    end
    set(handles.popupmenu1,'String',sortorder)
else
    set(handles.popupmenu1,'String',handles.popupmenu1_default)
end
handles.main_unit_selection = get(handles.main_unit_en,'Value');
guidata(hObject, handles);
