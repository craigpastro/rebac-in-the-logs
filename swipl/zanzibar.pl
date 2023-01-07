:- dynamic(config/3).
:- dynamic(tuple/4).

% check add the cut at the end of list so it just finds an answer and won't backtrack.
check(Namespace, ObjectId, Relation, User) :-
    list(Namespace, ObjectId, Relation, User),
    !.

list(Namespace, ObjectId, Relation, User) :-
    config(Namespace, Relation, Rewrite),
    listWR(Namespace, ObjectId, Relation, User, Rewrite).

% listWR is list with rewrite
listWR(Namespace, ObjectId, Relation, User, self) :-
    tuple(Namespace, ObjectId, Relation, User).

listWR(Namespace, ObjectId, _, User, computedUserset(Relation0)) :-
    list(Namespace, ObjectId, Relation0, User).

listWR(Namespace, ObjectId, _, User, tupleToUserset(Tupleset, ComputedUserset)) :-
    tuple(Namespace, ObjectId, Tupleset, object(Namespace0, ObjectId0)),
    list(Namespace0, ObjectId0, ComputedUserset, User).

listWR(Namespace, ObjectId, _, User, tupleToUserset(Tupleset, ComputedUserset)) :-
    tuple(Namespace, ObjectId, Tupleset, userset(Namespace0, ObjectId0, ComputedUserset)),
    list(Namespace0, ObjectId0, ComputedUserset, User).

listWR(Namespace, ObjectId, Relation, User, union(L, _)) :-
    listWR(Namespace, ObjectId, Relation, User, L).

listWR(Namespace, ObjectId, Relation, User, union(_, R)) :-
    listWR(Namespace, ObjectId, Relation, User, R).

listWR(Namespace, ObjectId, Relation, User, intersection(L, R)) :-
    listWR(Namespace, ObjectId, Relation, User, L),
    listWR(Namespace, ObjectId, Relation, User, R).

listWR(Namespace, ObjectId, Relation, User, exclusion(M, S)) :-
    listWR(Namespace, ObjectId, Relation, User, M),
    \+ listWR(Namespace, ObjectId, Relation, User, S).
