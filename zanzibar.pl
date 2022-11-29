:- dynamic schema/3.
:- dynamic tuple/4.

/*
Write schemas using the following notation, one rewrite per line.

schema(namespace, relation, computedUserset(writer))
schema(namespace, relation, tupleToUserset(tupleset, computedUserset))
schema(namespace, relation, union(rewrite1, rewrite2))
schema(namespace, relation, intersection(rewrite1, rewrite2))
schema(namespace, relation, exclusion(rewrite1, rewrite2))

Write tuples using the following notation

tuple(namespace, id, relation, user(alice)).
tuple(namespace, id, relation, object(namespace, id)).
tuple(namespace, id, relation, userset(namespace, id, relation)).
*/

% checkWR = check with rewrite
checkWR(Namespace, Id, Rel, User, self) :- tuple(Namespace, Id, Rel, User).

checkWR(Namespace, Id, _, User, computedUserset(Rel0)) :- tuple(Namespace, Id, Rel0, User).

checkWR(Namespace, Id, _, User, tupleToUserset(S, T)) :-
    tuple(Namespace, Id, S, object(Namespace0, Id0)),
    schema(Namespace0, T, Rewrite),
    checkWR(Namespace0, Id0, T, User, Rewrite).

checkWR(Namespace, Id, _, User, tupleToUserset(S, T)) :-
    tuple(Namespace, Id, S, userset(Namespace0, Id0, T)),
    schema(Namespace0, T, Rewrite),
    checkWR(Namespace0, Id0, T, User, Rewrite).

checkWR(Namespace, Id, Rel, User, union(S, _)) :- checkWR(Namespace, Id, Rel, User, S).
checkWR(Namespace, Id, Rel, User, union(_, T)) :- checkWR(Namespace, Id, Rel, User, T).

checkWR(Namespace, Id, Rel, User, intersection(S, T)) :-
    checkWR(Namespace, Id, Rel, User, S),
    checkWR(Namespace, Id, Rel, User, T).

checkWR(Namespace, Id, Rel, User, exclusion(S, T)) :-
    checkWR(Namespace, Id, Rel, User, S),
    \+ checkWR(Namespace, Id, Rel, User, T). % add , !. here?

% check add the cut at the end so it justs finds the answer and won't backtrack.
check(Namespace, Id, Rel, User) :-
    schema(Namespace, Rel, Rewrite),
    checkWR(Namespace, Id, Rel, User, Rewrite), !.

list(Namespace, Id, Rel, User) :-
    schema(Namespace, Rel, Rewrite),
    checkWR(Namespace, Id, Rel, User, Rewrite).
