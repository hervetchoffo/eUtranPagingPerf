function UE_ID = PagingEventScheduler_getUE_ID(this)
% return the current UE_ID corresponding to the lastest arrival event
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if (~EventScheduler_endOfTimeTable(this)) && (EventScheduler_getCurrEventType(this) == 1)
        currEventIndex = EventScheduler_getCurrEventIndex(this);
        if objects__{this}.UE_IDIndex < currEventIndex
            objects__{this}.UE_ID = floor(1024*rand);
            objects__{this}.UE_IDIndex = currEventIndex;
        end
        UE_ID = objects__{this}.UE_ID;
    else
        UE_ID = Inf;
    end
else
    fprintf('invalid reference\n');
end

end