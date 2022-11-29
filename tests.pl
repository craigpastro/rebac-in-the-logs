:- include(zanzibar).
:- discontiguous check/4.
:- discontiguous tuple/4.

% This
schema(document, viewer, self).
tuple(document, 1, viewer, abigail).
:- check(document, 1, viewer, abigail).
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).


% Computed Userset
schema(document, writer, self).
schema(document, viewer, computedUserset(writer)).
tuple(document, 1, writer, abigail).
:- check(document, 1, viewer, abigail).
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

% Tuple-to-userset
schema(folder, viewer, self).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).
:- check(document, 1, viewer, abigail).
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).


% This and union
schema(document, writer, self).
schema(document, viewer, union(self, computedUserset(writer))).
tuple(document, 1, viewer, abigail).
tuple(document, 2, writer, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

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
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

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
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

% Computed userset and union
schema(document, writer, self).
schema(document, editor, self).
schema(document, viewer, union(computedUserset(writer), computedUserset(editor))).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

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
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

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
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

% Tuple-to-userset and computed userset
schema(folder, writer, self).
schema(folder, viewer, computedUserset(writer)).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
:- check(document, 1, viewer, abigail).
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

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
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

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
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).

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
:- retractall(schema(_, _, _)).
:- retractall(tuple(_, _, _, _)).