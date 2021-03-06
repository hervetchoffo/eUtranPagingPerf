function nbCandidatePageRec = PagingQueueManager_getCandidatePageRec(this,queueNumber,targetDate)
% return the number of paging records still in the specified queue at the
% target date
global objects__ % objects in the heap
% global sysconst__; % system constants
if thisobj(this)
    % place your code here ...
    % compute first the number of leaving paging records
    nbLeavingPageRec = 0;
    minArrDate = targetDate - objects__{this}.maxDelay; % minimum arrival time according to maximum delay
    Queue_iteratorReset(objects__{this}.queue(queueNumber));
    while Queue_iteratorMoveNext(objects__{this}.queue(queueNumber)) && (Queue_iteratorCurrent(objects__{this}.queue(queueNumber)) < minArrDate)
        nbLeavingPageRec = nbLeavingPageRec + 1;
    end
    % deduce then the number of candidate paging records
    nbCandidatePageRec = Queue_size(objects__{this}.queue(queueNumber)) - nbLeavingPageRec;
 
else
    fprintf('invalid reference\n');
end

end