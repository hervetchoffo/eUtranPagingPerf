function Ns = PagingPolicer_getNs(this)
% return the number of paging occasions per paging frame
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    Ns = objects__{this}.Ns;
    
else
    fprintf('invalid reference\n');
end

end