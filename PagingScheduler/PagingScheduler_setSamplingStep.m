function PagingScheduler_setSamplingStep(this,samplingStep)
% set the sampling step for delay statistics
global objects__ % objects in the heap
if thisobj(this)
    % place your code here ...
    objects__{this}.samplingStep = samplingStep;
else
    fprintf('invalid reference\n');
end

end