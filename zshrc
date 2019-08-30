source ~/.zplug/init.zsh

# External commands
zplug "b4b4r07/enhancd", use:init.sh # enhanced "cd .." with autocompletion
zplug "Peltoche/lsd", from:gh-r, as:command  # ls with colors
zplug "sdispater/poetry", from:github, as:command, hook-build:"python get-poetry.py"  # Poetry, handle python projects
zplug 'sharkdp/bat', as:command, from:gh-r, rename-to:bat, use:"*x86_64-*-linux*" # bat, enhanced cat command
zplug 'sharkdp/fd', as:command, from:gh-r  # FD, enhanced find command
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf  # fuzzy finder

# ZSH plugins
zplug 'darvid/zsh-poetry', from:github   # handle poetry
zplug 'lukechilds/zsh-nvm'  # handle nvm
zplug 'junegunn/fzf', use:'shell/key-bindings.zsh' # fuzzy finder with ctrl+r
zplug "desyncr/auto-ls", from:github  # Automatically execute ls upon entering a dir
zplug "zsh-users/zsh-syntax-highlighting", defer:2  # Real time syntax highlighting
zplug "zsh-users/zsh-autosuggestions" # Autosuggestions
zplug "MichaelAquilina/zsh-auto-notify"  # Auto notify for long tasks
zplug ice wait'1' lucid
zplug light laggardkernel/zsh-thefuck  # TheFuck plugin
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# ZPlug itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug check || zplug install
zplug load

alias cat=bat --paging=never
alias tree="lsd --tree"
alias ls="lsd -lh"

export XDG_CONFIG_HOME=~/.local/share
export PATH=$PATH:~/.local/bin
export EDITOR=nvim

export AUTO_LS_NEWLINE=false
export AUTO_LS_COMMANDS=(ls)
export ENHANCD_DOT_SHOW_FULLPATH=1

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

autoload -Uz add-zsh-hook
_nicy_prompt() {
  PROMPT=$(~/.nimble/bin/nicy)
}
add-zsh-hook precmd _nicy_prompt
get_nerd_font(){ wget $(wget https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest -O -  | jq -r ".assets[]|select(.name==\"$1.zip\").browser_download_url")}
