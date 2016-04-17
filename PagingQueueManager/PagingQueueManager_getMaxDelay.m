function maxDelay = PagingQueueManager_getMaxDelay(this)
% return the maximum queueing delay
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    maxDelay = objects__{this}.maxDelay;
else
    fprintf('invalid reference\n');
end

end