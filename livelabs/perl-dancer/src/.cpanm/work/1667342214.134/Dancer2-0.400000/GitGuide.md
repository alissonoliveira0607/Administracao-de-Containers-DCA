# Git Guide

This guide will help you to set up your environment to be able to work
on the Dancer2's repository.

## Contributing

This guide has been written to help anyone interested in contributing
to the development of Dancer2.

First of all - thank you for your interest in the project!  It's the
community of helpful contributors who've helped Dancer grow
phenomenally. Without the community we wouldn't be where we are today!

Please read this guide before contributing to Dancer2, to avoid wasted
effort and maximizing the chances of your contributions being used.

There are many ways to contribute to the project. Dancer2 is a young
yet active project and any kind of help is very much appreciated!

### Documentation

We value documentation very much, but it's difficult to keep it
up-to-date.  If you find a typo or an error in the documentation
please do let us know - ideally by submitting a patch (pull request)
with your fix or suggestion (see
[Patch Submission](#environment-and-patch-submission)).

### Code

You can write extensions (plugins) for Dancer2 extending core
functionality or contribute to Dancer2's core code, see
[Patch Submission](#environment-and-patch-submission) below.

## General Development Guidelines

This section lists high-level recommendations for developing Dancer2,
for more detailed guidelines, see [Coding Guidelines](#coding-guidelines)
below.

### Quality Assurance

Dancer2 should be able to install for all Perl versions since 5.12, on
any platform for which Perl exists. We focus mainly on GNU/Linux (any
distribution), \*BSD and Windows (native and Cygwin).

We should avoid regressions as much as possible and keep backwards
compatibility in mind when refactoring. Stable releases should not
break functionality and new releases should provide an upgrade path
and upgrade tips such as warning the user about deprecated
functionality.

### Quality Supervision

We can measure our quality using the
[CPAN testers platform](http://www.cpantesters.org).

A good way to help the project is to find a failing build log on the
[CPAN testers](http://www.cpantesters.org/distro/D/Dancer2.html).

If you find a failing test report, feel free to report it as a
[GitHub issue](http://github.com/PerlDancer/Dancer2/issues).

### Reporting Bugs

We prefer to have all our bug reports on GitHub, in the
[issues section](http://github.com/PerlDancer/Dancer2/issues).

Please make sure the bug you're reporting does not yet exist. If in doubt
please ask on IRC.

## Environment and Patch Submission

### Set up a development environment

If you want to submit a patch for Dancer2, you need git and very
likely also [_Dist::Zilla_](https://metacpan.org/module/Dist::Zilla).
We also recommend perlbrew (see below) or,
alternatively, [_App::Plenv_](https://github.com/tokuhirom/plenv))
to test and develop Dancer2 on a recent
version of Perl. We also suggest
[_App::cpanminus_](https://metacpan.org/module/App::cpanminus)
to quickly and comfortably install Perl modules.

In the following sections we provide tips for the installation of some
of these tools together with Dancer. Please also see the documentation
that comes with these tools for more info.

#### Perlbrew tips (Optional)

Install perlbrew for example with

    $ cpanm App::perlbrew

Check which Perls are available

    $ perlbrew available

It should list the available Perl versions, like this (incomplete) list:

    perl-5.17.1
    perl-5.16.0
    perl-5.14.2
    perl-5.12.4
    ...

Now run the init command for perlbrew. The init command initializes and controls
processes. The init command is run as the last step of any startup
process.

    $ perlbrew init


Then install a version inside perlbrew. We recommend you
give a name to the installation (`--as` option), as well as compiling
without the tests (`--n` option) to speed it up.

    $ perlbrew install -n perl-5.14.4 --as dancer_development -j 3

Wait a while, and it should be done. Switch to your new Perl with:

    $ perlbrew switch dancer_development

Now you are using the fresh Perl, you can check it with:

    $ which perl

Install cpanm on your brewed version of Perl.

    $ perlbrew install-cpanm


### Install various dependencies (required)

Install Dist::Zilla

    $ cpanm Dist::Zilla

### Get Dancer2 sources

Get the Dancer sources from github (for a more complete git workflow
see below):

Clone your fork to have a local copy using the following command:

     $ git clone git://github.com/perldancer/Dancer2.git

The Dancer2 sources come with a `dist.ini`. That's the configuration
file for _Dist::Zilla_, so that it knows how to build Dancer2. Let's
use dist.ini to install additional `Dist::Zilla` plugins which are
not yet installed on your system (or Perl installation):

     $ dzil authordeps | cpanm -n

That should install a bunch of stuff. Now that _Dist::Zilla_ is up and
running, you should install the dependencies required by Dancer2:

     $ dzil listdeps | cpanm -n

When that is done, you're good to go! You can use `dzil` to build and test
Dancer2:

     $ dzil build
     $ dzil test --no-author


### Running your modified version

If you have any version of Dancer2 installed on your system you will likely
run into problems when you try and run the "Dancer2" binary due to the wrong
lib's being used.
The following command should resolve that.
```bash
perl -Ilib script/dancer2 gen -s share/skel --overwrite --path /tmp/d2app -a MyApp::App
```
- It assumes we are in the git repo root dir
- `-Ilib` - tells perl to include the lib dir in it's search path
- in this case we run "gen" and
  - `-s share/skel`     - specify the use of the local copy of the skel dir
  - `--overwrite`       - we want to overwrite the generated scaffold project
  - `--path /tmp/d2app` - the dir to write the generated scaffold project dir to
  - `-a MyApp::App`     - the name of the app project we want to generate


### Patch Submission (Github workflow)

The Dancer2 development team uses GitHub to collaborate.  We greatly
appreciate contributions submitted via GitHub, as it makes tracking
these contributions and applying them much, much easier. This gives
your contribution a much better chance of being integrated into
Dancer2 quickly!

**NOTE:** All active development is performed in the _master_ branch.
Therefore, all your contribution work should be done in a fork of the
_master_ branch.

Here is the workflow for submitting a patch:

1. Fork the repository: http://github.com/PerlDancer/Dancer2 and click "Fork";

2. Clone your fork to have a local copy using the following command:

        $ git clone git://github.com/myname/Dancer2.git

3. As a contributor, you should **always** work on the `master` branch of
   your clone.

        $ git remote add upstream https://github.com/PerlDancer/Dancer2.git
        $ git fetch upstream

   This will create a local branch in your clone named _master_ and
   that will track the official _master_ branch. That way, if you have
   more or less commits than the upstream repo, you'll be immediately
   notified by git.

4. You want to isolate all your commits in a _topic_ branch, this
   will make the reviewing much easier for the core team and will
   allow you to continue working on your clone without worrying about
   different commits mixing together.

   To do that, first create a local branch to build your pull request:

        # you should be in master here
        $ git checkout -b pr/$name

   Now you have created a local branch named _pr/$name_ where _$name_
   is the name you want (it should describe the purpose of the pull
   request you're preparing).

   In that branch, do all the commits you need (the more the better)
   and when done, push the branch to your fork:

        # ... commits ...
        git push origin pr/$name

   You are now ready to send a pull request.

5. Send a _pull request_ via the GitHub interface. Make sure your pull
   request is based on the _pr/$name_ branch you've just pushed, so
   that it incorporates the appropriate commits only.

   It's also a good idea to summarize your work in a report sent to
   the users' mailing list (see below), in order to make sure the team
   is aware of it.

   You could also notify the core team on IRC, on `irc.perl.org`,
   channel `#dancer` or via [web client](http://www.perldancer.org/irc).

6. When the core team reviews your pull request, it will either accept
   (and then merge into _master_) or refuse your request.

   If it's refused, try to understand the reasons explained by the
   team for the denial. Most of the time, communicating with the core
   team is enough to understand what the mistake was. Above all,
   please don't be offended.

   If your pull request is merged into _master_, then all you have to
   do is remove your local and remote _pr/$name_ branch:

        $ git checkout master
        $ git branch -D pr/$name
        $ git push origin :pr/$name

   And then, of course, you need to sync your local devel branch with
   upstream:

        $ git pull upstream master
        $ git push origin master

   You're now ready to start working on a new pull request!
