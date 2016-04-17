function samplingStep = PagingScheduler_getSamplingStep(this)
% return the sampling step for delay statistics
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    samplingStep = objects__{this}.samplingStep;
else
    fprintf('invalid reference\n');
end

end