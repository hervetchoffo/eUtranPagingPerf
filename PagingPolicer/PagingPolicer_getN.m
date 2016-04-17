function N = PagingPolicer_getN(this)
% return the number of paging frames per paging cycle
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    N = objects__{this}.N;
    
else
    fprintf('invalid reference\n');
end

end