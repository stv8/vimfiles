require 'rake'
desc "create the symlink of the vimrc files"

task :vimfiles do
  `ln -s ~/.vim/vimrc ~/.vimrc`
  `ln -s ~/.vim/gvimrc ~/.gvimrc`
  `ln -s ~/.vim/ackrc ~/.ackrc`
end

task :tmux do
  `ln -s ~/.vim/tmux.conf ~/.tmux.conf`
end

task :install_plugins do
  `cd ~/.vim`
  exec 'vim +BundleInstall +qall'
end

task :update_plugins do
  `cd ~/.vim`
  exec 'vim +BundleInstall! +qall'
end

task :default => :vimfiles
