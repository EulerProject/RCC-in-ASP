% RCC5 representations: eq (==), dr (!), pp (<), ppi (>), po (><)

%% [ASP :)]$ time dlv rcc-asp-3x3-demo.dlv -silent | wc
%%     3686  265392 2854156

%% real	0m0.925s
%% user	0m0.916s
%% sys	0m0.022s

% INPUT TAP 

% Taxonomy T1
pp(b,a). pp(c,a). pp(d,a).  % IS-A
dr(b,c). dr(c,d). dr(b,d).  % sibling disjointess

% Taxonomy T2
pp("B","A"). pp("C","A"). pp("D","A"). % IS-A
dr("B","C"). dr("C","D"). dr("B","D"). % sibling disjointess

% ARTICULATIONS
eq(a,"A").  % just connect the roots 

% Universe of concepts (active domain)
u(a).   u(b).   u(c).   u(d).
u("A"). u("B"). u("C"). u("D").

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
