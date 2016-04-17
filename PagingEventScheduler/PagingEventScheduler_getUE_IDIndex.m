function UE_IDIndex = PagingEventScheduler_getUE_IDIndex(this)
% return the current UE_ID index corresponding to the lastest arrival event
% index in the event scheduler
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    UE_IDIndex = objects__{this}.UE_IDIndex;
else
    fprintf('invalid reference\n');
end

end