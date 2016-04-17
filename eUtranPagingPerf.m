function stats = eUtranPagingPerf(nbPagingEvents,tho,T,maxDelay,samplingStep,nbSamples,lamda,nB,maxPageRec,bufferSize)
% main description here ...
% compute some eUtran paging performance as :
% > memory usage and related drops
% > queueing delay and related drops
% > scheduled paging records and related blocking
% > eUtran paging efficiency

% inputs description here ...
% > nbPagingEvents is the number of paging requests in the simulation
% > tho is the radio ressource processing delay in term of TTIs
% > T is the number of radio frames/paging cycle
% > maxDelay is the maximum queueing delay of paging requests (in seconds)
% > samplingStep is the sampling step for delay statistics (in seconds)
% > nbSamples is the number of sampling values for delay statistics
% > lamda is the arrival rate (pages/s)
% > nB sets nB/T
% > maxPageRec is the maximum number of paging records in each PCCH message (maxPageRec <= 16)
% > bufferSize is the maximum number of buffered paging requests

% outputs description here ...
% > stats.pageDropMemFullRatio gives the ratio of dropped paging requests
% due to lack of memory (%)
% > stats.memUseAverage gives the average number of queued paging records
% > stats.pageDropDelayExpRatio gives the ratio of dropped paging requests
% due to queueing delay exceeding the maxDelay threshold (%)
% > stats.pageBlkRatio gives the blocking rate (%)
% > stats.schedRecDistNb.val gives the number of scheduled paging records 
% > stats.schedRecDistNb.freq gives the scheduled paging records number distribution
% > stats.schedRecDistNb.mean gives the average number of scheduled paging records
% > stats.schedRecDistDelay.class gives the paging records delay sampling classes
% > stats.schedRecDistDelay.val gives the paging records delay sampling values
% > stats.schedRecDistDelay.freqDensity gives the paging records delay frequency distribution
% > stats.schedRecDistDelay.mean gives the average paging records delay
% > stats.eUtranPagingEfficiency gives the eUTRAN paging efficiency (%) i.e.
% ratio of incoming paging requests not dropped

% simulation running here ...
timeTable = newobj('PagingEventScheduler',lamda,nB,T,tho,nbPagingEvents); % timetable of the simulation
queueManager = newobj('PagingQueueManager',timeTable,bufferSize,nB*T,maxDelay); % manage memory related to paging requests processing
policer = newobj('PagingPolicer',timeTable,queueManager,bufferSize,nB,T); % policer doing admission control on paging requests
scheduler = newobj('PagingScheduler',timeTable,queueManager,tho,maxPageRec,samplingStep,nbSamples); % scheduler booking radio resources to send paging records

while ~EventScheduler_endOfTimeTable(timeTable) % events loop
    eventType = EventScheduler_getCurrEventType(timeTable);
    switch eventType
        case 1 % new paging request
            %eventDate = EventScheduler_getCurrEventDate(timeTable);
            %fprintf(['new paging request @',num2str(eventDate),' : '])
            PagingPolicer_processPagingRequest(policer); %queueNumber = PagingPolicer_processPagingRequest(policer);
            %fprintf(['queueNumber = ',num2str(queueNumber),'\n'])
        case 2 % new scheduling event
            %eventDate = EventScheduler_getCurrEventDate(timeTable);
            %fprintf(['new scheduling request @',num2str(eventDate),' : '])
            PagingScheduler_schedulePagingRecords(scheduler); %[bookingQueue,nbCandidatePageRec,nbScheduledPageRec] = PagingScheduler_schedulePagingRecords(scheduler);
            %fprintf(['bookingQueue = ',num2str(bookingQueue),', nbCandidatePageRec = ',num2str(nbCandidatePageRec),', nbScheduledPageRec = ',num2str(nbScheduledPageRec),'\n'])
        case 3 % new paging occasion
            %eventDate = EventScheduler_getCurrEventDate(timeTable);
            %fprintf(['new paging occasion @',num2str(eventDate),' : '])
            PagingScheduler_sendPagingRecords(scheduler); %[outgoingQueue,nbOutgoingPageRec] = PagingScheduler_sendPagingRecords(scheduler);
            %fprintf(['outgoingQueue = ',num2str(outgoingQueue),', nbOutgoingPageRec = ',num2str(nbOutgoingPageRec),'\n'])
        otherwise
            fprintf('unknown event\n')
    end
    EventScheduler_nextEvent(timeTable);
end

% compute your ouputs here ...
% policer performance monitoring statistics
stats.pageDropMemFullRatio = 100*PagingPolicer_getPmNbPageDropMemFull(policer)/PagingPolicer_getPmNbPageReq(policer);
stats.memUseAverage = PagingPolicer_getPmCumMemUsed(policer)/PagingPolicer_getPmNbPageReq(policer);

% queue manager performance monitoring statistics
stats.pageDropDelayExpRatio = 100*PagingQueueManager_getPmNbPageDropDelayExp(queueManager)/PagingQueueManager_getPmNbPageRec(queueManager);

% scheduler performance monitoring statistics
stats.pageBlkRatio = 100*PagingScheduler_getPmNbCandidatePageRecBlk(scheduler)/PagingScheduler_getPmNbCandidatePageRec(scheduler);
pmScheduledPageRecNbDist = PagingScheduler_getPmScheduledPageRecNbDist(scheduler);
pmScheduledPageRecDelayDist = PagingScheduler_getPmScheduledPageRecDelayDist(scheduler);
stats.schedRecDistNb.val = 0:maxPageRec;
stats.schedRecDistNb.freq = pmScheduledPageRecNbDist/sum(pmScheduledPageRecNbDist);
stats.schedRecDistNb.mean = sum(stats.schedRecDistNb.val.*stats.schedRecDistNb.freq);
stats.schedRecDistDelay.class = 0:samplingStep:((nbSamples-1)*samplingStep);
stats.schedRecDistDelay.val = stats.schedRecDistDelay.class + samplingStep/2;
stats.schedRecDistDelay.freqDensity = (pmScheduledPageRecDelayDist/sum(pmScheduledPageRecDelayDist))/samplingStep;
stats.schedRecDistDelay.mean = sum(stats.schedRecDistDelay.val.*stats.schedRecDistDelay.freqDensity)*samplingStep;

% eUtran paging efficiency
stats.eUtranPagingEfficiency = 100*(PagingScheduler_getPmNbCandidatePageRec(scheduler)-PagingScheduler_getPmNbCandidatePageRecBlk(scheduler))/PagingPolicer_getPmNbPageReq(policer);

% free memory
deleteobj(scheduler);
deleteobj(policer);
deleteobj(queueManager);
deleteobj(timeTable);

end