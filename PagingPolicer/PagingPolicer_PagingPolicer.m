function PagingPolicer_PagingPolicer(this,timeTable,queueManager,bufferSize,nB,T)
% constructor of the class PagingPolicer
% PagingPolicer does admission control on new paging requests: 
% > ensuring that memory is enough to process the request,
% > ensuring that requests are forwarded to the right queues (each of the
% nB queues corresponds to a paging occasion during a paging cycle)
global objects__ % objects in the heap
% global sysconst__; % system constants
if thisobj(this)
    if nargin == 1 % default constructor
        % constructors down chaining
        
        % place your code here ...
        objects__{this}.timeTable = 0; % init reference pointer to the timetable
        objects__{this}.queueManager = 0; % init reference pointer to the queue manager
        objects__{this}.bufferSize = 0; % init buffer size
        objects__{this}.N = 0; % init the number of paging frames per paging cycle
        objects__{this}.Ns = 0; % init the number of paging occasions per paging frame
        
    else
        
        % constructors down chaining
        
        % place your code here ...
        objects__{this}.timeTable = timeTable;
        objects__{this}.queueManager = queueManager;
        objects__{this}.bufferSize = bufferSize;
        objects__{this}.N = T*min(nB,1);
        objects__{this}.Ns = max(nB,1);
        
        % update reference counters
        holdobj(timeTable);
        holdobj(queueManager);
        
    end
    % init PM counters ...
    objects__{this}.pmNbPageReq = 0; % number of incoming paging requests
    objects__{this}.pmNbPageDropMemFull = 0; % number of paging requests dropped because memory is full
    objects__{this}.pmCumMemUsed = 0; % cumulative memory usage computed at each incoming paging request
else
    fprintf('invalid reference\n');
end

end