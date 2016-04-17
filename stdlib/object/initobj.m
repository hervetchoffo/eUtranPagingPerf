function initobj(maxRef)
% init the reference queue of objects in the heap
global tab__ head__ tail__ objects__ % properties of the references queue
if nargin == 0
    tab__ = 1:intmax('uint16'); % table containing the queue
    head__ = 1; % queue head pointer
    tail__ = intmax('uint16'); % queue tail pointer
    objects__ = cell(1,intmax('uint16')-1); % objects in the heap
else
    tab__ = 1:(maxRef+1);
    head__ = 1;
    tail__ = maxRef+1;
    objects__ = cell(1,maxRef);
end

end

