# viccuad's dotfiles

My dotfiles, based on [Holman's ones](https://github.com/holman/dotfiles) *(why isn't this a fork?).

![example](https://github.com/viccuad/dotfiles/raw/master/example.png)

## install

Run this:

```sh
git clone https://github.com/viccuad/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.


## topical

Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`. If you want a file *.foo* starting
  by a dot to get symlinked, then, you would need to rename it to *.foo.symlink*.



  ## install

	all inside /<application>/nostow/* is not going to be stowed.
	normally is adding path, completions, etc to zsh


  put zsh as default
  sublime2
  laptop-mode
  fonts

  ## unninstall
  remove all links, put backups in place, put bash as default shell

## Using stow

More info:

- http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html
- http://taihen.org/managing-dotfiles-with-gnu-stow/
- http://kianmeng.org/blog/2014/03/08/using-gnu-stow-to-manage-your-dotfiles/


## *
1. Holman applied some gitignores. In git, when you untrack files by gitignore and then remove the entries on the gitignore file, those files keep untracked. It was easier to create my own git repo and add my gitignore. 
2. This repo is NOT compatible with Holman's repos and forks.
