function p_safe_softmax = softmax(sigma, Delta)
beta = 1 / sigma * sqrt(pi / 2);
p_safe_softmax = 1 ./ ( 1 + exp( -beta * Delta ) );