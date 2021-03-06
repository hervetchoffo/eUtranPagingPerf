function queueNumber = PagingPolicer_processPagingRequest(this)
% process new paging requests
global objects__ % objects in the heap
% global sysconst__; % system constants
if thisobj(this)
    % place your code here ...
    % check that memory is enough to process the request and forward to the
    % appropriate queue
    memoryUsed = PagingQueueManager_getMemoryUsed(objects__{this}.queueManager);
    if memoryUsed < objects__{this}.bufferSize
        UE_ID = PagingEventScheduler_getUE_ID(objects__{this}.timeTable); % get UE_ID
        i = mod(UE_ID,objects__{this}.N); % compute target paging frame number modulo N
        is = mod(floor(UE_ID/objects__{this}.N),objects__{this}.Ns); % compute target paging occasion number modulo Ns
        queueNumber = i*objects__{this}.Ns + is + 1; % compute target queue number
        PagingQueueManager_enqueuePagingRequest(objects__{this}.queueManager,queueNumber);
    else
        % 0 is used to signal to the calling function a drop
        queueNumber = 0;
        % update drop PM counters (cause: memory full)
        objects__{this}.pmNbPageDropMemFull = objects__{this}.pmNbPageDropMemFull + 1;
        
    end
    % update PM counters
    objects__{this}.pmNbPageReq = objects__{this}.pmNbPageReq + 1;
    objects__{this}.pmCumMemUsed = objects__{this}.pmCumMemUsed + memoryUsed;
    
else
    fprintf('invalid reference\n');
end

end