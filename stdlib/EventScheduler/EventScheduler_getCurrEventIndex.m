function currEventIndex = EventScheduler_getCurrEventIndex(this)
% return the current event index
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    currEventIndex = objects__{this}.currEventIndex;
else
    fprintf('invalid reference\n');
end

end