function holdobj(this)
% increase the reference counter of the specified object
global objects__ % objects in the heap
if thisobj(this)
    objects__{this}.refcount__ = objects__{this}.refcount__ + 1;
end

end

