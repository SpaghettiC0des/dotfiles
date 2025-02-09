
# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

alias ssh:github="ssh-add -D && ssh-add --apple-use-keychain ~/.ssh/github"
alias ssh:fulcrum="ssh-add -D && ssh-add --apple-use-keychain ~/.ssh/fulcrum"
alias firefox:default="/Applications/Firefox.app/Contents/MacOS/firefox -P 'default'"
alias firefox:fulcrum="/Applications/Firefox.app/Contents/MacOS/firefox -P 'Fulcrum'"
alias firefox:="/Applications/Firefox.app/Contents/MacOS/firefox -P 'AHP'"
alias pnpx="pnpm dlx"
alias vim="nvim"
alias vi="nvim"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."
alias .........="cd ../../../../../../../.."
alias ..........="cd ../../../../../../../../.."
alias ...........="cd ../../../../../../../../../.."
alias ............="cd ../../../../../../../../../../.."
alias .............="cd ../../../../../../../../../../../.."

export EDITOR="nvim"
# export PATH="$PATH":"$HOME/.pub-cache/bin"
export CHROME_EXECUTABLE="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
# export CONFIG_DIR="$HOME/.config/lazygit"
export PATH=$PATH:$HOME/codes/flutter-sdk/bin
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export ANDROID_HOME=$ANDROID_SDK_ROOT
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
export PATH=$PATH:$HOME/Library/Python/3.8/bin
export PATH=$PATH:$HOME/Library/Python/3.11/bin
export PATH=$PATH:$HOME/.platformio/penv/bin
export PATH=$PATH:~/.local/bin
export SDKROOT=$(xcrun -sdk macosx --show-sdk-path)
eval "$(/opt/homebrew/bin/brew shellenv)"


# bun completions
[ -s "/Users/karlmarxlopez/.bun/_bun" ] && source "/Users/karlmarxlopez/.bun/_bun"

# Bun
export BUN_INSTALL="/Users/karlmarxlopez/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home

# export PATH="$HOME/zephr-sdk-0.16.3:$PATH"

# export GPG_TTY=$(tty)
# gpgconf --launch gpg-agent
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

eval "$(rbenv init - zsh)"

# pnpm
export PNPM_HOME="/Users/karlmarxlopez/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/karlmarxlopez/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/karlmarxlopez/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/karlmarxlopez/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/karlmarxlopez/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$PATH:$HOME/.maestro/bin
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"
export DPRINT_INSTALL="/Users/karlmarxlopez/.dprint"
export PATH="$DPRINT_INSTALL/bin:$PATH"
autoload_nvmrc() {
  if [ -f .nvmrc ] && [ -r .nvmrc ]; then
    nvm use
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd autoload_nvmrc
autoload_nvmrc

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/karlmarxlopez/.dart-cli-completion/zsh-config.zsh ]] && . /Users/karlmarxlopez/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

export FVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.fvm" || printf %s "${XDG_CONFIG_HOME}/fvm")"
[ -s "$FVM_DIR/fvm.sh" ] && \. "$FVM_DIR/fvm.sh" # This loads fvm
[ -s "$FVM_DIR/bash_completion" ] && \. "$FVM_DIR/bash_completion"  # This loads fvm bash_completion
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# ## https://github.com/kdheepak/lazygit.nvim/issues/22#issuecomment-2206274882
# if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
#     export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
#     export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
# else
#     export VISUAL="nvim"
#     export EDITOR="nvim"
# fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
