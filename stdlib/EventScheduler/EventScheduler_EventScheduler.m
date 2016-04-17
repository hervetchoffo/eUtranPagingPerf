function EventScheduler_EventScheduler(this,varargin)
% constructor of the class EventScheduler
global objects__ % objects in the heap
if thisobj(this)
    if nargin == 1 % default constructor
        % constructors down chaining

        % place your code here ...
        objects__{this}.eventType = [];
        objects__{this}.eventDate = [];
        objects__{this}.currEventIndex = Inf;
        objects__{this}.nbEvents = 0;
        
    else
        % constructors down chaining

        % place your code here ...
        EventScheduler_scheduleEvents(this,varargin{:})
    end
else
    fprintf('invalid reference\n');
end

end