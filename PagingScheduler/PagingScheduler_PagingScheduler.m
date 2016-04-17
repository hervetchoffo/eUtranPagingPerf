function PagingScheduler_PagingScheduler(this,timeTable,queueManager,tho,maxPageRec,samplingStep,nbSamples)
% constructor of the class PagingScheduler
% PagingScheduler books radio ressources needed to send paging records at each paging occasion: 
% > taking into account the radio resource processing delay i.e. booking is done before paging occasion happens,
% > taking into account the maximum allowed paging records per PCCH message
global objects__ % objects in the heap
global sysconst__; % system constants
if thisobj(this)
    if nargin == 1 % default constructor
        % constructors down chaining
        
        % place your code here ...
        objects__{this}.timeTable = 0; % init reference pointer to the timetable
        objects__{this}.queueManager = 0; % init reference pointer to the queue manager
        objects__{this}.tho = 0; % init the radio ressource processing delay
        objects__{this}.maxPageRec = 0; % init the maximum number of paging records in each PCCH message
        objects__{this}.bookedRes = []; % init the booked resources array
        objects__{this}.outgoingQueue = 0; % init the index of the current outgoing queue
        objects__{this}.bookingQueue = 0; % init the index of the current booking queue
        objects__{this}.samplingStep = 0; % init the sampling step for delay statistics
        
    else
        
        % constructors down chaining
        
        % place your code here ...
        objects__{this}.timeTable = timeTable;
        objects__{this}.queueManager = queueManager;
        objects__{this}.tho = tho*sysconst__.TTI;
        objects__{this}.maxPageRec = maxPageRec;
        objects__{this}.bookedRes = zeros(1,PagingQueueManager_getNbQueues(queueManager));
        if isempty(objects__{this}.bookedRes)
            objects__{this}.outgoingQueue = 0;
            objects__{this}.bookingQueue = 0;
        else
            objects__{this}.outgoingQueue = 1;
            objects__{this}.bookingQueue = 1;
            
        end
        objects__{this}.samplingStep = samplingStep;
        
        % update reference counters
        holdobj(timeTable);
        holdobj(queueManager);
        
    end
    % init PM counters ...
    objects__{this}.pmNbCandidatePageRec = 0; % number of candidate paging records
    objects__{this}.pmNbCandidatePageRecBlk = 0; % number of candidate paging records blocked because maximum radio resources reached
    objects__{this}.pmScheduledPageRecNbDist = zeros(1,maxPageRec + 1); % scheduled paging records number distribution
    objects__{this}.pmScheduledPageRecDelayDist = zeros(1,nbSamples); % scheduled paging records delay distribution
    
else
    fprintf('invalid reference\n');
end

end