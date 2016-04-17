function movingNext = Queue_iteratorMoveNext(this)
% move the iterator of the queue to the next element
global objects__ % objects in the heap
if thisobj(this)
    if objects__{this}.iterator < length(objects__{this}.tab)
        nextIteratorValue = objects__{this}.iterator + 1;
    else
        nextIteratorValue = 1;
    end
    if nextIteratorValue == objects__{this}.tail
        movingNext = false;
    else
        movingNext = true;
        objects__{this}.iterator = nextIteratorValue;
    end
else
    fprintf('invalid reference\n');
end

end