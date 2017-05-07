% RCC-5 in ASP (DLV) encoding. Based on: 
% [brenton2016answer] Brenton, Christopher, Wolfgang Faber, and Sotiris Batsakis. 2016.
% “Answer Set Programming for Qualitative Spatio-Temporal Reasoning: Methods and Experiments.”
% 32nd International Conference on Logic Programming (ICLP 2016)
% Schloss Dagstuhl–Leibniz-Zentrum fuer Informatik. doi:10.4230/OASIcs.ICLP.2016.4.

% To run: 
% dlv rcc-asp.dlv INPUTFILE.dlv

% To count |PWs|, i.e., the number of possible worlds: 
% dlv rcc-asp.dlv INPUTFILE.dlv -silent | sort -u | wc

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


% auxiliary output relations to remove symmetry (less is more)
e(X,Y) :- eq(X,Y), X > Y.      % equals w/o symmetry
d(X,Y) :- dr(X,Y), X > Y.      % disjoint w/o symmetry
o(X,Y) :- po(X,Y), X > Y.      % partial overlap w/o symmetry

h(X,Y) :- pp(X,Y), not t(X,Y). % hierarchy w/o transitive (= covering relation)
t(X,Y) :- pp(X,Z), pp(Z,Y).


% Universe of Discourse - in [brenton2016answer] this is element/1
u(X) :- dr(X,_).
u(X) :- eq(X,_).
u(X) :- po(X,_).
u(X) :- pp(X,_).
u(X) :- ppi(X,_).

u(X) :- dr(_,X).
u(X) :- eq(_,X).
u(X) :- po(_,X).
u(X) :- pp(_,X).
u(X) :- ppi(_,X).

% RCC5 representations:
% eq (==), dr (!), pp (<), ppi (>), po (><)

% Definition 5: DISJUNCTIVE ENCODING of the SEARCH SPACE
eq(X,Y) v dr(X,Y) v pp(X,Y) v ppi(X,Y) v po(X,Y) :- u(X), u(Y), X != Y.

% The Base5 relations are mutually exclusive, so there are 4+3+2+1 = 10 ICs
% These are easy to generate with $ python gen-mutex-pairs.py
% Note: [brenton2016answer] claims that there are 56 ICs for RCC8,
% but I think there are only 56 / 2 = 28 of these?? 
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

% eq/2 is reflexive:
eq(X,X) :- u(X).

%%%% Are the following implied e.g. via the composition table? Or do we need them in general? 
%% % inverse (a.k.a. converse) relations
%% ppi(X,Y) :- pp(Y,X).
%% pp(X,Y) :- ppi(Y,X).

%% %% % symmetry 
%% eq(X,Y) :- eq(Y,X).
%% po(X,Y) :- po(Y,X).
%% dr(X,Y) :- dr(Y,X).


% Definition 9: COMPOSITION TABLE
% There's quite a bit more theory and intricacy around composition tables,
% e.g. the distinction between composition and weak composition is important.
% Also path-consistency isn't (global) consistency, etc.
% 
% Some results and references:

%% [renz2005weak]: An immediate consequence for qualitative calculi where
%% weak composition is not equivalent to composition is that the
%% WELL-KNOWN CONCEPT OF PATH-CONSISTENCY IS NOT APPLICABLE ANYMORE.

%% [duntsch2001relation] Taking into account that the largest region is
%% RA de nable, we have re ned the RCC8 table to arrive at 10 base
%% relations, one of which is complementation. The RCC5 relations in
%% their REFINED FORM RCC7 lead to models of CLASSICAL MEREOLOGY, but
%% also to a notion of connectedness, where a region is connected to its
%% complement. We have also shown that a representation of RCC7 over a
%% Boolean algebra is Galois closed if and only if B is homogeneous.


%% [renz2005weak] Renz, Jochen, and Gérard Ligozat. 2005.
%% Weak Composition for Qualitative Spatial and Temporal Reasoning.
%% CP 2005, LNCS 3709, pp. 534–548.

%% [duntsch2001relation] Düntsch, Ivo, Hui Wang, and Steve McCloskey. 2001.
%% A Relation - Algebraic Approach to the Region Connection Calculus.
%% Theoretical Computer Science 255 (1): 63–83.
% 
% (WEAK !?) COMPOSITION TABLE

% COMPOSITION TABLE, RULE ENCODINGING (Definition 9) 

% (Generateed pattern with $ python gen-comp-templates.py then manually adjusted)

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