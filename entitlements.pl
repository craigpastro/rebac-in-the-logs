:- include('zanzibar.pl').

% Model
model(plan, subscriber, self).
model(plan, subscriber_member, tupleToUserset(subscriber, member)).

model(organization, member, self).

model(feature, access, tupleToUserset(associated_plan, subscriber_member)).
model(feature, associated_plan, self).

% Tuples
userTuple(organization, alpha, member, anne).
userTuple(organization, brayer, member, beth).
userTuple(organization, cups, member, charles).

usersetTuple(feature, draft_prs, associated_plan, plan, enterprise, empty).
usersetTuple(feature, draft_prs, associated_plan, plan, team, empty).
usersetTuple(feature, issues, associated_plan, plan, enterprise, empty).
usersetTuple(feature, issues, associated_plan, plan, free, empty).
usersetTuple(feature, issues, associated_plan, plan, team, empty).
usersetTuple(feature, sso, associated_plan, plan, enterprise, empty).
usersetTuple(plan, enterprise, subscriber, organization, cups, empty).
usersetTuple(plan, free, subscriber, organization, alpha, empty).
usersetTuple(plan, team, subscriber, organization, brayer, empty).

% Assertions
:- userTuple(feature, issues, access, anne).
:- userTuple(feature, issues, access, beth).
:- userTuple(feature, draft_prs, access, beth).
:- userTuple(feature, issues, access, charles).
:- userTuple(feature, draft_prs, access, charles).
:- userTuple(feature, sso, access, charles).
:- \+ userTuple(feature, draft_prs, access, anne).
:- \+ userTuple(feature, sso, access, anne).
:- \+ userTuple(feature, sso, access, beth).
