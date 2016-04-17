function pmNbPageDropMemFull = PagingPolicer_getPmNbPageDropMemFull(this)
% return the number of paging requests dropped because memory is full
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmNbPageDropMemFull = objects__{this}.pmNbPageDropMemFull;
    
else
    fprintf('invalid reference\n');
end

end