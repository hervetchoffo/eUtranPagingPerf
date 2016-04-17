function currEventDate = EventScheduler_getCurrEventDate(this)
% return the current event date
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    if objects__{this}.currEventIndex < Inf
        currEventDate = objects__{this}.eventDate(objects__{this}.currEventIndex);
    else
        currEventDate = Inf;
    end
else
    fprintf('invalid reference\n');
end

end
