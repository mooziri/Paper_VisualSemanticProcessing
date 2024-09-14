%% Function help
% this function computes wavelet transform
% written by: Morteza Mooziri & Ali Samii Moghaddam
% based on: Cohen MX, "Analyzing Neural Time Series Data", 2014, MIT Press.
% last update: Apr 04, 2024
% 
%%%%% input %%%%%
% sig:   signal time series (trials * timepoints)
% freqs: center frequencies for wavelent transform
% fs:    sampling frequency of the signal
% 
%%%%% output %%%%%
% analytic_sig: the complex value analytic signal
% freqs:        center frequencies for wavelent transform

%% Funcion
function [analytic_sig, freqs] = ma_wavelet(sig, freqs, fs)

% define sampling frequency, in case it is empty
if isempty(fs); fs = 2000; end

% define freqs, in case it is empty
if isempty(freqs); freqs = [1:30 35:5:120]; end

% zero padding
pad_pnt = 1000;
sig_pad = [];
for iTrial = 1 : size(sig,1)
    sig_pad = [sig_pad [zeros(1,pad_pnt) (sig(iTrial,:)) zeros(1,pad_pnt)]];
end

% number of cycles on either end of the center point (1 means a total of 2 cycles))
pnts = size(sig,2) + 2 * pad_pnt;
TrialNum = size(sig,1);

% wavelet and FFT parameters
time = -1:1/fs:1;
half_wavelet = (length(time)-1)/2;

num_ = 7;
num_cycles = num_ * ones(1,length(freqs)); % fixed number of cycles for all freqs
% num_cycles = logspace(log10(4),log10(8),length(freqs)); % appropriate number of cycles for every freq

% number of points
n_wavelet = length(time);
n_data = pnts * TrialNum;
n_convolution = n_wavelet + n_data - 1;

% data FFTs
Data_FFT = fft(reshape(sig_pad,1,n_data),n_convolution);
analytic_sig_h = [];

% loop over frequencies
for iFreq = 1 : length(freqs)
    
    % create wavelet and compute FFT
    s = num_cycles(iFreq)/(2*pi*freqs(iFreq));
    wavelet_fft = fft( exp(2*1i*pi*freqs(iFreq).*time) .* exp(-time.^2./(2*(s^2))) ,n_convolution);
    
    % multiply kernel & signal in frequency domain (i.e, convolution in time domain)
    ConvResultFFT= ifft(wavelet_fft.*Data_FFT,n_convolution);
    ConvResultFFT = ConvResultFFT(half_wavelet+1:end-half_wavelet);
    A_sig_h =[]; A_sig_h = reshape(ConvResultFFT,pnts,TrialNum);
    
    analytic_sig_h(:,iFreq,:)=((A_sig_h))';
     
end

analytic_sig = analytic_sig_h(:,:,pad_pnt+1:end-pad_pnt);

end



