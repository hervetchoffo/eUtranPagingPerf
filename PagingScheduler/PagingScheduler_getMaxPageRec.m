function maxPageRec = PagingScheduler_getMaxPageRec(this)
% return the maximum number of paging records in each PCCH message
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    maxPageRec = objects__{this}.maxPageRec;
    
else
    fprintf('invalid reference\n');
end

end