function pmScheduledPageRecNbDist = PagingScheduler_getPmScheduledPageRecNbDist(this)
% return the scheduled paging records number distribution
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmScheduledPageRecNbDist = objects__{this}.pmScheduledPageRecNbDist;
else
    fprintf('invalid reference\n');
end

end