function PagingQueueManager_initQueues(this,maxQueueSize,nbQueues)
% init the queues
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if nargin == 1
        objects__{this}.queue = []; % init the queue
        objects__{this}.memoryUsed = Inf; % init the memory state
        objects__{this}.memoryUsedIndex = 0; % init the memory state time index        
    else
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
    end
else
    fprintf('invalid reference\n');
end

end