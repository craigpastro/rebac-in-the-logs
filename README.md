# Zanzibar in Prolog

## What is this?

Inspired by the article [Is Datalog a good language for authorization?](https://neilmadden.blog/2022/02/19/is-datalog-a-good-language-for-authorization/) by Neil Madden, I am playing around trying to write a Zanzibar implementation in [Prolog](https://www.swi-prolog.org/).

```prolog
config(folder, viewer, self).
config(document, parent, self).
config(document, viewer, tupleToUserset(parent, viewer)).
tuple(document, 1, parent, object(folder, x)).
tuple(folder, x, viewer, abigail).

?- check(document, 1, viewer, abigail).
true
```

## How does it work?

You will need to have the [SWI-Prolog](https://www.swi-prolog.org/) variant of Prolog installed. I installed it with brew:
```console
brew install swi-prolog
```

Once installed, start it up with `swipl`. You should see a prompt like `?-`. You can quit Prolog by entering `halt.` at the prompt.

## Modelling

A model similar to the one found in the [Zanzibar paper](https://storage.googleapis.com/pub-tools-public-publication-data/pdf/10683a8987dbf0c6d4edcafb9b4f05cc9de5974a.pdf) can be written as
```prolog
config(document, owner, self).
config(document, editor, union(self, computedUserset(owner))).
config(document, viewer, union(self, union(editor, tupleToUserset(parent, viewer)))).
```

The general form of the `config` functor is
```prolog
config(Namespace, Relation, Rewrite).
```
where `Namespace` and `Relation` are names, and `Rewrite` can be:
- `self`.
- `computedUserset(r)`, where `r` is a name.
- `tupleToUserset(r, s)`, where `r` and `s` are names, called the _tupleset_ and _computed userset_ of the rewrite respectively.
- `union(R1, R2)`, where `R1` and `R2` are rewrites themselves.
- `intersection(R1, R2)`, where `R1` and `R2` are rewrites themselves.
- `exclusion(R1, R2)`, where `R1` and `R2` are rewrites themselves.

## Adding tuples

Tuples in this system are written as follows
```prolog
tuple(Namespace, Id, Relation, User).
```
where `Namespace`, `Id`, `Relation` are names, and `User` can be:
- a name representing a concrete user.
- `object(Namespace, Id)`, where `Namespace` and `Id` are names.
- `userset(Namespace, Id, Relation)`, where `Namespace`, `Id`, and `Relation` are names.

## Check

Once you have written your model and tuples into a file and loaded it into Prolog you can try running some checks. To check if `abigail` is a `viewer` of `document:secret` you would input
```prolog
?- check(document, secret, viewer, abigail).
```
Prolog returns `true` if `abigail` is a `viewer` of `document:secret`, and `false` if not.

## List

Suppose you are interested in the `document`s that `abigail` is a `viewer` of. This can be accomplished with
```prolog
?- list(document, X, viewer, abigail).
```
Keep pressing `;` to retrieve all the users.

Similarly, suppose you are interested in the users which can view `document:secret`. This is done as
```prolog
?- list(document, secret, viewer, X).
```

All other combinations are possible. Simply insert variables into the positions of interest and run the query.

## Tests

Run `make test` to run the tests. The tests provide examples of how to write schemas and tuples.

## Future Plans

I have wrapped this Prolog program in a web app which can be found https://github.com/craigpastro/nungwi. At some point I'll probably just continue work over there.

Currently investigating if I can do this using [Logica](https://github.com/EvgSkv/logica) or Datalog (or whatever https://github.com/google/mangle is).

## Modelling

Write schemas using the following notation, one relation config per line:
```
config(namespace, relation, computedUserset(writer))
config(namespace, relation, tupleToUserset(tupleset, computedUserset))
config(namespace, relation, union(rewrite1, rewrite2))
config(namespace, relation, intersection(rewrite1, rewrite2))
config(namespace, relation, exclusion(rewrite1, rewrite2))
```

Write tuples in the following notation:
```
tuple(namespace, id, relation, alice).
tuple(namespace, id, relation, object(namespace, id)).
tuple(namespace, id, relation, userset(namespace, id, relation)).
```

## Contributions

I would love to talk to a Datalog or Logica or Mangle expert, or really anyone that would like to help. Please reach out!
