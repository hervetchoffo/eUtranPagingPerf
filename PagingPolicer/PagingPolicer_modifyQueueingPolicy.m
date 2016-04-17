function PagingPolicer_modifyQueueingPolicy(this,nB,T)
% modify the queueing policy according to (nB,T) parameters
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.N = T*min(nB,1);
    objects__{this}.Ns = max(nB,1);    
    
else
    fprintf('invalid reference\n');
end

end