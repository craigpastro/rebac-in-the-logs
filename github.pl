:- include('zanzibar.pl').

% Model
% tupleToUserset(tupleset, computedUserset)  -- in our notation computedUserset from tupleset (member from crossing)
model(team, member, self).

model(repo, admin, self).
model(repo, admin, tupleToUserset(owner, repo_admin)).
model(repo, maintainer, self).
model(repo, maintainer, computedUserset(admin)).
model(repo, owner, self).
model(repo, reader, self).
model(repo, reader, computedUserset(triager)).
model(repo, reader, tupleToUserset(owner, repo_reader)).
model(repo, triager, self).
model(repo, triager, computedUserset(writer)).
model(repo, writer, self).
model(repo, writer, computedUserset(maintainer)).
model(repo, writer, tupleToUserset(owner, repo_writer)).

model(org, billing_manager, self).
model(org, billing_manager, computedUserset(owner)).
model(org, member, self).
model(org, member, computedUserset(owner)).
model(org, owner, self).
model(org, repo_admin, self).
model(org, repo_reader, self).
model(org, repo_writer, self).

model(app, app_manager, self).
model(app, app_manager, tupleToUserset(owner, owner)).
model(app, owner, self).


% Tuples
userTuple(org, openfga, member, erik).
userTuple(repo, openfga/openfga, reader, anne).
userTuple(repo, openfga/openfga, writer, beth).
userTuple(team, openfga/core, member, charles).
userTuple(team, openfga/backend, member, diane).

usersetTuple(org, openfga, repo_admin, org, openfga, member).
usersetTuple(repo, openfga/openfga, admin, team, openfga/core, member).
usersetTuple(repo, openfga/openfga, owner, org, openfga, empty).
usersetTuple(team, openfga/core, member, team, openfga/backend, member).


% Assertions
:- userTuple(repo, openfga/openfga, reader, anne).
:- userTuple(repo, openfga/openfga, admin, diane).
:- userTuple(repo, openfga/openfga, reader, erik).
:- userTuple(repo, openfga/openfga, writer, charles).
:- not(userTuple(repo, openfga/openfga, triager, anne)).
:- not(userTuple(repo, openfga/openfga, admin, beth)).
