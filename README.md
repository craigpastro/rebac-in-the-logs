# Zanzibar in Prolog

## What is this?

Inspired by the article [Is Datalog a good language for authorization?](https://neilmadden.blog/2022/02/19/is-datalog-a-good-language-for-authorization/) by Neil Madden, I am playing around trying to write a Zanzibar implementation in [Prolog](https://www.swi-prolog.org/).

```prolog
schema(folder, viewer, self).
schema(document, parent, self).
schema(document, viewer, tupleToUserset(parent, viewer)).
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
schema(document, owner, self).
schema(document, editor, union(self, computedUserset(owner))).
schema(document, viewer, union(self, union(editor, tupleToUserset(parent, viewer)))).
```

The general form of the `schema` functor is
```prolog
schema(Namespace, Relation, Rewrite).
```
where `Namespace` and `Relation` are names, and `Rewrite` can be either of:
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
where `Namespace`, `Id`, `Relation` are names, and `User` can be either of:
- a name representing a concrete user.
- `object(Namespace, Id)`, where `Namespace` and `Id` are names.
- `userset(Namespace, Id, Relation)`, where `Namespace`, `Id`, and `Relation` are names.

## Check

Once you have written your model and tuples into a file and loaded it into Prolog you can try running some checks. To check if `abigail` is a `viewer` of `document:secret` you would input
```prolog
?- check(document, secret, viewer, abigail).
```
If Prolog returns `true` then `abigail` is a `viewer` of `document:secret`, and `false` if not.

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

## Tests

Run `make test` to run the tests. The tests provide examples of how to write schemas and tuples.

## How to make this useful?

My first thought was to somehow wrap it as a web app using something like https://github.com/ichiban/prolog. Another thought was to learn Datalog (or whatever https://github.com/google/mangle is), and see if I could implement this in Datalog.

In any case, I could use your help! As you can probably tell, I am not an expert of Prolog. Please reach out here or at [twitter](https://twitter.com/craigpastro), and let me know if you can help!
