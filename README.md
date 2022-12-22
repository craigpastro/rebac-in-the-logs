# Zanzibar in the Logs

Inspired by the article [Is Datalog a good language for authorization?](https://neilmadden.blog/2022/02/19/is-datalog-a-good-language-for-authorization/) by Neil Madden, I am playing around trying to write a Zanzibar implementation with some of the "...logs".

- [SWI-Prolog](./swipl)
- [Logica](./logica) WIP
- [Souffle](./souffle) WIP

The main difference between the Prolog version and the current Datalog versions is that I can't figure out how to get intersection and exclusion to work in the latter. The current Prolog prolog does not seem to be translatable to Datalog due to "ungrounded variables" in the head of a rule. **If anyone can help with this please let me know!** I would love to talk to someone who knows (or would like to learn) Datalog or Logica or Mangle.
