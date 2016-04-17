function queueManager = PagingPolicer_getQueueManager(this)
% return the queue manager reference pointer
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    queueManager = objects__{this}.queueManager;
    
else
    fprintf('invalid reference\n');
end

end