function PagingScheduler__PagingScheduler(this)
% destructor of the class PagingScheduler
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    
    % destructors up chaining
    
    % update reference counters
    releaseobj(objects__{this}.timeTable);
    releaseobj(objects__{this}.queueManager);
    
else
    fprintf('invalid reference\n');
end

end