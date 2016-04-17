function memoryUsedIndex = PagingQueueManager_getMemoryUsedIndex(this)
% return the current memory used index corresponding to the lastest
% time when memory usage was updated
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    memoryUsedIndex = objects__{this}.memoryUsedIndex;
else
    fprintf('invalid reference\n');
end

end