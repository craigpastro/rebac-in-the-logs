:- include('zanzibar.pl').

% Actually, I think this is all wrong. The rewrites have to apply to the model.



% Rewrites needed for intersection and exclusion
userTuple(N, X, R, U) :- model(N, R, intersection(S, T)), userTuple(N, X, S, U), userTuple(N, X, T, U).
userTuple(N, X, R, U) :- model(N, R, exclusion(S, T)), userTuple(N, X, S, U), not(userTuple(N, X, T, U)).

model(document, writer, self).
model(document, reader, self).

model(document, owner, intersection(writer, reader)).

model(document, readerOnly, exclusion(reader, writer)).


userTuple(document, a, writer, anna).
userTuple(document, a, reader, anna).

userTuple(document, a, reader, beth).

% Sanity checks
:- userTuple(document, a, owner, anna).
:- userTuple(document, a, readerOnly, beth).
