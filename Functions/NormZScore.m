%% Function help
% this function computes the z-scored value between of an observation based
% on the desired distribution
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: Mar 18, 2024
%
%%%%% input %%%%%
% distribution: vector of distribution (data, null, etc)
% observation:  the observation to find its z-scored value
%
%%%%% output %%%%%
% zscored_value: zscored value of the observation based on the distribution

%% Function
function zscored_value = NormZScore(distribution, observation)

% compute mean and std of the distribution
ave_dist = []; ave_dist = nanmean(distribution);
std_dist = []; std_dist = nanstd(distribution);

% compute the value of z-score
zscored_value = (observation - ave_dist) ./ std_dist;

end



