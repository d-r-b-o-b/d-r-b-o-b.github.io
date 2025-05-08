function ACCURACY = makeManyDecisions_fast(D, T, f, nDecisions)


dot_direction = binornd(1, f, D*T, nDecisions);
N_correct = sum(dot_direction);
N_wrong = sum(1-dot_direction);

ACCURACY = mean(N_correct>N_wrong) + 0.5*mean(N_correct == N_wrong);