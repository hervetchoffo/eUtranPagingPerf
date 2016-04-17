function PagingPolicer_setQueueManager(this,queueManager)
% set the queue manager reference pointer
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.queueManager = queueManager;
    
else
    fprintf('invalid reference\n');
end

end