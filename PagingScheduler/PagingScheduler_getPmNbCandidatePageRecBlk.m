function pmNbCandidatePageRecBlk = PagingScheduler_getPmNbCandidatePageRecBlk(this)
% return the number of candidate paging records blocked because maximum radio resources reached
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmNbCandidatePageRecBlk = objects__{this}.pmNbCandidatePageRecBlk;
else
    fprintf('invalid reference\n');
end

end