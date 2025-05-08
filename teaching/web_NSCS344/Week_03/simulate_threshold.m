function [accuracy, DT, Delta] = simulate_threshold(D, f, z)

% frame counter - note we need to initialize this 
% outside the loop now
i = 1;

% initialize the count
N_correct = 0;
N_wrong = 0;

% initialize Delta
Delta(1) = N_correct - N_wrong;

while abs(Delta(i)) < z
    for j = 1:D
        % randomly sample the direction of this dot
        dot_direction = binornd(1, f);
        
        % update the counts
        N_correct = N_correct + dot_direction;
        N_wrong = N_wrong + (1 - dot_direction);
        
    end
    
    
    % increment counter by one
    i = i + 1;
    
    % compute the difference
    Delta(i) = N_correct - N_wrong;
    
end

% compute accuracy - correct if crossed +z threshold
% wrong if crossed -z threshold
accuracy = Delta(i) > 0;

% compute decision time in frames
DT = i;