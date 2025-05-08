function ACCURACY = makeManyDecisions_slow(D, T, f, nDecisions)

a = nan(nDecisions,1);
for i = 1:nDecisions
    a(i) = makeOneDecision(D, T, f);
end
ACCURACY = mean(a);