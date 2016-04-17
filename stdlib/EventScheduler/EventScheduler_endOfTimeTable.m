function isEnd = EventScheduler_endOfTimeTable(this)
% return 1 when simulation ends and 0 otherwise
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    isEnd = objects__{this}.currEventIndex == Inf;
else
    fprintf('invalid reference\n');
end

end