function deallocref(this)
% deallocate the specified reference
global tab__ tail__ head__ % properties of the references queue
% know first if some references are unavailable
if tail__ == length(tab__) % boundaries of "tab" reached
    isFull = head__ == 1;
else
    isFull = head__ == (tail__+1);
end
if ~isFull % some references unavailable
    % insert the specified reference at the tail of the references queue
    tab__(tail__) = this;
    % we modify the boundaries of the queue in the table thanks to pointers
    if tail__ == length(tab__) % boundaries of "tab" reached
        tail__ = 1;
    else
        tail__ = tail__ + 1;
    end
end

end

