function PagingScheduler_setQueueManager(this,queueManager)
% set the queue manager reference pointer
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.queueManager = queueManager;
    objects__{this}.bookedRes = zeros(1,PagingQueueManager_getNbQueues(queueManager));
    if isempty(objects__{this}.bookedRes)
        objects__{this}.outgoingQueue = 0;
        objects__{this}.bookingQueue = 0;
    else
        objects__{this}.outgoingQueue = 1;
        objects__{this}.bookingQueue = 1;
    end
    
else
    fprintf('invalid reference\n');
end

end