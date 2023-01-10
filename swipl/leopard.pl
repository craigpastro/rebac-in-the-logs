:- dynamic(config/3).
:- dynamic(tuple/4).

m2g(User, Namepace, ObjectId, Relation) :-
    tuple(Namepace, ObjectId, Relation, User).

g2g(Namespace, ObjectId, Relation, Namespace, ObjectId, Relation) :-
    tuple(Namespace, ObjectId, Relation, _).

g2g(Namespace, ObjectId, Relation, Namespace, ObjectId, Relation0) :-
    config(Namespace, Relation, computedUserset(Relation0)).

g2g(Namespace, ObjectId, Relation, Namespace0, ObjectId0, Relation0) :-
    config(Namespace, Relation, tupleToUserset(Tupleset, Relation0)),
    tuple(Namespace, ObjectId, Tupleset, object(Namespace0, ObjectId0)).

g2g(Namespace, ObjectId, Relation, Namespace0, ObjectId0, Relation0) :-
    config(Namespace, Relation, tupleToUserset(Tupleset, Relation0)),
    tuple(Namespace, ObjectId, Tupleset, userset(Namespace0, ObjectId0, Relation0)).

check(Namespace, ObjectId, Relation, UserId) :-
    m2g(UserId, Namespace0, ObjectId0, Relation0),
    g2g(Namespace, ObjectId, Relation, Namespace0, ObjectId0, Relation0),
    !.

% Now, to compute intersections and exlusions, I think you have to jump out of Prolog.
% For example, if you had `config(document, viewer, intersection(writer, editor))` then 
% issue two checks against writer and editor and return the result.


config(folder, viewer, self).
config(document, parent, self).
config(document, writer, self).
config(document, viewer, computedUserset(writer)).
config(document, viewer, tupleToUserset(parent, viewer)).

tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).

tuple(document, 2, writer, beatrix).

:- check(document, 2, viewer, beatrix).
:- check(document, 1, viewer, abigail).
