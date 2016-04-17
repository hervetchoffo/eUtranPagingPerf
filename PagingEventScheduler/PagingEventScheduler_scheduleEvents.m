function PagingEventScheduler_scheduleEvents(this,lamda,nB,T,tho,nbPagingEvents)
% schedule arrivals and departures of pagings
global objects__ % objects in the heap
global sysconst__; % system constants
if thisobj(this)
    % place your code here ...
    % set arrival events
    arrival = -lamda\log(rand(1,nbPagingEvents));
    for i=2:nbPagingEvents
        arrival(i)=arrival(i-1)+arrival(i);
    end

    % set departure events
    N = T*min(nB,1); % number of paging frames per cycle
    Ns = max(nB,1); % number of paging occasions per paging frame
    pagingCycleDuration = T*sysconst__.rfDuration; % duration of a paging cycle
    nbPagingCycles = ceil(arrival(nbPagingEvents)/(pagingCycleDuration*sysconst__.TTI)); % number of paging cycles during this simulation
    nbPagingFrames = nbPagingCycles*N; % number of paging frames during this simulation
    pagingFrameInterval = pagingCycleDuration/N; % time elapsed between two paging frames
    departure = zeros(1,nbPagingFrames*Ns);
    pagingFrameStart = 0; % start of paging frame
    for k=1:nbPagingFrames
        for is=1:Ns
            departure((k-1)*Ns+is) = pagingFrameStart + sysconst__.pagingOccasionNumber(Ns,is);
        end
        pagingFrameStart = pagingFrameStart + pagingFrameInterval;
    end
    departure = departure*sysconst__.TTI;

    % schedule arrivals and departures
    EventScheduler_scheduleEvents(this,arrival,departure-tho*sysconst__.TTI,departure);

    % reset UE_ID
    objects__{this}.UE_ID = Inf;
    objects__{this}.UE_IDIndex = 0;
else
    fprintf('invalid reference\n');
end

end