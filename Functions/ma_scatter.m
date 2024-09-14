%% Function help
% this function makes a scatter plot
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: May 23, 2024
%
%%%%% input %%%%%
% x_val:        vector of values for x axis (1-dim)
% y_val:        vector of values for y axis (1-dim)
% x_axis_label: label of the x axis (string variable)
% y_axis_label: label of the y axis (string variable)
% method:       1 for veiwing distribution of data against x=y line
%               2 for correlation purpuse, Spearman correlation
%               3 for correlation purpuse, Pearnson correlation
%
%%%%% output %%%%%
% p: handler to the generated plot

%% Function
function p = ma_scatter(x_val, y_val, x_axis_label, y_axis_label, method)

% variables
if size(x_val,2)>size(x_val,1); x_val = x_val'; end
if size(y_val,2)>size(y_val,1); y_val = y_val'; end

if method==1
    data_range = max([range(x_val) range(y_val)]);
    axis_x = [min([x_val y_val], [], 'all')-.2*data_range, ...
        max([x_val y_val], [], 'all')+.2*data_range];
    axis_y = axis_x;
    plot_center = mean(axis_x,2);
else
    data_range = [range(x_val) range(y_val)];
    axis_x = [min(x_val)-.2*data_range(1) max(x_val)+.2*data_range(1)];
    axis_y = [min(y_val)-.2*data_range(2) max(y_val)+.2*data_range(2)];
    plot_center = [mean(axis_x,2) mean(axis_y,2)];
end

switch method
    
    case 1
        % scatter plot
        p = scatter(x_val, y_val,50,...
            'MarkerEdgeColor',[1 1 1],...
            'MarkerFaceColor',[0 .7 .7],...
            'LineWidth',1.5);
        hold on;
        
        % x=y line
        xyline = [min(axis_x) max(axis_x);min(axis_x) max(axis_x)];
        line([xyline(1,1) xyline(1,2)], [xyline(2,1) xyline(2,2)], 'LineStyle', '--', 'LineWidth',1, 'Color', 'k');
        
        % add racksum p_value
        p_val = ranksum(x_val, y_val);
        text(plot_center + .3*data_range, plot_center + .6*data_range,...
            ['p  = ', num2str(p_val)], 'fontsize', 16, 'fontweigh', 'bold');
        
    case 2
        
        % scatter plot
        p = scatter(x_val, y_val,40,...
            'MarkerEdgeColor',[0 .5 .5],...
            'MarkerFaceColor',[0 .7 .7],...
            'LineWidth',1.5);
        hold on;
        
        % compute correlation
        [xy_corr_r, xy_corr_p] = corr(x_val, y_val, 'Type', 'Spearman');
        
        % plot linear regression model
        plot(fitlm(x_val, y_val));
        lgnd = findobj('type', 'legend'); set(lgnd, 'visible', 'off');
        
        % add correlation rho & p_value
        text(plot_center(1) + .3*data_range(1), plot_center(2) + .6*data_range(2),...
            ['r  = ', num2str(xy_corr_r)], 'fontsize', 16, 'fontweigh', 'bold');
        text(plot_center(1) + .3*data_range(1), plot_center(2) + .5*data_range(2),...
            ['p = ', num2str(xy_corr_p)], 'fontsize', 16, 'fontweigh', 'bold');
        
    case 3
        % scatter plot
        p = scatter(x_val, y_val,40,...
            'MarkerEdgeColor',[0 .5 .5],...
            'MarkerFaceColor',[0 .7 .7],...
            'LineWidth',1.5);
        hold on;
        
        % compute correlation
        [xy_corr_r, xy_corr_p] = corr(x_val, y_val, 'Type', 'Pearson');
        
        % plot linear regression model
        plot(fitlm(x_val, y_val));
        lgnd = findobj('type', 'legend'); set(lgnd, 'visible', 'off');
        
        % add correlation rho & p_value
        text(plot_center(1) + .3*data_range(1), plot_center(2) + .6*data_range(2),...
            ['r  = ', num2str(xy_corr_r)], 'fontsize', 16, 'fontweigh', 'bold');
        text(plot_center(1) + .3*data_range(1), plot_center(2) + .5*data_range(2),...
            ['p = ', num2str(xy_corr_p)], 'fontsize', 16, 'fontweigh', 'bold');
end

% axes limits
xlim(axis_x);
ylim(axis_y);

% axes labels
xlabel(x_axis_label);
ylabel(y_axis_label);

% font
set(gca, 'fontsize', 14, 'fontweigh', 'bold');
hold off;

end







