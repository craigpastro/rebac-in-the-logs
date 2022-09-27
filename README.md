# Zanzibar in Prolog

## What is this?

Inspired by the article [Is Datalog a good language for authorization?](https://neilmadden.blog/2022/02/19/is-datalog-a-good-language-for-authorization/) by Neil Madden, I am playing around trying to write a Zanzibar implementation in [Prolog](https://www.swi-prolog.org/).

## How does it work?

You will need to have the [SWI-Prolog](https://www.swi-prolog.org/) variant of Prolog installed. I installed it with brew:
```console
$ brew install swi-prolog
```

Note to self: check out [Logtalk](https://logtalk.org/)?

Once installed, start it up with `swipl`. You should see a prompt like `?-`.

Try loading one of the files. For example, the GitHub model can be loaded as follows:
```prolog
?- [github]
true.
```
The `true.` at the end means it loaded the Zanzibar implementation, the GitHub model, and checked some assertions.

Try some of your own assertions such as
```
?- userTuple(repo, openfga/openfga, writer, charles).
```

Get out of Prolog with
```prolog
?- halt.
```

## Modelling

TODO: more explaination

```
model(namespace, relation, rewrite)
```
where rewrite can be any of
- `self`
- `computedUserset(r)`, where r is a relation
- `tupleToUserset(r, s)`, where r and s are relations, called the _tupleset_ and _computed userset_ respectively.

Intersection and Exclusion are yet to be done. I started something [here](intersection.pl), but I think it is wrong.

### Self

I am not really sure we need `self`. But we do need a triple, so maybe `model(N, R, self)` is fine. Need to understand the meaning better.

### Union

`define R as S or T`. This union is written as:
```
model(N, R, S)
model(N, R, T)
```

### Intersection and exclusion

Not yet

## Tuples

```prolog
userTuple(namespace, objectId, relation, user)
usersetTuple(namespace, objectId, relation, userNamespace, userObjectId, userRelation)
```
`userRelation` may be empty, which we represent as `empty`.

## Check

To check if `namespace:objectId#relation@user` is allowed simply:

```prolog
?- userTuple(namespace, objectId, relation, user)
```
Similarly for `usersetTuple`s.

## List objects or relations

### List objects

What objects in `namespace` does `user` have a `relation` with:
```prolog
?- userTuple(namespace, X, relation, user)
```

More generally, fill in what you want to constrain. For example, what objects in `namespace` does `user` have a relation with:
```prolog
?- userTuple(namespace, X, R, user)
```
This will return the object X and the relation X it has with it.

Of course, this works with usersetTuples as well.

### List relations

What relations does `user` have on `object` in `namespace`:
```prolog
?- userTuple(namespace, object, R, user)
```

Use `;` to see the next result.

TODO: How do I print all results?


## You can help me!

- Help me learn Prolog
- Help me learn Datalog
- Help me understand Zanzibar

## References

- [Is Datalog a good language for authorization?](https://neilmadden.blog/2022/02/19/is-datalog-a-good-language-for-authorization/)
- [SWI-Prolog](https://www.swi-prolog.org/)
- [Learn Prolog Now!](http://www.let.rug.nl/bos/lpn//)
- [Zanzibar paper](https://research.google/pubs/pub48190/)
