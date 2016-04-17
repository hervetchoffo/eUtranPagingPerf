function tho = PagingScheduler_getTho(this)
% return the radio resource processing delay
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    tho = objects__{this}.tho;
    
else
    fprintf('invalid reference\n');
end

end