function blockingRate()
% main description here ...
% > compute eUtran paging blocking rate
% > compute eUtran paging efficiency

% update namespaces here ...
USERPATH = userpath;
USERPATH(length(USERPATH))= filesep;
PREVIOUSPATH = addpath(genpath(cd)); % include project namespace

% define system constants here ...
global sysconst__;
sysconst__.TTI = .001;
sysconst__.rfDuration = 10;
sysconst__.defaultPagingCycle.rf32 = 32;
sysconst__.defaultPagingCycle.rf64 = 64;
sysconst__.defaultPagingCycle.rf128 = 128;
sysconst__.defaultPagingCycle.rf256 = 256;
sysconst__.defaultPagingCycle.val = [32,64,128,256];
sysconst__.nB.fourT = 4;
sysconst__.nB.twoT = 2;
sysconst__.nB.oneT = 1;
sysconst__.nB.halfT = 1/2;
sysconst__.nB.quarterT = 1/4;
sysconst__.nB.oneEighthT = 1/8;
sysconst__.nB.oneSixteenthT = 1/16;
sysconst__.nB.oneThirtySecondT = 1/32;
sysconst__.nB.val = [1/32,1/16,1/8,1/4,1/2,1,2,4];
sysconst__.maxPageRec = 16;
sysconst__.pagingOccasionNumber = [9,0,0,0;
                                   4,9,0,0;
                                   0,4,5,9];

% init queue of objects references in the heap here ...
initobj();

% place your code here ...

% place your inputs here ...
% nota bene: nbEvents ~ nbPagingEvents(1+200nB/T/lamda)
nbPagingEvents = 100000; % number of paging requests in the simulation
T = sysconst__.defaultPagingCycle.rf128; % number of radio frames/paging cycle
nB = sysconst__.nB.oneT; % nB/T value
lamda = 10:10:100; % arrival rate (pages/s)
maxPageRec = 3; % maximum number of paging records in each PCCH message
maxDelayFactor = 2; % maximum queueing delay of paging requests in term of paging cycles
tho = 0; % radio ressource processing delay in term of TTIs
samplingStep = .001; % sampling step for delay statistics (in seconds)
avgMemoryLoad = .5; % average load for buffer size dimensioning

tDrxCycle = T*sysconst__.rfDuration*sysconst__.TTI; % DRX cycle duration in seconds
maxDelay = maxDelayFactor*tDrxCycle; % maximum queueing delay of paging requests (in seconds)
nbSamples = floor(maxDelay/samplingStep) + 1; % number of sampling values for delay statistics
bufferSize = ceil((lamda*tDrxCycle/2)/avgMemoryLoad); % maximum number of buffered paging requests (setting according to Little's law)
styleString = {'-','--',':','-.'}; % style string for output plots
colorString = 'kymcrgb'; % color string for output plots

% run the simulation here ...
datestr(clock)
for i=1:length(nB)
    pageBlkRatio = zeros(length(maxPageRec),length(lamda));
    eUtranPagingEfficiency = zeros(length(maxPageRec),length(lamda));
    for j=1:length(maxPageRec)
        for k=1:length(lamda)
            stats = eUtranPagingPerf(nbPagingEvents,tho,T,maxDelay,samplingStep,nbSamples,lamda(k),nB(i),maxPageRec(j),bufferSize(k));
            pageBlkRatio(j,k) = stats.pageBlkRatio;
            eUtranPagingEfficiency(j,k) = stats.eUtranPagingEfficiency;
            datestr(clock)
        end
    end

    % compute your ouputs here ...
    
    % blocking rate
    h = figure;
    hold on;
    for j=1:length(maxPageRec)
        plot(lamda,pageBlkRatio(j,:),[styleString{mod(floor((j-1)/7),4)+1},colorString(mod((j-1),7)+1)],'Linewidth',2);
    end
    xlabel('PAGING REQUESTS RATE (page/s)');
    ylabel('PAGING BLOCKING RATE (%)');
    title({'PAGING BLOCKING VS. ARRIVAL RATE',['nB/T = ',num2str(nB(i)),' - DRX CYCLE = ',num2str(T),' RADIO FRAMES'],['MAX DELAY = ',num2str(maxDelay),'s - MEAN MEMORY LOAD = ',num2str(floor(100*avgMemoryLoad)),'%']});
    legend(strcat({'Rmax = '},num2str(maxPageRec')));
    grid on;
    fileName = ['PAGING_BLOCKING_VS_ARRIVAL_RATE_nB_T_',num2str(32*nB(i)),'_32EME_DRX_CYCLE_',num2str(T),'RF_MAX_DELAY_',num2str(maxDelay),'s_MEAN_MEMORY_LOAD_',num2str(floor(100*avgMemoryLoad))];
    saveas(h,fileName,'jpg');
    saveas(h,fileName,'fig');
    
    % paging efficiency
    h = figure;
    hold on;
    for j=1:length(maxPageRec)
        plot(lamda,eUtranPagingEfficiency(j,:),[styleString{mod(floor((j-1)/7),4)+1},colorString(mod((j-1),7)+1)],'Linewidth',2);
    end
    xlabel('PAGING REQUESTS RATE (page/s)');
    ylabel('PAGING EFFICIENCY (%)');
    title({'PAGING EFFICIENCY VS. ARRIVAL RATE',['nB/T = ',num2str(nB(i)),' - DRX CYCLE = ',num2str(T),' RADIO FRAMES'],['MAX DELAY = ',num2str(maxDelay),'s - MEAN MEMORY LOAD = ',num2str(floor(100*avgMemoryLoad)),'%']});
    legend(strcat({'Rmax = '},num2str(maxPageRec')));
    grid on;
    fileName = ['PAGING_EFFICIENCY_VS_ARRIVAL_RATE_nB_T_',num2str(32*nB(i)),'_32EME_DRX_CYCLE_',num2str(T),'RF_MAX_DELAY_',num2str(maxDelay),'s_MEAN_MEMORY_LOAD_',num2str(floor(100*avgMemoryLoad))];
    saveas(h,fileName,'jpg');
    saveas(h,fileName,'fig');   
end

% restore search path here ...
path(PREVIOUSPATH);

end
