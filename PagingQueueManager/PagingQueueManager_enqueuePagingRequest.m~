function PagingQueueManager_enqueuePagingRequest(this,queueNumber)
% enqueue the current paging request into the specified queue by the PagingPolicer
global objects__ % objects in the heap
% global sysconst__; % system constants
if thisobj(this)
    % place your code here ...
    currEventDate = EventScheduler_getCurrEventDate(objects__{this}.timeTable);
    Queue_enqueue(objects__{this}.queue(queueNumber),currEventDate);
    objects__{this}.memoryUsed = objects__{this}.memoryUsed + 1;
    objects__{this}.memoryUsedIndex = EventScheduler_getCurrEventIndex(objects__{this}.timeTable);
    
    % update PM counters
    objects__{this}.pmNbPageRec = objects__{this}.pmNbPageRec + 1;
    
else
    fprintf('invalid reference\n');
end

end