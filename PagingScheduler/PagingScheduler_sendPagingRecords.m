function [outgoingQueue,nbOutgoingPageRec] = PagingScheduler_sendPagingRecords(this)
% send paging records corresponding to the current paging occasion
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if ~isempty(objects__{this}.bookedRes)
        % cleanup the current outgoing queue
        outgoingQueue = objects__{this}.outgoingQueue;
        PagingQueueManager_cleanUpMemory(objects__{this}.queueManager,outgoingQueue);
        % dequeue the scheduled paging records
        nbOutgoingPageRec = objects__{this}.bookedRes(outgoingQueue);
        pageRec = PagingQueueManager_dequeuePageRec(objects__{this}.queueManager,outgoingQueue,nbOutgoingPageRec);
        % move to the next queue
        if objects__{this}.outgoingQueue < length(objects__{this}.bookedRes)
            objects__{this}.outgoingQueue = objects__{this}.outgoingQueue + 1;
        else
            objects__{this}.outgoingQueue = 1;
        end
        
        % update scheduled paging records number and delay PM counters (cause: paging records leaving the system)
        objects__{this}.pmScheduledPageRecNbDist(length(pageRec) + 1) = objects__{this}.pmScheduledPageRecNbDist(length(pageRec) + 1) + 1;
        currTime = EventScheduler_getCurrEventDate(objects__{this}.timeTable);
        nbSamples = length(objects__{this}.pmScheduledPageRecDelayDist);
        for i=1:length(pageRec)
            sample = min(floor((currTime - pageRec(i))/objects__{this}.samplingStep) + 1,nbSamples);
            objects__{this}.pmScheduledPageRecDelayDist(sample) = objects__{this}.pmScheduledPageRecDelayDist(sample) + 1;
        end

    end
else
    fprintf('invalid reference\n');
end

end