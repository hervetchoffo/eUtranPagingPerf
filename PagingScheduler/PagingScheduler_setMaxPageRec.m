function PagingScheduler_setMaxPageRec(this,maxPageRec)
% set the maximum number of paging records in each PCCH message
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.maxPageRec = maxPageRec;
    
else
    fprintf('invalid reference\n');
end

end