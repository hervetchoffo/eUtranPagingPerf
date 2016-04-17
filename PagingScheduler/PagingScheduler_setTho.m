function PagingScheduler_setTho(this,tho)
% set the radio resource processing delay
global objects__ % objects in the heap
global sysconst__; % system constants
if thisobj(this)
    % place your code here ...
    objects__{this}.tho = tho*sysconst__.TTI;
    
else
    fprintf('invalid reference\n');
end

end