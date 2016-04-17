function pageRec = PagingQueueManager_dequeuePageRec(this,queueNumber,dequeueNumber)
% dequeue the specified queue from the required number of paging records
global objects__ % objects in the heap
% global sysconst__; % system constants
if thisobj(this)
    % place your code here ...
    dequeueNumber = min(dequeueNumber,Queue_size(objects__{this}.queue(queueNumber))); % taking into account available records in the queue
    pageRec = zeros(1,dequeueNumber); % list of paging records leaving the queue
    for i=1:dequeueNumber
        pageRec(i) = Queue_dequeue(objects__{this}.queue(queueNumber));
    end
    objects__{this}.memoryUsed = objects__{this}.memoryUsed - dequeueNumber;
    objects__{this}.memoryUsedIndex = EventScheduler_getCurrEventIndex(objects__{this}.timeTable);
 
else
    fprintf('invalid reference\n');
end

end