% RCC5 representations: eq (==), dr (!), pp (<), ppi (>), po (><)

e(X,Y) :- eq(X,Y), X>Y.
o(X,Y) :- po(X,Y), X>Y.

% INPUT TAP 

% Taxonomy T1
pp(b,a). pp(c,a).  % IS-A
dr(b,c).           % sibling disjointess

% Taxonomy T2
pp("B","A"). pp("C","A").  
dr("B","C"). 

% ARTICULATIONS
eq(a,"A").  % just connect the roots

%% eq(X,c) v pp(X,c) :- dr(b,X), pp(X,a). % if X (disjoint from b) is in a, then it's equal to c or part of c.
%% eq(X,b) v pp(X,b) :- dr(c,X), pp(X,a). % ditto but with b and c swapped

%% eq(X,"C") v pp(X,"C") :- dr("B",X), pp(X,"A").
%% eq(X,"B") v pp(X,"B") :- dr("C",X), pp(X,"A").

% Universe of concepts (active domain)
u(a).   u(b).   u(c).   
u("A"). u("B"). u("C"). 

%  Defining the SEARCH SPACE: one of the Base5 must hold for a pair (X,Y) 
eq(X,Y) v dr(X,Y) v pp(X,Y) v ppi(X,Y) v po(X,Y) :- u(X), u(Y), X != Y.

% eq/2 is reflexive:
eq(X,X) :- u(X).

% The Base5 relations are mutually exclusive, so there are 4+3+2+1 = 10 ICs
:- eq(X,Y), dr(X,Y).
:- eq(X,Y), pp(X,Y).
:- eq(X,Y), ppi(X,Y).
:- eq(X,Y), po(X,Y).
:- dr(X,Y), pp(X,Y).
:- dr(X,Y), ppi(X,Y).
:- dr(X,Y), po(X,Y).
:- pp(X,Y), ppi(X,Y).
:- pp(X,Y), po(X,Y).
:- ppi(X,Y), po(X,Y).

% (WEAK) COMPOSITION TABLE
eq(X,Z)                                          :- eq(X,Y), eq(Y,Z).
          dr(X,Z)                                :- eq(X,Y), dr(Y,Z).
                    pp(X,Z)                      :- eq(X,Y), pp(Y,Z).
                              ppi(X,Z)           :- eq(X,Y), ppi(Y,Z).
                                         po(X,Z) :- eq(X,Y), po(Y,Z).
          dr(X,Z)                                :- dr(X,Y), eq(Y,Z).
eq(X,Z) v dr(X,Z) v pp(X,Z) v ppi(X,Z) v po(X,Z) :- dr(X,Y), dr(Y,Z).
          dr(X,Z) v pp(X,Z)            v po(X,Z) :- dr(X,Y), pp(Y,Z).
          dr(X,Z)           v ppi(X,Z) v po(X,Z) :- dr(X,Y), ppi(Y,Z).
          dr(X,Z) v pp(X,Z)            v po(X,Z) :- dr(X,Y), po(Y,Z).
                    pp(X,Z)                      :- pp(X,Y), eq(Y,Z).
          dr(X,Z)                                :- pp(X,Y), dr(Y,Z).
                    pp(X,Z)                      :- pp(X,Y), pp(Y,Z).
eq(X,Z) v dr(X,Z) v pp(X,Z) v ppi(X,Z) v po(X,Z) :- pp(X,Y), ppi(Y,Z).
          dr(X,Z) v pp(X,Z)            v po(X,Z) :- pp(X,Y), po(Y,Z).
                              ppi(X,Z)           :- ppi(X,Y), eq(Y,Z).
          dr(X,Z)           v ppi(X,Z) v po(X,Z) :- ppi(X,Y), dr(Y,Z).
eq(X,Z) v dr(X,Z) v pp(X,Z) v ppi(X,Z) v po(X,Z) :- ppi(X,Y), pp(Y,Z).
                              ppi(X,Z)           :- ppi(X,Y), ppi(Y,Z).
                              ppi(X,Z) v po(X,Z) :- ppi(X,Y), po(Y,Z). % po o ppi
                                         po(X,Z) :- po(X,Y), eq(Y,Z).
          dr(X,Z)           v ppi(X,Z) v po(X,Z) :- po(X,Y), dr(Y,Z).
                    pp(X,Z)            v po(X,Z) :- po(X,Y), pp(Y,Z).
          dr(X,Z)           v ppi(X,Z) v po(X,Z) :- po(X,Y), ppi(Y,Z). % ppi o po
eq(X,Z) v dr(X,Z) v pp(X,Z) v ppi(X,Z) v po(X,Z) :- po(X,Y), po(Y,Z).
