How to contribute?
==================

If you are reading this, chances are you want to contribute to the project,
and that is already great news.

Issues
------

Issues in the project are tracked in the `GitHub issues`_.

Please create an issue even if you plan to fix it (instead of creating a merge
request directly - see below).

If you are reporting a bug, in the description of the issue try to focus on clearly
stating the steps necessary to reproduce the problem - this will make it easier to
trace and fix the bug and prevent unnecessary frustration and delays.

If you'd like to file a feature request, then just carefully describe what you need
- the more background and precise suggestions you provide, the higher the chance
that someone will be able to implement it.

A good issue will include:

* the platform you are using (MacOS, Windows, Linux, what distro/version?)
* the build system version you are using (Git commit)

Pull requests
-------------

If you plan to fix an issue by yourself, you should use the `GitHub pull requests`_.

To do that, you need to:

* create a fork of our repository on your account (if you haven't done it already);
* create a branch based on the current ``master`` branch with a meaningful name;
* write and commit your code (see sections below);
* create the pull request to our repository on that branch.

What happens then?

Your merge request will be reviewed, and a discussion on GitHub will ensue.

We might ask you to do some fixes or write a test for your change, but this is only
meant to keep code quality high(er).

.. _`GitHub issues`: https://github.com/roddehugo/arm-build-system/issues
.. _`GitHub pull requests`: https://github.com/roddehugo/arm-build-system/pulls

Committing
----------

Guidelines
++++++++++

We recommend small commits. Note that while small commits can always be squashed
together, dividing commits is not that straightforward.

For example if for the issue to be fixed you need to correct two classes without
changing their public interface, do it in two separate commits.  Also if the change
as a whole is big, it is easier to review it afterwards if it is divided into parts
similar to the way the original author introduced the changes.  If you change some
names and behaviour in the same commit, it is hard to tell which changes apply
where.

If you are fixing some formatting issue, please take care to separate these changes
from any logic-related commits.  You don't have to split formatting of different
files into different commits, however, formatting changes are best done
simultaneously for coherence. The same goes for renames, please avoid renaming a
file _and_ editing code inside that file.s

It is vital to have all the code compiling without errors after each commit - this
is useful for bisecting.

Commit messages
+++++++++++++++

Here is a proposed format of the commit message:

.. code-block::

   Short description of a commit, refs #1234

   If you feel that the commit needs a bit more explanation than
   a short description you can put all your thoughts here (after
   a blank line).

``#1234`` is obviously the number of the GitHub issue that describes the problem
you're trying to fix.

The short description is just a short sentence describing changes introduced by a
commit.  If you have problems to formulate a single sentence (because the commit
makes a lot of changes) than perhaps you should consider splitting it into several
independent commits (as noted above).  We usually write these descriptions in a form
of a sentence, in imperative mood, starting with a capitalized letter.

The long description is not obligatory, but nice to have.
There is no word limit here, but we all should be reasonable.
Discussions and long analyses should be placed in the GitHub issue system.

A good blog post about `Git commit messages`_.

.. _`Git commit message`: https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

Code formatting and quality
---------------------------

Please do not introduce formatting that is strictly inconsistent with other files,
and make best effort to be consistent in your variable naming and comments.

Uniformity adds rich look to your code. Never add extra spaces nor line breaks in
the middle of the code block. The way you structure the blocks brings beauty to
the code.

When your code is more uniform it creates the picture in mind, and helps to read
the more lines of code.
