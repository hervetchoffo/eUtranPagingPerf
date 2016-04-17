function currEventType = EventScheduler_getCurrEventType(this)
% return the current event type
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if objects__{this}.currEventIndex < Inf
        currEventType = objects__{this}.eventType(objects__{this}.currEventIndex);
    else
        currEventType = Inf;
    end
else
    fprintf('invalid reference\n');
end

end
