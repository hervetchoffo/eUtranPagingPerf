function deleteobj(this)
% call the appropriate destructor and delete the specified object
global objects__ % objects in the heap
if thisobj(this)
    classname = objects__{this}.class__;
    feval([classname,'__',classname],this); % call of the destructor
    % delete the corresponding object
    deallocref(this);
    objects__{this} = [];
end

end

