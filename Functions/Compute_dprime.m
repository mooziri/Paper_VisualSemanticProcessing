%% Function help
% this function computes the d-prime value between two data distributions
% results are based on "data1 - data2", i.e., positive vlues indicate data1 is
% greater than data2
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: Feb 20, 2024
%
%%%%% input %%%%%
% data1: vector of 1st data distribution
% data2: vector of 2nd data distribution
%
%%%%% output %%%%%
% dprime_value: value of the d-prime

%% Function
function dprime_value = Compute_dprime(data1, data2)

% compute mean of each data distribution
mu1 = nanmean(data1);
mu2 = nanmean(data2);

% compute standard deviation of each data distribution
var1 = (nanstd(data1)) .^2;
var2 = (nanstd(data2)) .^2;

% compute value of the d-prime
dprime_value = (mu1 - mu2) ./ sqrt(.5 * (var1 + var2) );

end



