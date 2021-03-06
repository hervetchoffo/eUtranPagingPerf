function PagingQueueManager_cleanUpMemory(this,queueNumber)
% clean up memory from paging requests delayed for more than the required
% maximum delay maxDelay
global objects__ % objects in the heap
% global sysconst__; % system constants
if thisobj(this)
    % place your code here ...
    formerMemoryUsed = objects__{this}.memoryUsed; % former memory use to update PM counters
    if nargin == 1 % cleanup all queues (default behavior)
        currTime = EventScheduler_getCurrEventDate(objects__{this}.timeTable);
        minArrTime = currTime - objects__{this}.maxDelay; % minimum arrival time according to maximum delay
        for i=1:length(objects__{this}.queue)
            while (~Queue_isEmpty(objects__{this}.queue(i)))&&(Queue_head(objects__{this}.queue(i)) < minArrTime)
                Queue_dequeue(objects__{this}.queue(i));
                objects__{this}.memoryUsed = objects__{this}.memoryUsed - 1;
            end
        end
    else % cleanup the specified queue
        currTime = EventScheduler_getCurrEventDate(objects__{this}.timeTable);
        minArrTime = currTime - objects__{this}.maxDelay; % minimum arrival time according to maximum delay
        while (~Queue_isEmpty(objects__{this}.queue(queueNumber)))&&(Queue_head(objects__{this}.queue(queueNumber)) < minArrTime)
            Queue_dequeue(objects__{this}.queue(queueNumber));
            objects__{this}.memoryUsed = objects__{this}.memoryUsed - 1;
        end
    end
    objects__{this}.memoryUsedIndex = EventScheduler_getCurrEventIndex(objects__{this}.timeTable);
 
    % update drop PM counters (cause: paging record delay expired)
    objects__{this}.pmNbPageDropDelayExp = objects__{this}.pmNbPageDropDelayExp + (formerMemoryUsed - objects__{this}.memoryUsed);

else
    fprintf('invalid reference\n');
end

end