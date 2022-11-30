:- include(zanzibar).
:- discontiguous check/4.
:- discontiguous tuple/4.

cleanup :-
    retractall(schema(_, _, _)),
    retractall(tuple(_, _, _, _)).

% This
schema(document, viewer, self).
tuple(document, 1, viewer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Computed Userset
schema(document, writer, self).
schema(document, viewer, computedUserset(writer)).
tuple(document, 1, writer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Tuple-to-userset
schema(folder, viewer, self).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% This and union
schema(document, writer, self).
schema(document, viewer, union(self, computedUserset(writer))).
tuple(document, 1, viewer, abigail).
tuple(document, 2, writer, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- cleanup.

% This and intersection
schema(document, writer, self).
schema(document, viewer, intersection(self, computedUserset(writer))).
tuple(document, 1, viewer, abigail).
tuple(document, 1, writer, abigail).
tuple(document, 2, viewer, beatrix).
tuple(document, 3, writer, charlie).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% This and exclusion base
schema(document, writer, self).
schema(document, viewer, exclusion(self, computedUserset(writer))).
tuple(document, 1, viewer, abigail).
tuple(document, 1, writer, abigail).
tuple(document, 2, viewer, beatrix).
tuple(document, 3, writer, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Computed userset and union
schema(document, writer, self).
schema(document, editor, self).
schema(document, viewer, union(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- cleanup.

% Computed userset and intersection
schema(document, writer, self).
schema(document, editor, self).
schema(document, viewer, intersection(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 3, editor, charlie).
:- check(document, 1, viewer, abigail).
:- \+ check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Computed userset and exclusion
schema(document, writer, self).
schema(document, editor, self).
schema(document, viewer, exclusion(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 3, editor, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Tuple-to-userset and computed userset
schema(folder, writer, self).
schema(folder, viewer, computedUserset(writer)).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Tuple-to-userset and tuple-to-userset
schema(group, member, self).
schema(folder, parent, self).
schema(folder, viewer, tupleToUserset(parent, member)).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, parent, object(group, g)).
tuple(group, g, member, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Tuple-to-userset and union
schema(folder, writer, self).
schema(folder, editor, self).
schema(folder, viewer, union(computedUserset(writer), computedUserset(editor))).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
tuple(folder, x, editor, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 1, viewer, beatrix).
:- cleanup.

% Tuple-to-userset and intersection
schema(folder, writer, self).
schema(folder, editor, self).
schema(folder, viewer, intersection(computedUserset(writer), computedUserset(editor))).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
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
schema(folder, writer, self).
schema(folder, editor, self).
schema(folder, viewer, exclusion(computedUserset(writer), computedUserset(editor))).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
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
schema(folder, viewer, self).
schema(document, parent, self).
schema(document, writer, self).
schema(document, viewer, union(computedUserset(writer), tupleToUserset(parent, viewer))).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
tuple(document, 1, writer, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 1, viewer, beatrix).
:- cleanup.

% Union and union
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, union(computedUserset(writer), union(computedUserset(editor), computedUserset(owner)))).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
tuple(document, 3, owner, charlie).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- cleanup.

% Union and intersection
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, union(computedUserset(writer), intersection(computedUserset(editor), computedUserset(owner)))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, union(computedUserset(writer), exclusion(computedUserset(editor), computedUserset(owner)))).
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
schema(folder, viewer, self).
schema(document, parent, self).
schema(document, writer, self).
schema(document, viewer, intersection(computedUserset(writer), tupleToUserset(parent, viewer))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, intersection(computedUserset(writer), union(computedUserset(editor), computedUserset(owner)))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, intersection(computedUserset(writer), intersection(computedUserset(editor), computedUserset(owner)))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, intersection(computedUserset(writer), exclusion(computedUserset(editor), computedUserset(owner)))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, viewer, exclusion(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 1, editor, abigail).
tuple(document, 2, writer, beatrix).
tuple(document, 3, editor, charlie).
:- \+ check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- \+ check(document, 3, viewer, charlie).
:- cleanup.

% Exclusion and tuple-to-userset in minuend
schema(folder, viewer, self).
schema(document, parent, self).
schema(document, writer, self).
schema(document, viewer, exclusion(tupleToUserset(parent, viewer), computedUserset(writer))).
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
schema(folder, viewer, self).
schema(document, parent, self).
schema(document, writer, self).
schema(document, viewer, exclusion(computedUserset(writer), tupleToUserset(parent, viewer))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, exclusion(union(computedUserset(writer), computedUserset(editor)), computedUserset(owner))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, exclusion(computedUserset(writer), union(computedUserset(editor), computedUserset(owner)))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, exclusion(intersection(computedUserset(writer), computedUserset(editor)), computedUserset(owner))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, exclusion(computedUserset(writer), intersection(computedUserset(editor), computedUserset(owner)))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, exclusion(exclusion(computedUserset(writer), computedUserset(editor)), computedUserset(owner))).
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
schema(document, writer, self).
schema(document, editor, self).
schema(document, owner, self).
schema(document, viewer, exclusion(computedUserset(writer), exclusion(computedUserset(editor), computedUserset(owner)))).
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
