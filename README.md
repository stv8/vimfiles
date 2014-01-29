##Installation:

Installing vim (OSX, requires homebrew)

```
  brew install macvim --override-system-vim
```

Install [ag](https://github.com/ggreer/the_silver_searcher#installationn)


Install tmux

```
  brew install tmux
```


Clone this repository

```
 git clone git://github.com/rkrdo/vimfiles.git ~/.vim

```
Now run the rake command to create the symlinks (you need to have Ruby installed)

```
  cd ~/.vim
  rake
```

Or if you don't have Ruby in your system:

```
  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/gvimrc ~/.gvimrc
```

Fetch the plugins:

```
  cd ~/.vim
  rake install_plugins
```

Or you can do it manually:

Go to `cd ~/.vim`, launch `vim` and run `:BundleInstall`

#Updating Plugins


You can update the plugins running (again, a Ruby installation is needed)

```
  rake update_plugins
```

Or manually:

Go to `cd ~/.vim`, launch `vim` and run `:BundleInstall!` (notice the bang ! at the end)


##Control-enter hack

I have an insert mode mapping for MacVim that basically escapes insert mode and presses o, so I can go to a new line while being in insert mode. Unfortunately if I press this key combination in Terminal Vim, it makes my terminal enter fullscreen mode, I found a hack on [Stack Overflow](http://stackoverflow.com/a/12117076) to map Control-Enter to this behavior.

#Contributing

Find this repo useful?

1. Fork it
2. Add more useful plugins
3. Commit the changes
4. Create a new Pull Request

#TODO

- ~~clean the folder and add the submodules~~

- ~~add a rake task to automate the symlinks and submodule fetching~~

- ~~changed from Pathogen to Vundle~~

- ~~add list of plugins and git repository link~~



