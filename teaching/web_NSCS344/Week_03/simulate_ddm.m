function [choice, DT, Delta] = simulate_ddm(D, f, z, dt)

i = 1;

N_correct = 0;
N_wrong = 0;

flag = true;

while flag
    for j = 1:D
        % randomly sample the direction of this dot
        dot_direction = binornd(1, f);
        
        % update the counts
        N_correct = N_correct + dot_direction;
        N_wrong = N_wrong + (1 - dot_direction);
        
    end
    
    % compute the difference
    Delta(i) = N_correct - N_wrong;
    
    if abs(Delta(i)) > z
        flag = false;
        choice = Delta(i) > 0;
        DT = i * dt;
    end
    
    i = i + 1;
    
end