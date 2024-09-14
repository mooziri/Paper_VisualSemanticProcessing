%% Function help
% this function downsamples time-series data
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: July 6, 2024
%
%%%%% input %%%%%
% in_data:        M*N*T matrix of data, shape (Channels, Trials, Timepoints)
% in_fs:          sampling frequency of the input data
% decimate_order: the order for downsampling
% 
%%%%% output %%%%%
% out_data: downsampled data
% out_fs:   sampling frequency of the downsampled data

%% Function
function [out_data, out_fs] = ma_DownSam(in_data, in_fs, decimate_order)

out_fs = in_fs ./ decimate_order;
out_data = nan(size(in_data,1), size(in_data,2), size(in_data,3)./decimate_order);

for i_chn = 1 : size(in_data,1)
    for i_trial = 1 : size(in_data,2)
        out_data(i_chn, i_trial, :) = decimate(squeeze(in_data(i_chn, i_trial, :)), decimate_order);
    end
end

end




