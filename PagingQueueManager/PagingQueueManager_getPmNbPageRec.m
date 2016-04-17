function pmNbPageRec = PagingQueueManager_getPmNbPageRec(this)
% return the number of incoming paging records
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmNbPageRec = objects__{this}.pmNbPageRec;
else
    fprintf('invalid reference\n');
end

end