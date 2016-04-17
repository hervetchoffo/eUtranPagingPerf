function [bookingQueue,nbCandidatePageRec,nbScheduledPageRec] = PagingScheduler_schedulePagingRecords(this)
% schedule paging records before corresponding paging occasion i.e. taking
% into account the radio resource processing delay (tho)
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if ~isempty(objects__{this}.bookedRes)
        % get the number of candidate paging records i.e. present in the
        % system when corresponding paging occasion occurs
        pagingOccasionEventDate = EventScheduler_getCurrEventDate(objects__{this}.timeTable) + objects__{this}.tho;
        bookingQueue = objects__{this}.bookingQueue;
        nbCandidatePageRec = PagingQueueManager_getCandidatePageRec(objects__{this}.queueManager,bookingQueue,pagingOccasionEventDate);
        % book resources in the limit of maxPageRec
        nbScheduledPageRec = min(nbCandidatePageRec,objects__{this}.maxPageRec);
        objects__{this}.bookedRes(bookingQueue) = nbScheduledPageRec;
        % move to the next queue
        if objects__{this}.bookingQueue < length(objects__{this}.bookedRes)
            objects__{this}.bookingQueue = objects__{this}.bookingQueue + 1;
        else
            objects__{this}.bookingQueue = 1;
        end
        
        % update blocking PM counters (cause: maximum number of paging records reached)
        objects__{this}.pmNbCandidatePageRec = objects__{this}.pmNbCandidatePageRec + nbCandidatePageRec;
        objects__{this}.pmNbCandidatePageRecBlk = objects__{this}.pmNbCandidatePageRecBlk + max(nbCandidatePageRec - objects__{this}.maxPageRec,0);
        
    end
else
    fprintf('invalid reference\n');
end

end