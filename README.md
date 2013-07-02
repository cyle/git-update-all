# CyleSoft Git Update All

This Ruby script simply runs `git remote update` and `git status -sb` below a tree of directories where your git projects live. It'll then tell you which git repos are clean, which have pending changes, which are behind or ahead of remote branches, etc.

Basically I wanted to re-create the awesome bookmarks list in the [SourceTree](http://www.sourcetreeapp.com/) app, but on a linux-based system. I haven't found a program to do this, so I built this script.

## Requirements

This was built with Ruby 1.9.3, that's all. I don't know if it'll work with Ruby 1.8 or 2.0, though I'm fairly certain it'll run with 2.0.

## Usage

If you call the script with no arguments, simply `./git-update-all.rb`, it'll use the current directory to scan for repos.

You can pass a directory path to it as an argument and it'll scan that directory for git repos, i.e. `./git-update-all.rb /path/to/projects`

See next section for an example.

## Example Usage

This script depends on you having a directory that's full of your projects. If one of those project folders is a git repo, this script will check on it.

For example, say you have a directory called **projects** that has the following contents:

    some-project/
    some-other-project/
    another-project/
    some-non-git-project/

and each one of those directories has a git repo in it, except for that last one. If you ran:

    /git-update-all.rb /path/to/projects

You'd get a list of each git repo, whether it's clean, whether it has untracked changes, push/pulling to be done, etc.

Colorized, too. Very pretty. That's all.

## Notes

If git is not installed in `/usr/bin/git` you should edit the "git_program_path" variable in git-update-all.rb

This uses a built-in class to colorize terminal output, so no gems are necessary. I lifted this from [here](http://stackoverflow.com/questions/1489183/colorized-ruby-output).

To install this script as a commandline program just like any other, link to it from /usr/local/bin (or wherever is in your PATH):

    ln -s /path/to/git-update-all.rb /usr/local/bin/git-update-all

and make sure you `chown +x /path/to/git-update-all.rb` to make sure it's executable.
