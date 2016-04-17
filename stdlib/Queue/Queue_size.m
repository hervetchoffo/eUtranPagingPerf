function x = Queue_size(this)
% return the current size of the queue
global objects__ % objects in the heap
if thisobj(this)
    if objects__{this}.head <= objects__{this}.tail
        x = objects__{this}.tail - objects__{this}.head;
    else
        x  = length(objects__{this}.tab) - (objects__{this}.head - objects__{this}.tail);
    end
else
    fprintf('invalid reference\n');
end

end

