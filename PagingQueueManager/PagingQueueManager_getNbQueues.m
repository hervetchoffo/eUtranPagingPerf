function nbQueues = PagingQueueManager_getNbQueues(this)
% return the number of queues
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    nbQueues = length(objects__{this}.queue);
else
    fprintf('invalid reference\n');
end

end