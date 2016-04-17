function this = allocref()
% allocate a new reference
global tab__ head__ tail__ % properties of the references queue
% return and remove the reference from the queue head
if head__ ~= tail__ % some references are available
    this = tab__(head__);
    % we modify the boundaries of the queue in the table thanks to pointers
    if head__ == length(tab__) % boundaries of "tab" reached
        head__ = 1;
    else
        head__ = head__ + 1;
    end
else
    this = 0;
end

end

