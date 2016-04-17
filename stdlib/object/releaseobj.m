function releaseobj(this)
% decrease the reference counter and delete the specified object if needed
global objects__ % objects in the heap
if thisobj(this)
    objects__{this}.refcount__ = objects__{this}.refcount__ - 1;
    if objects__{this}.refcount__ == 0
        deleteobj(this);
    end
end

end