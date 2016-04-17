function pmNbPageReq = PagingPolicer_getPmNbPageReq(this)
% return the number of incoming paging requests
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmNbPageReq = objects__{this}.pmNbPageReq;
    
else
    fprintf('invalid reference\n');
end

end