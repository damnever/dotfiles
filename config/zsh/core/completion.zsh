# Ref: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
# fixme - the load process here seems a bit bizarre
zmodload -i zsh/complist

WORDCHARS=''

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Complete . and .. special directories
zstyle ':completion:*' special-dirs true

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# # Don't complete uninteresting users
# zstyle ':completion:*:*:*:users' ignored-patterns \
        # adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        # clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        # gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        # ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        # named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        # operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        # rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        # usbmux uucp vcsa wwwrun xfs '_*'

# # ... unless we really want to.
# zstyle '*' single-ignored show


# Ref: https://getantidote.github.io/completions
# https://github.com/mattmc3/zephyr/blob/main/plugins/completions/completions.plugin.zsh
_cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
[[ -d "$_cache_dir" ]] || mkdir -p "$_cache_dir"
_zcompdump="$_cache_dir/compdump"
_zcompcache="$_cache_dir/compcache"

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$_zcompcache"

# if homebrew completions exist, use those
if (( $+commands[brew] )); then
  brew_prefix=${commands[brew]:A:h:h}
  fpath=("$brew_prefix"/share/zsh/site-functions(-/FN) $fpath)
  fpath=("$brew_prefix"/opt/curl/share/zsh/site-functions(-/FN) $fpath)
  unset brew_prefix
fi


# load and initialize the completion system ignoring insecure directories with a
# cache time of 20 hours, so it should almost always regenerate the first time a
# shell is opened each day.
# glob magic explained:
#   N - sets null_glob option (no error on 0 results)
#   mh-20 - modified less than 20 hours ago
autoload -Uz compinit
local _comp_files=($_zcompdump(Nmh-20))
if (( $#_comp_files )); then
  compinit -i -C -d "$_zcompdump"
else
  compinit -i -d "$_zcompdump"
  # keep zcompdump younger than cache time even if it isn't regenerated
  touch "$_zcompdump"
fi

# compile zcompdump, if modified, in background to increase startup speed
{
  if [[ -s "$_zcompdump" && (! -s "${_zcompdump}.zwc" || "$_zcompdump" -nt "${_zcompdump}.zwc") ]]; then
    zcompile "$_zcompdump"
  fi
} &!
