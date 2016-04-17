function EventScheduler_nextEvent(this)
% step to the next scheduled event
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if objects__{this}.currEventIndex < objects__{this}.nbEvents
        objects__{this}.currEventIndex = objects__{this}.currEventIndex + 1;
    else
        objects__{this}.currEventIndex = Inf;
    end
else
    fprintf('invalid reference\n');
end

end