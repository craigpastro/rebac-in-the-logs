:- dynamic(config/3).
:- dynamic(tuple/4).

% check add the cut at the end of list so it just finds an answer and won't backtrack.
check(Namespace, Id, Rel, User) :-
    list(Namespace, Id, Rel, User), !.

list(Namespace, Id, Rel, User) :-
    config(Namespace, Rel, Rewrite),
    listWR(Namespace, Id, Rel, User, Rewrite).

% listWR is list with rewrite
listWR(Namespace, Id, Rel, User, self) :-
    tuple(Namespace, Id, Rel, User).

listWR(Namespace, Id, _, User, computedUserset(Rel0)) :-
    list(Namespace, Id, Rel0, User).

listWR(Namespace, Id, _, User, tupleToUserset(Tupleset, ComputedUserset)) :-
    tuple(Namespace, Id, Tupleset, object(Namespace0, Id0)),
    list(Namespace0, Id0, ComputedUserset, User).

listWR(Namespace, Id, _, User, tupleToUserset(Tupleset, ComputedUserset)) :-
    tuple(Namespace, Id, Tupleset, userset(Namespace0, Id0, ComputedUserset)),
    list(Namespace0, Id0, ComputedUserset, User).

listWR(Namespace, Id, Rel, User, union(L, _)) :-
    listWR(Namespace, Id, Rel, User, L).

listWR(Namespace, Id, Rel, User, union(_, R)) :-
    listWR(Namespace, Id, Rel, User, R).

listWR(Namespace, Id, Rel, User, intersection(L, R)) :-
    listWR(Namespace, Id, Rel, User, L),
    listWR(Namespace, Id, Rel, User, R).

listWR(Namespace, Id, Rel, User, exclusion(M, S)) :-
    listWR(Namespace, Id, Rel, User, M),
    \+ listWR(Namespace, Id, Rel, User, S).
