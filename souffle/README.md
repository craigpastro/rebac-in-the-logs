# Souffle

A version using [Souffle](https://souffle-lang.github.io/).

Run the ancestor file sending output to stdout (with `-`):
```
souffle --output-dir=- zanzibar.dl
```

## Reading from SQLite3

```
.decl edge(source:symbol, target:symbol)
.input edge(IO=sqlite, dbname="path/to/sqlite3db")
```

Data will now be read from an sqlite3 database at the given path. The data is expected to be stored in a table matching the relation name prefixed by an underscore and the sqlite3 database is expected to contain a view matching the relation name. For example, for the relation `edge`, the sqlite3 database should have a table named `_edge` containing the data and a view named `edge` that returns the data from `_edge`.

```
create table _edge (source, target);
create view edge as select * from _edge;
```





