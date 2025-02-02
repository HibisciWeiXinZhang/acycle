% wavelet update plots


% Designed for Acycle: wavelet analysis coherence
%
% By Mingsong Li
%   Peking University
%   msli@pku.edu.cn
%   acycle.org
%   Nov 11, 2021
% lang
lang_var = handles.lang_var;
[~, menu129] = ismember('menu129',handles.lang_id);
[~, main34] = ismember('main34',handles.lang_id); % Unit
[~, main23] = ismember('main23',handles.lang_id); % Depth
[~, main21] = ismember('main21',handles.lang_id); % Time
[~, main24] = ismember('main24',handles.lang_id); % Value
[~, main12] = ismember('main12',handles.lang_id);

if plot_series ==1
    try figure(handles.figwave)
       % clf
    catch
        handles.figwave = figure;
        %set(gcf,'Name','Acycle: Wavelet coherence and cross-spectrum plot')
        set(gcf,'Name',['Acycle: ',lang_var{menu129}])
        set(gcf,'units','norm') % set location
        set(gcf, 'color','white')
        set(gcf,'position',[0.1,0.65,0.4,0.4]* handles.MonZoom)
    end
    
    % update panel A: time series  
    %--- Plot time series
    for ploti = 1:2
        if ploti == 1
            if plot_swap == 0
                %--- Plot time series 1
                ax1 = subplot('position',[0.1 0.8 0.8 0.15]);
                plot(datax,dat1y,'k')
                ax1.XAxis.Visible = 'off'; % remove x-axis
            else
                ax1 = subplot('position',[0.07 0.1 0.15 0.8]);
                plot(datax,dat1y,'k')
                view([-90 90])
                %ax1.XAxis.Visible = 'off'; % remove x-axis

                
                if or(handles.lang_choice == 0, handles.main_unit_selection == 0)
                    if handles.unit_type == 0
                        xlabel(['Unit (',handles.unit,')'])
                    elseif handles.unit_type == 1
                        xlabel(['Depth (',handles.unit,')'])
                    else
                        xlabel(['Time (',handles.unit,')'])
                    end
                    
                else
                    
                    if handles.unit_type == 0
                        xlabel([lang_var{main34},' (',handles.unit,')'])
                    elseif handles.unit_type == 1
                        xlabel([lang_var{main23},' (',handles.unit,')'])
                    else
                        xlabel([lang_var{main21},' (',handles.unit,')'])
                    end
                end
            end
            if or(handles.lang_choice == 0, handles.main_unit_selection == 0)
                ylabel('Value of series #1')
            else
                ylabel([lang_var{main12},' #1 ',lang_var{main24}])
            end
            
                
        elseif ploti == 2
            if plot_swap == 0
                %--- Plot time series 2
                ax2 = subplot('position',[0.1 0.6 0.8 0.15]);
                plot(datax,dat2y,'k')
                ax2.XAxis.Visible = 'off'; % remove x-axis
                
                if or(handles.lang_choice == 0, handles.main_unit_selection == 0)
                    if handles.unit_type == 0
                        xlabel(['Unit (',handles.unit,')'])
                    elseif handles.unit_type == 1
                        xlabel(['Depth (',handles.unit,')'])
                    else
                        xlabel(['Time (',handles.unit,')'])
                    end
                    
                else
                    [~, main34] = ismember('main34',handles.lang_id); % Unit
                    [~, main23] = ismember('main23',handles.lang_id); % Depth
                    [~, main21] = ismember('main21',handles.lang_id); % Time
                    [~, main24] = ismember('main24',handles.lang_id); % Value
                    [~, main12] = ismember('main12',handles.lang_id);
                    if handles.unit_type == 0
                        xlabel([lang_var{main34},' (',handles.unit,')'])
                    elseif handles.unit_type == 1
                        xlabel([lang_var{main23},' (',handles.unit,')'])
                    else
                        xlabel([lang_var{main21},' (',handles.unit,')'])
                    end
                    
                end
            else
                ax2 = subplot('position',[0.25 0.1 0.15 0.8]);
                plot(datax,dat2y,'k')
                %ax2.XAxis.Visible = 'off'; % remove x-axis
                set(ax2,'XTickLabel',[])
                view([-90 90])
            end
            if or(handles.lang_choice == 0, handles.main_unit_selection == 0)
                ylabel('Value of series #2')
            else
                ylabel([lang_var{main12},' #2 ',lang_var{main24}])
            end
            
        end
        set(gca,'XMinorTick','on','YMinorTick','on')
        set(gca,'TickDir','out');
        set(gca,'XLim',xlim(:))
        if plot_flipx
            set(gca,'Xdir','reverse')
        else
            set(gca,'Xdir','normal')
        end
    end
    
    %--- Contour plot wavelet power spectrum
    if plot_swap == 0
        sub3 = subplot('position',[0.1 0.1 0.8 0.45]);
    else
        sub3 = subplot('position',[0.45 0.1 0.5 0.8]);
    end
    % update wavelet coherence
    if method_sel == 1
        wavecoh_update_wavecoh
    elseif method_sel == 2
        wavecoh_update_wtc
        wavecoh_update_xwt
    end
    figure(handles.waveletGUIfig)

%%
elseif plot_series == 0
    try figure(handles.figwave)
    %    clf
    catch
        handles.figwave = figure;
        set(gcf,'Name',['Acycle: ',lang_var{menu129}])
        set(gcf,'units','norm') % set location
        set(gcf, 'color','white')
        set(gcf,'position',[0.1,0.65,0.4,0.4]* handles.MonZoom)
    end
    
    %--- Contour plot wavelet power spectrum
    if plot_swap == 0
        sub3 = subplot('position',[0.1 0.1 0.8 0.8]);
    else
        sub3 = subplot('position',[0.1 0.1 0.8 0.8]);
    end
    % update wavelet coherence
    if method_sel == 1
        wavecoh_update_wavecoh
    elseif method_sel == 2
        wavecoh_update_wtc
        wavecoh_update_xwt
    end
    figure(handles.waveletGUIfig)
end