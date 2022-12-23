@Engine("sqlite");
@AttachDatabase("db", "zanzibar.db");

Config(namespace: "folder",   rel: "viewer", rewrite: "self", relation: "", tupleset: "", computed_userset: "");
Config(namespace: "document", rel: "parent", rewrite: "self", relation: "", tupleset: "", computed_userset: "");
Config(namespace: "document", rel: "writer", rewrite: "self", relation: "", tupleset: "", computed_userset: "");
Config(namespace: "document", rel: "viewer", rewrite: "self", relation: "", tupleset: "", computed_userset: "");
Config(namespace: "document", rel: "viewer", rewrite: "computedUserset", relation: "writer", tupleset: "", computed_userset: "");
Config(namespace: "document", rel: "viewer", rewrite: "tupleToUserset", relation: "", tupleset: "parent", computed_userset: "viewer");

Tuple(namespace: "folder", id: "x", rel: "viewer", user: "id", user_id: "aardvark", user_namespace: "", user_object_id: "", user_relation: "");
Tuple(namespace: "document", id: "1", rel: "parent", user: "object", user_id: "", user_namespace: "folder", user_object_id: "x", user_relation: "");
Tuple(namespace: "document", id: "2", rel: "writer", user: "id", user_id: "badger", user_namespace: "", user_object_id: "", user_relation: "");
# Tuple(namespace: "document", id: "1", rel: "writer", user: "id", user_id: "badger", user_namespace: "", user_object_id: "", user_relation: "");


List(namespace:, id:, rel:, user:, user_id:, user_namespace:, user_object_id:, user_relation:) :-
    Config(namespace:, rel:, rewrite: "self"),
    Tuple(namespace:, id:, rel:, user:, user_id:, user_namespace:, user_object_id:, user_relation:);

List(namespace:, id:, rel:, user:, user_id:, user_namespace:, user_object_id:, user_relation:) :-
    Config(namespace:, rel:, rewrite: "computedUserset", relation: rel0),
    List(namespace:, id:, rel: rel0, user:, user_id:, user_namespace:, user_object_id:, user_relation:);

List(namespace:, id:, rel:, user:, user_id:, user_namespace:, user_object_id:, user_relation:) :-
    Config(namespace:, rel:, rewrite: "tupleToUserset", tupleset: tupleset, computed_userset: computeduserset),
    Tuple(namespace:, id:, rel: tupleset, user: "object", user_namespace: usernamespace, user_object_id: userobjectid, user_relation:),
    List(namespace: usernamespace, id: userobjectid, rel: computeduserset, user:, user_id:, user_namespace:, user_object_id:, user_relation:);

DocumentViewers(id:, user:, user_id:, user_namespace:, user_object_id:, user_relation:) :-
    List(namespace: "document", id:, rel: "viewer", user:, user_id:, user_namespace:, user_object_id:, user_relation:);

# List(namespace:, id:, rel:, user:, user_id:, user_namespace:, user_object_id:, user_relation:) :-
#     Config(namespace:, rel:, rewrite: "tupleToUserset", tupleset: tupleset, computed_userset: computed_userset),
#     Tuple(namespace:, id:, rel: tupleset, user: "userset", user_namespace: user_namespace, user_object_id: user_object_id, user_relation: computed_userset),
#     List(namespace: user_namespace, id: user_object_id, rel: computed_userset, user:, user_id:, user_namespace:, user_object_id:, user_relation:);
