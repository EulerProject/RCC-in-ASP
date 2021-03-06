% This example w/ current encoding generates 82 PWs. 

%% [DLV :)]$ dlv rcc-asp-dlv.pro input-2x2-dlv.pro -silent | sort  | wc
%%        7     302    3217

% Now obtaining the "magnificent 7" PWs! See tap2x2-magnificent7PWs.pdf
% The first two PWs are leaf permutations
% The next four PWs have a single overlap
% The final PW has four overlaps

%% [DLV :)]$ dlv rcc-asp-dlv.pro input-2x2-dlv.pro -silent -filter=e,o | sort  
%% {e(a,"A"), e(b,"B"), e(c,"C")} 
%% {e(a,"A"), e(b,"C"), e(c,"B")}

%% {e(a,"A"), o(b,"B")}
%% {e(a,"A"), o(b,"C")}
%% {e(a,"A"), o(c,"B")}
%% {e(a,"A"), o(c,"C")}

%% {e(a,"A"), o(b,"B"), o(b,"C"), o(c,"B"), o(c,"C")}

% INPUT TAP 

% T1: (a b c) 
pp(b,a). pp(c,a).            % IS-A 
dr(b,c).                     % Sibling disjointness

% Rules for PARENT COVERAGE for (a b c) -- need to check whether this is set is complete and minimal for the example
% TO-DO: explore variant encodings and generalizations to simplify rule generation
%dr(a,X) :- dr(b,X), dr(c,X). % if X is disjoint from b and c, then also from a
%po(a,X) :- dr(b,X), po(c,X). % .. but if X (disjoint from b) overlaps c, then X also overlaps a
%po(a,X) :- dr(c,X), po(b,X). % .. ditto, but with b and c swapped 
%po(a,X) v pp(X,a) :- po(b,X). % if X overlaps b, then b overlaps a or is contained in a
%po(a,X) v pp(X,a) :- po(c,X). % ditto, but with b and c swapped
eq(X,c) v pp(X,c) :- dr(b,X), pp(X,a). % if X (disjoint from b) is in a, then it's equal to c or part of c.
eq(X,b) v pp(X,b) :- dr(c,X), pp(X,a). % ditto but with b and c swapped



% T2: (A B C)
% Same encoding as for T1
pp("B","A"). pp("C","A").
dr("B","C").

%dr("A",X) :- dr("B",X), dr("C",X).
%po("A",X) :- dr("B",X), po("C",X). 
%po("A",X) :- dr("C",X), po("B",X). 
%% po("A",X) v pp(X,"A") :- po("B",X).
%% po("A",X) v pp(X,"A") :- po("C",X).
eq(X,"C") v pp(X,"C") :- dr("B",X), pp(X,"A").
eq(X,"B") v pp(X,"B") :- dr("C",X), pp(X,"A").


% Articulations
eq(a,"A").

