function config --wraps='git --git-dir=$HOME/dotfiles --work-tree=$HOME' --description 'Manage dotfiles easily'
  git --git-dir=$HOME/dotfiles --work-tree=$HOME $argv
end
