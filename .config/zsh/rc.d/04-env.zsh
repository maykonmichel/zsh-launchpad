#!/bin/zsh

##
# Environment variables
#

export JAVA_HOME=~/.local/share/mise/installs/java/zulu-11.66.15

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_ROOT_SDK=$ANDROID_HOME

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/Git/google-cloud-sdk/path.zsh.inc' ]; then . '~/Git/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/Git/google-cloud-sdk/completion.zsh.inc' ]; then . '~/Git/google-cloud-sdk/completion.zsh.inc'; fi


# pnpm
export PNPM_HOME="~/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end%

# -U ensures each entry in these is unique (that is, discards duplicates).
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath  # -T creates a "tied" pair; see below.

# $PATH and $path (and also $FPATH and $fpath, etc.) are "tied" to each other.
# Modifying one will also modify the other.
# Note that each value in an array is expanded separately. Thus, we can use ~
# for $HOME in each $path entry.
path=(
    /home/linuxbrew/.linuxbrew/bin(N)   # (N): null if file doesn't exist
    $path
    ~/.local/bin
    $ANDROID_HOME
    $ANDROID_HOME/platform-tools
    $ANDROID_HOME/tools
)

# Add your functions to your $fpath, so you can autoload them.
fpath=(
    $ZDOTDIR/functions
    $fpath
    ~/.local/share/zsh/site-functions
)

if command -v brew > /dev/null; then
  # `znap eval <name> '<command>'` is like `eval "$( <command> )"` but with
  # caching and compilation of <command>'s output, making it 10 times faster.
  znap eval brew-shellenv 'brew shellenv'

  # Add dirs containing completion functions to your $fpath and they will be
  # picked up automatically when the completion system is initialized.
  # Here, we add it to the end of $fpath, so that we use brew's completions
  # only for those commands that zsh doesn't already know how to complete.
  fpath+=(
      $HOMEBREW_PREFIX/share/zsh/site-functions
  )
fi
