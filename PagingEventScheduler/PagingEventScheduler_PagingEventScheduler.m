function PagingEventScheduler_PagingEventScheduler(this,lamda,nB,T,tho,nbPagingEvents)
% constructor of the class PagingEventScheduler
% PagingEventScheduler schedules 3 types of events: 
% > arrivals of paging requests in poisson process of intensity lamda,
% > departures during paging occasions determined by (nB,T) parameters,
% > scheduling events taking into account resource processing delay tho
% PagingEventScheduler tags paging requests with UE_ID integers
% randomly uniformly distributed between 0 and 1023
global objects__ % objects in the heap
global sysconst__; % system constants
if thisobj(this)
    if nargin == 1 % default constructor
        % constructors down chaining
        EventScheduler_EventScheduler(this);

        % place your code here ...
        objects__{this}.UE_ID = Inf;
        objects__{this}.UE_IDIndex = 0;
        
    else
        % set arrival events
        arrival = -lamda\log(rand(1,nbPagingEvents));
        for i=2:nbPagingEvents
            arrival(i)=arrival(i-1)+arrival(i);
        end
        
        % set departure events
        N = T*min(nB,1); % number of paging frames per cycle
        Ns = max(nB,1); % number of paging occasions per paging frame
        NsIndex = floor(Ns/2) + 1; % index giving paging occasions numbering in a paging frame
        pagingCycleDuration = T*sysconst__.rfDuration; % duration of a paging cycle
        nbPagingCycles = ceil(arrival(nbPagingEvents)/(pagingCycleDuration*sysconst__.TTI)); % number of paging cycles during this simulation
        nbPagingFrames = nbPagingCycles*N; % number of paging frames during this simulation
        pagingFrameInterval = pagingCycleDuration/N; % time elapsed between two paging frames
        departure = zeros(1,nbPagingFrames*Ns);
        pagingFrameStart = 0; % start of paging frame
        for k=1:nbPagingFrames
            for is=1:Ns
                departure((k-1)*Ns+is) = pagingFrameStart + sysconst__.pagingOccasionNumber(NsIndex,is);
            end
            pagingFrameStart = pagingFrameStart + pagingFrameInterval;
        end
        departure = departure*sysconst__.TTI;
        
        % constructors down chaining
        EventScheduler_EventScheduler(this,arrival,departure - tho*sysconst__.TTI,departure);
        
        % place your code here ...
        objects__{this}.UE_ID = Inf;
        objects__{this}.UE_IDIndex = 0;
    end
else
    fprintf('invalid reference\n');
end

end