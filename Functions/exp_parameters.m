%% Function help
% this function initializes the experiment parameters
% written by: Morteza Mooziri & Ali Samii Moghaddam
% last update: Mar 01, 2024

%%%%% Input %%%%%
% none

%%%%% Output %%%%%
% exp_params: structure containing important parameters of the experiment

%% Function
function exp_params = exp_parameters()

%% recording
exp_params.fs_EEG = 200; % sampling frequency for EEG data
exp_params.fs_iEEG = 2000; % sampling frequency for iEEG data

%% timing
exp_params.TimeResolution = 1000; % to make time resolution as "ms"
exp_params.BaselineTime = 1; % duration of fixation period in secs
exp_params.EncodeTime = 2; % duration of encoding period in secs
exp_params.MaintenanceTime = 3; % duration of maintenance period in secs
exp_params.RetrievalTime = 2; % duration of retrieval period in secs
exp_params.PreProbeTime = 6; % duration of time from trial start to probe onset in secs
exp_params.TrialDuration = 8; % total duration of each trial in secs

% time-stamps for each trial (relative to probe onset) in ms
exp_params.TimeStamps = [0.001 : 1/exp_params.TimeResolution : exp_params.TrialDuration] - exp_params.PreProbeTime;
exp_params.TimeStamps_EEG = [1./exp_params.fs_EEG:1./exp_params.fs_EEG:exp_params.TrialDuration] - exp_params.PreProbeTime;
exp_params.TimeStamps_iEEG = [1./exp_params.fs_EEG:1./exp_params.fs_iEEG:exp_params.TrialDuration] - exp_params.PreProbeTime;

end


