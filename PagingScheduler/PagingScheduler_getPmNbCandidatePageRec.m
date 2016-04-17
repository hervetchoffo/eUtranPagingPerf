function pmNbCandidatePageRec = PagingScheduler_getPmNbCandidatePageRec(this)
% return the number of candidate paging records
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    pmNbCandidatePageRec = objects__{this}.pmNbCandidatePageRec;
else
    fprintf('invalid reference\n');
end

end