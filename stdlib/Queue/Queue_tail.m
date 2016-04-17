function x = Queue_tail(this)
% return the tail of the queue
global objects__ % objects in the heap
if thisobj(this)
    if objects__{this}.tail > 1
        x = objects__{this}.tab(objects__{this}.tail-1);
    else
        x = objects__{this}.tab(length(objects__{this}.tab));
    end
else
    fprintf('invalid reference\n');
end

end

