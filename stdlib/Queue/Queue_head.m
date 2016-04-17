function x = Queue_head(this)
% return the head of the queue
global objects__ % objects in the heap
if thisobj(this)
    x = objects__{this}.tab(objects__{this}.head);
else
    fprintf('invalid reference\n');
end

end

