%% Function help
% this function computes pairwise phase consistency
% based on: Vinck et al., The pairwise phase consistency: a bias-free
% measure of rhythmic neuronal synchronization, 2010, NeuroImage.
% editted by: Zahra Bahmani, Morteza Mooziri & Ali Samii Moghaddam
% last update: Mar 11, 2024

%%%%% input %%%%%
% phase_val1:
% method:

%%%%% output %%%%%
% ppc_value: phase-locking value

%% Function
function ppc_value = ComputePPC(phase_val,method)

% variables
N = length(phase_val);
if isempty(method); method = 2; end

if N<2
    ppc_value = nan;
    return
end

switch method
    
    case 1
        %%% Method 1: needs more memory
        val_h=[];
        var_h=[]; var_h=cos(phase_val)*cos(phase_val)'+sin(phase_val)*sin(phase_val)';
        var_h_=sum(sum(triu(var_h)))-length(phase_val);
        ppc_value= 2*var_h_/(N*(N-1));
        
    case 2
        %%% Method 2: is faster
        val_h = [];
        for ii = 1 : N-1
            val_h = [val_h nansum(cos(phase_val(ii))*cos(phase_val(ii+1:end))+sin(phase_val(ii))*sin(phase_val(ii+1:end)))];
        end
        ppc_value = 2*nansum(val_h)/(N*(N-1));
        
    case 3
        %%% Method 3: is slow
        val_h=[];
        for ii = 1:N
            for jj = ii+1:N
                val_h = [ val_h cos(phase_val(ii))*cos(phase_val(jj))+sin(phase_val(ii))*sin(phase_val(jj))];
            end
        end
        ppc_value= 2*nansum(val_h)/(N*(N-1));
end

end