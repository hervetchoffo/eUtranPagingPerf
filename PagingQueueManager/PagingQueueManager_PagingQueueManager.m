function PagingQueueManager_PagingQueueManager(this,timeTable,maxQueueSize,nbQueues,maxDelay)
% constructor of the class PagingQueueManager
% PagingQueueManager manages memory used to process paging requests: 
% > enqueues new paging requests in corresponding queues,
% > ensures that paging requests are not delayed more than the specified threshold maxDelay,
global objects__ % objects in the heap
% global sysconst__; % system constants
if thisobj(this)
    if nargin == 1 % default constructor
        % constructors down chaining

        % place your code here ...
        objects__{this}.timeTable = 0; % init reference pointer to the timetable
        objects__{this}.queue = []; % init the queue
        objects__{this}.memoryUsed = Inf; % init the memory state
        objects__{this}.memoryUsedIndex = 0; % init the memory state time index
        objects__{this}.maxDelay = Inf; % init the maximum queueing delay
        
    else
        % constructors down chaining
        
        % place your code here ...
        objects__{this}.timeTable = timeTable;
        objects__{this}.queue = zeros(nbQueues);
        for i=1:nbQueues
            objects__{this}.queue(i) = newobj('Queue',maxQueueSize);
        end
        if (nbQueues > 0) && (maxQueueSize > 0)
            objects__{this}.memoryUsed = 0;
        else
            objects__{this}.memoryUsed = Inf;
        end
        objects__{this}.memoryUsedIndex = 0;
        objects__{this}.maxDelay = maxDelay;
        
        % update reference counters
        holdobj(timeTable);
        
    end
    % init PM counters ...
    objects__{this}.pmNbPageRec = 0; % number of incoming paging records
    objects__{this}.pmNbPageDropDelayExp = 0; % number of paging records dropped because maximum delay reached
else
    fprintf('invalid reference\n');
end

end