% This is v1 of a Prolog Zanzibar implementation which does not include
% intersection and exclusion. See v2 if you need these things.
:- dynamic(config/3).
:- dynamic(tuple/4).

% check add the cut at the end of list so it just finds an answer and won't backtrack.
check(Namespace, ObjectId, Relation, User) :-
    list(Namespace, ObjectId, Relation, User),
    !.

list(Namespace, ObjectId, Relation, User) :- 
    config(Namespace, Relation, self),
    tuple(Namespace, ObjectId, Relation, User).

list(Namespace, ObjectId, Relation, User) :-
    config(Namespace, Relation, computedUserset(Relation0)),
    list(Namespace, ObjectId, Relation0, User).

list(Namespace, ObjectId, Relation, User) :-
    config(Namespace, Relation, tupleToUserset(Tupleset, ComputedUserset)),
    tuple(Namespace, ObjectId, Tupleset, object(Namespace0, ObjectId0)),
    list(Namespace0, ObjectId0, ComputedUserset, User).

list(Namespace, ObjectId, Relation, User) :-
    config(Namespace, Relation, tupleToUserset(Tupleset, ComputedUserset)),
    config(Namespace, Tupleset, self),
    tuple(Namespace, ObjectId, Tupleset, userset(Namespace0, ObjectId0, ComputedUserset)),
    list(Namespace0, ObjectId0, ComputedUserset, User).
