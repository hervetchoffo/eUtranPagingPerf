function EventScheduler_scheduleEvents(this,varargin)
% use this code to schedule events according to their trigger times
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    
    % step 1 - merge all events

    objects__{this}.nbEvents = 0;
    nbEventTypes = length(varargin);
    thresholds = zeros(1,1+nbEventTypes);
  
    for i=1:nbEventTypes
        objects__{this}.nbEvents = objects__{this}.nbEvents + length(varargin{i});
        thresholds(i+1) = objects__{this}.nbEvents;
    end

    buffer=zeros(1,objects__{this}.nbEvents);

    for i=1:nbEventTypes
        buffer(1+thresholds(i):thresholds(i+1)) = varargin{i};
    end

    % step 2 - sort all events

    [objects__{this}.eventDate,eventIndex] = sort(buffer);
    objects__{this}.eventType = zeros(size(eventIndex));

    for i=1:nbEventTypes
        objects__{this}.eventType(eventIndex>thresholds(i) & eventIndex<=thresholds(i+1))=i;
    end
    
    % step 3 - init the event scheduler
    
    if objects__{this}.nbEvents > 0
        objects__{this}.currEventIndex = 1;
    else
        objects__{this}.currEventIndex = Inf;
    end

else
    fprintf('invalid reference\n');
end

end