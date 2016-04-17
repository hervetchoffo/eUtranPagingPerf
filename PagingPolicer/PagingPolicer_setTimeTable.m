function PagingPolicer_setTimeTable(this,timeTable)
% set the timetable reference pointer
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.timeTable = timeTable;
    
else
    fprintf('invalid reference\n');
end

end