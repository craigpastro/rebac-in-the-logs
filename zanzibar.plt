:- begin_tests(zanzibar_test).
:- include(zanzibar).

% test(check1, [
%     setup(assertz(schema(doc, writer, self))),
%     setup(assertz(schema(doc, viewer, union(self, computedUserset(writer))))),
%     setup(assertz(tuple(doc, 1, viewer, alice))),
%     setup(assertz(tuple(doc, 2, writer, bob))),
%     cleanup(retractall(schema(_, _, _))),
%     cleanup(retractall(tuple(_, _, _, _)))
% ]) :- check(doc, 1, viewer, alice).


schema(doc, writer, self).
schema(doc, viewer, union(self, computedUserset(writer))).
tuple(doc, 1, viewer, alice).
tuple(doc, 2, writer, bob).

test(check1) :- check(doc, 1, viewer, alice).
test(check2) :- check(doc, 2, viewer, bob).
test(itwillpass) :- check(doc, 2, writer, bob).

:- end_tests(zanzibar_test).
