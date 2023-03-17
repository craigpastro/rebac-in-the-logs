:- include(zanzibar_v1).
:- discontiguous(check/4).
:- discontiguous(tuple/4).

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
config(document, viewer, self).
config(document, viewer, computedUserset(writer)).
tuple(document, 1, viewer, abigail).
tuple(document, 2, writer, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- cleanup.

% Computed userset and computed userset
config(document, owner, self).
config(document, writer, computedUserset(owner)).
config(document, viewer, computedUserset(writer)).
tuple(document, 1, owner, abigail).
:- check(document, 1, viewer, abigail).
:- cleanup.

% Computed userset and union
config(document, writer, self).
config(document, editor, self).
config(document, viewer, computedUserset(writer)).
config(document, viewer, computedUserset(editor)).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
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
config(folder, viewer, computedUserset(writer)).
config(folder, viewer, computedUserset(editor)).
config(folder, viewer, computedUserset(writer)).
config(folder, viewer, computedUserset(editor)).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, writer, abigail).
tuple(folder, x, editor, beatrix).
:- check(document, 1, viewer, abigail).
:- check(document, 1, viewer, beatrix).
:- cleanup.

% Union and tuple-to-userset
config(folder, viewer, self).
config(document, parent, self).
config(document, writer, self).
config(document, viewer, computedUserset(writer)).
config(document, viewer, tupleToUserset(parent, viewer)).
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
config(document, viewer, computedUserset(writer)).
config(document, viewer, computedUserset(editor)).
config(document, viewer, computedUserset(owner)).
tuple(document, 1, writer, abigail).
tuple(document, 2, editor, beatrix).
tuple(document, 3, owner, charlie).
:- check(document, 1, viewer, abigail).
:- check(document, 2, viewer, beatrix).
:- check(document, 3, viewer, charlie).
:- cleanup.

