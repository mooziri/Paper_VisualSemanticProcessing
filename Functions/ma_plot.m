%% Function help
% this function plots the mean and standard error of mean (SEM) of data
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: Mar 18, 2024
%
%%%%% input %%%%%
% x_val:        values of the x axis
% data:         M*N matrix of data where M is the number of repetitions and N is
%               the number of points on the x axis
% win:          the smoothing window size
% face_color:   a vector for plot color in [R G B FaceAlpha] format
% line_style:   'LineStyle' of mean
% error_method: measure of variability or confidence
%               'sem', for standard error of mean
%               'std', for standard deviation
%               'ci', for %95 confidence interval
%
%%%%% output %%%%%
% p: handler to the generated plot

%% Function
function p = ma_plot(x_val, MyData, win, face_color, error_method, line_style)

% variables
inte = 255;

% smooth data
for k = 1 : size(MyData,1)
    smotthed_data(k,:) = smooth(MyData(k,:), win);
end

% create y axis values
y  = nanmean(smotthed_data,1);

switch error_method
    case 'sem'
        y1 = nanmean(smotthed_data) + (nanstd(smotthed_data)./(size(smotthed_data, 1).^.5));
        y2 = nanmean(smotthed_data) - (nanstd(smotthed_data)./(size(smotthed_data, 1).^.5));
    case 'std'
        y1 = nanmean(smotthed_data) + nanstd(smotthed_data);
        y2 = nanmean(smotthed_data) - nanstd(smotthed_data);
    case 'ci'
        y1 = nanmean(smotthed_data) + 1.96 * (nanstd(smotthed_data)./(size(smotthed_data, 1).^.5));
        y2 = nanmean(smotthed_data) - 1.96 * (nanstd(smotthed_data)./(size(smotthed_data, 1).^.5));
end
Y  = [y1 y2(size(smotthed_data , 2):-1:1)];

% create x axis values
X  = [x_val sort(x_val, 'descend')];

% plot
if size(MyData,1) > 1
    fill(X, Y, [face_color(1)/inte face_color(2)/inte face_color(3)/inte],...
        'FaceAlpha',face_color(4), 'LineStyle', 'none');
    hold on;
end
p = plot(x_val, y,  'color', [face_color(1)/inte face_color(2)/inte face_color(3)/inte],...
    'LineWidth',3, 'LineStyle',line_style);
box off;
set(gca, 'fontsize', 13, 'fontweight', 'bold');

end


