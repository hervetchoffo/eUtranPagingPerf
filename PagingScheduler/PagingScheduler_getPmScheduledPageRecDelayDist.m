function pmScheduledPageRecDelayDist = PagingScheduler_getPmScheduledPageRecDelayDist(this)
% return the scheduled paging records delay distribution
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmScheduledPageRecDelayDist = objects__{this}.pmScheduledPageRecDelayDist;
else
    fprintf('invalid reference\n');
end

end