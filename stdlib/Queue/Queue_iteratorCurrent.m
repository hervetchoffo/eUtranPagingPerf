function currValue = Queue_iteratorCurrent(this)
% return the queued value matching the current iterator
global objects__ % objects in the heap
if thisobj(this)
    currValue = objects__{this}.tab(objects__{this}.iterator);
else
    fprintf('invalid reference\n');
end

end