function isFull = Queue_isFull(this)
% return 1 if the queue is full and 0 otherwise
global objects__ % objects in the heap
if thisobj(this)
    if objects__{this}.tail == length(objects__{this}.tab) % boundaries of "tab" reached
        isFull = objects__{this}.head == 1;
    else
        isFull = objects__{this}.head == (objects__{this}.tail+1);
    end
else
    fprintf('invalid reference\n');
end

end

