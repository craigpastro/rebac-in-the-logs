:- include('zanzibar.pl').

% tupleToUserset(tupleset, computedUserset)  -- in our notation computedUserset from tupleset (member from crossing)
% Model
model(group, member, self).
model(document, crossing, self).
model(document, writer, self).
model(document, writer, tupleToUserset(crossing, member)).
model(document, reader, self).
model(document, reader, computedUserset(writer)).

% Tuples
userTuple(group, x, member, anna).
userTuple(document, b, writer, susan).
usersetTuple(document, a, crossing, group, x, empty). % empty is special


% Assertions
:- userTuple(document, b, reader, susan).
:- usersetTuple(document, a, writer, group, x, member).
:- userTuple(document, a, writer, anna).
