function wget --description 'Force `wget` to store its history file in `~/.local/share`'
 command wget --hsts-file=$HOME/.local/share/wget-hsts $argv;
end
