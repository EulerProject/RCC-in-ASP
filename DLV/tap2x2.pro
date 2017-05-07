% T1: (a b c) 
bl(b,a). bl(c,a).

% T2: (A B C) 
bl("B","A"). bl("C","A").

% Articulations
eq(a,"A").


% Rules for PARENT COVERAGE for (a b c) -- need to check whether this is set is complete and minimal for the example
% TO-DO: explore variant encodings and generalizations to simplify rule generation
%% dr(a,X) :- dr(b,X), dr(c,X). % if X is disjoint from b and c, then also from a

%% po(a,X) :- dr(b,X), po(c,X). % .. but if X (disjoint from b) overlaps c, then X also overlaps a
%% po(a,X) :- dr(c,X), po(b,X). % .. ditto, but with b and c swapped 

%% eq(X,c) v pp(X,c) :- dr(b,X), pp(X,a). % if X (disjoint from b) is in a, then it's equal to c or part of c.
%% eq(X,b) v pp(X,b) :- dr(c,X), pp(X,a). % ditto but with b and c swapped






