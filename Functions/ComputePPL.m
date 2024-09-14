%% Function help
% this function computes phase-phase locking (ppl) value
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: Aug 1, 2024
%
%%%%% input %%%%%
% phases1: "N*F*T" matrix of phase values of the signal 1,
%          (trials*frequencies*timepoints)
% phases2: "N*F*T" matrix of phase values of the signal 2,
%          (trials*frequencies*timepoints)
%
%%%%% output %%%%%
% ppl_vals: phase-phase locking value
% zs_ppls:  shuffle z-scored phase-phase locking value

%% Function
function [ppl_vals,zs_ppls]= ComputePPL(phases1, phases2)

% variables
ppl_vals = []; zs_ppls = []; shuff_ppl = []; shuff_ave = []; shuff_std = [];
cycle_num = 200;

if size(phases1,1) ~= size(phases2,1); return; end
if size(phases1,2) ~= size(phases2,2); return; end
if size(phases1,3) ~= size(phases2,3); return; end

% handle to compute instantaneous ppl
ppl = @(x1,x2) abs(nanmean(exp(1i*(x1-x2))));

% compute SPL
ppl_vals = squeeze(ppl(phases1, phases2));

% compute shuffled SPL
for iCycle = 1 : cycle_num
    shuff_ppl(iCycle,:,:) = ppl(phases1(:,:,randperm(size(phases1,3))), ...
        phases2(:,:,randperm(size(phases2,3))));
end

% shuffle-correction
shuff_ave = squeeze(nanmean(shuff_ppl, 1));
shuff_std = squeeze(nanstd(shuff_ppl, [], 1));
zs_ppls = (ppl_vals - shuff_ave) ./ shuff_std;

end



