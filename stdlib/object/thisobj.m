function isObj = thisobj(this)
% return 1 if "this" is a valid reference and 0 otherwise
global objects__ % objects in the heap
isObj = (this >= 1)&&(this <= length(objects__))&&(~isempty(objects__{this}));

end

