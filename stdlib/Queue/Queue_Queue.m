function Queue_Queue(this,maxQueueSize)
% constructor of the class Queue
global objects__ % objects in the heap
if thisobj(this)
    if nargin == 1 % default constructor
        objects__{this}.tab = zeros(1,intmax('uint16')); % table containing the queue
        objects__{this}.head = 1; % head pointer of the queue
        objects__{this}.tail = 1; % tail pointer of the queue
        objects__{this}.iterator = length(objects__{this}.tab); % circular iterator of the queue
    else
        objects__{this}.tab = zeros(1,maxQueueSize+1); % table containing the queue
        objects__{this}.head = 1; % head pointer of the queue
        objects__{this}.tail = 1; % tail pointer of the queue
        objects__{this}.iterator = length(objects__{this}.tab); % circular iterator of the queue
    end
else
    fprintf('invalid reference\n');
end

end

