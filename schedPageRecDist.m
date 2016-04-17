function schedPageRecDist()
% main description here ...
% compute some eUtran paging performance as :
% > scheduled paging records number distribution
% > scheduled paging records delay distribution

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
% nota bene: 
% > nbEvents ~ nbPagingEvents(1+200nB/T/lamda)
% > simulation time ~ 60000 events/min
nbPagingEvents = 100000; % number of paging requests in the simulation
T = sysconst__.defaultPagingCycle.rf128; % number of radio frames/paging cycle
nB = sysconst__.nB.oneT; % nB/T value
lamda = 10:10:100; % arrival rate (pages/s)
maxPageRec = 3; % maximum number of paging records in each PCCH message
maxDelayFactor = 2; % maximum queueing delay of paging requests in term of paging cycles
tho = 0; % radio ressource processing delay in term of TTIs
samplingStep = .001; % sampling step for delay statistics (in seconds)
avgMemoryLoad = .7; % average load for buffer size dimensioning

tDrxCycle = T*sysconst__.rfDuration*sysconst__.TTI; % DRX cycle duration in seconds
maxDelay = maxDelayFactor*tDrxCycle; % maximum queueing delay of paging requests (in seconds)
nbSamples = floor(maxDelay/samplingStep) + 1; % number of sampling values for delay statistics
nbDrxCycleSpl = floor(tDrxCycle/samplingStep) + 1; % number of sampling values in a DRX cycle for delay statistics
bufferSize = ceil((lamda*tDrxCycle/2)/avgMemoryLoad); % maximum number of buffered paging requests (setting according to Little's law)

% run the simulation here ...
datestr(clock)
for i = 1:length(nB)
    for j=1:length(maxPageRec)
        for k=1:length(lamda)
            stats = eUtranPagingPerf(nbPagingEvents,tho,T,maxDelay,samplingStep,nbSamples,lamda(k),nB(i),maxPageRec(j),bufferSize(k));
            
            % scheduled paging records delay distribution
            h = figure;
            hold on;
            plot(stats.schedRecDistDelay.class,stats.schedRecDistDelay.freqDensity,'-b','Linewidth',2);
            plot(stats.schedRecDistDelay.class,[ones(1,nbDrxCycleSpl)/tDrxCycle,zeros(1,nbSamples-nbDrxCycleSpl)],'-k','Linewidth',2);
            xlabel('QUEUEING DELAY (s)');
            ylabel('FREQUENCY DENSITY');
            title({'QUEUEING DELAY FREQUENCY DISTRIBUTION FUNCTION',['Rmax = ',num2str(maxPageRec(j)),' PAGING RECORDS - LAMBDA = ',num2str(lamda(k)),' PAGE/S - nB/T = ',num2str(nB(i)),' - DRX CYCLE = ',num2str(T),' RADIO FRAMES'],['MAX DELAY = ',num2str(maxDelay),'s - MEAN MEMORY LOAD = ',num2str(floor(100*meanMemoryLoad)),'%']});
            legend({'simulation','theory'});
            grid on;
            fileName = ['QUEUEING_DELAY_FREQUENCY_DISTRIBUTION_FUNCTION_Rmax_',num2str(maxPageRec(j)),'PAGEREC_LAMBDA_',num2str(lamda(k)),'PAGEPERSEC_nB_T_',num2str(nB(i)),'_DRX_CYCLE_',num2str(T),'RF_MAX_DELAY_',num2str(maxDelay),'SEC_MEAN_MEMORY_LOAD_',num2str(floor(100*meanMemoryLoad)),'PERCENT'];
            saveas(h,fileName,'jpg');
            saveas(h,fileName,'fig');
            
            % scheduled paging records number distribution
            h = figure;
            hold on;
            I = (lamda(k)/nB(i))*sysconst__.rfDuration*sysconst__.TTI; % average number of candidate paging records per paging occasion
            R = 0:maxPageRec(j); % number of scheduled paging records per paging occasion
            schedRecDistNbProb = exp(-I)*(I.^R)./factorial(R); % scheduled paging records probability distribution function
            schedRecDistNbProb(maxPageRec(j) + 1) = 1 - sum(schedRecDistNbProb(1:maxPageRec(j))); % law of total probability
            bar(stats.schedRecDistNb.val,100*[stats.schedRecDistNb.freq',schedRecDistNbProb']);
            xlabel('SCHEDULED PAGING RECORDS (page/PO)');
            ylabel('FREQUENCY (%)');
            title({'SCHEDULED PAGING RECORDS FREQUENCY DISTRIBUTION FUNCTION',['Rmax = ',num2str(maxPageRec(j)),' PAGING RECORDS - LAMBDA = ',num2str(lamda(k)),' PAGE/S - nB/T = ',num2str(nB(i)),' - DRX CYCLE = ',num2str(T),' RADIO FRAMES'],['MAX DELAY = ',num2str(maxDelay),'s - MEAN MEMORY LOAD = ',num2str(floor(100*meanMemoryLoad)),'%']});
            legend({'simulation','theory'});
            grid on;
            fileName = ['SCHEDULED_PAGING_RECORDS_FREQUENCY_DISTRIBUTION_FUNCTION_Rmax_',num2str(maxPageRec(j)),'PAGEREC_LAMBDA_',num2str(lamda(k)),'PAGEPERSEC_nB_T_',num2str(nB(i)),'_DRX_CYCLE_',num2str(T),'RF_MAX_DELAY_',num2str(maxDelay),'SEC_MEAN_MEMORY_LOAD_',num2str(floor(100*meanMemoryLoad)),'PERCENT'];
            saveas(h,fileName,'jpg');
            saveas(h,fileName,'fig');
            
            datestr(clock)
        end
    end
end

% restore search path here ...
path(PREVIOUSPATH);

end
