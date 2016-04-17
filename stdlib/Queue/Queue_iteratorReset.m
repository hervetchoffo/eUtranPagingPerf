function Queue_iteratorReset(this)
% reset the iterator of the queue
global objects__ % objects in the heap
if thisobj(this)
    if objects__{this}.head > 1
        objects__{this}.iterator = objects__{this}.head - 1;
    else
        objects__{this}.iterator = length(objects__{this}.tab);
    end
else
    fprintf('invalid reference\n');
end

end