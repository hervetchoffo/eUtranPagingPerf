function bufferSize = PagingPolicer_getBufferSize(this)
% return the buffer size
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    bufferSize = objects__{this}.bufferSize;
    
else
    fprintf('invalid reference\n');
end

end