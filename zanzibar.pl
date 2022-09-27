:- discontiguous userTuple/4.
:- discontiguous usersetTuple/6.

/*
Write models using the following notation, one relation per line.

model(namespace, relation, self)
model(namespace, relation, computedUserset(writer))
model(namespace, relation, tupleToUserset(tupleset, computedUserset))
*/

% REWRITES
userTuple(N, A, R, U) :- usersetTuple(N, A, R, M, B, S), userTuple(M, B, S, U).

% model(document, reader, computedUserset(writer)), tuple(document, a, writer, U) --> tuple(document, a, reader, U)
userTuple(N, A, S, U) :- model(N, S, computedUserset(R)), userTuple(N, A, R, U).
usersetTuple(N, A, S, M, B, S) :- model(N, S, computedUserset(R)), usersetTuple(N, A, R, M, B, S).

% model(document, writer, tupleToUserset(crossing, member)), usersetTuple(document, a, crossing, group, x, member) --> usersetTuple(document, a, writer, userset(group, x, member))
usersetTuple(N, A, T, M, B, S) :- model(N, T, tupleToUserset(R, S)), model(M, S, _), usersetTuple(N, A, R, M, B, S).

% Tuple-to-userset rewrite when the userset has no relation.
% The last part ensures that the namespace M has a relation S on it
usersetTuple(N, A, T, M, B, S) :- model(N, T, tupleToUserset(R, S)), model(M, S, _), usersetTuple(N, A, R, M, B, empty).
