#  github.com/jeffreytse/zsh-vi-mode will auto execute this zvm_config function
#  https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#configuration-function
zvm_config() {
    ZVM_VI_ESCAPE_BINDKEY=^[

    ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_USER_DEFAULT
    ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
    ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

    ZVM_VI_SURROUND_BINDKEY=classic
}