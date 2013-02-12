##Installation:

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

#Contributing

Find this repo useful?
1. Fork it
2. Add more useful plugins
3. Commit the changes
4. Create a new Pull Request

#TODO
~~- clean the folder and add the submodules~~
- add list of plugins and git repository link
~~- add a rake task to automate the symlinks and submodule fetching~~
