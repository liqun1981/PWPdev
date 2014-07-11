% main pwp model module


%tic
%t0 = clock;

%
% -------------------------------------------------------------------------
% Initialize model parameters
% -------------------------------------------------------------------------

iniparams;
% inihydrors97;
inihydrors_hawaii;
inifloatdata;
iniforcing;
inifctraquik;               % Initialize useful factors
inibio;                     % initialze biological parameters
inio2isotopes;              % initialize oxygen isotope parameters
initracers;



% -------------------------------------------------------------------------
% Main time step loop
% -------------------------------------------------------------------------
for it=1:nt
    T(1)=T(1)+thf(it);		% add sensible + latent heat flux
    S(1)=S(1)*FWFlux(it);   % alter salinity due to precip/evap
    S=S+hsc;                % add horizontal eddy salt convergence
    if rst_ON_OFF > 0
        restoreS;           % restoring salinity
    end
    T=T+rhf(it)*dRdz;       % add radiant heat to profile
    T=T+hhc;                % add horizontal eddy heat convergence
    if rst_ON_OFF > 0
        restoreT;           % restoring temperature
    end
    dogasheatcorr;          % maintain gas sat. when heat is added
    dostins;                % do static instability adjustment
    addmom;                 % add wind stress induced momentum
    dobrino;                % do bulk Ri No Adjustment
    dolight;                % calculate light field; adjust light according
                            % to observed isopycnal displacement
    oxyprod;                % add biological oxygen
    gasexchak;              % exchange gases
    dogrino;                % do gradient  Ri No Adjustment
    advdif;                 % advect and diffuse
    if floatON_OFF ~= 0, modelout; end    % if time, save data
    dooutput;
    
end

%etime(clock,t0)/60

%toc