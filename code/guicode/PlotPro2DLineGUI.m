
function PlotPro2DLineGUI(varargin)
% Plot Pro GUI for 2D line plot
% Mingsong Li
% Peking Univeristy
% msli@pku.edu.cn
% Dec 16, 2022 - Jan. 4, 2023

%%
%% read data and unit type
%MonZoom = varargin{1}.MonZoom;
MonZoom = 1;
%% language
lang_choice = varargin{1}.lang_choice;
handles.lang_choice = lang_choice;
lang_id = varargin{1}.lang_id;
lang_var = varargin{1}.lang_var;
handles.lang_id = lang_id;
handles.lang_var = lang_var;
handles.main_unit_selection = varargin{1}.main_unit_selection;

[~, plt20] = ismember('plt20',lang_id);
[~, plt21] = ismember('plt21',lang_id);
[~, plt22] = ismember('plt22',lang_id);
[~, plt23] = ismember('plt23',lang_id);
[~, plt24] = ismember('plt24',lang_id);
[~, plt25] = ismember('plt25',lang_id);
[~, plt26] = ismember('plt26',lang_id);
[~, plt27] = ismember('plt27',lang_id);
[~, plt28] = ismember('plt28',lang_id);
[~, plt29] = ismember('plt29',lang_id);
[~, plt30] = ismember('plt30',lang_id);
[~, plt31] = ismember('plt31',lang_id);
[~, plt32] = ismember('plt32',lang_id);
[~, plt33] = ismember('plt33',lang_id);
[~, plt34] = ismember('plt34',lang_id);
[~, plt35] = ismember('plt35',lang_id);
[~, plt36] = ismember('plt36',lang_id);
[~, plt37] = ismember('plt37',lang_id);
[~, plt38] = ismember('plt38',lang_id);
[~, plt39] = ismember('plt39',lang_id);
[~, plt40] = ismember('plt40',lang_id);
[~, plt41] = ismember('plt41',lang_id);
[~, plt42] = ismember('plt42',lang_id);
[~, plt43] = ismember('plt43',lang_id);
[~, plt44] = ismember('plt44',lang_id);
[~, plt45] = ismember('plt45',lang_id);
[~, plt46] = ismember('plt46',lang_id);
[~, plt49] = ismember('plt49',lang_id);

handles.selectcolortext = lang_var{plt49};
handles.selecttext =  lang_var{plt34};

[~, plt50] = ismember('plt50',lang_id);
handles.warnplt50 =  lang_var{plt50};
[~, plt51] = ismember('plt51',lang_id);
handles.warnplt51 =  lang_var{plt51};
[~, plt52] = ismember('plt52',lang_id);
handles.warnplt52 =  lang_var{plt52};
handles.alphatext =  lang_var{plt45}; % alpha text
handles.edgetext =  lang_var{plt39}; % edge text
%% GUI settings

[~, menu41] = ismember('menu41',lang_id);
h_PlotPro2DLineGUI = figure('MenuBar','none','Name',['Acycle: ',lang_var{menu41}],'NumberTitle','off');

handles.h_PlotPro2DLineGUI = h_PlotPro2DLineGUI;
set(h_PlotPro2DLineGUI,'units','norm') % set location
set(0,'Units','normalized') % set units as normalized
set(h_PlotPro2DLineGUI,'position',[0.02,0.2,0.6,0.7] * MonZoom,'Color','white') % set position
% color map

handles.c_map0 = [0 0.4470 0.7410
            0.8500 0.3250 0.0980
            0.9290 0.6940 0.1250
            0.4940 0.1840 0.5560
            0.4660 0.6740 0.1880
            0.3010 0.7450 0.9330
            0.6350 0.0780 0.1840
            0.5700 0.6900 0.3000
            0.89 0.88 0.57
            0.76 0.49 0.58
            0.47 0.76 0.81
            0.21 0.21 0.35
            0.28 0.57 0.54
            0.07 0.35 0.40
            0.41 0.20 0.42
            0.60 0.24 0.18
            0.76 0.84 0.65
            0.77 0.18 0.78
            0.21 0.33 0.64
            0.88 0.17 0.56
            0.20 0.69 0.28
            0.26 0.15 0.47
            0.83 0.27 0.44
            0.87 0.85 0.42
            0.85 0.51 0.87
            0.99 0.62 0.76
            0.52 0.43 0.87
            0.00 0.68 0.92
            0.26 0.45 0.77
            0.98 0.75 0.00
            0.72 0.81 0.76
            0.77 0.18 0.78
            0.28 0.39 0.44
            0.22 0.26 0.24
            0.64 0.52 0.64
            0.87 0.73 0.78
            0.94 0.89 0.85
            0.85 0.84 0.86];
handles.c_map1 = [0.57, 0.69, 0.30
         0.89, 0.88, 0.57
         0.76, 0.49, 0.58
         0.47, 0.76, 0.81
         0.21, 0.21, 0.35
         0.28, 0.57, 0.54
         0.07, 0.35, 0.40
         0.41, 0.20, 0.42
         0.60, 0.24, 0.18
         0.76, 0.84, 0.65];
handles.c_map2 = [0.77, 0.18, 0.78
          0.21, 0.33, 0.64
          0.88, 0.17, 0.56
          0.20, 0.69, 0.28
          0.26, 0.15, 0.47
          0.83, 0.27, 0.44
          0.87, 0.85, 0.42
          0.85, 0.51, 0.87
          0.99, 0.62, 0.76
          0.52, 0.43, 0.87
          0.00, 0.68, 0.92
          0.26, 0.45, 0.77
          0.98, 0.75, 0.00    
          0.72, 0.81, 0.76
          0.77, 0.18, 0.78
          0.28, 0.39, 0.44
          0.22, 0.26, 0.24
          0.64, 0.52, 0.64
          0.87, 0.73, 0.78
          0.94, 0.89, 0.85
          0.85, 0.84, 0.86];
textcolor = [140 0 0]/255; % Peking University logo color (Beida Red)
%% data panel
% All panel
[~, plt01] = ismember('plt01',lang_id);
handles.panel_datapanel = uipanel(h_PlotPro2DLineGUI,'Title',lang_var{plt01},'FontSize',12,...
    'Position',[0.05 0.85 0.9 0.12],'BackgroundColor','white','FontWeight','bold');
