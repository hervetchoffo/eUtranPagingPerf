function this = newobj(classname,varargin)
% create a new object and call the class constructor
global objects__ % objects in the heap
this = allocref();
if this == 0 % reference unavailable
    fprintf('reference unavailable\n');
else
    objects__{this}.refcount__ = 1;
    objects__{this}.class__ = classname;
    feval([classname,'_',classname],this,varargin{:}); % call of the class constructor
end

end

