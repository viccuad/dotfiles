# viccuad's dotfiles

My dotfiles!

#### spacemacs inside tmux
![emacs_tmux](https://github.com/viccuad/dotfiles/raw/master/emacs_tmux.png)

#### gvim
![gvim](https://github.com/viccuad/dotfiles/raw/master/gvim.png)

#### vim inside tmux
![vim_tmux](https://github.com/viccuad/dotfiles/raw/master/vim_tmux.png)

#### old vim + gdb (ConqueGDB plugin)
![vim_gdb](https://github.com/viccuad/dotfiles/raw/master/vim_gdb.png)


## Layout

I use `stow` for deployment (and a little script), so the layout of the
dotfiles is as follows:

![tree](https://github.com/viccuad/dotfiles/raw/master/tree.png)

As you can see, 'applications' are separated on directories, and inside
them, stowable files that follow to path they should have from `~/`.

There's a few special files in the hierarchy.

 - containing **nostow**: Any files containing `nostow` in their filename will
   not get symlinked by stow.

 - **/nostow/bin/**: Anything in `bin/` will get added to your `$PATH` and be
   made available everywhere.

 - **topic/nostow/dependencies.sh**: A wrapper to install the needed software
   for that topic (normally, Debian packages)

 - **topic/nostow/*.zsh**: Any files ending in `.zsh` get loaded into your
   environment.

 - **topic/nostow/path.zsh**: Any file named `path.zsh` is loaded first and is
   expected to setup `$PATH` or similar.

 - **topic/nostow/completion.zsh**: Any file named `completion.zsh` is loaded
   last and is expected to setup autocomplete.

If you're adding a new area to your forked dotfiles — say, "Java" — you
can simply add a `java` directory and put files in there. Anything with
an extension of `.zsh` inside of `java/nostow/` will get automatically
included into your shell. All the things inside `java` that aren't inside
of `nostow` or don't have `nostow` in their filenames will get symlinked
into `$HOME` when you run `install.sh`.


## install

To install run this:

```
sh
git clone --recursive https://github.com/viccuad/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git submodule init
git submodule update
./install.sh
```
The install script will ask if you want to set your Zsh as the default
shell, make a new gitconfig, install the dependencies, make a dry run that
does not write anything, etc.
Installing a dir will symlink the appropriate files in `.dotfiles` to your
home directory. Everything is configured and tweaked within `~/.dotfiles`.

We are using stow, and stow _does_ _not_ delete or overwrite file that
already exist. You will need to make a backup of them or delete them.

## uninstall

To uninstall run:

```
./uninstall.sh
```
## todo

 - [] implement something like [vcsh](https://github.com/RichiH/vcsh) or move to it
 - Make optional to load folders on zsh
