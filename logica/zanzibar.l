@Engine("sqlite");
@AttachDatabase("db", "zanzibar.db");

Config(
    namespace: "folder",
    rel: "viewer",
    rewrite: "self",
    relation: "",
    tupleset: "",
    computed_userset: ""
);
Config(
    namespace: "document",
    rel: "parent",
    rewrite: "self",
    relation: "",
    tupleset: "",
    computed_userset: ""
);
Config(
    namespace: "document",
    rel: "viewer",
    rewrite: "self",
    relation: "",
    tupleset: "",
    computed_userset: ""
);
Config(
    namespace: "document",
    rel: "viewer",
    rewrite: "tupleToUserset",
    relation: "",
    tupleset: "parent",
    computed_userset: "viewer"
);

Tuple(
    namespace: "folder",
    object_id: "x",
    rel: "viewer",
    user_type: "id",
    user_id: "aardvark",
    user_namespace: "",
    user_object_id: "",
    user_relation: ""
);
Tuple(
    namespace: "document",
    object_id: "1",
    rel: "parent",
    user_type: "object",
    user_id: "",
    user_namespace: "folder",
    user_object_id: "x",
    user_relation: ""
);
Tuple(
    namespace: "document",
    object_id: "1",
    rel: "viewer",
    user_type: "id",
    user_id: "badger",
    user_namespace: "",
    user_object_id: "",
    user_relation: ""
);


List(
    namespace:,
    object_id:,
    rel:,
    user_type:,
    user_id:,
    user_namespace:,
    user_object_id:,
    user_relation:
) :-
    Config(
        namespace:,
        rel:,
        rewrite: "self"
    ),
    Tuple(
        namespace:,
        object_id:,
        rel:,
        user_type:,
        user_id:,
        user_namespace:,
        user_object_id:,
        user_relation:
    );

List(
    namespace:,
    object_id:,
    rel:,
    user_type:,
    user_id:,
    user_namespace:,
    user_object_id:,
    user_relation:
) :-
    Config(namespace:, rel:, rewrite: "computedUserset", relation: rel0),
    List(namespace:, object_id:, rel: rel0, user_type:, user_id:, user_namespace:, user_object_id:, user_relation:);

List(
    namespace:,
    object_id:,
    rel:,
    user_type:,
    user_id:,
    user_namespace:,
    user_object_id:,
    user_relation:
) :-
    Config(namespace:, rel:, rewrite: "tupleToUserset", tupleset: tupleset, computed_userset: computeduserset),
    Tuple(namespace:, object_id:, rel: tupleset, user_type: "object", user_namespace: usernamespace, user_object_id: userobjectid, user_relation:),
    List(namespace: usernamespace, object_id: userobjectid, rel: computeduserset, user_type:, user_id:, user_namespace:, user_object_id:, user_relation:);

List(
    namespace:,
    object_id:,
    rel:,
    user_type:,
    user_id:,
    user_namespace:,
    user_object_id:,
    user_relation:
 ) :-
    Config(namespace:, rel:, rewrite: "tupleToUserset", tupleset: tupleset, computed_userset: computeduserset),
    Tuple(namespace:, object_id:, rel: tupleset, user_type: "userset", user_namespace: usernamespace, user_object_id: userobjectid, user_relation: computeduserset),
    List(namespace: usernamespace, object_id: userobjectid, rel: computeduserset, user_type:, user_id:, user_namespace:, user_object_id:, user_relation:);

DocumentViewers(object_id:, user_type:, user_id:, user_namespace:, user_object_id:, user_relation:) :-
    List(namespace: "document", object_id:, rel: "viewer", user_type:, user_id:, user_namespace:, user_object_id:, user_relation:);


