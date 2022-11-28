:- include('zanzibar.pl').

% schema(doc, writer, self).
% schema(doc, viewer, union(self, computedUserset(writer))).
% tuple(doc, 1, viewer, alice).
% tuple(doc, 2, writer, bob).

:- begin_tests(zanzibar).

test(viewer, [
    setup((
        assertz(schema(doc, writer, self)),
        assertz(schema(doc, viewer, union(self, computedUserset(writer)))),
        assertz(tuple(doc, 1, viewer, alice)),
        assertz(tuple(doc, 2, writer, bob))
    )),
    cleanup((
        retractall(schema(_, _, _)),
        retractall(tuple(_, _, _, _))
    ))
]) :- check(doc, 1, viewer, alice).

test(check1) :- check(doc, 1, viewer, alice).
test(check2) :- check(doc, 2, viewer, bob).

:- end_tests(zanzibar).
