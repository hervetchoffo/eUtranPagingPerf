function memoryUsed = PagingQueueManager_getMemoryUsed(this)
% return the current memory usage
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if (~EventScheduler_endOfTimeTable(objects__{this}.timeTable))
        currEventIndex = EventScheduler_getCurrEventIndex(objects__{this}.timeTable);
        if objects__{this}.memoryUsedIndex < currEventIndex
            PagingQueueManager_cleanUpMemory(this);
            objects__{this}.memoryUsedIndex = currEventIndex;
        end
        memoryUsed = objects__{this}.memoryUsed;
    else
        memoryUsed = Inf;
    end
else
    fprintf('invalid reference\n');
end

end