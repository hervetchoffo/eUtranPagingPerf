function Queue_enqueue(this,x)
% insert the specified element at the tail of the queue
global objects__ % objects in the heap
if thisobj(this)
    if ~Queue_isFull(this) % the queue is not full
        objects__{this}.tab(objects__{this}.tail) = x;
        % we modify the boundaries of the queue in the table thanks to pointers
        if objects__{this}.tail == length(objects__{this}.tab) % boundaries of "tab" reached
            objects__{this}.tail = 1;
        else
            objects__{this}.tail = objects__{this}.tail + 1;
        end
    else
        fprintf('the queue is full\n');
    end
else
    fprintf('invalid reference\n');
end

end

