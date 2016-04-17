function x = Queue_dequeue(this)
% return and delete the element at the head of the queue
global objects__ % objects in the heap
if thisobj(this)
    if ~Queue_isEmpty(this) % the queue is not empty
        x = objects__{this}.tab(objects__{this}.head);
        % we modify the boundaries of the queue in the table thanks to pointers
        if objects__{this}.head == length(objects__{this}.tab) % boundaries of "tab" reached
            objects__{this}.head = 1;
        else
            objects__{this}.head = objects__{this}.head + 1;
        end
    else
        x = [];
    end
else
    fprintf('invalid reference\n');
end

end

