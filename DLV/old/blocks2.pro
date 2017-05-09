% IS-A (proper containment hierarchy)
% every block B of A is properly contained in A
% NOTE: if B is sole child of A, should generate eq(B,A) :- bl(B,A) instead
pp(B,A) :- bl(_,B,A).

% SIBLING DISJOINTNESS
% any two different blocks FROM THE SAME PARTITION (within a taxonomy T) of A are disjoint
dr(B,C) :- bl(P,B,A), bl(P,C,A), B != C.


% COVERAGE


pid(P) :- bl(P,_,_). % each block has a partition ID

% Current issues:
% Neither the X-pp-A nor the X-po-A rule sets are confirmed to be correct/complete.
% In fact, the numbers don't add up yet for the 3x3 problem:
% - without coverage constraints: 3686 PWs (correct)
% - with X-po-A constraints:       493 PWs
% - with X-pp-A constraints:        49 Pws
% - with both constraints:           6 PWs
% - number according to mncb/mnpw: 265 PWs



% X-pp-A 

pp1(P, X,A) :- pp(X,A), bl(P, X,A), bl(P,B,A), not dr(X,B).

:- pp(X,A), pid(P), not pp1(P,X,A), pp_on.

%  X-po-A 

po1(P, X,A) :- po(X,A), bl(P,B,A), po(X,B).
%po_pp(X,A) :- po(X,A), bl(B,A), pp(X,B).

%:- po(X,A), not po_po(X,A), not po_pp(X,A), po_on.
:- po(X,A), pid(P), not po1(P, X,A), po_on.

