function timeTable = PagingPolicer_getTimeTable(this)
% return the timetable reference pointer
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    timeTable = objects__{this}.timeTable;
    
else
    fprintf('invalid reference\n');
end

end