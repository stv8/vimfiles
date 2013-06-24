##Installation:

Installing vim (OSX, requires homebrew)

```
  brew install macvim --override-system-vim
```

Installing [ag](https://github.com/ggreer/the_silver_searcher#installationn)

Clone this repository

```
 git clone git://github.com/rkrdo/vimfiles.git ~/.vim

```
Now run the rake command to create the symlinks

```
  cd ~/.vim
  rake
```

Or you can create them manually:

```
  ln -s ~/.vim/vimrc ~/.vimrc
  ln -s ~/.vim/gvimrc ~/.gvimrc
```

Fetch the submodules:

```
  cd ~/.vim
  rake init_submodules
```

Or you can do it manually:

```
  cd ~/.vim
  git submodule init
  git submodule update
```

#Updating Submodules

You can update each submodule by going to the plugin's folder and pulling from the repo

```
  cd ~/.vim/bundle/snipmate
  git pull origin master
```

You can also upgrade all the submodules with the command:

```
  git submodule foreach git pull origin master
```

Or within the rake file

```
  rake update_submodules
```

#Contributing

Find this repo useful?

1. Fork it
2. Add more useful plugins
3. Commit the changes
4. Create a new Pull Request

#TODO

- ~~clean the folder and add the submodules~~

- ~~add a rake task to automate the symlinks and submodule fetching~~

- add list of plugins and git repository link



