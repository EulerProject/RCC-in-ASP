% IS-A (proper containment hierarchy)
% every block B of A is properly contained in A
% NOTE: if B is sole child of A, should generate eq(B,A) :- bl(B,A) instead
pp(B,A) :- bl(B,A).

% SIBLING DISJOINTNESS
% any two different blocks of A are disjoint
dr(B,C) :- bl(B,A), bl(C,A), B != C.


% COVERAGE

% Current issues:
% Neither the X-pp-A nor the X-po-A rule sets are confirmed to be correct/complete.
% In fact, the numbers don't add up yet for the 3x3 problem:
% - without coverage constraints: 3686 PWs (correct)
% - with X-po-A constraints:       493 PWs
% - with X-pp-A constraints:        49 Pws
% - with both constraints:           6 PWs
% - number according to mncb/mnpw: 265 PWs

% X-pp-A ==> 1 of 3 cases ... (not clear whether we got the right rules here)

% ... Case 1. for SOME block B: X-eq-B
eqB(X,A)  :- pp(X,A), bl(B,A), eq(X,B).  

% ... or Case 2. for SOME block B: X-pp-B
ppB(X,A)  :- pp(X,A), bl(B,A), pp(X,B).  

% ... or Case 3. for (at least) two blocks B,C:  X-po-B and X-po-C
poBC(X,A) :- pp(X,A), bl(B,A), bl(C,A), B != C, po(X,B), po(X,C).

:- pp(X,A), not eqB(X,A), not ppB(X,A), not poBC(X,A). % eliminate if none of Cases 1-3

% Explicit po(X,B) generation for tap3x3 problem 
% po(X,b) v po(X,c) v po(X,d) :- po(X,a).
% po(X,"B") v po(X,"C") v po(X,"D") :- po(X,"A").


% X-po-A ==> X-po-B for some block B
% For 3x3 this coverage constraint alone brings down |PWs| from 3686 to 493
% NOTE: These rules do not seem to generate (any/enough) po(X,B) guesses 

poB(X,A) :- po(X,A), bl(B,A), po(X,B). % for SOME block B we have X-po-B

:- po(X,A), not poB(X,A).  % eliminate models if X has no po with any block B