[~, plt02] = ismember('plt02',lang_id);
handles.panel_datapanel_full_text = uicontrol('Parent',handles.panel_datapanel,'Style','text','String',lang_var{plt02},...
    'units','norm','Position',[0.02 0.55 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
% all panel
tooltip = 'Format: row,col';
handles.panel_datapanel_full_input = uicontrol('Parent',handles.panel_datapanel,'Style','edit','String','1,1',...
    'units','norm','Position',[0.12 0.6 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'Callback',@callbk_panel_datapanel_full_input,...
    'tooltip',tooltip,'BackgroundColor','white');
% set panel
[~, plt03] = ismember('plt03',lang_id);
handles.panel_datapanel_set_text = uicontrol('Parent',handles.panel_datapanel,'Style','text','String',lang_var{plt03},...
    'units','norm','Position',[0.25 0.55 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_datapanel_set_input = uicontrol('Parent',handles.panel_datapanel,'Style','pop','String','1',...
    'units','norm','Position',[0.35 0.55 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'Callback',@callbk_panel_datapanel_set_input,'BackgroundColor','white');
% Data file
[~, plt04] = ismember('plt04',lang_id);
handles.panel_datapanel_data_text = uicontrol('Parent',handles.panel_datapanel,'Style','text','String',lang_var{plt04},...
    'units','norm','Position',[0.46 0.55 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');

handles.panel_datapanel_data_input = uicontrol('Parent',handles.panel_datapanel,'Style','pop','String','',...
    'units','norm','Position',[0.56 0.55 0.4 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'Callback',@callbk_panel_datapanel_data_input,'BackgroundColor','white');

% set x axis
[~, dd14] = ismember('dd14',lang_id);
handles.panel_datapanel_x_text = uicontrol('Parent',handles.panel_datapanel,'Style','text','String',lang_var{dd14},...
    'units','norm','Position',[0.02 0.12 0.1 0.3],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_datapanel_x_input = uicontrol('Parent',handles.panel_datapanel,'Style','edit','String','1',...
    'units','norm','Position',[0.12 0.2 0.1 0.3],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_datapanel_x_input,'BackgroundColor','white');

% set y axis
[~, dd15] = ismember('dd15',lang_id);
handles.panel_datapanel_y_text = uicontrol('Parent',handles.panel_datapanel,'Style','text','String',lang_var{dd15},...
    'units','norm','Position',[0.25 0.12 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_datapanel_y_input = uicontrol('Parent',handles.panel_datapanel,'Style','edit','String','2',...
    'units','norm','Position',[0.35 0.2 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'Callback',@callbk_panel_datapanel_y_input,'BackgroundColor','white');

% set y axis data id LIST
[~, plt05] = ismember('plt05',lang_id);
handles.panel_datapanel_y_i_text = uicontrol('Parent',handles.panel_datapanel,'Style','text','String',lang_var{plt05},...
    'units','norm','Position',[0.46 0.12 0.1 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_datapanel_y_i_input = uicontrol('Parent',handles.panel_datapanel,'Style','pop','String',' ',...
    'units','norm','Position',[0.56 0.12 0.4 0.3],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'Callback',@callbk_panel_datapanel_y_i_input,'BackgroundColor','white');

%% Error plot 
%set x error negative
handles.panel_datapanel_xneg_chk = uicontrol('Parent',handles.panel_datapanel,'Style','checkbox','String',['-',lang_var{plt46}],...
    'units','norm','Position',[0.12 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_xneg_chk,'BackgroundColor','white');
function callbk_panel_datapanel_xneg_chk(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
handles.panel_datapanel_xneg_input = uicontrol('Parent',handles.panel_datapanel,'Style','edit','String','',...
    'units','norm','Position',[0.17 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_xneg_input,'BackgroundColor','white');
function callbk_panel_datapanel_xneg_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
% set x error positive
handles.panel_datapanel_xpos_chk = uicontrol('Parent',handles.panel_datapanel,'Style','checkbox','String',['+',lang_var{plt46}],...
    'units','norm','Position',[0.22 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_xpos_chk,'BackgroundColor','white');
function callbk_panel_datapanel_xpos_chk(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
handles.panel_datapanel_xpos_input = uicontrol('Parent',handles.panel_datapanel,'Style','edit','String','',...
    'units','norm','Position',[0.27 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_xpos_input,'BackgroundColor','white');
function callbk_panel_datapanel_xpos_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

% set y error negative
handles.panel_datapanel_yneg_chk = uicontrol('Parent',handles.panel_datapanel,'Style','checkbox','String',['-',lang_var{plt46}],...
    'units','norm','Position',[0.42 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_yneg_chk,'BackgroundColor','white');
function callbk_panel_datapanel_yneg_chk(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
handles.panel_datapanel_yneg_input = uicontrol('Parent',handles.panel_datapanel,'Style','edit','String','',...
    'units','norm','Position',[0.47 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_yneg_input,'BackgroundColor','white');
function callbk_panel_datapanel_yneg_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

% set y error positive
handles.panel_datapanel_ypos_chk = uicontrol('Parent',handles.panel_datapanel,'Style','checkbox','String',['+',lang_var{plt46}],...
    'units','norm','Position',[0.52 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_ypos_chk,'BackgroundColor','white');
function callbk_panel_datapanel_ypos_chk(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
handles.panel_datapanel_ypos_input = uicontrol('Parent',handles.panel_datapanel,'Style','edit','String','',...
    'units','norm','Position',[0.57 0.2 0.05 0.3],'Value',0,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_datapanel_ypos_input,'BackgroundColor','white');
function callbk_panel_datapanel_ypos_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

%% title
[~, plt06] = ismember('plt06',lang_id);
handles.panel_font = uipanel(h_PlotPro2DLineGUI,'Title',lang_var{plt06},'FontSize',12,...
    'Position',[0.05 0.5 0.6 0.32],'BackgroundColor','white','FontWeight','bold');
% title
[~, plt07] = ismember('plt07',lang_id);
handles.panel_font_title_text = uicontrol('Parent',handles.panel_font,'Style','text','String',lang_var{plt07},...
    'units','norm','Position',[0.02 0.72 0.1 0.12],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_font_title_input = uicontrol('Parent',handles.panel_font,'Style','edit','String','',...
    'units','norm','Position',[0.12 0.75 0.3 0.12],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_font_title_input,'BackgroundColor','white');
% legend
[~, plt08] = ismember('plt08',lang_id);
handles.panel_font_legend_input = uicontrol('Parent',handles.panel_font,'Style','checkbox','String',lang_var{plt08},...
    'units','norm','Position',[0.02 0.54 0.1 0.12],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_font_legend_input,'BackgroundColor','white');
handles.panel_font_legend_text = uicontrol('Parent',handles.panel_font,'Style','edit','String',' ',...
    'units','norm','Position',[0.12 0.55 0.3 0.12],'Enable','off',...
    'FontSize',11,'Callback',@callbk_panel_font_legend_text,'BackgroundColor','white');
function callbk_panel_font_legend_text(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
% legend box
[~, plt09] = ismember('plt09',lang_id);
handles.panel_font_legendbox_input = uicontrol('Parent',handles.panel_font,'Style','checkbox','String',lang_var{plt09},...
    'units','norm','Position',[0.51 0.54 0.2 0.12],'Value',0,'Enable','off',...
    'FontSize',11,'Callback',@callbk_panel_font_legendbox_input,'BackgroundColor','white');
function callbk_panel_font_legendbox_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
% Font name
[~, plt10] = ismember('plt10',lang_id);
handles.panel_font_fontname_text = uicontrol('Parent',handles.panel_font,'Style','text','String',lang_var{plt10},...
    'units','norm','Position',[0.02 0.3 0.1 0.12],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
fontNameList = listfonts;
handles.panel_font_fontname_input = uicontrol('Parent',handles.panel_font,'Style','pop','String',fontNameList,...
    'units','norm','Position',[0.12 0.3 0.3 0.12],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_font_fontname_input,'BackgroundColor','white');
function callbk_panel_font_fontname_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% Font size
[~, plt11] = ismember('plt11',lang_id);
handles.panel_font_fontsize_text = uicontrol('Parent',handles.panel_font,'Style','text','String',lang_var{plt11},...
    'units','norm','Position',[0.5 0.3 0.1 0.12],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_font_fontsize_input = uicontrol('Parent',handles.panel_font,'Style','edit','String','12',...
    'units','norm','Position',[0.62 0.3 0.3 0.12],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_font_fontsize_input,'BackgroundColor','white');
function callbk_panel_font_fontsize_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% Font weight
[~, plt12] = ismember('plt12',lang_id);
handles.bg = uibuttongroup('Parent',handles.panel_font,'Position',[0.02 0.05 0.45 0.2],...
    'Title',lang_var{plt12},'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
[~, plt13] = ismember('plt13',lang_id);
[~, plt14] = ismember('plt14',lang_id);
[~, plt15] = ismember('plt15',lang_id);
[~, plt16] = ismember('plt16',lang_id);
handles.panel_font_fontwt_input1 = uicontrol('Parent',handles.bg,'Style','radiobutton','String',lang_var{plt14},...
    'units','norm','Position',[0.3 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_font_fontwt_input1,'BackgroundColor','white');
function callbk_panel_font_fontwt_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
handles.panel_font_fontwt_input2 = uicontrol('Parent',handles.bg,'Style','radiobutton','String',lang_var{plt15},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_font_fontwt_input2,'BackgroundColor','white');
function callbk_panel_font_fontwt_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% Font angle
handles.bg2 = uibuttongroup('Parent',handles.panel_font,'Position',[0.5 0.05 0.45 0.2],...
    'Title',lang_var{plt13},'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_font_fontangle_input1 = uicontrol('Parent',handles.bg2,'Style','radiobutton','String',lang_var{plt14},...
    'units','norm','Position',[0.3 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_font_fontangle_input1,'BackgroundColor','white');
function callbk_panel_font_fontangle_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

handles.panel_font_fontangle_input2 = uicontrol('Parent',handles.bg2,'Style','radiobutton','String',lang_var{plt16},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_font_fontangle_input2,'BackgroundColor','white');
function callbk_panel_font_fontangle_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

%% x&y label/axis
[~, plt17] = ismember('plt17',lang_id);
handles.panel_xyaxis = uipanel(h_PlotPro2DLineGUI,'Title',lang_var{plt17},'FontSize',12,...
    'Position',[0.05 0.05 0.6 0.42],'BackgroundColor','white','FontWeight','bold');
% x label
[~, plt18] = ismember('plt18',lang_id);
[~, main21] = ismember('main21',lang_id); % time
[~, main23] = ismember('main23',lang_id); % depth
[~, main24] = ismember('main24',lang_id); % value
[~, main34] = ismember('main34',lang_id); % unit
handles.panel_xyaxis_xlabel_text = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String',['X ',lang_var{plt18}],...
    'units','norm','Position',[0.02 0.8 0.1 0.1],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');

handles.panel_xyaxis_xlabel_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String',[lang_var{main23},' (',lang_var{main34},')'],...
    'units','norm','Position',[0.12 0.825 0.3 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xlabel_input,'BackgroundColor','white');
function callbk_panel_xyaxis_xlabel_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
% y label
handles.panel_xyaxis_ylabel_text = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String',['Y ',lang_var{plt18}],...
    'units','norm','Position',[0.5 0.8 0.1 0.1],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');

handles.panel_xyaxis_ylabel_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String',[lang_var{main24},' (',lang_var{main34},')'],...
    'units','norm','Position',[0.62 0.825 0.3 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_ylabel_input,'BackgroundColor','white');
function callbk_panel_xyaxis_ylabel_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% x lim
[~, plt19] = ismember('plt19',lang_id);  % limit
handles.panel_xyaxis_xlim_text = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String',['X ',lang_var{plt19}],...
    'units','norm','Position',[0.02 0.65 0.1 0.1],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_xyaxis_xlim_low_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String','',...
    'units','norm','Position',[0.12 0.675 0.13 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xlim_low_input,'BackgroundColor','white');
function callbk_panel_xyaxis_xlim_low_input(source,eventdata)
    UpdatePlotPro2DLineTableXYLim
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_xlim_text2 = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String','-',...
    'units','norm','Position',[0.25 0.65 0.04 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_xyaxis_xlim_high_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String','',...
    'units','norm','Position',[0.29 0.675 0.13 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xlim_high_input,'BackgroundColor','white');
function callbk_panel_xyaxis_xlim_high_input(source,eventdata)
    UpdatePlotPro2DLineTableXYLim
    UpdatePlotPro2DLinePlot
end
% y lim
handles.panel_xyaxis_ylim_text = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String',['Y ',lang_var{plt19}],...
    'units','norm','Position',[0.5 0.65 0.1 0.1],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_xyaxis_ylim_low_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String','',...
    'units','norm','Position',[0.62 0.675 0.13 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_ylim_low_input,'BackgroundColor','white');
function callbk_panel_xyaxis_ylim_low_input(source,eventdata)
    UpdatePlotPro2DLineTableXYLim
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_ylim_low_text2 = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String','-',...
    'units','norm','Position',[0.75 0.65 0.04 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_xyaxis_ylim_high_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String','',...
    'units','norm','Position',[0.79 0.675 0.13 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_ylim_high_input,'BackgroundColor','white');
function callbk_panel_xyaxis_ylim_high_input(source,eventdata)
    UpdatePlotPro2DLineTableXYLim
    UpdatePlotPro2DLinePlot
end
% x tick label
handles.panel_xyaxis_xticklabel_text = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String',['X ',lang_var{plt20}],...
    'units','norm','Position',[0.02 0.5 0.1 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_xyaxis_xticklabel_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String','',...
    'units','norm','Position',[0.12 0.525 0.3 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white','Enable','Off');
% y tick label
handles.panel_xyaxis_yticklabel_text = uicontrol('Parent',handles.panel_xyaxis,'Style','text','String',['Y ',lang_var{plt20}],...
    'units','norm','Position',[0.5 0.5 0.1 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_xyaxis_yticklabel_input = uicontrol('Parent',handles.panel_xyaxis,'Style','edit','String','',...
    'units','norm','Position',[0.62 0.525 0.3 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white','Enable','Off');

% x minor tick

handles.bg7 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.02 0.35 0.22 0.15],...
    'Title',['X ',lang_var{plt21}],'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_xminortick_input1 = uicontrol('Parent',handles.bg7,'Style','radiobutton','String',lang_var{plt22},...
    'units','norm','Position',[0.1 0.05 0.4 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xminortick_input1,'BackgroundColor','white');
function callbk_panel_xyaxis_xminortick_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_xminortick_input2 = uicontrol('Parent',handles.bg7,'Style','radiobutton','String',lang_var{plt23},...
    'units','norm','Position',[0.5 0.05 0.4 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xminortick_input2,'BackgroundColor','white');
function callbk_panel_xyaxis_xminortick_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% y minor tick
handles.bg8 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.25 0.35 0.22 0.15],...
    'Title',['Y ',lang_var{plt21}],'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_yminortick_input1 = uicontrol('Parent',handles.bg8,'Style','radiobutton','String',lang_var{plt22},...
    'units','norm','Position',[0.1 0.05 0.4 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_yminortick_input1,'BackgroundColor','white');
function callbk_panel_xyaxis_yminortick_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

handles.panel_xyaxis_yminortick_input2 = uicontrol('Parent',handles.bg8,'Style','radiobutton','String',lang_var{plt23},...
    'units','norm','Position',[0.5 0.05 0.4 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_yminortick_input2,'BackgroundColor','white');
function callbk_panel_xyaxis_yminortick_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
% 
% Grid
handles.bg9 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.5 0.35 0.22 0.15],...
    'Title',lang_var{plt24},'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_grid1 = uicontrol('Parent',handles.bg9,'Style','radiobutton','String',lang_var{plt22},...
    'units','norm','Position',[0.3 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_grid1,'BackgroundColor','white');
function callbk_panel_xyaxis_grid1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_grid2 = uicontrol('Parent',handles.bg9,'Style','radiobutton','String',lang_var{plt23},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_grid2,'BackgroundColor','white');
function callbk_panel_xyaxis_grid2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% 
% swap X-Y
handles.bg20 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.73 0.35 0.22 0.15],...
    'Title',[lang_var{plt25},' X-Y'],'FontSize',12,'units','norm','FontWeight','bold','ForegroundColor',textcolor,...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_swap1 = uicontrol('Parent',handles.bg20,'Style','radiobutton','String',lang_var{plt23},...
    'units','norm','Position',[0.1 0.05 0.4 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_swap1,'BackgroundColor','white');
function callbk_panel_xyaxis_swap1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_swap2 = uicontrol('Parent',handles.bg20,'Style','radiobutton','String',lang_var{plt22},...
    'units','norm','Position',[0.5 0.05 0.4 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_swap2,'BackgroundColor','white');
function callbk_panel_xyaxis_swap2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% x dir
handles.bg3 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.02 0.2 0.45 0.15],...
    'Title',['X ',lang_var{plt26}],'FontSize',12,'units','norm','FontWeight','bold','ForegroundColor',textcolor,...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_xdir_input1 = uicontrol('Parent',handles.bg3,'Style','radiobutton','String',lang_var{plt14},...
    'units','norm','Position',[0.3 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xdir_input1,'BackgroundColor','white');
function callbk_panel_xyaxis_xdir_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_xdir_input2 = uicontrol('Parent',handles.bg3,'Style','radiobutton','String',lang_var{plt27},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xdir_input2,'BackgroundColor','white');
function callbk_panel_xyaxis_xdir_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% y dir
handles.bg4 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.5 0.2 0.45 0.15],...
    'Title',['Y ',lang_var{plt26}],'FontSize',12,'units','norm','FontWeight','bold','ForegroundColor',textcolor,...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_ydir_input1 = uicontrol('Parent',handles.bg4,'Style','radiobutton','String',lang_var{plt14},...
    'units','norm','Position',[0.3 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_ydir_input1,'BackgroundColor','white');
function callbk_panel_xyaxis_ydir_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

handles.panel_xyaxis_ydir_input2 = uicontrol('Parent',handles.bg4,'Style','radiobutton','String',lang_var{plt27},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_ydir_input2,'BackgroundColor','white');
function callbk_panel_xyaxis_ydir_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% x scale
[~, main03] = ismember('main03',lang_id);
[~, main04] = ismember('main04',lang_id);
handles.bg5 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.02 0.05 0.45 0.15],...
    'Title',['X ',lang_var{plt28}],'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_xscale_input1 = uicontrol('Parent',handles.bg5,'Style','radiobutton','String',lang_var{main03},...
    'units','norm','Position',[0.3 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xscale_input1,'BackgroundColor','white');
function callbk_panel_xyaxis_xscale_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_xscale_input2 = uicontrol('Parent',handles.bg5,'Style','radiobutton','String',lang_var{main04},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_xscale_input2,'BackgroundColor','white');
function callbk_panel_xyaxis_xscale_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% y scale
handles.bg6 = uibuttongroup('Parent',handles.panel_xyaxis,'Position',[0.5 0.05 0.45 0.15],...
    'Title',['Y ',lang_var{plt28}],'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_xyaxis_yscale_input1 = uicontrol('Parent',handles.bg6,'Style','radiobutton','String',lang_var{main03},...
    'units','norm','Position',[0.3 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_yscale_input1,'BackgroundColor','white');
function callbk_panel_xyaxis_yscale_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
handles.panel_xyaxis_yscale_input2 = uicontrol('Parent',handles.bg6,'Style','radiobutton','String',lang_var{main04},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_xyaxis_yscale_input2,'BackgroundColor','white');
function callbk_panel_xyaxis_yscale_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

%%  Line spec
handles.panel_lspec = uipanel(h_PlotPro2DLineGUI,'Title',lang_var{plt29},'FontSize',12,...
    'Position',[0.67 0.5 0.28 0.32],'BackgroundColor','white','FontWeight','bold');
% Line plot
handles.panel_lspec_lineplot_text = uicontrol('Parent',handles.panel_lspec,'Style','text','String',lang_var{plt30},...
    'units','norm','Position',[0.1 0.7 0.3 0.1],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');

linePlotList = {'line';'stairs';'errorbar';'area'};
handles.panel_lspec_lineplot_input = uicontrol('Parent',handles.panel_lspec,'Style','pop','String',linePlotList,...
    'units','norm','Position',[0.5 0.725 0.4 0.1],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'Callback',@callbk_panel_lspec_lineplot_input,'BackgroundColor','white');
function callbk_panel_lspec_lineplot_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

% Line style
handles.panel_lspec_linestyle_text = uicontrol('Parent',handles.panel_lspec,'Style','text','String',lang_var{plt31},...
    'units','norm','Position',[0.1 0.5 0.3 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
lineStyleList = {'-';'--';':';'-.';'none'};
handles.panel_lspec_linestyle_input = uicontrol('Parent',handles.panel_lspec,'Style','pop','String',lineStyleList,...
    'units','norm','Position',[0.5 0.525 0.4 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_lspec_linestyle_input,'BackgroundColor','white');
function callbk_panel_lspec_linestyle_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% Line width
handles.panel_lspec_linewidth_text = uicontrol('Parent',handles.panel_lspec,'Style','text','String',lang_var{plt32},...
    'units','norm','Position',[0.1 0.3 0.3 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
lineWidthList = {'0.1';'0.2';'0.3';'0.4';'0.5';'0.7';'1';'1.5';'2';'3';'4';'5';'6';'7';'8';'9';'10';'12';'15';'20';'25';'30';'40';'50';'60';'70';'80';'100';'120'};
handles.panel_lspec_linewidth_input = uicontrol('Parent',handles.panel_lspec,'Style','pop','String',lineWidthList,...
    'units','norm','Position',[0.5 0.325 0.4 0.1],'Value',9,...
    'FontSize',11,'Callback',@callbk_panel_lspec_linewidth_input,'BackgroundColor','white');
function callbk_panel_lspec_linewidth_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

%% stairs
% pad edge
handles.panel_lspec_stairs_extend_text = uicontrol('Parent',handles.panel_lspec,'Style','text','String',lang_var{plt35},...
    'units','norm','Position',[0.05 0.15 0.2 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'BackgroundColor','white');
handles.panel_lspec_stairs_input1 = uicontrol('Parent',handles.panel_lspec,'Style','edit','String','',...
    'units','norm','Position',[0.25 0.17 0.15 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_lspec_stairs_input1,'BackgroundColor','white');
function callbk_panel_lspec_stairs_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

handles.panel_lspec_stairs_extend_text2 = uicontrol('Parent',handles.panel_lspec,'Style','text','String','-',...
    'units','norm','Position',[0.4 0.17 0.02 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'BackgroundColor','white');

handles.panel_lspec_stairs_input2 = uicontrol('Parent',handles.panel_lspec,'Style','edit','String','',...
    'units','norm','Position',[0.42 0.17 0.15 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_lspec_stairs_input2,'BackgroundColor','white');
function callbk_panel_lspec_stairs_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

% stairs direction
handles.panel_lspec_stairsDir = uicontrol('Parent',handles.panel_lspec,'Style','pushbutton','String',[lang_var{plt26},'-->'],...
    'units','norm','Position',[0.6 0.17 0.3 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_lspec_stairsDir,'BackgroundColor','white');

% update stairs direction
function callbk_panel_lspec_stairsDir(source,eventdata)
    if strcmp(get(handles.panel_lspec_stairsDir,'String'), [lang_var{plt26},'-->'])
        set(handles.panel_lspec_stairsDir,'String',['<--',lang_var{plt26}])
    else
        set(handles.panel_lspec_stairsDir,'String',[lang_var{plt26},'-->'])
    end
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
%% errorbar capsize
handles.panel_lspec_capsize_text = uicontrol('Parent',handles.panel_lspec,'Style','text','String',lang_var{plt36},...
    'units','norm','Position',[0.1 0.17 0.3 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'BackgroundColor','white');
handles.panel_lspec_capsize_input = uicontrol('Parent',handles.panel_lspec,'Style','edit','String','6',...
    'units','norm','Position',[0.5 0.17 0.4 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_lspec_capsize_input,'BackgroundColor','white');
function callbk_panel_lspec_capsize_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% Line color
handles.panel_lspec_linecolor_text = uicontrol('Parent',handles.panel_lspec,'Style','text','String',lang_var{plt33},...
    'units','norm','Position',[0.1 0.1 0.3 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');

for i=1:7
    lineColorList{i,:}=mat2str(handles.c_map0(i,:));
end

handles.panel_lspec_linecolor_input = uicontrol('Parent',handles.panel_lspec,'Style','pushbutton',...
    'units','norm','Position',[0.5 0.125 0.4 0.1],'Value',1,'Visible','on','String',handles.selecttext,...
    'FontSize',11,'Callback',@callbk_panel_lspec_linecolor_input,'BackgroundColor',lineColorList{1,:});

%% area plot: face color
handles.panel_lspec_areaFaceColor_input = uicontrol('Parent',handles.panel_lspec,'Style','pushbutton','String',lang_var{plt38},...
    'units','norm','Position',[0.1 0.04 0.3 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_lspec_areaFaceColor_input,'BackgroundColor',lineColorList{1,:});

% base value for area plot
handles.panel_lspec_basevalue_text = uicontrol('Parent',handles.panel_lspec,'Style','text','String',lang_var{plt37},...
    'units','norm','Position',[0.1 0.17 0.3 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'BackgroundColor','white');
handles.panel_lspec_basevalu_input = uicontrol('Parent',handles.panel_lspec,'Style','edit','String','0',...
    'units','norm','Position',[0.5 0.17 0.4 0.1],'Value',1,'Visible','off',...
    'FontSize',11,'Callback',@callbk_panel_lspec_basevalu_input,'BackgroundColor','white');
function callbk_panel_lspec_basevalu_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

%% Marker spec
handles.panel_mspec = uipanel(h_PlotPro2DLineGUI,'Title',lang_var{plt40},'FontSize',12,...
    'Position',[0.67 0.05 0.28 0.42],'BackgroundColor','white','FontWeight','bold');
[~, main30] = ismember('main30',lang_id); % yes
[~, main31] = ismember('main31',lang_id); % no
% Marker show
handles.bg10 = uibuttongroup('Parent',handles.panel_mspec,'Position',[0.05 0.8 0.9 0.15],...
    'Title',lang_var{plt41},'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_mspec_markershow_input1 = uicontrol('Parent',handles.bg10,'Style','radiobutton','String',lang_var{main30},...
    'units','norm','Position',[0.2 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markershow_input1,'BackgroundColor','white');
function callbk_panel_mspec_markershow_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
handles.panel_mspec_markershow_input2 = uicontrol('Parent',handles.bg10,'Style','radiobutton','String',lang_var{main31},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markershow_input2,'BackgroundColor','white');
function callbk_panel_mspec_markershow_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

% Marker edge show
handles.bg11 = uibuttongroup('Parent',handles.panel_mspec,'Position',[0.05 0.65 0.9 0.15],...
    'Title',lang_var{plt42},'FontSize',12,'units','norm',...
    'HandleVisibility','off','BackgroundColor','white');
handles.panel_mspec_markeredgeshow_input1 = uicontrol('Parent',handles.bg11,'Style','radiobutton','String',lang_var{main30},...
    'units','norm','Position',[0.2 0.05 0.3 0.9],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markeredgeshow_input1,'BackgroundColor','white');
function callbk_panel_mspec_markeredgeshow_input1(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
handles.panel_mspec_markeredgeshow_input2 = uicontrol('Parent',handles.bg11,'Style','radiobutton','String',lang_var{main31},...
    'units','norm','Position',[0.6 0.05 0.3 0.9],'Value',0,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markeredgeshow_input2,'BackgroundColor','white');
function callbk_panel_mspec_markeredgeshow_input2(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

% Marker style
handles.panel_mspec_markerstyle_text = uicontrol('Parent',handles.panel_mspec,'Style','text','String',lang_var{plt43},...
    'units','norm','Position',[0.1 0.5 0.3 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
markerStyleList = {'none';'o';'+';'*';'x';'-';'|';'square';'diamond';'^';'v';'>';'<';'pentagram';'hexagram'};
handles.panel_mspec_markerstyle_input = uicontrol('Parent',handles.panel_mspec,'Style','pop','String',markerStyleList,...
    'units','norm','Position',[0.5 0.5 0.4 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markerstyle_input,'BackgroundColor','white');
function callbk_panel_mspec_markerstyle_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% Marker size
handles.panel_mspec_markersize_text = uicontrol('Parent',handles.panel_mspec,'Style','text','String',lang_var{plt44},...
    'units','norm','Position',[0.1 0.35 0.3 0.1],'Value',1,...
    'FontSize',11,'BackgroundColor','white');
% markerSizeList = {'0.1';'0.2';'0.3';'0.4';'0.5';'0.7';'1';'1.5';'2';'3';'4';'5';'6';'7';'8';'9';'10';'12';'15';'20';'25';'30';'40';'50';'60';'70';'80';'100';'120'};
% handles.panel_mspec_markersize_input = uicontrol('Parent',handles.panel_mspec,'Style','pop','String',markerSizeList,...
handles.panel_mspec_markersize_input = uicontrol('Parent',handles.panel_mspec,'Style','edit','String','50',...
    'units','norm','Position',[0.5 0.375 0.4 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markersize_input,'BackgroundColor','white');
function callbk_panel_mspec_markersize_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% alpha
handles.panel_mspec_markeralpha_text = uicontrol('Parent',handles.panel_mspec,'Style','text','String',[lang_var{plt45},' 50%'],...
    'units','norm','Position',[0.1 0.2 0.3 0.1],'Value',1,'FontWeight','bold','ForegroundColor',textcolor,...
    'FontSize',11,'BackgroundColor','white');
handles.panel_mspec_markeralpha_input = uicontrol('Parent',handles.panel_mspec,'Style','slider',...
    'units','norm','Position',[0.4 0.2 0.45 0.1],'Value',0.5,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markeralpha_input);
function callbk_panel_mspec_markeralpha_input(source,eventdata)
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end
% Marker face color
handles.panel_mspec_markerfacecolor_input = uicontrol('Parent',handles.panel_mspec,'Style','pushbutton','String',lang_var{plt38},...
    'units','norm','Position',[0.1 0.075 0.3 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markerfacecolor_input,'BackgroundColor',lineColorList{1,:});
% Marker edge color
handles.panel_mspec_markeredgeshow_input = uicontrol('Parent',handles.panel_mspec,'Style','pushbutton','String',lang_var{plt39},...
    'units','norm','Position',[0.6 0.075 0.3 0.1],'Value',1,...
    'FontSize',11,'Callback',@callbk_panel_mspec_markeredgeshow_input,'BackgroundColor',lineColorList{1,:});

%% Read handles
%% read data and unit type
handles.data = varargin{1}.current_data;
handles.dat_name = varargin{1}.dat_name;
%handles.data_name = varargin{1}.data_name;
handles.unit = varargin{1}.unit;
handles.unit_type = varargin{1}.unit_type;
handles.listbox_acmain = varargin{1}.listbox_acmain;
handles.edit_acfigmain_dir= varargin{1}.edit_acfigmain_dir;
handles.nplot = varargin{1}.nplot;
handles.val1 = varargin{1}.val1;

plot_s = varargin{1}.plot_s;
handles.plot_s = plot_s;

[~, a27] = ismember('a27',lang_id);  % data error
[~, plt47] = ismember('plt47',lang_id);  %  Error! try "Math -> Sort/Unique/Delete-empty" first
[~, main57] = ismember('main57',lang_id);  % Preview
[~, handles.plt48] = ismember('plt48',lang_id);  % Warning: Load data failed. Please check 
handles.FigNameText = ['Acycle: ',lang_var{menu41},' ',lang_var{main57}];
%
for i = 1: handles.nplot
    plot_no = plot_s{i};
    plot_no = strrep2(plot_no, '<HTML><FONT color="blue">', '</FONT></HTML>');
    if isdir(plot_no)
        return
    end
    [handles.plot_no_dir,plotseries,ext] = fileparts(plot_no);
    handles.plot_list{i} = plotseries;
    handles.plot_list_ext{i} = [plotseries,ext];
    try dat = load(plot_no);
    catch
        errordlg([[plotseries,ext],lang_var{plt47}],lang_var{a27})
    end
end


% set data file
set(handles.panel_datapanel_data_input,'String',handles.plot_list_ext)
% set data file
set(handles.panel_datapanel_y_i_input,'String',[handles.plot_list_ext{1},' 2'])
% set title
set(handles.panel_font_title_input,'String',handles.plot_list_ext{1});

if or(handles.main_unit_selection == 1, handles.lang_choice == 0)
    % set x label
    if handles.unit_type == 0
        set(handles.panel_xyaxis_xlabel_input,'String',['Unit (',handles.unit,')']);
    elseif handles.unit_type == 1
        set(handles.panel_xyaxis_xlabel_input,'String',['Depth (',handles.unit,')']);
    else
        set(handles.panel_xyaxis_xlabel_input,'String',['Time (',handles.unit,')']);
    end
else
    
    % set x label
    if handles.unit_type == 0
        set(handles.panel_xyaxis_xlabel_input,'String',[lang_var{main34},' (',handles.unit,')']);
    elseif handles.unit_type == 1
        set(handles.panel_xyaxis_xlabel_input,'String',[lang_var{main23},' (',handles.unit,')']);
    else
        set(handles.panel_xyaxis_xlabel_input,'String',[lang_var{main21},' (',handles.unit,')']);
    end
end
% set x & y limit

try
    
    data = handles.data;
    x = data(:,1);
    y = data(:,2);
    set(handles.panel_xyaxis_xlim_low_input,'String',num2str(min(x)))
    set(handles.panel_xyaxis_xlim_high_input,'String',num2str(max(x)))
    set(handles.panel_xyaxis_ylim_low_input,'String',num2str(min(y)))
    set(handles.panel_xyaxis_ylim_high_input,'String',num2str(max(y)))
    if handles.lang_choice == 0
        handles.plotpro2dfig = figure('Name','Acycle: Plot Pro Preview','NumberTitle','off');
    else
        
        handles.plotpro2dfig = figure('Name',['Acycle: ',lang_var{menu41},' ',lang_var{main57}],'NumberTitle','off');
    end
    set(handles.plotpro2dfig,'units','norm') % set location
    set(0,'Units','normalized') % set units as normalized
    set(handles.plotpro2dfig,'position',[0.62,0.2,0.35,0.5] * MonZoom,'Color','white') % set position
    % ui table
    handles.plotpro2dFigTable = uifigure('units','norm','position',[0.62,0.75,0.35,0.2],'Color','white');
    uit = uitable(handles.plotpro2dFigTable,'units','norm','position',[0.02,0.02,0.96,0.96],'Data',data);
    %plot(x,y)
catch
    
end
% set y limit

%% Default settings
% read excel file and plot
PlotAdvSettingSeed = readtable('PlotAdvSettingSeed.xlsx');
PlotAdvSetting = PlotAdvSettingSeed;
PlotAdvSetting.x_axis_file = handles.plot_list_ext{1};
PlotAdvSetting.y_axis_file = handles.plot_list_ext{1};
PlotAdvSetting.xlim_low = min(x);
PlotAdvSetting.xlim_high = max(x);
PlotAdvSetting.ylim_low = min(y);
PlotAdvSetting.ylim_high = max(y);
[~,plotseries,ext] = fileparts(handles.dat_name);
PlotAdvSetting.title = string(plotseries);

handles.ny = 1;  % for iteration
%% define some parameters for the Nested and Anonymous Functions.
j = nan;
k = nan;
m = 1;
n = 1;
panel_i = [];
str = [];
val = [];
currData = [];
datan = 1;
checklegend = 0;
plotHd = [];
scatterHd = [];
SetDataList=[];
SetDataListn = 0;
int_gt_0 = 0;
result = 0;
dat_tmp = [];
%%
% default value for plot
panel_datapanel_y_input = str2num(get(handles.panel_datapanel_y_input, 'string'));

%pAxes18('ggray')
UpdatePlotPro2DLineGUI
UpdatePlotPro2DLinePlot

%% update excel file
% if gui changes

%% get all panels
function callbk_panel_datapanel_full_input(source,eventdata)
    
    panel_datapanel_set_text = get(handles.panel_datapanel_full_input, 'string');
    panel_datapanel_set_text_all = strsplit(panel_datapanel_set_text,',');
    % Update excel table
    PlotAdvSetting.panel_nrow(:) = str2double(panel_datapanel_set_text_all{1});
    PlotAdvSetting.panel_ncol(:) = str2double(panel_datapanel_set_text_all{2});
    panel_n = str2double(panel_datapanel_set_text_all{1}) * str2double(panel_datapanel_set_text_all{2});
    panel_i = [];
    for i = 1 : panel_n
        panel_i{i} = num2str(i);
    end
    set(handles.panel_datapanel_set_input, 'String', panel_i,'Value',1);
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

%% set the i-th panel
function callbk_panel_datapanel_set_input(source,eventdata)
    UpdatePlotPro2DLineGUI
    panel_i = get(handles.panel_datapanel_set_input,'Value');  % get panel id
    % read selection
    str = get(handles.panel_datapanel_data_input,'String');
    val = get(handles.panel_datapanel_data_input,'Value');
    
    [datan, ~]=size(PlotAdvSetting);  % read rows of the setting excel file
    yaxisi = 0;  % 
    yaxisj = 0;  % set data list number
    xydata_yn = 0;  % default: no settings detected
    SetDataList=[];
    
    for i = 1: datan
        % if data file included and, belongs to the panel
        if and(strcmp(PlotAdvSetting.y_axis_file(i,:), str(val)),PlotAdvSetting.panel_i(i) == panel_i)
            yaxisi = yaxisi + 1;
            % set GUI x axis
            set(handles.panel_datapanel_x_input,'String',num2str(PlotAdvSetting.x_axis_col(i)))
            yaxislist(yaxisi) = PlotAdvSetting.y_axis_col(i);
            xydata_yn = 1;  % existing settings detected
        end
        % if belongs to the panel
        if PlotAdvSetting.panel_i(i) == panel_i
            yaxisj = yaxisj + 1;
            SetDataList{yaxisj} = strcat(PlotAdvSetting.y_axis_file(i,:),{' '},num2str(PlotAdvSetting.y_axis_col(i)));
        end
    end
    
    if xydata_yn == 1
        set(handles.panel_datapanel_y_input,'String',regexprep(num2str(yaxislist),'\s+',','))
    else
        set(handles.panel_datapanel_x_input,'String','1')
        set(handles.panel_datapanel_y_input,'String',' ')
    end
    
    %if yaxisj == 0; SetDataList=' ';end
    %assignin('base','SetDataList',SetDataList)
    if length(SetDataList) == 0
        set(handles.panel_datapanel_y_i_input, 'String', ' ', 'Value',1)
    elseif length(SetDataList) == 1
        set(handles.panel_datapanel_y_i_input, 'String', {convertCharsToStrings(SetDataList{1})},'Value',1)
    else
        set(handles.panel_datapanel_y_i_input, 'String', SetDataList,'Value',1)
    end
    
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    
    % if y is empty
    xydata_yn = 0;  % default: no settings detected
    yaxisi = 0;  % 
    yaxislist=[]; %
    
    if isnan(str2double(get(handles.panel_datapanel_y_input,'String')))
        [datan, ~]=size(PlotAdvSetting);  % read rows of the setting excel file
        % set data file using the one appear in the table
        for i = 1 : datan
            % identify the panel
            if PlotAdvSetting.panel_i(i) == get(handles.panel_datapanel_set_input,'Value')  % get panel id
                set(handles.panel_datapanel_data_input,'Value',find(strcmp(PlotAdvSetting.y_axis_file(i,:), get(handles.panel_datapanel_data_input, 'String'))))
                xydata_yn = 1; % find the first data
                break
            end
        end
        % set y axis column
        if xydata_yn == 1
            for i = 1 : datan
                % identify the panel
                if PlotAdvSetting.panel_i(i) == get(handles.panel_datapanel_set_input,'Value')  % get panel id
                    str = get(handles.panel_datapanel_data_input, 'String');
                    val = get(handles.panel_datapanel_data_input, 'Value');
                    if strcmp(str(val), PlotAdvSetting.y_axis_file(i,:))
                        yaxisi = yaxisi + 1;
                        yaxislist(yaxisi) = PlotAdvSetting.y_axis_col(i);
                    end
                end
            end
            % okay set y axis columns
            set(handles.panel_datapanel_y_input,'String',regexprep(num2str(yaxislist),'\s+',','))
        end
    end
    
end

%% select data file
function callbk_panel_datapanel_data_input(source,eventdata)
    % read selection
    str = get(handles.panel_datapanel_data_input,'String');
    val = get(handles.panel_datapanel_data_input,'Value');
    lang_var = handles.lang_var;
    [datan, ~] = size(PlotAdvSetting);  % read rows of the setting excel file
    % 
    % ui table
    try figure(handles.plotpro2dFigTable)
    catch
        handles.plotpro2dFigTable = uifigure('units','norm','position',[0.62,0.75,0.35,0.2],'Color','white');
        uit = uitable(handles.plotpro2dFigTable,'units','norm','position',[0.02,0.02,0.96,0.96],'Data',data);
    end
    % search for each row in the data file list
    
    for i = 1: length(str)
        % find the row = selection
        if i == val
            try
                data = load( fullfile(handles.plot_no_dir, str{i} ) );
                uit.Data = data;
            catch
                warning([lang_var{handles.plt48}, str{i}])  % Warning: Load data failed. Please check 
            end
        end
    end
    
    PlotAdvSetting_tmp = PlotAdvSetting(strcmp(PlotAdvSetting.y_axis_file, str(val)),:);
    
    yaxisi = 0;  %
    xydata_yn = 0;  % default: no settings detected
    panel_i = get(handles.panel_datapanel_set_input,'Value');  % get panel id
    for i = 1 : datan
        if and(strcmp(PlotAdvSetting.y_axis_file(i,:), str(val)), PlotAdvSetting.panel_i(i) == panel_i)
            yaxisi = yaxisi + 1;
            xaxislist(yaxisi) = PlotAdvSetting.x_axis_col(i);
            yaxislist(yaxisi) = PlotAdvSetting.y_axis_col(i);
            %SetDataList{yaxisi} = num2str(PlotAdvSetting.y_axis_col(i));
            xydata_yn = 1;  % existing settings detected
        end
    end
    
    if xydata_yn == 1
        set(handles.panel_datapanel_x_input,'String',regexprep(num2str(xaxislist),'\s+',','))
        set(handles.panel_datapanel_y_input,'String',regexprep(num2str(yaxislist),'\s+',','))
        %set(handles.panel_datapanel_y_i_input, 'string',SetDataList,'Value',1)
    else
        set(handles.panel_datapanel_x_input,'String','1')
        set(handles.panel_datapanel_y_input,'String',' ')
        %set(handles.panel_datapanel_y_i_input,'String',' ')
    end
    UpdatePlotPro2DLineGUI
end

%% read x data
function callbk_panel_datapanel_x_input(source,eventdata)
    panel_i = get(handles.panel_datapanel_set_input,'Value');  % get panel id
    % read selection
    lang_var = handles.lang_var;
    str = get(handles.panel_datapanel_data_input,'String');
    val = get(handles.panel_datapanel_data_input,'Value');
    [datan, ~] = size(PlotAdvSetting);  % read rows of the setting excel file
    panel_datapanel_x_input = str2double(get(handles.panel_datapanel_x_input, 'string'));
    % error msg
    for i = 1 : datan
        if and(strcmp(PlotAdvSetting.y_axis_file(i,:), str(val)), PlotAdvSetting.panel_i(i) == panel_i)
            % load data
            data = load( fullfile(handles.plot_no_dir, PlotAdvSetting.x_axis_file(i,:) ) );
            %data = load(PlotAdvSetting.x_axis_file(i,:));
            % read number of rows (m) and columns(n);
            [m,n] = size(data); 
            int_gt_0 = @(n) (rem(n,1) == 0) & (n >= 0);  % 0 or positive interger
            result = int_gt_0(panel_datapanel_x_input);
            if result == 1
                if panel_datapanel_x_input > n
                    warning([handles.warnplt50, num2str(n)])
                    panel_datapanel_x_input = n;
                end
            else
                warning(handles.warnplt51)
                panel_datapanel_x_input = 0;
            end
            PlotAdvSetting.x_axis_col(i) = panel_datapanel_x_input;
            set(handles.panel_datapanel_x_input, 'String',num2str(panel_datapanel_x_input))
        end
    end
    
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLinePlot
end

%% read y data
function callbk_panel_datapanel_y_input(source,eventdata)
    
    % read number of rows of the setting excel file
    [datan, ~]=size(PlotAdvSetting);
    if datan == 0
        PlotAdvSetting = PlotAdvSettingSeed;
    end
    % get panel id from GUI
    
    panel_i = get(handles.panel_datapanel_set_input,'Value');
    % read selection
    str = get(handles.panel_datapanel_data_input,'String');
    val = get(handles.panel_datapanel_data_input,'Value');
    
    % read y axis id, get the length
    panel_datapanel_y_input = str2num(get(handles.panel_datapanel_y_input, 'string'));
    handles.ny = length(panel_datapanel_y_input);
    
    % error msg
    er1 = 0;
    for i = 1 : datan
        if and(strcmp(PlotAdvSetting.y_axis_file(i,:), str(val)), PlotAdvSetting.panel_i(i) == panel_i)
            % load data
            data = load( fullfile(handles.plot_no_dir, PlotAdvSetting.y_axis_file(i,:)));
            % read number of rows (m) and columns(n);
            [m,n] = size(data);
            % check each member
            for j = 1: handles.ny
                int_gt_0 = @(n) (rem(n,1) == 0) & (n > 0);  % 0 or positive interger
                result = int_gt_0(panel_datapanel_y_input(j));
                if result == 1
                    if panel_datapanel_y_input(j) > n
                        warning([handles.warnplt50, num2str(n)])
                        panel_datapanel_y_input(j) = n;
                        er1 = 1;
                    end
                else
                    warning(handles.warnplt52)
                    panel_datapanel_y_input(j) = [];
                    handles.ny = 0;
                    er1 = 1;
                end
                PlotAdvSetting.y_axis_col(i) = panel_datapanel_y_input(j);
            end
        end
    end
    % if the input has error, update the input box
    if er1 == 1
        set(handles.panel_datapanel_y_input, 'String',num2str(unique(panel_datapanel_y_input)))
    end
    
    if handles.ny > 0
        % find at least 1 data
        % search all rows whether this panel has been fully defined
        [datan, ~]=size(PlotAdvSetting);
        % read selection
        str = get(handles.panel_datapanel_data_input,'String');
        val = get(handles.panel_datapanel_data_input,'Value');
        
        while datan > 0
             if and( PlotAdvSetting.panel_i(datan) == panel_i, strcmp(PlotAdvSetting.y_axis_file(datan,:), str(val)) )
                 if ~ismember(PlotAdvSetting.y_axis_col(datan), panel_datapanel_y_input)
                    % New data doesn't include this row. Delete it.
                    PlotAdvSetting(datan,:) = [];
                 end
             end
             datan = datan - 1;
        end
        assignin('base','tbl1',PlotAdvSetting);
        PlotAdvSetting_tmp = PlotAdvSetting(PlotAdvSetting.panel_i == panel_i,:);
        [datan, ~]=size(PlotAdvSetting);
        
        for i = 1: handles.ny

            % check y axis columns has been defined or not
            if i <= datan
                if and(ismember(panel_datapanel_y_input(i), PlotAdvSetting_tmp.y_axis_col), strcmp(PlotAdvSetting.y_axis_file(i,:), str(val)))
                    % this file and column has been defined
                else
                    % this column has never been defined
                    PlotAdvSettingSeed.ID = datan+1;
                    panel_datapanel_set_text = get(handles.panel_datapanel_full_input, 'string');
                    panel_datapanel_set_text_all = strsplit(panel_datapanel_set_text,',');
                    % Update excel table
                    PlotAdvSettingSeed.panel_nrow = str2double(panel_datapanel_set_text_all{1});
                    PlotAdvSettingSeed.panel_ncol = str2double(panel_datapanel_set_text_all{2});
                    PlotAdvSettingSeed.panel_i = get(handles.panel_datapanel_set_input, 'value');

                    str = get(handles.panel_datapanel_data_input, 'String');
                    val = get(handles.panel_datapanel_data_input,'value');
                    PlotAdvSettingSeed.x_axis_file = string(str{val});
                    PlotAdvSettingSeed.x_axis_col = str2double(get(handles.panel_datapanel_x_input, 'string'));
                    PlotAdvSettingSeed.y_axis_file = string(str{val});
                    PlotAdvSettingSeed.y_axis_col = panel_datapanel_y_input(i);
                    % color 
                    PlotAdvSettingSeed.line_color = cellstr(mat2str(handles.c_map0(i,:)));
                    PlotAdvSettingSeed.marker_face_color = cellstr(mat2str(handles.c_map0(i,:)));
                    PlotAdvSettingSeed.marker_edge_color = cellstr(mat2str(handles.c_map0(i,:)));

                    % x y limits limits for each panel
                    data1 = load(fullfile(handles.plot_no_dir, PlotAdvSettingSeed.x_axis_file));
                    data2 = load(fullfile(handles.plot_no_dir, PlotAdvSettingSeed.y_axis_file));
                    %PlotAdvSettingSeed.x_axis_col(1)
                    y = data2(:, PlotAdvSettingSeed.y_axis_col(1));
                    try
                        x = data1(:, PlotAdvSettingSeed.x_axis_col(1));
                    catch
                        PlotAdvSettingSeed.x_axis_col = 0;
                        x = (1:length(y))';
                    end
                    PlotAdvSettingSeed.xlim_low = min(x);
                    PlotAdvSettingSeed.xlim_high = max(x);
                    PlotAdvSettingSeed.ylim_low = min(y);
                    PlotAdvSettingSeed.ylim_high = max(y);
                    % add it
                    %assignin('base','tbl1',PlotAdvSetting)
                    PlotAdvSetting = [PlotAdvSetting; PlotAdvSettingSeed]; 
                end
            else
                % this column has never been defined
                PlotAdvSettingSeed.ID = datan+1;
                panel_datapanel_set_text = get(handles.panel_datapanel_full_input, 'string');
                panel_datapanel_set_text_all = strsplit(panel_datapanel_set_text,',');
                % Update excel table
                PlotAdvSettingSeed.panel_nrow = str2double(panel_datapanel_set_text_all{1});
                PlotAdvSettingSeed.panel_ncol = str2double(panel_datapanel_set_text_all{2});
                PlotAdvSettingSeed.panel_i = get(handles.panel_datapanel_set_input, 'value');

                str = get(handles.panel_datapanel_data_input, 'String');
                val = get(handles.panel_datapanel_data_input,'value');
                PlotAdvSettingSeed.x_axis_file = string(str{val});
                PlotAdvSettingSeed.x_axis_col = str2double(get(handles.panel_datapanel_x_input, 'string'));
                PlotAdvSettingSeed.y_axis_file = string(str{val});
                PlotAdvSettingSeed.y_axis_col = panel_datapanel_y_input(i);
                % color 
                PlotAdvSettingSeed.line_color = cellstr(mat2str(handles.c_map1(1,:)));
                PlotAdvSettingSeed.marker_face_color = cellstr(mat2str(handles.c_map1(1,:)));
                PlotAdvSettingSeed.marker_edge_color = cellstr(mat2str(handles.c_map1(1,:)));

                % x y limits limits for each panel
                data1 = load(fullfile(handles.plot_no_dir, PlotAdvSettingSeed.x_axis_file));
                data2 = load(fullfile(handles.plot_no_dir, PlotAdvSettingSeed.y_axis_file));
                %PlotAdvSettingSeed.x_axis_col(1)
                y = data2(:, PlotAdvSettingSeed.y_axis_col(1));
                try
                    x = data1(:, PlotAdvSettingSeed.x_axis_col(1));
                catch
                    PlotAdvSettingSeed.x_axis_col = 0;
                    x = (1:length(y))';
                end
                PlotAdvSettingSeed.xlim_low = min(x);
                PlotAdvSettingSeed.xlim_high = max(x);
                PlotAdvSettingSeed.ylim_low = min(y);
                PlotAdvSettingSeed.ylim_high = max(y);
                % add it
                PlotAdvSetting = [PlotAdvSetting; PlotAdvSettingSeed]; 
            end
        end
    else
        [datan, ~]=size(PlotAdvSetting);
        % remove rows for all this data
        str = get(handles.panel_datapanel_data_input, 'String');
        val = get(handles.panel_datapanel_data_input,'value');
        
        while datan > 0
            if and(strcmp(PlotAdvSetting.y_axis_file(datan,:),str{val}),PlotAdvSetting.panel_i(datan) == panel_i)
                PlotAdvSetting(datan,:) = [];
            end
            datan = datan - 1;
        end
    end
    
    % unique table
    [~, ia] = unique(PlotAdvSetting(:,[4:8]));
    PlotAdvSetting = PlotAdvSetting(ia,:);
    % update color using default settings
    [datan, ~]=size(PlotAdvSetting);
    j = 0;
    for i = 1: datan
        if PlotAdvSetting.panel_i(i) == panel_i
            j = j + 1;
            if j < 8
                PlotAdvSetting.line_color{i}          = mat2str(handles.c_map0(j,:));
                PlotAdvSetting.marker_face_color{i}   = mat2str(handles.c_map0(j,:));
                PlotAdvSetting.marker_edge_color{i}   = mat2str(handles.c_map0(j,:));
            elseif j < 18
                PlotAdvSetting.line_color{i}          = mat2str(handles.c_map1(j-7,:));
                PlotAdvSetting.marker_face_color{i}   = mat2str(handles.c_map1(j-7,:));
                PlotAdvSetting.marker_edge_color{i}   = mat2str(handles.c_map1(j-7,:));
            else
                PlotAdvSetting.line_color{i}          = mat2str(handles.c_map2(j-17,:));
                PlotAdvSetting.marker_face_color{i}   = mat2str(handles.c_map2(j-17,:));
                PlotAdvSetting.marker_edge_color{i}   = mat2str(handles.c_map2(j-17,:));
            end
        end
    end
    %
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

%% set data LIST
function callbk_panel_datapanel_y_i_input(source,eventdata)
    
    UpdatePlotPro2DLineGUI
    UpdatePlotPro2DLineTable
end

%% update title
function callbk_panel_font_title_input(source,eventdata)
    % Update table
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

% update legend selection
    function callbk_panel_font_legend_input(source,eventdata)
        UpdatePlotPro2DLineTable
        UpdatePlotPro2DLinePlot
    end

%% line color
function callbk_panel_lspec_linecolor_input(source,eventdata)
    c = uisetcolor(get(handles.panel_lspec_linecolor_input,'BackgroundColor'),handles.selectcolortext);
    % read current panel
    panel_i = get(handles.panel_datapanel_set_input,'Value');  % get panel id
    % read current data
    str = get(handles.panel_datapanel_y_i_input,'String');  % get current data list
    val = get(handles.panel_datapanel_y_i_input,'Value');  % get current data list
    currData = str(val,:);
    currData = split(currData,' ');
    % how many rows?
    [datan, ~] = size(PlotAdvSetting);  % read rows of the setting excel file
    for i = 1: datan
        % identify the panel
        if PlotAdvSetting.panel_i(i) == panel_i
            if and(strcmp(PlotAdvSetting.y_axis_file(i,:), currData{1}),PlotAdvSetting.y_axis_col(i)==str2num(currData{2}))
                set(handles.panel_lspec_linecolor_input,'BackgroundColor',c)
                PlotAdvSetting.line_color{i} = mat2str(c);
            end
        end
    end
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

%% area face color
function callbk_panel_lspec_areaFaceColor_input(source,eventdata)
    c = uisetcolor(get(handles.panel_lspec_areaFaceColor_input,'BackgroundColor'),handles.selectcolortext);
    % read current panel
    panel_i = get(handles.panel_datapanel_set_input,'Value');  % get panel id
    % read current data
    str = get(handles.panel_datapanel_y_i_input,'String');  % get current data list
    val = get(handles.panel_datapanel_y_i_input,'Value');  % get current data list
    currData = str(val,:);
    currData = split(currData,' ');
    % how many rows?
    [datan, ~] = size(PlotAdvSetting);  % read rows of the setting excel file
    for i = 1: datan
        % identify the panel
        if PlotAdvSetting.panel_i(i) == panel_i
            if and(strcmp(PlotAdvSetting.y_axis_file(i,:), currData{1}),PlotAdvSetting.y_axis_col(i)==str2num(currData{2}))
                set(handles.panel_lspec_areaFaceColor_input,'BackgroundColor',c)
                PlotAdvSetting.area_facecolor{i} = mat2str(c);
            end
        end
    end
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
%% marker face color
function callbk_panel_mspec_markerfacecolor_input(source,eventdata)
    c = uisetcolor(get(handles.panel_mspec_markerfacecolor_input,'BackgroundColor'),handles.selectcolortext);
    % read current panel
    panel_i = get(handles.panel_datapanel_set_input,'Value');  % get panel id
    % read current data
    str = get(handles.panel_datapanel_y_i_input,'String');  % get current data list
    val = get(handles.panel_datapanel_y_i_input,'Value');  % get current data list
    currData = str(val,:);
    currData = split(currData,' ');
    % how many rows?
    [datan, ~] = size(PlotAdvSetting);  % read rows of the setting excel file
    for i = 1: datan
        % identify the panel
        if PlotAdvSetting.panel_i(i) == panel_i
            if and(strcmp(PlotAdvSetting.y_axis_file(i,:), currData{1}),PlotAdvSetting.y_axis_col(i)==str2num(currData{2}))
                set(handles.panel_mspec_markerfacecolor_input,'BackgroundColor',c)
                PlotAdvSetting.marker_face_color{i} = mat2str(c);
            end
        end
    end
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end

%% marker edge color
function callbk_panel_mspec_markeredgeshow_input(source,eventdata)
    c = uisetcolor(get(handles.panel_mspec_markeredgeshow_input,'BackgroundColor'),handles.selectcolortext);
    % read current panel
    panel_i = get(handles.panel_datapanel_set_input,'Value');  % get panel id
    % read current data
    str = get(handles.panel_datapanel_y_i_input,'String');  % get current data list
    val = get(handles.panel_datapanel_y_i_input,'Value');  % get current data list
    currData = str(val,:);
    currData = split(currData,' ');
    % how many rows?
    [datan, ~] = size(PlotAdvSetting);  % read rows of the setting excel file
    for i = 1: datan
        % identify the panel
        if PlotAdvSetting.panel_i(i) == panel_i
            if and(strcmp(PlotAdvSetting.y_axis_file(i,:), currData{1}),PlotAdvSetting.y_axis_col(i)==str2num(currData{2}))
                set(handles.panel_mspec_markeredgeshow_input,'BackgroundColor',c)
                PlotAdvSetting.marker_edge_color{i} = mat2str(c);
            end
        end
    end
    UpdatePlotPro2DLineTable
    UpdatePlotPro2DLinePlot
end
end