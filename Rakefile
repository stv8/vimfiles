require 'rake'
desc "create the symlink of the vimrc files"

task :vimfiles do
  `ln -s ~/.vim/vimrc ~/.vimrc`
  `ln -s ~/.vim/gvimrc ~/.gvimrc`
end

task :init_submodules do
  `cd ~/.vim`
  `git submodule init`
  `git submodule update`
end

task :update_submodules do
  `cd ~/.vim`
  `git submodule foreach git pull origin master`
end

task :default => :vimfiles
