function pmNbPageDropDelayExp = PagingQueueManager_getPmNbPageDropDelayExp(this)
% return the number of paging records dropped because maximum delay reached
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmNbPageDropDelayExp = objects__{this}.pmNbPageDropDelayExp;
else
    fprintf('invalid reference\n');
end

end