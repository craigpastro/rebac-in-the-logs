:- include(zanzibar).
:- discontiguous(check/4).
:- discontiguous(tuple/4).
:- discontiguous(cleanup/0).

cleanup :-
    retractall(config(_, _, _)),
    retractall(tuple(_, _, _, _)).

% This
config(document, viewer, self).
tuple(document, 1, viewer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Computed Userset
config(document, writer, self).
config(document, viewer, computedUserset(writer)).
tuple(document, 1, writer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Tuple-to-userset
config(folder, viewer, self).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% This and union
config(document, writer, self).
config(document, viewer, union(self, computedUserset(writer))).
tuple(document, 1, viewer, abigail).
tuple(document, 2, writer, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- cleanup.

% This and intersection
config(document, writer, self).
config(document, viewer, intersection(self, computedUserset(writer))).
tuple(document, 1, viewer, abigail).
tuple(document, 1, writer, abigail).
tuple(document, 2, viewer, beatrix).
tuple(document, 3, writer, charlie).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% This and exclusion base
config(document, writer, self).
config(document, viewer, exclusion(self, computedUserset(writer))).
tuple(document, 1, viewer, abigail).
tuple(document, 1, writer, abigail).
tuple(document, 2, viewer, beatrix).
tuple(document, 3, writer, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Computed userset and union
config(document, writer, self).
config(document, editor, self).
config(document, viewer, union(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- cleanup.

% Computed userset and intersection
config(document, writer, self).
config(document, editor, self).
config(document, viewer, intersection(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 3, editor, charlie).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Computed userset and exclusion
config(document, writer, self).
config(document, editor, self).
config(document, viewer, exclusion(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 3, editor, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Tuple-to-userset and computed userset
config(folder, writer, self).
config(folder, viewer, computedUserset(writer)).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Tuple-to-userset and tuple-to-userset
config(group, member, self).
config(folder, parent, self).
config(folder, viewer, tupleToUserset(parent, member)).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, parent, object(group, g)).
tuple(group, g, member, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Tuple-to-userset and union
config(folder, writer, self).
config(folder, editor, self).
config(folder, viewer, union(computedUserset(writer), computedUserset(editor))).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
tuple(folder, x, editor, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 1, viewer, beatrix).
:- cleanup.

% Tuple-to-userset and intersection
config(folder, writer, self).
config(folder, editor, self).
config(folder, viewer, intersection(computedUserset(writer), computedUserset(editor))).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
tuple(folder, x, editor, abigail).
tuple(folder, x, writer, beatrix).
tuple(folder, x, editor, charlie).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 1, viewer, beatrix).
:- \+ check(document, 1, viewer, charlie).
:- cleanup.

% Tuple-to-userset and exclusion
config(folder, writer, self).
config(folder, editor, self).
config(folder, viewer, exclusion(computedUserset(writer), computedUserset(editor))).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
tuple(folder, x, editor, abigail).
tuple(folder, x, writer, beatrix).
tuple(folder, x, editor, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 1, viewer, beatrix).
:- \+ check(document, 1, viewer, charlie).
:- cleanup.

% Union and tuple-to-userset
config(folder, viewer, self).
config(document, parent, self).
config(document, writer, self).
config(document, viewer, union(computedUserset(writer), tupleToUserset(parent, viewer))).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
tuple(document, 1, writer, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 1, viewer, beatrix).
:- cleanup.

% Union and union
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, union(computedUserset(writer), union(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
tuple(document, 3, owner, charlie).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- cleanup.

% Union and intersection
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, union(computedUserset(writer), intersection(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
tuple(document, 2, owner, beatrix).
tuple(document, 3, editor, charlie).
tuple(document, 4, owner, daphne).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- \+ check(document, 4, viewer, daphne).
:- cleanup.

% Union and exclusion
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, union(computedUserset(writer), exclusion(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
tuple(document, 2, owner, beatrix).
tuple(document, 3, editor, charlie).
tuple(document, 4, owner, daphne).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- \+ check(document, 4, viewer, daphne).
:- cleanup.

% Intersection and tuple-to-userset
config(folder, viewer, self).
config(document, parent, self).
config(document, writer, self).
config(document, viewer, intersection(computedUserset(writer), tupleToUserset(parent, viewer))).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
tuple(document, 1, writer, abigail).
tuple(folder, x, viewer, beatrix).
tuple(document, 2, writer, charlie).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 1, viewer, beatrix).
:- \+ check(document, 2, viewer, charlie).
:- cleanup.

% Intersection and union
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, intersection(computedUserset(writer), union(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, owner, beatrix).
tuple(document, 3, writer, charlie).
tuple(document, 4, editor, daphne).
tuple(document, 5, owner, elise).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- \+ check(document, 4, viewer, daphne).
:- \+ check(document, 5, viewer, elise).
:- cleanup.

% Intersection and intersection
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, intersection(computedUserset(writer), intersection(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 1, owner, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, editor, beatrix).
tuple(document, 3, writer, charlie).
tuple(document, 3, owner, charlie).
tuple(document, 4, writer, daphne).
tuple(document, 5, editor, elise).
tuple(document, 6, owner, fernanda).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- \+ check(document, 4, viewer, daphne).
:- \+ check(document, 5, viewer, elise).
:- \+ check(document, 5, viewer, fernanda).
:- cleanup.

% Intersection and exclusion
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, intersection(computedUserset(writer), exclusion(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 1, owner, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, editor, beatrix).
tuple(document, 3, writer, charlie).
tuple(document, 3, owner, charlie).
tuple(document, 4, writer, daphne).
tuple(document, 5, editor, elise).
tuple(document, 6, owner, fernanda).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- \+ check(document, 4, viewer, daphne).
:- \+ check(document, 5, viewer, elise).
:- \+ check(document, 5, viewer, fernanda).
:- cleanup.

% Exclusion and computed userset
config(document, writer, self).
config(document, editor, self).
config(document, viewer, exclusion(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 3, editor, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Exclusion and tuple-to-userset in minuend
config(folder, viewer, self).
config(document, parent, self).
config(document, writer, self).
config(document, viewer, exclusion(tupleToUserset(parent, viewer), computedUserset(writer))).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
tuple(document, 1, writer, abigail).
tuple(folder, x, viewer, beatrix).
tuple(document, 2, writer, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 1, viewer, beatrix).
:- \+ check(document, 2, viewer, charlie).
:- cleanup.

% Exclusion and tuple-to-userset in subtrahend
config(folder, viewer, self).
config(document, parent, self).
config(document, writer, self).
config(document, viewer, exclusion(computedUserset(writer), tupleToUserset(parent, viewer))).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
tuple(document, 1, writer, abigail).
tuple(folder, x, viewer, beatrix).
tuple(document, 2, writer, charlie).
:- \+ check(document, 1, viewer, abigail).
:- \+ check(document, 1, viewer, beatrix).
:- check(document, 2, viewer, charlie).
:- cleanup.

% Exclusion and union in minuend
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, exclusion(union(computedUserset(writer), computedUserset(editor)), computedUserset(owner))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 1, owner, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, owner, beatrix).
tuple(document, 3, editor, charlie).
tuple(document, 3, owner, charlie).
tuple(document, 4, writer, daphne).
tuple(document, 5, editor, elise).
:- \+ check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- check(document, 4, viewer, daphne).
:- check(document, 5, viewer, elise).
:- cleanup.

% Exclusion and union in subtrahend
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, exclusion(computedUserset(writer), union(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, owner, beatrix).
tuple(document, 3, writer, charlie).
:- \+ check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- cleanup.

% Exclusion and intersection in minuend
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, exclusion(intersection(computedUserset(writer), computedUserset(editor)), computedUserset(owner))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 1, owner, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, editor, beatrix).
tuple(document, 3, writer, charlie).
tuple(document, 4, editor, daphne).
tuple(document, 5, owner, elise).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- \+ check(document, 4, viewer, daphne).
:- \+ check(document, 5, viewer, elise).
:- cleanup.

% Exclusion and intersection in subtrahend
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, exclusion(computedUserset(writer), intersection(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 1, owner, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, editor, beatrix).
tuple(document, 3, writer, charlie).
tuple(document, 3, owner, charlie).
tuple(document, 4, writer, daphne).
tuple(document, 5, editor, elise).
tuple(document, 6, owner, fernanda).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- check(document, 4, viewer, daphne).
:- \+ check(document, 5, viewer, elise).
:- \+ check(document, 6, viewer, fernanda).
:- cleanup.

% Exclusion and exclusion in minuend
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, exclusion(exclusion(computedUserset(writer), computedUserset(editor)), computedUserset(owner))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, owner, beatrix).
tuple(document, 3, writer, charlie).
tuple(document, 4, editor, elise).
tuple(document, 5, editor, fernanda).
:- \+ check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- \+ check(document, 4, viewer, elise).
:- \+ check(document, 5, viewer, fernanda).
:- cleanup.

% Exclusion and exclusion in subtrahend
config(document, writer, self).
config(document, editor, self).
config(document, owner, self).
config(document, viewer, exclusion(computedUserset(writer), exclusion(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 1, owner, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 2, editor, beatrix).
tuple(document, 3, writer, charlie).
tuple(document, 3, owner, charlie).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- cleanup.
