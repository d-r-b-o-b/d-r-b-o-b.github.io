function ACCURACY = makeManyDecisions(D, T, f, nDecisions)

for i = 1:nDecisions
    a(i) = makeOneDecision(D, T, f);
end
ACCURACY = mean(a);