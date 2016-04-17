function PagingPolicer_setBufferSize(this,bufferSize)
% set the buffer size
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.bufferSize = bufferSize;
    
else
    fprintf('invalid reference\n');
end

end