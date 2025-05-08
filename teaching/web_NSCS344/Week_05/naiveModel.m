function [VA, VB] = naiveModel(alpha, r, A, B)

T = length(r); % added this line to save inputting T

for i = 1:T
    
    % exception for first trial
    if i == 1
        
        % if A is present initialize it to alpha * r(1)
        % if A is absent initialize it to 0
        VA(i) = alpha * r(i) * A(i);
    
        % if B is present initialize it to alpha * r(1)
        % if B is absent initialize it to 0
        VB(i) = alpha * r(i) * B(i);
        
    else % update for remaining trials
        
        % update by prediction error if A is present
        % do not change value of A if A is absent
        VA(i) = VA(i-1) + alpha * (r(i) - VA(i-1)) * A(i);
        
        % update by prediction error if B is present
        % do not change value of B if B is absent
        VB(i) = VB(i-1) + alpha * (r(i) - VB(i-1));
        
    end
end