%% Function help
% this function:
% (1) computes spike-phase locking value using PPC method
% (2) reports Rayleigh test for non-uniformity of circular data
% based on:
% (1) Vinck et al., The pairwise phase consistency: a bias-free
%     measure of rhythmic neuronal synchronization, 2010, NeuroImage.
% (2) Berens P. CircStat: a MATLAB toolbox for circular statistics,
%     2009, Journal of statistical software.
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: July 7, 2024
%
%%%%% input %%%%%
% phases:     "N*M" matrix of phase values of the signal, where N is the number
%             of trials and M is the number of timepoints
% spiketimes: "A*B" matrix of spike trains, where A is the number
%             of trials and B is the number of timepoints
%
%%%%% output %%%%%
% rtest_p:   p-value of the Rayleigh test
% rtest_h:   decision of the Rayleigh test, with 1 indicating the rejection
%            of the null hypothesis that "the data is uniformly distributed
%            around the circle"
% spl:       spike-phase locking value
% zs_spl:    z-scored value of spl based on the shuffled distribution
% spl_shuff: distribution of spl values from the shuffling process

%% Function
function [rtest_p, rtest_h, spl, zs_spl, spl_shuff] = ComputeSPL(phases, spiketimes)

% initialize variables
shuff_cycle = 200;
sf_factor = size(spiketimes,2) ./ size(phases,2);

% compute spl
if sum(sum(spiketimes)) < 2
    spl       = nan;
    zs_spl    = nan;
    spl_shuff = nan;
    rtest_p   = nan;
    rtest_h   = nan;
    
else
    % find phase values at the time of each spike
    idx_SpikeTimes = []; phase_val = [];
    for trial_iii = 1 : size(phases,1)
        idx_SpikeTimes = ceil(find(spiketimes(trial_iii,:)) ./ sf_factor);
        phase_val      = [phase_val phases(trial_iii, idx_SpikeTimes)];
    end
    
    % copmute Rayleigh test
    rtest_p = []; rtest_h = 0;
    rtest_p = circ_rtest(phase_val);
    if rtest_p<.05; rtest_h = 1; end
    
    % compute SPL
    spl = [];
    spl = ComputePPC(phase_val,2);
    
    % compute shuffled SPL
    spl_shuff = [];
    for iCycle = 1 : shuff_cycle
        
        % shuffle phase values
        TrInds = []; tpInds = []; shuff_phases = [];
        TrInds = randperm(size(phases,1),size(phases,1));
        tpInds = randperm(size(phases,2),size(phases,2));
        shuff_phases = phases(TrInds,tpInds);
        
        % find phase values at the time of each spike
        idx_SpikeTimes = []; phase_val = [];
        for trial_iii = 1 : size(shuff_phases,1)
            idx_SpikeTimes = ceil(find(spiketimes(trial_iii,:)) ./ sf_factor);
            phase_val      = [phase_val shuff_phases(trial_iii, idx_SpikeTimes)];
        end
        
        % compute SPL
        spl_shuff(iCycle) = ComputePPC(phase_val,2);
    end
    
    % compute z-scored spl
    zs_spl = [];
    zs_spl = NormZScore(spl_shuff, spl);
    
end
end



