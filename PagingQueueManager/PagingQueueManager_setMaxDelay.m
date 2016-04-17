function PagingQueueManager_setMaxDelay(this,maxDelay)
% set the maximum queueing delay
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.maxDelay = maxDelay;
else
    fprintf('invalid reference\n');
end

end