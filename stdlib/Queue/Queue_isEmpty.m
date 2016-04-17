function isEmpty = Queue_isEmpty(this)
% return 1 if the queue is empty and 0 otherwise
global objects__ % objects in the heap
if thisobj(this)
    isEmpty = objects__{this}.tail == objects__{this}.head;
else
    fprintf('invalid reference\n');
end

end

