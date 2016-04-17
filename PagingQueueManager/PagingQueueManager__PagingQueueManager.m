function PagingQueueManager__PagingQueueManager(this)
% destructor of the class PagingQueueManager
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    for i=1:length(objects__{this}.queue)
        deleteobj(objects__{this}.queue(i));
    end
    
    % destructors up chaining
    
    % update reference counters
    releaseobj(objects__{this}.timeTable);
    
else
    fprintf('invalid reference\n');
end

end