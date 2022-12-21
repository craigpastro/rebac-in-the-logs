:- dynamic(config/3).
:- dynamic(tuple/4).

% checkWR is check with rewrite
checkWR(Namespace, Id, Rel, User, self) :- tuple(Namespace, Id, Rel, User).

checkWR(Namespace, Id, _, User, computedUserset(Rel0)) :-
    config(Namespace, Rel0, Rewrite),
    checkWR(Namespace, Id, Rel0, User, Rewrite).

checkWR(Namespace, Id, _, User, tupleToUserset(Tupleset, ComputedUserset)) :-
    tuple(Namespace, Id, Tupleset, object(Namespace0, Id0)),
    config(Namespace0, ComputedUserset, Rewrite),
    checkWR(Namespace0, Id0, ComputedUserset, User, Rewrite).

checkWR(Namespace, Id, _, User, tupleToUserset(Tupleset, ComputedUserset)) :-
    tuple(Namespace, Id, Tupleset, userset(Namespace0, Id0, ComputedUserset)),
    config(Namespace0, ComputedUserset, Rewrite),
    checkWR(Namespace0, Id0, ComputedUserset, User, Rewrite).

checkWR(Namespace, Id, Rel, User, union(L, _)) :- checkWR(Namespace, Id, Rel, User, L).
checkWR(Namespace, Id, Rel, User, union(_, R)) :- checkWR(Namespace, Id, Rel, User, R).

checkWR(Namespace, Id, Rel, User, intersection(L, R)) :-
    checkWR(Namespace, Id, Rel, User, L),
    checkWR(Namespace, Id, Rel, User, R).

checkWR(Namespace, Id, Rel, User, exclusion(M, S)) :-
    checkWR(Namespace, Id, Rel, User, M),
    \+ checkWR(Namespace, Id, Rel, User, S).

% check add the cut at the end so it just finds the answer and won't backtrack.
check(Namespace, Id, Rel, User) :-
    config(Namespace, Rel, Rewrite),
    checkWR(Namespace, Id, Rel, User, Rewrite), !.

list(Namespace, Id, Rel, User) :-
    config(Namespace, Rel, Rewrite),
    checkWR(Namespace, Id, Rel, User, Rewrite).
