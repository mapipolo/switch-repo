Make a zsh script called switch-repo that uses fd to get a list of all git repos under ~/Source: fd -t d -H -g .git ~/Source. It should use this list as the autocompleter for its only argument: the relative path to the repo from ~/Source. I.e., when I type switch-repo [TAB], it should present a list like this: 

my-repo
my-dir/repo1
my-dir/repo2
another-repo
ripgrep
etc.

Whichever repo is selected, it will cd to that folder. That's it.
