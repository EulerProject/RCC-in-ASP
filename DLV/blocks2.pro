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

% X-pp-A 

pp1(X,A) :- pp(X,A), bl(B,A), not dr(X,B).

:- pp(X,A), not pp1(X,A), pp_on.

%  X-po-A 

po1(X,A) :- po(X,A), bl(B,A), po(X,B).
%po_pp(X,A) :- po(X,A), bl(B,A), pp(X,B).

%:- po(X,A), not po_po(X,A), not po_pp(X,A), po_on.
:- po(X,A), not po1(X,A), po_on.

