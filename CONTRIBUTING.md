# Project contributing guide

First of all, thank you for your interest in being part of our development
team, this is an awesome decision 👍!

Before starting, please, take a look at our
[code of conduct](../../../.github/blob/master/CODE_OF_CONDUCT.md) which
provide some guidelines about how to interact with our community, what expect
with your contribution submission and what other people **shouldn't** do or
behave in face of your actions.

Also, worths mention that [issue trackers](../../issues) aren't the right place
to ask for help. Common tasks may be already documented on any of the community
files like [README](README.md), this contributing file, [LICENSE](LICENSE.md)
or [SUPPORT](SUPPORT.md).

## Getting started

If you're familiar with git, you can safely skip this step.

First things first, make sure that you already [forked](../../fork) this
repository.

Then, it's recommended that you clone **your fork** into a local environment.
To do so, run the following command into a terminal emulator:

`git clone https://github.com/(your-github-username)/.github.git`

You can also make use of graphical git clients like [github desktop](https://desktop.github.com)
or [git kraken](https://www.gitkraken.com).

After successfully cloning, you're able to start changing or creating things.

## Committing behavior

We strongly recommend that you [commit often, perfect later, publish once](https://en.wikibooks.org/wiki/Commit_Often,_Perfect_Later,_Publish_Once:_Git_Best_Practices/Commiting_early_and_often).

This means that each checkpoint, each piece of work that should be preserved
need to gain a commit and - I would particularly advise - a push. Such practice
will prevent you from losing hours (even days!) of work in case of, for example,
hard disk data loss.

Dont bother with commit amount or its content. You can open a PR with several
_"[wip] doing things..."_ commits that your PR will be [squashed](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History#_squashing)
into a single and meaningful commit when your PR is merged.

But the *content* of the PR will be used as the commit message, so make sure that
it is well written. [Here](https://thoughtbot.com/blog/5-useful-tips-for-a-better-commit-message)
and [here](https://chris.beams.io/posts/git-commit/) are some tips 😉.

## Conventions

### Coding standards

Make sure to follow the project coding standards. This will be a real blocker
for your contribution being accepted.

These rules often describe file encoding, line-break characters, identation
rules and variable case naming.

### Pull request rules

- Your pull request should be **always linked to an issue**
- Your issue should carry one of the following types:
  - Bug: Misbehaviors. Something acts in an unexpected way
  - Feat: Something that you consider useful is missing
  - Misc: Typos, docs, refactors, etc
- Your PR content should make use of a [keyword that close the related issue](https://help.github.com/en/articles/closing-issues-using-keywords)
- Your PR should always target the source branch

### Branch rules

- Your branch should follow the pattern `[type]-#ISSUE-short-description` like:
  - `bug-#35-segfault-on-macos`
  - `feat-#18-windows-support`
  - `misc-#41-increase-build-verbosity`
- Your branch should be mergeable into the source branch

### Commit rules

- Use the present tense ("Add feature" not "Added feature")
- Use the imperative mood ("Move cursor to..." not "Moves cursor to...")
- Limit the first line to 72 characters or less than 54 whenever possible

These rules applies to the content written into the PR ticket, as described on
[Committing behavior section](#committing-behavior).

## Optional recommends

You might [sign your commits](https://help.github.com/en/articles/signing-commits)
to ensure an additional security layer and prevent username tampering,
endorsing **your** identity online as an active an trustworthy contributor.

We encourage the usage of [gitmoji](https://gitmoji.carloscuesta.me/), but
your PR won't be denied if you decide to don't use it.

When applicable, please include [vim modelines](https://vim.fandom.com/wiki/Modeline_magic)
into your code to help vim users keep coding standards while editing. Some
modern editors may take advantage of these modelines also, providing useful
help on auto-formatters.

<!-- vim: set ai si sta et sw=4 sts=4 fenc=utf-8 nobomb eol ff=unix ft=markdown:
