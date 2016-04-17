function nbEvents = EventScheduler_getNbEvents(this)
% return the number of events being scheduled
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    nbEvents = objects__{this}.nbEvents;
else
    fprintf('invalid reference\n');
end

end