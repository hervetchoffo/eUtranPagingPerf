function pmCumMemUsed = PagingPolicer_getPmCumMemUsed(this)
% return the cumulative memory usage computed at each incoming paging request
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmCumMemUsed = objects__{this}.pmCumMemUsed;
    
else
    fprintf('invalid reference\n');
end

end