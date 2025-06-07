#  github.com/jeffreytse/zsh-vi-mode will auto execute this zvm_config function
#  https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#configuration-function
zvm_config() {
    ZVM_VI_ESCAPE_BINDKEY=^[

    ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_USER_DEFAULT
    ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
    ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

    ZVM_VI_SURROUND_BINDKEY=classic
}

# https://github.com/jeffreytse/zsh-vi-mode/blob/master/README.md#execute-extra-commands
function _init_some_plugin_again() {
  source $HOME/Library/Caches/antidote/ohmyzsh/ohmyzsh/plugins/fzf/fzf.plugin.zsh
}
zvm_after_init_commands+=(_init_some_plugin_again)
